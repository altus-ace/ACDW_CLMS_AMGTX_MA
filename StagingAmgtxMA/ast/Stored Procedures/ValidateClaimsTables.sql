create PROCEDURE [ast].[ValidateClaimsTables] 
AS 
BEGIN
   -- CREATE TABLE #ClaimsValidationCounts(skey INT IDENTITY(1,1) PRIMARY KEY
	--   , [ValidationType] VARCHAR(20)
	--   , cnt INT
	--   , PrimarySvcYear INT
	--   , CatOfSvc VARCHAR(20) DEFAULT('ALL')
	--   );
   --
       
	
	SELECT 'ast.Hdr_01' [Test] , COUNT(*) TestResult, d.LoadDate, d.SrcClaimType
	FROM  ast.Claim_01_Header_Dedup d --- produce a list of some composition and cardinality
	GROUP BY d.LoadDate, d.SrcClaimType;
	
	
	SELECT 'ast.Hdr_02 ' [Test] , COUNT(*) TestResult, d.LoadDate, d.SrcClaimType
	FROM  ast.Claim_02_HeaderSuperKey d
	GROUP BY d.LoadDate, d.srcClaimType;
	
	SELECT 'ast.Hdr_03' [Test] , COUNT(*) TestResult, GETDATE() LoadDate, d.SrcClaimType
	FROM  ast.Claim_03_Header_LatestEffective d
	GROUP BY d.SrcClaimType;

	SELECT 'ast.Dtl_04' [Test] , COUNT(*) TestResult, GETDATE() LoadDate, d.SrcClaimType
	FROM  ast.Claim_04_Detail_Dedup d
	GROUP BY d.SrcClaimType;
	
	
	SELECT 'ast.Prc_05' [Test] , COUNT(*) TestResult, GETDATE() LoadDate, d.SrcClaimType
	FROM  ast.Claim_05_Procs_Dedup d
	GROUP BY d.SrcClaimType;
	
	
	SELECT 'ast.Dia_06' [Test] , COUNT(*) TestResult, GETDATE() LoadDate, d.SrcClaimType
	FROM  ast.Claim_06_Diag_Dedup d
	group by d.SrcClaimType;


	SELECT COUNT(*) Cnt, 'hdr' Test FROM  adw.Claims_Headers	;
	SELECT COUNT(*) Cnt, 'dtl' Test FROM adw.Claims_Details		;
	SELECT COUNT(*) Cnt, 'dia' Test FROM adw.Claims_Diags		;
	SELECT COUNT(*) Cnt, 'pro' Test FROM adw.Claims_Procs		;
	SELECT COUNT(*) Cnt, 'mbr' Test FROM adw.Claims_Member		;

	/* CLIAIMS STAGING TABLE TEST CASES: CARDINALITY TESTS */

	/* 01 has a cardinality of 1 */
	SELECT 'Staging Table Cardinality Test, any rows that are returned, failed and the data in the table violates the cardinality requirement.' as TEST;
	SELECT hd.SrcAdiKey ,  COUNT(*)  CountTestFail , 'Hdr' Test
		FROM  ast.Claim_01_Header_Dedup hd 
			GROUP BY hd.SrcAdiKey having COUNT(*) > 1			;
	/* 03 should have a cardinality of 1, any that do not are SHOW STOPPER */
	SELECT le.LatestClaimAdiKey srcAdiKey, COUNT(*) CountTestFail, 'SuperKey' TEST 
		FROM  ast.Claim_03_Header_LatestEffective le group by le.LatestClaimAdiKey having COUNT(*) > 1;
	/* 04 should ahve a cardinality of 1 */
	SELECT d.ClaimSeqClaimId, d.ClaimDetailLineNumber, COUNT(*)  CountTestFail , 'Details' Test FROM  ast.Claim_04_Detail_Dedup d	GROUP BY d.ClaimSeqClaimId, d.ClaimDetailLineNumber HAVING COUNT(*)>1;
	SELECT p.ProcAdiKey, p.ProcNumber, COUNT(*)  CountTestFail , 'Procs' Test FROM  ast.Claim_05_Procs_Dedup	p	GROUP BY p.ProcAdiKey, p.ProcNumber HAVING COUNT(*)>1;
	SELECT d.DiagAdiKey, d.DiagNum, COUNT(*)  CountTestFail , 'Diags' Test FROM  ast.Claim_06_Diag_Dedup	d	GROUP BY d.DiagAdiKey, d.DiagNum HAVING COUNT(*)>1;

	--- produce a list of some composition and cardinality
END
