
CREATE PROCEDURE [adi].[ValidateCareopps]

AS

	/* Checking for Max Dates*/
	SELECT	COUNT(*)RecCnt,DataDate AS DataDate_plsCareopps_AllMeasures,RowStatus
	FROM	[adi].[Amerigroup_AltusAceGap]  -- update [adi].[Amerigroup_AltusAceGap]  set rowstatus = 0 where datadate = '2022-02-01'
	--WHERE	RowStatus = 0
	GROUP BY DataDate,RowStatus
	ORDER BY DataDate DESC
	

	SELECT	COUNT(*)RecCnt,DataDate AS DataDate_plsCareopps_GapAdherence,RowStatus
	FROM	 [adi].[Amerigroup_AltusAceGapAdherence] 
	WHERE	RowStatus = 0
	GROUP BY DataDate,RowStatus
	ORDER BY DataDate DESC

	
	/* AWV*/
	SELECT	COUNT(*)AWVCareOpps, LoadDate
			, a.RowStatus,a.DataDate
	FROM	[adi].[Amerigroup_MA_WellnessVisits] a
	GROUP BY LoadDate
			 ,a.DataDate
			 ,a.RowStatus
	ORDER BY LoadDate DESC
	
	/*A: Validating for [ast].[plsCareopps_AllMeasures] [adi].[Amerigroup_AltusAceGap]
			Show me measures in both adi and look up table*/
	DECLARE @DataDateAltusAceGroup DATE = (
					SELECT	MAX(DataDate)
					FROM	[adi].[Amerigroup_AltusAceGap]
					)
	SELECT	DISTINCT Measures AS MeasuresInAdiAndLookUpTableForplsCareopps_AllMeasures
			, Source,Destination
	FROM	(	/*List of all Pivoted Columns*/
				SELECT	[BCS] ,[CBP],[CDC_HbA1c_Test]
						,[CDC_HbA1c_LE9] ,[CDC_EyeExam] 
						,[CDC_Nephro],[KED]	,[COA_ACP],[COA_FSA],[COA_MR] ,[COA_PS]
						,[COL],[OSW],CAST(OMW collate database_default AS VARCHAR(20)) AS [OMW] ,[AOMW]
						,[FUH_Followup_30],[FUH_Followup_7],[TRC_ENGAGEMENT] ,[SPC_REC_TOTAL]
						,CAST([TRC_RECONCILIATION] collate database_default AS VARCHAR(20)) AS[TRC_RECONCILIATION]
				FROM	adi.[Amerigroup_AltusAceGap] adi
				WHERE	DataDate = @DataDateAltusAceGroup
			)adi
	UNPIVOT
			(Metrics FOR Measures IN ([BCS] ,[CBP],[CDC_HbA1c_Test]
						,[CDC_HbA1c_LE9] ,[CDC_EyeExam] 
						,[CDC_Nephro],[KED]	,[COA_ACP]
						,[COA_FSA],[COA_MR] ,[COA_PS]
						,[COL],[OSW],[OMW] ,[AOMW]
						,[FUH_Followup_30]
						,[FUH_Followup_7]
						,[TRC_ENGAGEMENT] 
						,[SPC_REC_TOTAL]
						,[TRC_RECONCILIATION]))pvt
	JOIN (SELECT	Destination,Source
					FROM	lst.ListAceMapping
					WHERE	ClientKey = 21
					AND		MappingTypeKey = 14
					AND IsActive = 1) lstAce
	ON	pvt.Measures = lstAce.Source

	/*B: Show me Measures not in the look up Table*/
	SELECT	DISTINCT Measures AS MeasuresNotInTheLookUpTableForplsCareopps_AllMeasures
			, Source,Destination
	FROM	(	/*List of all Pivoted Columns*/
				SELECT	[BCS] ,[CBP],[CDC_HbA1c_Test],[CDC_HbA1c_LE9] ,[CDC_EyeExam] 
						,[CDC_Nephro],[KED]	,[COA_ACP],[COA_FSA],[COA_MR] ,[COA_PS]
						,[COL],[OSW],CAST(OMW collate database_default AS VARCHAR(20)) AS [OMW] ,[AOMW]
						,[FUH_Followup_30],[FUH_Followup_7],[TRC_ENGAGEMENT] ,[SPC_REC_TOTAL]
						,CAST([TRC_RECONCILIATION] collate database_default AS VARCHAR(20)) AS[TRC_RECONCILIATION]
				FROM	adi.[Amerigroup_AltusAceGap] adi
				WHERE	DataDate = @DataDateAltusAceGroup
			)adi
	UNPIVOT
			(Metrics FOR Measures IN ([BCS] ,[CBP],[CDC_HbA1c_Test]
						,[CDC_HbA1c_LE9] ,[CDC_EyeExam] 
						,[CDC_Nephro],[KED]	,[COA_ACP]
						,[COA_FSA],[COA_MR] ,[COA_PS]
						,[COL],[OSW],[OMW] ,[AOMW]
						,[FUH_Followup_30]
						,[FUH_Followup_7]
						,[TRC_ENGAGEMENT] 
						,[SPC_REC_TOTAL]
						,[TRC_RECONCILIATION]))pvt
	LEFT JOIN (SELECT	Destination,Source
					FROM	lst.ListAceMapping
					WHERE	ClientKey = 21
					AND		MappingTypeKey = 14
					AND IsActive = 1) lstAce
	ON	pvt.Measures = lstAce.Source
	WHERE	lstAce.Source IS NULL





	/*C: Validating for [ast].[plsCareopps_GapADherence] [adi].[Amerigroup_AltusAceGapAdherence]
			Show me measures in both adi and lookup table*/
	DECLARE @DataDateAltusAceGapAdherence DATE = (
					SELECT	MAX(DataDate)
					FROM	[adi].[Amerigroup_AltusAceGapAdherence]
					)
	SELECT	DISTINCT Measures AS MeasuresInAdiAndLookUpTableForplsCareopps_GapAdherence
			, Source,Destination
	FROM	(	/*List of all Pivoted Columns*/
				SELECT	[DiabetesProportionDaysCovered_PDC]
						,[HypertensionProportionDaysCovered_PDC]
						,[CholesterolProportionofDaysCovered_PDC]
						,[Statin_use_inPersonsWDiabetesIndicator]
				FROM	adi.[Amerigroup_AltusAceGapAdherence] adi
				WHERE	DataDate = @DataDateAltusAceGapAdherence
			)adi
	UNPIVOT
			(Metrics FOR Measures IN ([DiabetesProportionDaysCovered_PDC]
									,[HypertensionProportionDaysCovered_PDC]
									,[CholesterolProportionofDaysCovered_PDC]
									,[Statin_use_inPersonsWDiabetesIndicator]))pvt
	JOIN (SELECT	Destination,Source
					FROM	lst.ListAceMapping
					WHERE	ClientKey = 21
					AND		MappingTypeKey = 14
					AND IsActive = 1) lstAce
	ON	pvt.Measures = lstAce.Source

	/*D: Show me Measures not in the look up Table*/
	SELECT	DISTINCT Measures AS MeasuresNotInTheLookUpTableplsCareopps_GapAdherence
			, Source,Destination
	FROM	(	/*List of all Pivoted Columns*/
				SELECT	[DiabetesProportionDaysCovered_PDC]
						,[HypertensionProportionDaysCovered_PDC]
						,[CholesterolProportionofDaysCovered_PDC]
						,[Statin_use_inPersonsWDiabetesIndicator]
				FROM	adi.[Amerigroup_AltusAceGapAdherence] adi
				WHERE	DataDate = @DataDateAltusAceGapAdherence
			)adi
	UNPIVOT
			(Metrics FOR Measures IN ([DiabetesProportionDaysCovered_PDC]
									,[HypertensionProportionDaysCovered_PDC]
									,[CholesterolProportionofDaysCovered_PDC]
									,[Statin_use_inPersonsWDiabetesIndicator]))pvt
	LEFT JOIN (SELECT	Destination,Source
					FROM	lst.ListAceMapping
					WHERE	ClientKey = 21
					AND		MappingTypeKey = 14
					AND IsActive = 1) lstAce
	ON	pvt.Measures = lstAce.Source
	WHERE	lstAce.Source IS NULL


