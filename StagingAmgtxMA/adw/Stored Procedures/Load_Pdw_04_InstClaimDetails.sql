CREATE PROCEDURE [adw].[Load_Pdw_04_InstClaimDetails]
   ( @LatestDataDate DATE = '12/31/2099')
AS
  /* PURPOSE: -- 4. de dup claims details     */	
    DECLARE @DataDate DATE;
    DECLARE @AuditId INT;    
    DECLARE @JobStatus tinyInt = 1    -- 1 in process , 2 Completed
    DECLARE @JobType SmallInt = 9	  -- 9: Ast Load, 10: Ast Transform, 11:Ast Validation	
    DECLARE @ClientKey INT	 = 16; -- mssp
    DECLARE @JobName VARCHAR(100) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @ActionStart DATETIME2 = GETDATE();    
    DECLARE @DestName VARCHAR(100) = '[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl]'
    DECLARE @ErrorName VARCHAR(100) = 'NA';
    DECLARE @InpCnt INT = -1;
    DECLARE @OutCnt INT = -1;
    DECLARE @ErrCnt INT = -1;

	 IF @LatestDataDate = '12/31/2099'
	   BEGIN
	   SELECT @DataDate = MAX(ch.DataDate)
		  FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] ch
		  WHERE ch.PG_ID = 'TX000425'  
			and ch.InstitutionalIndicator = 'Y'
	   END
	   ELSE SET @DataDate = @LatestDataDate; 
    TRUNCATE TABLE ast.Claim_04_Detail_Dedup;   
	 
    CREATE TABLE #OutputTbl (srcAdiKey INT NOT NULL, SrcClaimType CHAR(5) NOT NULL , PRIMARY KEY (srcAdiKey, SrcClaimType));	
BEGIN -- Inst Claims Details
--declare @DataDate date = '01/01/2021'
    SELECT @InpCnt = COUNT(cl.Amerigroup_MedClaimDetlKey)      	
	FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] ch
	   JOIN ast.Claim_03_Header_LatestEffective lr -- list of latest effective claims
		  ON ch.MedClaimHdrKey = lr.LatestClaimAdiKey
		  AND lr.LatestClaimAdiKey = lr.ReplacesAdiKey
		  AND lr.SrcClaimType = 'INST'			
	   JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON ch.ClaimNbr = cl.ClaimNbr
		  AND ch.DataDate = cl.DataDate 
		 -- AND cl.ClaimRecordID = 'LIN' talk to gk
	WHERE ch.DataDate <= @DataDate and cl.DataDate <= @DataDate
    ;
    DECLARE @SrcName VARCHAR(100) = '[adi].[Amerigroup_MedClaimDetl]'
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
    
    INSERT INTO ast.Claim_04_Detail_Dedup(
	ClaimDetailSrcAdiKey
	, ClaimDetailSrcAdiTableName
	, AdiDataDate
	, ClaimSeqClaimId
	, ClaimDetailLineNumber
	, SrcClaimType)
    OUTPUT Inserted.pstClmDetailKey, inserted.SrcClaimType INTO #OutputTbl(srcAdiKey, SrcClaimType)    
    SELECT
	 cl.Amerigroup_MedClaimDetlKey
	 , @SrcName
	 , cl.DataDate
	 , cl.ClaimNbr
	 ,ROW_NUMBER() OVER(PARTITION BY ch.ClaimNbr ORDER BY ch.DataDate DESC, ch.OriginalFileName ASC) ClaimLinenumber
	 --, cl.ClaimLinenumber
	 , lr.SrcClaimType
   FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] ch
	   JOIN ast.Claim_03_Header_LatestEffective lr -- list of latest effective claims
		  ON ch.MedClaimHdrKey = lr.LatestClaimAdiKey
		  AND lr.LatestClaimAdiKey = lr.ReplacesAdiKey
		  AND lr.SrcClaimType = 'INST'			
	   JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON ch.ClaimNbr = cl.ClaimNbr
		  AND ch.DataDate = cl.DataDate 
		 -- AND cl.ClaimRecordID = 'LIN' talk to gk
	WHERE ch.DataDate <= @DataDate and cl.DataDate <= @DataDate
    ;
	-- if this fails it just stops. How should this work, structure from the WLC or AET COM care Op load, acedw do this soon.
	SELECT @OutCnt = COUNT(*) FROM #OutputTbl otb WHERE otb.SrcClaimType = 'INST'; 
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
END
/* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */
BEGIN -- PROF Claims Details
    -- declare @DataDate date = '01/01/2021';
    SELECT @InpCnt = COUNT(cl.Amerigroup_MedClaimDetlKey)        
	FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] ch
	   JOIN ast.Claim_03_Header_LatestEffective lr -- list of latest effective claims
		  ON ch.MedClaimHdrKey = lr.LatestClaimAdiKey
		  AND lr.LatestClaimAdiKey = lr.ReplacesAdiKey
		  AND lr.SrcClaimType = 'PROF'			
	   JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON ch.ClaimNbr = cl.ClaimNbr
		  AND ch.DataDate = cl.DataDate 
		 -- AND cl.ClaimRecordID = 'LIN' talk to gk
	WHERE ch.DataDate <= @DataDate and cl.DataDate <= @DataDate   
   
    ;

    set @SrcName = 'adi.Amerigroup_MedClaimDetl';
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
    
    INSERT INTO ast.Claim_04_Detail_Dedup(
	ClaimDetailSrcAdiKey
	, ClaimDetailSrcAdiTableName
	, AdiDataDate
	, ClaimSeqClaimId
	, ClaimDetailLineNumber
	, SrcClaimType)
    OUTPUT Inserted.pstClmDetailKey, inserted.SrcClaimType INTO #OutputTbl(srcAdiKey, SrcClaimType)
    SELECT cl.Amerigroup_MedClaimDetlKey
			, @SrcName
			, cl.DataDate
			, cl.ClaimNbr
			, ROW_NUMBER() OVER(PARTITION BY ch.ClaimNbr ORDER BY ch.DataDate DESC, ch.OriginalFileName ASC) ClaimLinenumber
			--, cl.ClaimLinenumber
			, lr.SrcClaimType
   FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] ch
	   JOIN ast.Claim_03_Header_LatestEffective lr -- list of latest effective claims
		  ON ch.MedClaimHdrKey = lr.LatestClaimAdiKey
		  AND lr.LatestClaimAdiKey = lr.ReplacesAdiKey
		  AND lr.SrcClaimType = 'PROF'			
	   JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON ch.ClaimNbr = cl.ClaimNbr
		  AND ch.DataDate = cl.DataDate 
		 -- AND cl.ClaimRecordID = 'LIN' talk to gk
	WHERE ch.DataDate <= @DataDate and cl.DataDate <= @DataDate   
       ;
	-- if this fails it just stops. How should this work, structure from the WLC or AET COM care Op load, acedw do this soon.
	SELECT @OutCnt = COUNT(*) FROM #OutputTbl otb WHERE otb.SrcClaimType = 'PROF'; 
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
END
/*
/* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */

