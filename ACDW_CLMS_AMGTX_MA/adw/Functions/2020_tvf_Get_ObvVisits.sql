﻿
CREATE FUNCTION [adw].[2020_tvf_Get_ObvVisits]
(
 @PrimSvcDate_Start DATE, 
 @PrimSvcDate_End   DATE
)
RETURNS TABLE
AS RETURN
(
		SELECT DISTINCT B1.[SEQ_CLAIM_ID]
			  ,B1.[SUBSCRIBER_ID]
			  ,B1.[CATEGORY_OF_SVC]
			  ,B1.[ICD_PRIM_DIAG]
			  ,B1.[PRIMARY_SVC_DATE]
			  ,B1.[SVC_TO_DATE]
			  ,B1.[CLAIM_THRU_DATE]
			  ,B1.[VENDOR_ID]
			  ,B1.[PROV_SPEC]
			  ,B1.[IRS_TAX_ID]
			  ,B1.[DRG_CODE]
			  ,B1.[BILL_TYPE]		
			  ,B1.[ADMISSION_DATE]
			  ,B1.[CLAIM_TYPE]
			  ,B1.[TOTAL_BILLED_AMT]
			  ,B1.[TOTAL_PAID_AMT]
			  ,B1.SVC_PROV_NPI
			  ,B1.ATT_PROV_NPI
			  ,D.REV_CODE
			  ,D.PLACE_OF_SVC1
			  ,D.PLACE_OF_SVC2
			  ,CASE WHEN DATEDIFF(dd, PRIMARY_SVC_DATE, SVC_TO_DATE) = 0 THEN 1 ELSE DATEDIFF(dd, PRIMARY_SVC_DATE, SVC_TO_DATE) END AS LOS
			  ,DATEDIFF(dd,B1.PRIMARY_SVC_DATE, GETDATE())			AS DaysSincePrimarySvcDate
		  FROM [adw].[Claims_Headers] B1
		  INNER JOIN
			(
				SELECT DISTINCT [SUBSCRIBER_ID], [SEQ_CLAIM_ID]
					,REV_CODE
					,DRG_CODE
					,CATEGORY_OF_SVC
					,PLACE_OF_SVC1 AS PLACE_OF_SVC1
					,PLACE_OF_SVC2 AS PLACE_OF_SVC2
				FROM [adw].[2020_tvf_Get_ClaimsByRevCode] (@PrimSvcDate_Start,@PrimSvcDate_End) a
				WHERE REV_CODE = '762' 
				--UNION
				--SELECT DISTINCT [SUBSCRIBER_ID], [SEQ_CLAIM_ID]
				--	,'999'
				--	,DRG_CODE
				--	,CATEGORY_OF_SVC
				--	,PLACE_OF_SVC1 AS PLACE_OF_SVC1
				--	,PLACE_OF_SVC2 AS PLACE_OF_SVC2
				--FROM [adw].[2020_tvf_Get_ClaimsByCPTCode] (@PrimSvcDate_Start,@PrimSvcDate_End) a
				--WHERE CPT_CODE IN ('99218', '99219','99220','99234', '99235','99236')
			) AS D 
		ON D.SUBSCRIBER_ID = B1.SUBSCRIBER_ID
		AND D.[SEQ_CLAIM_ID]  = B1.[SEQ_CLAIM_ID] 
		AND B1.CLAIM_TYPE IN ('40','60')
		--B1.PROCESSING_STATUS			= 'P'
		--AND B1.CLAIM_STATUS			= 'P'
		AND CONVERT(DATETIME, B1.PRIMARY_SVC_DATE)	>=  @PrimSvcDate_Start
		AND CONVERT(DATETIME, B1.SVC_TO_DATE)			<=  @PrimSvcDate_End
		--AND DRG_CODE = '000'

)

/***
Usage: 
SELECT a.*
FROM [adw].[2020_tvf_Get_ObvVisits] ('01/01/2019','12/31/2020') a
WHERE SUBSCRIBER_ID IN ('3AK5K25NJ54')
***/