----/*Validate staging*/
	/*
	
		
		
	SELECT COUNT(*)RecCnt
			,astRowStatus
			,QmMsrId,QmCntCat
			,MbrCareOpToPlnFlg
			,MbrCOPInContractFlg
			,MbrActiveFlg
	FROM	ast.QM_ResultByMember_History 
	WHERE	QMDate = '2022-01-15'
	AND		astRowStatus = 'Valid' --- 'Exported' -- 
	GROUP BY astRowStatus
			,QmMsrId,QmCntCat
			,MbrCareOpToPlnFlg
			,MbrCOPInContractFlg
			,MbrActiveFlg
	ORDER BY QmMsrId,QmCntCat
		
	--ADW

	SELECT          COUNT(*)
                       ,[QmMsrId]
                       ,[QmCntCat] 
       FROM            [adw].[QM_ResultByMember_History]
       WHERE           QMDate = '2022-01-15'
       AND             ClientKey = 21
       GROUP BY        [QmMsrId]
                       ,[QmCntCat]
       ORDER BY        [QmMsrId],[QmCntCat]

	SELECT	*
	FROM	adw.QM_ResultByValueCodeDetails_History
	WHERE	QMDate = '2022-01-15'

	SELECT	COUNT(*)
			,MbrActiveFlg
			,MbrCareOpToPlnFlg
			,MbrCOPInContractFlg
	FROM	adw.FailedCareOpps
	WHERE   QMDate = '2022-01-15'
	GROUP BY MbrActiveFlg
			,MbrCareOpToPlnFlg
			,MbrCOPInContractFlg
	*/

	