BEGIN -- RX Claims Details
    -- declare @DataDate date = '01/01/2021';
    SELECT @InpCnt = COUNT(ch.RxClaimsKey)            
    FROM [adi].[Amerigroup_RxClaims] ch
	   JOIN ast.Claim_03_Header_LatestEffective lr 
		  ON ch.RxClaimsKey = lr.LatestClaimAdiKey
		  AND lr.LatestClaimAdiKey = lr.ReplacesAdiKey	   
		  AND lr.SrcClaimType = 'RX'
	WHERE ch.DataDate <= @DataDate 
    ;

    set @SrcName = '[adi].[Amerigroup_RxClaims]';
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
    
    INSERT INTO ast.Claim_04_Detail_Dedup(ClaimDetailSrcAdiKey, ClaimDetailSrcAdiTableName, AdiDataDate, ClaimSeqClaimId, ClaimDetailLineNumber, SrcClaimType)
    OUTPUT Inserted.pstClmDetailKey, inserted.SrcClaimType INTO #OutputTbl(srcAdiKey, SrcClaimType)
    SELECT 
	ch.RXClaimsKey
	, @SrcName
	, ch.DataDate
	, ch.ClaimNbr
	, ROW_NUMBER() OVER(PARTITION BY ch.ClaimNbr ORDER BY ch.DataDate DESC, ch.OriginalFileName ASC) ClaimLinenumber
	--, ch.ClaimLinenumber
	, lr.SrcClaimType
    FROM [adi].[Amerigroup_RxClaims] ch
	   JOIN ast.Claim_03_Header_LatestEffective lr 
		  ON ch.RxClaimsKey = lr.LatestClaimAdiKey
		  AND lr.LatestClaimAdiKey = lr.ReplacesAdiKey	   
		  AND lr. SrcClaimType = 'RX'
	WHERE ch.DataDate <= @DataDate 
    ;
	-- if this fails it just stops. How should this work, structure from the WLC or AET COM care Op load, acedw do this soon.
	SELECT @OutCnt = COUNT(*) FROM #OutputTbl otb WHERE otb.SrcClaimType = 'RX'; 
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
END
/* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */
*/