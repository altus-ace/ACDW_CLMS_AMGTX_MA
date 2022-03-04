
CREATE PROCEDURE [adi].[ValidateMemberShip]

AS

BEGIN

	DECLARE @LoadDate DATE = (SELECT MAX(LoadDate) FROM ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member) SELECT @LoadDate

	IF OBJECT_ID('tempdb..#gtDates') IS NOT NULL DROP TABLE #gtDates
	DECLARE @a INT  = 1
	WHILE (@a <= 1)
	---SET @a = 1
	BEGIN
		SELECT		DISTINCT TOP 1 m.DataDate AS MbrDataDate
					,e.DataDate AS EligDataDate,m.LoadDate
					,e.LoadDate AS eLoadDate
					,m.RowStatus AS MbrRowStatus,e.RowStatus 
		INTO		#gtDates
		FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member m
		JOIN		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility e
		ON			m.MasterConsumerID=e.MASTER_CONSUMER_ID
		AND			m.DataDate = e.DataDate
		ORDER BY	m.DataDate DESC
					,e.DataDate DESC
	
	SET			@a = @a + 1
	
	END

	SELECT * FROM #gtDates

	
	
	/*Checking to see if assigned NPIs are captured in the PR*/
	DECLARE @MappingTypeKey INT = 22
	DECLARE @ClientKey INT = 21
	SELECT	DISTINCT AttribTIN ,NPI,Source AS AttribTIN_Doesnt_Exist_in_PR,Destination
	FROM	(	SELECT	Source,Destination
				FROM	lst.ListAceMapping
				WHERE	ClientKey = @ClientKey
				AND		MappingTypeKey = @MappingTypeKey
			)aceplMap
	LEFT JOIN (SELECT AttribTIN,NPI 
				FROM ACECAREDW.adw.tvf_AllClient_ProviderRoster(@ClientKey, @LoadDate,1)
			  )pr
	ON		 aceplMap.Source = pr.AttribTIN
	AND		 aceplMap.Destination = pr.NPI
	WHERE	pr.AttribTIN IS NULL


	SELECT	COUNT(*)AdiCntForThCurrentDate_Amerigroup_Member
	FROM	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member a
	WHERE	LoadDate = (SELECT MAX(LoadDate) 
						FROM ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member)

	SELECT	COUNT(*)AdiCntForThCurrentDate_Amerigroup_MemberEligibility
	FROM	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility a
	WHERE	LoadDate = (SELECT MAX(LoadDate) 
						FROM ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility)

	-- To get Invalid Plans
		SELECT	DISTINCT m.BNFTPKGID,LOB
					,SourceValue
					--m.BNFTPKGName,
		FROM	ACDW_CLMS_AMGTX_MA.[adi].[Amerigroup_Member] m
		LEFT JOIN lst.lstPlanMapping lst
		ON		lst.SourceValue = m.BNFTPKGID
		WHERE	DataDate = (SELECT MbrDataDate 
								FROM #gtDates)
		AND		lst.SourceValue IS NULL


		---Medicare
		SELECT		COUNT(*) TotalMbrCountForMedicare--- a.MasterConsumerID,b.MASTER_CONSUMER_ID,a.LOB
					--,a.DataDate,b.*,a.*
		FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member a
		LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility b
		ON			a.MasterConsumerID = b.MASTER_CONSUMER_ID
		WHERE		a.LoadDate = (SELECT LoadDate FROM #gtDates)
		AND			b.LoadDate =  (SELECT LoadDate FROM #gtDates)
		AND			LOB = 'Medicare'
		AND			a.LoadDate BETWEEN a.EffectiveDate AND a.TerminationDate
		AND			a.PG_ID = b.PG_ID
		AND			b.PRDCTSL = 'HMO'
		AND			a.LoadDate BETWEEN b.EligibilityEffectiveDate AND b.EligibilityEndDate 
		

		--Total MbrMembership Count for Amerigroup
		SELECT		COUNT(*) TotalMbrCountForAmerigroup--- a.MasterConsumerID,b.MASTER_CONSUMER_ID,a.LOB
					--,a.DataDate,b.*,a.*
		FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member a
		LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility b
		ON			a.MasterConsumerID = b.MASTER_CONSUMER_ID
		WHERE		a.LoadDate = (SELECT LoadDate FROM #gtDates)
		AND			b.LoadDate =  (SELECT LoadDate FROM #gtDates)

		--Match against NPI and Plans
		SELECT	COUNT(*)ValidMbrToBeProcessedIntoADWMinusAssigned
		FROM	(
					SELECT		MasterConsumerID,m.Responsible_NPI,pr.NPI,m.LoadDate ---COUNT(*)--
								,Responsible_Tax_ID_Could_Contain_SSN,LOB
								,ROW_NUMBER()OVER(PARTITION BY MasterConsumerID,NPI ORDER BY m.DataDate DESC)RwCnt
								,m.BNFTPKGID
					FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member m
					LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility e
					ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
					AND			m.PG_ID = e.PG_ID
					LEFT JOIN	(SELECT * from [ACECAREDW].adw.tvf_AllClient_ProviderRoster(21, (SELECT LoadDate FROM #gtDates),1)
								)pr
					ON			pr.NPI = m.Responsible_NPI
					LEFT JOIN   (SELECT ClientKey,SourceValue,TargetValue, ACTIVE
									FROM lst.lstPlanMapping 
									WHERE ClientKey = 21 
									AND TargetSystem = 'ACDW_Plan' 
									AND @LoadDate BETWEEN EffectiveDate AND ExpirationDate)lstplan
					ON			m.BNFTPKGID = lstplan.SourceValue
					WHERE		m.LOB = 'Medicare'
					AND			m.LoadDate =  (SELECT LoadDate FROM #gtDates)
					AND			E.LoadDate =  (SELECT LoadDate FROM #gtDates)
					AND			m.LoadDate BETWEEN m.EffectiveDate AND m.TerminationDate
					AND			e.LoadDate BETWEEN e.EligibilityEffectiveDate AND e.EligibilityEndDate 
					AND			e.PRDCTSL = 'HMO'
					AND			pr.NPI IS NOT NULL
					AND			lstplan.SourceValue IS NOT NULL
				)src
		WHERE	RwCnt = 1
	END

	--Match against NPI
		SELECT	COUNT(*)ValidMbrwithNPIMinusAssigned
		FROM	(
					SELECT		MasterConsumerID,m.Responsible_NPI,pr.NPI,m.LoadDate ---COUNT(*)--
								,Responsible_Tax_ID_Could_Contain_SSN,LOB
								,ROW_NUMBER()OVER(PARTITION BY MasterConsumerID,NPI ORDER BY m.DataDate DESC)RwCnt
								,m.BNFTPKGID
					FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member m
					LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility e
					ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
					AND			m.PG_ID = e.PG_ID
					LEFT JOIN	(SELECT * from [ACECAREDW].adw.tvf_AllClient_ProviderRoster(21, (SELECT LoadDate FROM #gtDates),1)
								)pr
					ON			pr.NPI = m.Responsible_NPI
					LEFT JOIN   (SELECT ClientKey,SourceValue,TargetValue, ACTIVE
									FROM lst.lstPlanMapping 
									WHERE ClientKey = 21 
									AND TargetSystem = 'ACDW_Plan' 
									AND @LoadDate BETWEEN EffectiveDate AND ExpirationDate)lstplan
					ON			m.BNFTPKGID = lstplan.SourceValue
					WHERE		m.LOB = 'Medicare'
					AND			m.LoadDate =  (SELECT LoadDate FROM #gtDates)
					AND			E.LoadDate =  (SELECT LoadDate FROM #gtDates)
					AND			m.LoadDate BETWEEN m.EffectiveDate AND m.TerminationDate
					AND			e.LoadDate BETWEEN e.EligibilityEffectiveDate AND e.EligibilityEndDate 
					AND			e.PRDCTSL = 'HMO'
					AND			pr.NPI IS NOT NULL
				)src
		WHERE	RwCnt = 1

		--Match against Plans
		SELECT	COUNT(*)ValidMbrWithPlans
		FROM	(
					SELECT		MasterConsumerID,m.Responsible_NPI,pr.NPI,m.LoadDate ---COUNT(*)--
								,Responsible_Tax_ID_Could_Contain_SSN,LOB
								,ROW_NUMBER()OVER(PARTITION BY MasterConsumerID,NPI ORDER BY m.DataDate DESC)RwCnt
								,m.BNFTPKGID
					FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member m
					LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility e
					ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
					AND			m.PG_ID = e.PG_ID
					LEFT JOIN	(SELECT * from [ACECAREDW].adw.tvf_AllClient_ProviderRoster(21, (SELECT LoadDate FROM #gtDates),1)
								)pr
					ON			pr.NPI = m.Responsible_NPI
					LEFT JOIN   (SELECT ClientKey,SourceValue,TargetValue, ACTIVE
									FROM lst.lstPlanMapping 
									WHERE ClientKey = 21 
									AND TargetSystem = 'ACDW_Plan' 
									AND @LoadDate BETWEEN EffectiveDate AND ExpirationDate)lstplan
					ON			m.BNFTPKGID = lstplan.SourceValue
					WHERE		m.LOB = 'Medicare'
					AND			m.LoadDate =  (SELECT LoadDate FROM #gtDates)
					AND			E.LoadDate =  (SELECT LoadDate FROM #gtDates)
					AND			m.LoadDate BETWEEN m.EffectiveDate AND m.TerminationDate
					AND			e.LoadDate BETWEEN e.EligibilityEffectiveDate AND e.EligibilityEndDate 
					AND			e.PRDCTSL = 'HMO'
					AND			lstplan.SourceValue IS NOT NULL
				)src
		WHERE	RwCnt = 1
	
	/*
	SELECT	 adikey,prvnpi, prvtin, srcNPI,srcTIN,stgrowstatus
			 ,MstrMrnKey,DataDate,loaddate,EffectiveDate
			 ,MbrnpiFlg,MbrPlnFlg,MbrFlgCount,NPIReplacedFlg
			 ,srcpln,plnClientPlanEffective
			 ,plnClientPlanEndDate --- 2021-10-31
			 ,plnProductPlan,plnProductSubPlan,plnProductSubPlanName,CsplnProductSubPlanName
			 ,prvClientEffective,prvClientExpiration,ClientSubscriberID -- select distinct srcpln
	FROM	 ast.mbrstg2_mbrdata 
	WHERE	 effectivedate = '2022-02-01' --AND PRVnpi IS not null and plnproductplan is null
	AND		 stgrowstatus  = 'Valid'


	SELECT	stgRowStatus,* 
	FROM	ast.MbrStg2_PhoneAddEmail
	WHERE	LoadDate = '2022-02-01'
	AND		 stgrowstatus  = 'Valid'*/

	


