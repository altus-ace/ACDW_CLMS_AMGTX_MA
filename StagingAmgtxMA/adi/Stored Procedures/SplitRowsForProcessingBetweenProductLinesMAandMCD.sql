

CREATE PROCEDURE adi.SplitRowsForProcessingBetweenProductLinesMAandMCD -- adi.SplitRowsForProcessingBetweenProductLinesMAandMCD '2021-05-11'
				(@DataDate DATE OUTPUT)

AS

	BEGIN


	SELECT @DataDate  = (SELECT MAX(DataDate) 
								FROM adi.[Amerigroup_CARE-OPPS] ) 
	SELECT @DataDate DateDate
--Setting to 3 where condition is not in Medicare
	UPDATE	adi.[Amerigroup_CARE-OPPS] 
	SET		MA_RowStatus = 3
	WHERE	DataDate = @DataDate
	AND		(PG_NAME <> 'TX_Altus_ACE_MCR'
	AND		PG_ID <> 'TX000425'
	AND		PGM_ID <> 'TXTAA0101' )
	


--- Setting to 3 where condition is not in Medicare
	UPDATE	adi.[Amerigroup_CARE-OPPS] 
	SET		MCD_RowStatus = 3
	WHERE	DataDate = @DataDate
	AND		(PG_NAME <> 'TX_Altus_ACE_MCD'
	AND		PG_ID <> 'TX000424'
	AND		PGM_ID <> 'TXTAA0102')


	
	SELECT		COUNT(*)RecCnt, PG_NAME,DataDate
				, PG_ID,PGM_ID,MA_RowStatus,MCD_RowStatus
	FROM		[adi].[Amerigroup_CARE-OPPS]
	GROUP BY	PG_NAME,DataDate
				, PG_ID,PGM_ID,MA_RowStatus
				,MCD_RowStatus
	ORDER BY	DataDate DESC

	END