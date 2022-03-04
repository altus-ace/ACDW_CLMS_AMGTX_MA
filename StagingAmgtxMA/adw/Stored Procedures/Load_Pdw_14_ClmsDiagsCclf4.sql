
CREATE PROCEDURE [adw].[Load_Pdw_14_ClmsDiagsCclf4]
AS 
   
   /* prepare logging */
    DECLARE @AuditId INT;    
    DECLARE @JobStatus tinyInt = 1    -- 1 in process , 2 Completed
    DECLARE @JobType SmallInt = 8	  -- AST load
    DECLARE @ClientKey INT	 = 16; -- mssp
    DECLARE @JobName VARCHAR(100) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @ActionStart DATETIME2 = GETDATE();
    DECLARE @SrcName VARCHAR(100) = '[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_DIAG]'
    DECLARE @DestName VARCHAR(100) = 'adw.Claims_Diags'
    DECLARE @ErrorName VARCHAR(100) = 'NA';
    DECLARE @InpCnt INT = -1;
    DECLARE @OutCnt INT = -1;
    DECLARE @ErrCnt INT = -1;
	
    SELECT @InpCnt = COUNT(*) 
    SELECT COUNT(*) 
    FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_DIAG] cp 		
	   JOIN ast.Claim_06_Diag_Dedup ast 
		  ON cp.Amerigroup_CLM_DIAGKey = ast.DiagAdiKey
		  and SrcClaimType = 'INST'
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
        , @ErrorName	   = @ErrorName
        ;
    CREATE TABLE #OutputTbl (ID INT NOT NULL PRIMARY KEY);	
    INSERT INTO  adw.Claims_Diags
           ([SEQ_CLAIM_ID]
           ,[SUBSCRIBER_ID]
           ,[ICD_FLAG]
           ,[diagNumber]
           ,[diagCode]
           ,[diagPoa]
		   ,LoadDate
		   ,SrcAdiTableName
		   ,SrcAdiKey)
    OUTPUT INSERTED.URN INTO #OutputTbl(ID)
   		   SELECT	dg.ClaimNbr				AS SEQ_CLAIM_ID  
			 , cd.MasterConsumerID			AS SUBSCRIBER_ID
			 , ''		AS ICD_FLAG   
			 , ast.DiagNum	  			AS diagNumber     			
			 , dg.DIAG_CD    DiagCode
			 , ''				     AS DiagPoa
			 , getDate()			     AS LoadDate
			 , '[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_DIAG]' AS SrcAdiTableName
			 , dg.Amerigroup_CLM_DIAGKey			as adiKey			 
   from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_CLM_DIAG] dg
	left JOIN ast.Claim_06_Diag_Dedup ast ON ast.DiagAdiKey = dg.Amerigroup_CLM_DIAGKey	
	JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cd ON cd.Amerigroup_MedClaimDetlKey = dg.Amerigroup_CLM_DIAGKey
	where ast.SrcClaimType = 'INST'
		 
    ORDER BY dg.ClaimNbr, ast.DiagNum
	;

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
