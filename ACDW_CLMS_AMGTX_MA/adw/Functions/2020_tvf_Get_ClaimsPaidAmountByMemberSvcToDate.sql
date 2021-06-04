﻿

CREATE  FUNCTION [adw].[2020_tvf_Get_ClaimsPaidAmountByMemberSvcToDate]
(
 @PrimSvcDate_Start DATE, 
 @PrimSvcDate_End   DATE
)

RETURNS TABLE
AS RETURN
(
		SELECT DISTINCT @PrimSvcDate_Start as PrimSvcDate_Start,@PrimSvcDate_End as PrimSvcDate_End
			,B1.[SUBSCRIBER_ID] 
			,YEAR(CONVERT(DATETIME,B1.SVC_TO_DATE)) as PrimSvcYr
			,MONTH(CONVERT(DATETIME, B1.SVC_TO_DATE)) as PrimSvcMth
			,COUNT(DISTINCT B1.SEQ_CLAIM_ID) AS CntClaims
			,SUM(B1.[TOTAL_PAID_AMT]) AS SumPaidAmt
		FROM [adw].[Claims_Headers] B1
		WHERE YEAR(CONVERT(DATETIME, B1.SVC_TO_DATE))		>= YEAR(@PrimSvcDate_Start)-2 
			AND YEAR(CONVERT(DATETIME, B1.SVC_TO_DATE))		<= YEAR(@PrimSvcDate_Start)
			AND CLAIM_TYPE			IN ('10','20','30','40','50','60','61','71','72')
			--AND CATEGORY_OF_SVC <> 'PHARMACY'
			--AND B1.PROCESSING_STATUS			= 'P'
			--AND B1.CLAIM_STATUS				= 'P'
		GROUP BY B1.[SUBSCRIBER_ID]
			--,B1.[CLAIM_TYPE]
			,YEAR(CONVERT(DATETIME, B1.SVC_TO_DATE))
			,MONTH(CONVERT(DATETIME, B1.SVC_TO_DATE))
)

/***
Usage:
SELECT * --sum(SumPaidAmt) as SumAmt
FROM [adw].[2020_tvf_Get_ClaimsPaidAmountByMember] ('2020-01-01','2020-08-30') a
***/
