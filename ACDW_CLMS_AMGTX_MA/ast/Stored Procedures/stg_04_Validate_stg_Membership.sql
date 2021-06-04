

CREATE PROCEDURE [ast].[stg_04_Validate_stg_Membership](@DataDate DATE
														,@MbrShipDataDate DATE
														,@EffectiveDate DATE
														,@MbrEligDataDate DATE) 
														-- [ast].[stg_04_Validate_stg_Membership]'2021-04-15','2021-04-15','2021-04-01','2021-04-15'
AS

BEGIN
	-----To fill in later.

	--Validate qualified records
	--  
	CREATE TABLE #Output(Cnt INT)
	INSERT INTO #Output
	OUTPUT inserted.Cnt
	SELECT		COUNT(*) LatestRecordCntAMGTX_MA
	FROM		(
				SELECT		m.MasterConsumerID
							,pr.NPI
							,pr.AttribTIN
				FROM		adi.Amerigroup_Member m 
				LEFT JOIN	adi.Amerigroup_MemberEligibility e
				ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
				AND			m.PG_ID = e.PG_ID
				LEFT JOIN		(SELECT  SourceValue,TargetValue
								FROM	lst.lstPlanMapping a
								WHERE	ClientKey = 21
								AND		TargetSystem = 'ACDW'
								AND		GETDATE() BETWEEN EffectiveDate AND ExpirationDate
								AND		ACTIVE = 'Y'
								)pl
				ON			m.BNFTPKGID = pl.SourceValue
				LEFT JOIN     (SELECT AttribTIN ,NPI
									FROM [ACECAREDW].adw.tvf_AllClient_ProviderRoster(21,GETDATE(),1) 
							   )pr
				ON			m.Responsible_NPI = pr.NPI
				WHERE		LOB = 'Medicare'
				AND			m.DataDate = @MbrShipDataDate
				AND			e.DataDate = @MbrEligDataDate
				AND			@MbrShipDataDate  BETWEEN e.[EligibilityEffectiveDate]  AND e.[EligibilityEndDate] 
				AND			@MbrEligDataDate  BETWEEN m.EffectiveDate				AND m.[TerminationDate]
				AND			e.PRDCTSL = 'HMO'
				)cnt
	--SELECT * FROM #Output
	
	DROP TABLE #Output
END
	
	--- Checking for Invalid Records
	SELECT		COUNT(*)RecCnt, stgRowStatus
	FROM		ast.MbrStg2_MbrData
	WHERE		DataDate = @DataDate
	AND			EffectiveDate = @EffectiveDate
	GROUP BY	stgRowStatus

	--Checking for Members without Valid Plans
	---Create a new field to have a status on these
	SELECT		stgRowStatus,*
	FROM		ast.MbrStg2_MbrData stg
	WHERE		DataDate = @DataDate
	AND			EffectiveDate = @EffectiveDate
	AND			[plnProductSubPlanName] = 'No Plan'

	--Checking for AceID>1
		SELECT	 COUNT(*) RecCnt, MstrMrnKey
    FROM	 ast.MbrStg2_MbrData
    WHERE	 DataDate =  @DataDate 
	GROUP BY MstrMrnKey
	HAVING	 COUNT(*) >1


