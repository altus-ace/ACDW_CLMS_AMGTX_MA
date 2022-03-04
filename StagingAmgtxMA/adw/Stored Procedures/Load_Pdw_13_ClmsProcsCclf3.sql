CREATE PROCEDURE [adw].[Load_Pdw_13_ClmsProcsCclf3]
AS
    --Task 3 Insert Proc: -- Insert to proc    
	/* prepare logging */
    DECLARE @AuditId INT;    
    DECLARE @JobStatus tinyInt = 1    -- 1 in process , 2 Completed
    DECLARE @JobType SmallInt = 8	  -- AST load
    DECLARE @ClientKey INT	 = 16; -- mssp
    DECLARE @JobName VARCHAR(100) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @ActionStart DATETIME2 = GETDATE();
    DECLARE @SrcName VARCHAR(100) = '[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_HDR_PROC]'
    DECLARE @DestName VARCHAR(100) = 'adw.Claims_Procs'
    DECLARE @ErrorName VARCHAR(100) = 'NA';
    DECLARE @InpCnt INT = -1;
    DECLARE @OutCnt INT = -1;
    DECLARE @ErrCnt INT = -1;
	
    SELECT @InpCnt = COUNT(*) 	
    FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_HDR_PROC] cl
	   JOIN ast.Claim_05_Procs_Dedup ast ON cl.Amerigroup_CLM_HDR_PROC_Key = ast.ProcAdiKey
    WHERE ast.SrcClaimType = 'INST'
	   ;	

    EXEC amd.sp_AceEtlAudit_Open 
           @AuditID = @AuditID OUTPUT
           , @AuditStatus = @JobStatus
           , @JobType = @JobType
           , @ClientKey = @ClientKey
           , @JobName = @JobName
           , @ActionStartTime = @ActionStart
           , @InputSourceName = @SrcName
           , @DestinationName = @DestName
           , @ErrorName = @ErrorName
           ;
    CREATE TABLE #OutputTbl (ID INT NOT NULL PRIMARY KEY);	
    
    INSERT INTO adw.Claims_Procs
               (SEQ_CLAIM_ID
				,SUBSCRIBER_ID
				,ProcNumber
				,ProcCode
				,ProcDate
				,LoadDate
				,SrcAdiTableName
				,SrcAdiKey	)	
    OUTPUT Inserted.URN INTO #OutputTbl(ID)
    SELECT cp.ClaimNbr						AS SEQ_CLAIM_ID
        , cd.MasterConsumerID			 			AS subscriberID
        , ast.ProcNumber			 			AS ProcNum
        ,cp.ICD_CM_procedure					AS ProcCode
        , cp.ICD_Procedure_Date	  				AS ProcDate
	   , getdate()							AS LoadDate
	   , '[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_HDR_PROC]'	AS SrcAdiTableName
	   , ast.ProcAdiKey					   	AS SrcAdiKey
		-- implicit: 	CreatedDate,CreatedBy,LastUpdatedDate,LastUpdatedBy
    FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_HDR_PROC] cp
        JOIN ast.Claim_05_Procs_Dedup ast ON cp.Amerigroup_CLM_HDR_PROC_Key = ast.ProcAdiKey AND ast.SrcClaimType = 'INST'
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cd
		  ON cd.ClaimNbr = cp.ClaimNbr 
    ORDER BY cp.ClaimNbr, ast.ProcNumber;

	-- if this fails it just stops. How should this work, structure from the WLC or AET COM care Op load, acedw do this soon.
	SELECT @OutCnt = COUNT(*) FROM #OutputTbl; 
	SET @ActionStart = GETDATE();    
	SET @JobStatus =2  -- complete
    
	EXEC amd.sp_AceEtlAudit_Close 
        @AuditId = @AuditID
        , @ActionStopTime = @ActionStart
        , @SourceCount = @InpCnt		  
        , @DestinationCount = @OutCnt
        , @ErrorCount = @ErrCnt
        , @JobStatus = @JobStatus
	   ;

