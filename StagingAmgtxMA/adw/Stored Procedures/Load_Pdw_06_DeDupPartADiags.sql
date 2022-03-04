

CREATE PROCEDURE [adw].[Load_Pdw_06_DeDupPartADiags]( @LatestDataDate DATE = '12/31/2099')
AS 

     /* -- 6. de dup diags

	   get diags sets by claim and line and adj and ???
	   deduplicate for cases:
		  1. deal with duplicates: all relavant details are the same
		  2. deal with adjustments: if details sub line code is different
		  3. deal with???? will determin as we move forward

	   sort by file date or???
	   
	   insert into ast claims dedup diags urns table [pstcDgDeDupUrns]
    */

    DECLARE @DataDate DATE;
   

    DECLARE @AuditId INT;    
    DECLARE @JobStatus tinyInt = 1    -- 1 in process , 2 Completed
    DECLARE @JobType SmallInt = 9	  -- 9: Ast Load, 10: Ast Transform, 11:Ast Validation	
    DECLARE @ClientKey INT	 = 16; -- mssp
    DECLARE @JobName VARCHAR(100) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @ActionStart DATETIME2 = GETDATE();
    DECLARE @SrcName VARCHAR(100) = 'adi.Amerigroup_MedClaimHdr'
    DECLARE @DestName VARCHAR(100) = 'ast.pstcDgDeDupUrns'
    DECLARE @ErrorName VARCHAR(100) = 'NA';
    DECLARE @InpCnt INT = -1;
    DECLARE @OutCnt INT = -1;
    DECLARE @ErrCnt INT = -1;
	

	 -- Inst Claims
    IF @LatestDataDate = '12/31/2099'
	   BEGIN
	   SELECT @DataDate = MAX(ch.DataDate)
		  FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] ch
		  WHERE ch.PG_ID = 'TX000425'  
			and ch.InstitutionalIndicator = 'Y'
	   END
	   ELSE SET @DataDate = @LatestDataDate;  

	   
    CREATE TABLE #OutputTbl (srcAdikey INT NOT NULL, srcClaimType CHAR(5), PRIMARY KEY(srcAdiKey, srcClaimType));	
    TRUNCATE table ast.Claim_06_Diag_Dedup;


BEGIN -- INst claims 
    SELECT @InpCnt = COUNT(*) 
    FROM (SELECT cd.MedClaimHdrKey AdiKey, 1 AS DiagNum
		  from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 2 AS DiagNum
		from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 3 AS DiagNum
		   from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 4 AS DiagNum
		 from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 5 AS DiagNum
		  from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		 /* UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 6 AS DiagNum 
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode6 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 7 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode7 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 8 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode8 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 9 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode9 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 10 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode10 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 11 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode11 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 12 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode12 , '') <> '' AND ast.SrcClaimType = 'INST'*/
    ) src;

    SET @SrcName = '[adi].[Amerigroup_MedClaimHdr]';
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

    INSERT INTO ast.Claim_06_Diag_Dedup(DiagAdiKey, DiagNum, SrcClaimType)
    OUTPUT inserted.ClaimDiagDedupKey, inserted.SrcClaimType INTO #OutputTbl(srcAdikey, srcClaimType)
    SELECT src.AdiKey, src.DiagNum, src.SrcClaimType
    FROM (SELECT cd.MedClaimHdrKey AdiKey, 1 AS DiagNum, ast.SrcClaimType
		   from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 2 AS DiagNum, ast.SrcClaimType
		 from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 3 AS DiagNum, ast.SrcClaimType
		  from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 4 AS DiagNum, ast.SrcClaimType
		  from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 5 AS DiagNum, ast.SrcClaimType
		  from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  join ast.Claim_03_Header_LatestEffective ast  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey 
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'INST'
		 /* UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 6 AS DiagNum , ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode6 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 7 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode7 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 8 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode8 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 9 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode9 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 10 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode10 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 11 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode11 , '') <> '' AND ast.SrcClaimType = 'INST'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 12 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode12 , '') <> '' AND ast.SrcClaimType = 'INST' */
	   ) SRC

	SELECT @OutCnt = COUNT(*) FROM #OutputTbl Otb WHERE Otb.srcClaimType = 'INST'
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
/* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */
BEGIN -- Prof claims 
    --declare @datadate date = '01/01/2021'
    SELECT @InpCnt = COUNT(*)     
    FROM (SELECT cd.MedClaimHdrKey AdiKey, 1 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 2 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_2_CD , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 3 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate   
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_3_CD , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 4 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_4_CD , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 5 AS DiagNum
		 FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_5_CD , '') <> '' AND ast.SrcClaimType = 'PROF'
		 /* UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 6 AS DiagNum 
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode6 , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 7 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode7 , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 8 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode8 , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 9 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode9 , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 10 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode10 , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 11 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode11 , '') <> '' AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 12 AS DiagNum
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode12 , '') <> '' AND ast.SrcClaimType = 'PROF'*/
    ) src;

    SET @SrcName =' [adi].[Amerigroup_MedClaimDetl] ';
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

    INSERT INTO ast.Claim_06_Diag_Dedup(DiagAdiKey, DiagNum, SrcClaimType)
    OUTPUT inserted.ClaimDiagDedupKey, inserted.SrcClaimType INTO #OutputTbl(srcAdikey, srcClaimType)
    SELECT src.AdiKey, src.DiagNum, src.SrcClaimType
    FROM (SELECT cd.MedClaimHdrKey AdiKey, 1 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate      
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_1_CD, '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 2 AS DiagNum, ast.SrcClaimType
		 FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate      
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_2_CD , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 3 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate   
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_3_CD , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 4 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate  
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_4_CD , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.MedClaimHdrKey AdiKey, 5 AS DiagNum, ast.SrcClaimType
		 FROM ast.Claim_03_Header_LatestEffective ast
		     Join [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] cd
		  	  ON ast.LatestClaimAdiKey = cd.MedClaimHdrKey  
			  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON cd.ClaimNbr = cl.ClaimNbr
		  AND cd.DataDate = cl.DataDate     
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cl.DIAG_5_CD , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		 /* UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 6 AS DiagNum , ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode6 , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 7 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode7 , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 8 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode8 , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 9 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode9 , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 10 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode10 , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 11 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode11 , '') <> ''
		  AND ast.SrcClaimType = 'PROF'
		  UNION ALL
		  SELECT cd.ProfessionalClaimKey AdiKey, 12 AS DiagNum, ast.SrcClaimType
		  FROM ast.Claim_03_Header_LatestEffective ast
		     Join adi.Steward_BCBS_ProfessionallClaim cd
		  	  ON ast.LatestClaimAdiKey = cd.ProfessionalClaimKey    
		  WHERE cd.DataDate <= @DataDate AND ISNULL(cd.HLDiagnosisCode12 , '') <> ''
			 AND ast.SrcClaimType = 'PROF'*/
	   ) SRC
    

	SELECT @OutCnt = COUNT(*) FROM #OutputTbl Otb WHERE Otb.srcClaimType = 'PROF'
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
/* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */
-- no rx diags
