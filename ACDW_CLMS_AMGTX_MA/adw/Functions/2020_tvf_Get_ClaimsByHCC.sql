
CREATE  FUNCTION [adw].[2020_tvf_Get_ClaimsByHCC]
(
 @PrimSvcDate_Start VARCHAR(20), 
 @PrimSvcDate_End   VARCHAR(20),
 @CodesetEffDate	VARCHAR(20)
)
RETURNS TABLE
AS RETURN
(
		SELECT B1.[SEQ_CLAIM_ID]
			  ,B1.[SUBSCRIBER_ID]
			  ,B1.[CATEGORY_OF_SVC]
			  ,B1.[PRIMARY_SVC_DATE]
			  ,B1.[SVC_TO_DATE]
			  ,B1.[CLAIM_THRU_DATE]
			  ,B1.[VEND_FULL_NAME]
			  ,B1.[PROV_SPEC]
			  ,B1.[IRS_TAX_ID]
			  ,B1.[DRG_CODE]
			  ,B1.[BILL_TYPE]		
			  ,B1.[ADMISSION_DATE]
			  ,B1.[CLAIM_TYPE]
			  ,B1.[TOTAL_BILLED_AMT]
			  ,B1.[TOTAL_PAID_AMT]
			  ,D.ValueCode
			  ,D.HCC AS HCC_CODE
			  ,CASE WHEN DATEDIFF(dd, PRIMARY_SVC_DATE, SVC_TO_DATE) = 0 THEN 1 ELSE DATEDIFF(dd, PRIMARY_SVC_DATE, SVC_TO_DATE) END AS LOS
			  ,DATEDIFF(dd,B1.PRIMARY_SVC_DATE, GETDATE())			AS DaysSincePrimarySvcDate
		  FROM [adw].[Claims_Headers] B1
		  INNER JOIN
			(
				SELECT DISTINCT C3.SEQ_CLAIM_ID, L33.ICDCode AS ValueCode, L33.HCC
				FROM adw.Claims_Diags C3 
				INNER JOIN
				(
					SELECT DISTINCT [ICDCode],[HCC]
					FROM [lst].[LIST_ICDcwHCC] L3
					WHERE LEN(L3.HCC) > 0
					AND @CodesetEffDate BETWEEN L3.EffectiveDate AND L3.ExpirationDate
				) L33 ON L33.[ICDCode] = C3.diagCodeWithoutDot
			) AS D 
		ON D.SEQ_CLAIM_ID = B1.SEQ_CLAIM_ID
		WHERE B1.SEQ_CLAIM_ID IS NOT NULL
		--AND B1.PROCESSING_STATUS	= 'P'
		AND CONVERT(DATETIME, B1.PRIMARY_SVC_DATE)	>=  @PrimSvcDate_Start
		AND CONVERT(DATETIME, B1.SVC_TO_DATE)			<=  @PrimSvcDate_End
)

/***
Usage: 
SELECT *
FROM [adw].[2020_tvf_Get_ClaimsByHCC] ('01/01/2019','12/31/2019','12/31/2019')
***/
