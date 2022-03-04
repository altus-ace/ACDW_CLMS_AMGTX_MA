﻿
CREATE FUNCTION [adw].[2020_tvf_Get_ClaimsPaidAmount]
(
 @PrimSvcDate_Start DATE, 
 @PrimSvcDate_End   DATE
)

RETURNS TABLE
AS RETURN
(
WITH CTE AS (
		SELECT DISTINCT B1.[SUBSCRIBER_ID]
			,YEAR(CONVERT(DATETIME, B1.PRIMARY_SVC_DATE)) as PrimSvcYr
			,COUNT(DISTINCT B1.SEQ_CLAIM_ID) AS CntClaims
			,SUM(B1.[TOTAL_PAID_AMT]) AS SumPaidAmt
			,CONVERT(DATE,DATEADD(MONTH, -11,@PrimSvcDate_End)) AS CRYStart
			,CONVERT(DATE,DATEADD(MONTH, DATEDIFF(MONTH, -1, @PrimSvcDate_End), -1)) AS CRYEnd 
			,CONVERT(DATE,DATEADD(MONTH, -12, CONVERT(DATE,DATEADD(MONTH, -11,@PrimSvcDate_End)))) AS PRYStart
			,CONVERT(DATE,DATEADD(MONTH, -12, CONVERT(DATE,DATEADD(MONTH, DATEDIFF(MONTH, -1, @PrimSvcDate_End), -1)))) AS PRYEnd
			,SUM(CASE WHEN CONVERT(DATE, B1.PRIMARY_SVC_DATE) BETWEEN CONVERT(DATE,DATEADD(MONTH, -11,@PrimSvcDate_End)) AND CONVERT(DATE,DATEADD(MONTH, DATEDIFF(MONTH, -1, @PrimSvcDate_End), -1)) THEN B1.[TOTAL_PAID_AMT] ELSE 0 END) AS CRY_SumPaidAmt
			,SUM(CASE WHEN CONVERT(DATE, B1.PRIMARY_SVC_DATE) BETWEEN CONVERT(DATE,DATEADD(MONTH, -11,CONVERT(DATE,DATEADD(MONTH, -12, CONVERT(DATE,DATEADD(MONTH, -11,@PrimSvcDate_End)))))) AND CONVERT(DATE,DATEADD(MONTH, -12, CONVERT(DATE,DATEADD(MONTH, DATEDIFF(MONTH, -1, @PrimSvcDate_End), -1)))) THEN B1.[TOTAL_PAID_AMT] ELSE 0 END) AS PFY_SumPaidAmt
 			,SUM(CASE WHEN CONVERT(DATETIME, B1.PRIMARY_SVC_DATE) BETWEEN CONVERT(DATE,DATEADD(MONTH, -11,@PrimSvcDate_End)) AND CONVERT(DATE,DATEADD(MONTH, DATEDIFF(MONTH, -1, @PrimSvcDate_End), -1)) AND B1.CATEGORY_OF_SVC = 'PHYSICIAN' THEN B1.[TOTAL_PAID_AMT] ELSE 0 END) AS CRY_SumPaidAmt_PHY
 			,SUM(CASE WHEN CONVERT(DATETIME, B1.PRIMARY_SVC_DATE) BETWEEN CONVERT(DATE,DATEADD(MONTH, -11,@PrimSvcDate_End)) AND CONVERT(DATE,DATEADD(MONTH, DATEDIFF(MONTH, -1, @PrimSvcDate_End), -1)) AND B1.CATEGORY_OF_SVC = 'INPATIENT' THEN B1.[TOTAL_PAID_AMT] ELSE 0 END) AS CRY_SumPaidAmt_IP
 			,SUM(CASE WHEN CONVERT(DATETIME, B1.PRIMARY_SVC_DATE) BETWEEN CONVERT(DATE,DATEADD(MONTH, -11,@PrimSvcDate_End)) AND CONVERT(DATE,DATEADD(MONTH, DATEDIFF(MONTH, -1, @PrimSvcDate_End), -1)) AND B1.CATEGORY_OF_SVC = 'OUTPATIENT' THEN B1.[TOTAL_PAID_AMT] ELSE 0 END) AS CRY_SumPaidAmt_OP
		FROM [adw].[Claims_Headers] B1
		WHERE YEAR(CONVERT(DATETIME, B1.PRIMARY_SVC_DATE)) BETWEEN YEAR(@PrimSvcDate_End)-2 AND YEAR(@PrimSvcDate_End)
		--CONVERT(DATETIME, B1.PRIMARY_SVC_DATE)	BETWEEN 	@PrimSvcDate_Start AND  @PrimSvcDate_End
			--AND B1.PROCESSING_STATUS			= 'P'
			--AND B1.CLAIM_STATUS				= 'P'
		GROUP BY B1.[SUBSCRIBER_ID]
			--,B1.[CLAIM_TYPE]
			,YEAR(CONVERT(DATETIME, B1.PRIMARY_SVC_DATE))
		)
	SELECT DISTINCT SUBSCRIBER_ID
		--,(SELECT ISNULL(SumPaidAmt,0) FROM CTE WHERE PrimSvcYr = YEAR(@PrimSvcDate_Start)) AS CY_TotalPaid
		,SUM(CASE WHEN PrimSvcYr = YEAR(@PrimSvcDate_End) THEN SumPaidAmt ELSE 0 END) AS CY_TotalPaid
		,SUM(CASE WHEN PrimSvcYr = YEAR(@PrimSvcDate_End)-1 THEN SumPaidAmt ELSE 0 END) AS PY_TotalPaid
		,SUM(CRY_SumPaidAmt) as CRY_TotalPaid
		,SUM(PFY_SumPaidAmt) as PRY_TotalPaid
		,SUM(CRY_SumPaidAmt_PHY) as CRY_PhyPaid
		,SUM(CRY_SumPaidAmt_IP) as CRY_IPPaid
		,SUM(CRY_SumPaidAmt_OP) as CRY_OPPaid

	FROM CTE
	GROUP BY SUBSCRIBER_ID
)

/***
Usage: 
SELECT a.*
FROM [adw].[2020_tvf_Get_ClaimsPaidAmount] ('01/01/2019','5/31/2021') a
WHERE SUBSCRIBER_ID = '119285346'

SELECT TOP 1000 SUBSCRIBER_ID
	,DATEDIFF(dd,CONVERT(DATETIME, PRIMARY_SVC_DATE),'7/31/2019')
	,PRIMARY_SVC_DATE
	,TOTAL_PAID_AMT
	--,SUM(CASE WHEN DATEDIFF(dd,CONVERT(DATETIME, PRIMARY_SVC_DATE),'7/31/2019') < 365 THEN [TOTAL_PAID_AMT] ELSE 0 END) AS CFY_SumPaidAmt
FROM [adw].[Claims_Headers] 
WHERE SUBSCRIBER_ID = '100414008'
AND YEAR(CONVERT(DATETIME, PRIMARY_SVC_DATE)) BETWEEN 2018 AND 2019
GROUP BY SUBSCRIBER_ID
***/

