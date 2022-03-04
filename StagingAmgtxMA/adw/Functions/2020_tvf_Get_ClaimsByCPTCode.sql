﻿
CREATE  FUNCTION [adw].[2020_tvf_Get_ClaimsByCPTCode]
(
 @PrimSvcDate_Start DATE, 
 @PrimSvcDate_End   DATE
 --@RevCodeEffDate	DATE
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
			  ,D.CPT_CODE
  			  ,D.POS1 as PLACE_OF_SVC1
			  ,D.POS2 as PLACE_OF_SVC2
			  ,D.DetailKey 
			  ,D.DETAIL_SVC_DATE
			  ,D.REVENUE_CODE
			  ,CASE WHEN DATEDIFF(dd, PRIMARY_SVC_DATE, SVC_TO_DATE) = 0 THEN 1 ELSE DATEDIFF(dd, PRIMARY_SVC_DATE, SVC_TO_DATE) END AS LOS
			  ,DATEDIFF(dd,B1.PRIMARY_SVC_DATE, GETDATE())			AS DaysSincePrimarySvcDate
		  FROM [adw].[Claims_Headers] B1
		  INNER JOIN
			(
				SELECT DISTINCT C3.SEQ_CLAIM_ID, C3.PROCEDURE_CODE AS CPT_CODE, C3.LINE_NUMBER, C3.DETAIL_SVC_DATE, C3.REVENUE_CODE,
				C3.PLACE_OF_SVC_CODE1 AS POS1, C3.PLACE_OF_SVC_CODE2 AS POS2, C3.ClaimsDetailsKey AS DetailKey
				FROM adw.Claims_Details C3 
				WHERE LEN(C3.PROCEDURE_CODE) > 1
			) AS D 
		ON D.SEQ_CLAIM_ID = B1.SEQ_CLAIM_ID
		WHERE B1.[SEQ_CLAIM_ID] IS NOT NULL
		--AND B1.PROCESSING_STATUS			= 'P'
		--AND B1.CLAIM_STATUS				= 'P'
		AND CONVERT(DATETIME, B1.PRIMARY_SVC_DATE)	>=  @PrimSvcDate_Start
		AND CONVERT(DATETIME, B1.SVC_TO_DATE)			<=  @PrimSvcDate_End
)

/***
Usage: 
SELECT a.*
FROM [adw].[2020_tvf_Get_ClaimsByCPTCode] ('01/01/2019','12/31/2019') a
***/
