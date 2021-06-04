
CREATE PROCEDURE adi.ValidateMemberShip

AS

BEGIN



	IF OBJECT_ID('tempdb..#gtDates') IS NOT NULL DROP TABLE #gtDates
	DECLARE @a INT  = 1
	WHILE @a <= 1
	BEGIN
		SELECT		DISTINCT TOP 1 m.DataDate AS MbrDataDate
					,e.DataDate AS EligDataDate
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


		---Medicare
		SELECT		COUNT(*) TotalMbrCount--- a.MasterConsumerID,b.MASTER_CONSUMER_ID,a.LOB
					--,a.DataDate,b.*,a.*
		FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member a
		LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility b
		ON			a.MasterConsumerID = b.MASTER_CONSUMER_ID
		WHERE		a.DataDate = (SELECT MbrDataDate FROM #gtDates)
		AND			b.DataDate =  (SELECT MbrDataDate FROM #gtDates)
		AND			LOB = 'Medicare'
		AND			a.DataDate BETWEEN a.EffectiveDate AND a.TerminationDate
		AND			a.PG_ID = b.PG_ID
		AND			b.PRDCTSL = 'HMO'
		AND			a.DataDate BETWEEN b.EligibilityEffectiveDate AND b.EligibilityEndDate 
		

		--Match against NPI
		SELECT	*
		FROM	(
					SELECT		MasterConsumerID,m.Responsible_NPI,pr.NPI ---COUNT(*)--
								,Responsible_Tax_ID_Could_Contain_SSN,LOB
								,ROW_NUMBER()OVER(PARTITION BY MasterConsumerID,NPI ORDER BY m.DataDate DESC)RwCnt
					FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member m
					LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility e
					ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
					AND			m.PG_ID = e.PG_ID
					LEFT JOIN	(SELECT * from [ACECAREDW].adw.tvf_AllClient_ProviderRoster(21, (SELECT MbrDataDate FROM #gtDates),1)
								)pr
					ON			pr.NPI = m.Responsible_NPI
					WHERE		m.LOB = 'Medicare'
					AND			m.DataDate =  (SELECT MbrDataDate FROM #gtDates)
					AND			E.DataDate =  (SELECT MbrDataDate FROM #gtDates)
					AND			m.DataDate BETWEEN m.EffectiveDate AND m.TerminationDate
					AND			e.DataDate BETWEEN e.EligibilityEffectiveDate AND e.EligibilityEndDate 
					AND			e.PRDCTSL = 'HMO'
					AND			pr.NPI IS NOT NULL
				)src
		WHERE	RwCnt = 1

		SELECT	COUNT(*)MbrCountToLoad
		FROM	(
					SELECT		MasterConsumerID,m.Responsible_NPI,pr.NPI ---COUNT(*)--
								,Responsible_Tax_ID_Could_Contain_SSN,LOB
								,ROW_NUMBER()OVER(PARTITION BY MasterConsumerID,NPI ORDER BY m.DataDate DESC)RwCnt
					FROM		ACDW_CLMS_AMGTX_MA.adi.Amerigroup_Member m
					LEFT JOIN	ACDW_CLMS_AMGTX_MA.adi.Amerigroup_MemberEligibility e
					ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
					AND			m.PG_ID = e.PG_ID
					LEFT JOIN	(SELECT * from [ACECAREDW].adw.tvf_AllClient_ProviderRoster(21, (SELECT MbrDataDate FROM #gtDates),1)
								)pr
					ON			pr.NPI = m.Responsible_NPI
					WHERE		m.LOB = 'Medicare'
					AND			m.DataDate =  (SELECT MbrDataDate FROM #gtDates)
					AND			E.DataDate =  (SELECT MbrDataDate FROM #gtDates)
					AND			m.DataDate BETWEEN m.EffectiveDate AND m.TerminationDate
					AND			e.DataDate BETWEEN e.EligibilityEffectiveDate AND e.EligibilityEndDate 
					AND			e.PRDCTSL = 'HMO'
					AND			pr.NPI IS NOT NULL
				)src
		WHERE	RwCnt = 1
	END