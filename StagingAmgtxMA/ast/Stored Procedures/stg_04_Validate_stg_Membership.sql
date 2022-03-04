

CREATE PROCEDURE [ast].[stg_04_Validate_stg_Membership](@MbrShipDataDate DATE
														,@EffectiveDate DATE
														,@MbrEligDataDate DATE) 
														-- [ast].[stg_04_Validate_stg_Membership]'2021-09-16','2021-10-01','2021-09-16'
AS

BEGIN
	DECLARE @ClientKey INT = (SELECT ClientKey FROM lst.list_client)

	BEGIN
	/*Updating StgRowStatusin staging*/

		UPDATE		ast.MbrStg2_MbrData
		SET			stgRowStatus = 'Exported'
		WHERE		stgRowStatus = 'VALID'
		AND			DataDate = @MbrShipDataDate

	END
	
	BEGIN
	/*Updating StgRowStatus MbrStgAddressPhone in staging*/

		UPDATE		[ast].[MbrStg2_PhoneAddEmail]
		SET			stgRowStatus = m.stgRowStatus 
		FROM		[ast].[MbrStg2_PhoneAddEmail] ad
		JOIN		(SELECT  MAX(DataDate) DataDate
							,AdiKey,stgRowStatus
					 FROM	ast.MbrStg2_MbrData
					 WHERE	ClientKey = @ClientKey
					 AND	DataDate = @MbrShipDataDate
					 GROUP BY AdiKey,stgRowStatus
									)m
		ON		   ad.AdiKey = m.AdiKey
		WHERE	   ad.DataDate = @MbrShipDataDate

	END

	/*Upload Failed Membership Table*/
	BEGIN
	EXEC [adw].[pdw_Load_FailedMembership]@EffectiveDate

	END

	/*Create AWV Programs for New Members*/
	BEGIN
	DECLARE @ProgramID INT = 22
	EXECUTE [ast].[PdwCreateExportProgram]@EffectiveDate,@ClientKey,@ProgramID

	END
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
								AND		@MbrShipDataDate BETWEEN EffectiveDate AND ExpirationDate
								AND		ACTIVE = 'Y'
								)pl
				ON			m.BNFTPKGID = pl.SourceValue
				LEFT JOIN     (SELECT AttribTIN ,NPI
									FROM [ACECAREDW].adw.tvf_AllClient_ProviderRoster(21,@MbrShipDataDate,1) 
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
	WHERE		DataDate = @MbrShipDataDate
	AND			EffectiveDate = @EffectiveDate
	GROUP BY	stgRowStatus

	--Checking for Members without Valid Plans
	---Create a new field to have a status on these
	SELECT		stgRowStatus,*
	FROM		ast.MbrStg2_MbrData stg
	WHERE		DataDate = @MbrShipDataDate
	AND			EffectiveDate = @EffectiveDate
	AND			[plnProductSubPlanName] = 'No Plan'

	--Checking for AceID>1
		SELECT	 COUNT(*) RecCnt, MstrMrnKey
    FROM	 ast.MbrStg2_MbrData
    WHERE	 DataDate =  @MbrShipDataDate 
	GROUP BY MstrMrnKey
	HAVING	 COUNT(*) >1


