



CREATE PROCEDURE [adw].[Load_Pdw_11_ClmsHeadersPartA]
AS    

	/* prepare logging */
	DECLARE @AuditId INT;    
	DECLARE @JobStatus tinyInt = 1    -- 1 in process , 2 Completed
	DECLARE @JobType SmallInt = 8	  -- AST load
	DECLARE @ClientKey INT	 = 21; -- mssp
	DECLARE @JobName VARCHAR(100) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @ActionStart DATETIME2 = GETDATE();
    DECLARE @SrcName VARCHAR(100) = 'adi.Amerigroup_MedClaimHdr'
    DECLARE @DestName VARCHAR(100) = 'adw.Claims_Headers'
    DECLARE @ErrorName VARCHAR(100) = 'NA';
    DECLARE @InpCnt INT = -1;
    DECLARE @OutCnt INT = -1;
    DECLARE @ErrCnt INT = -1;
	
    SELECT @InpCnt = COUNT(*) 
	FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr]  ch
	   JOIN ast.Claim_03_Header_LatestEffective lr 
		ON ch.MedClaimHdrKey = lr.LatestClaimAdiKey
			AND lr.LatestClaimAdiKey = lr.ReplacesAdiKey
			and lr.SrcClaimType = 'INST';

	EXEC amd.sp_AceEtlAudit_Open 
        @AuditID = @AuditID OUTPUT
        , @AuditStatus = @JobStatus
        , @JobType = @JobType
        , @ClientKey = @ClientKey
        , @JobName = @JobName
        , @ActionStartTime = @ActionStart
        , @InputSourceName = @SrcName
        , @DestinationName = @DestName
        , @ErrorName = @ErrorName
        ;

	CREATE TABLE #OutputTbl (Seq_claim_ID VARCHAR(50) PRIMARY KEY NOT NULL);	
	
    -- 1. Insert cliams Using LastClmRow set 
    BEGIN TRAN LoadPartAHeader
    INSERT INTO adw.Claims_Headers(		
					SEQ_CLAIM_ID					
					,SUBSCRIBER_ID          
					,CLAIM_NUMBER           
					,CATEGORY_OF_SVC        
					,PAT_CONTROL_NO
					,ICD_PRIM_DIAG          
					,PRIMARY_SVC_DATE       
					,SVC_TO_DATE            
					,CLAIM_THRU_DATE        
					,POST_DATE              
					,CHECK_DATE             
					,CHECK_NUMBER           
					,DATE_RECEIVED          
					,ADJUD_DATE             
					,CMS_CertificationNumber
					,SVC_PROV_ID            
					,SVC_PROV_FULL_NAME     
					,SVC_PROV_NPI           
					,PROV_SPEC              
					,PROV_TYPE              
					,PROVIDER_PAR_STAT      
					,ATT_PROV_ID            
					,ATT_PROV_FULL_NAME     
					,ATT_PROV_NPI           
					,REF_PROV_ID            
					,REF_PROV_FULL_NAME     
					,VENDOR_ID              
					,VEND_FULL_NAME         
					,IRS_TAX_ID             
					,DRG_CODE               
					,BILL_TYPE              
					,ADMISSION_DATE         
					,AUTH_NUMBER            
					,ADMIT_SOURCE_CODE      
					,ADMIT_HOUR             
					,DISCHARGE_HOUR         
					,PATIENT_STATUS         
					,CLAIM_STATUS           
					,PROCESSING_STATUS      
					,CLAIM_TYPE             
					,TOTAL_BILLED_AMT       
					,TOTAL_PAID_AMT         
					,CalcdTotalBilledAmount 
					,BENE_PTNT_STUS_CD      
					,DISCHARGE_DISPO
					,srcAdiTableName
					,SrcAdiKey              
					,LoadDate
					)        
	OUTPUT INSERTED.SEQ_CLAIM_ID INTO #OutputTbl(Seq_claim_ID)			
     SELECT		
	    ch.ClaimNbr											AS	SEQ_CLAIM_ID				--SEQ_CLAIM_ID			
		,ch.MasterConsumerID			 							AS	SUBSCRIBER_ID          		--,SUBSCRIBER_ID          
		,ch.LEffClmSkey									AS	CLAIM_NUMBER           		--,CLAIM_NUMBER           
		--,CASE																		--'INPATIENT'
		--	WHEN (ch.CODE = 'Y' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 0) THEN 'INPATIENT'	--'I-1-IP' 
		--	WHEN (ch.Inpatient_OutpatientCode = 'Y' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 1) THEN 'INPATIENT'	--'I-2-IP'				
		--	WHEN (ch.Inpatient_OutpatientCode = 'Y' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 0) THEN 'OUTPATIENT' --'I-3-OP'
		--	WHEN (ch.Inpatient_OutpatientCode = 'Y' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 1) THEN 'INPATIENT'	--'I-4-IP'
		--	WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 0) THEN 'INPATIENT'	--'0-5-IP'
		--	WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 1) THEN 'INPATIENT'	--'O-6-IP'	
		--	WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 0) THEN 'OUTPATIENT' --'O-7-OP'
		--	WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 1) THEN 'INPATIENT'	--'O-8-IP'
		--	ELSE 'UNKNOWN'	END 		AS	CATEGORY_OF_SVC	        	--,CATEGORY_OF_SVC   
		,ch.BillType    AS	CATEGORY_OF_SVC	
		,''							   					AS	PAT_CONTROL_NO				
		,'No Data'							AS	ICD_PRIM_DIAG          		--,ICD_PRIM_DIAG          
		,ch.FromDate									AS	PRIMARY_SVC_DATE       		--,PRIMARY_SVC_DATE       
		,ch.ToDate									AS	SVC_TO_DATE            		--,SVC_TO_DATE            
		,ch.ToDate								     AS	CLAIM_THRU_DATE        		
		,'01/01/1900'									     AS	POST_DATE              		
		,'01/01/1900'										AS	CHECK_DATE             		--,CHECK_DATE             
		,''												AS	CHECK_NUMBER           		--,CHECK_NUMBER           
		,'01/01/1900'										AS	DATE_RECEIVED          		--,DATE_RECEIVED          
		,'01/01/1900'										AS	ADJUD_DATE             		--,ADJUD_DATE             
		, ''					 							AS CMS_CertNum					--,CMS_CertificationNumber
		,''												AS	SVC_PROV_ID            		--,SVC_PROV_ID            
		,''												AS	SVC_PROV_FULL_NAME     		--,SVC_PROV_FULL_NAME     
		,ch.ServiceRenderingProviderNPI	    						AS	SVC_PROV_NPI           		--,SVC_PROV_NPI           
		,'No Data'					AS	PROV_SPEC              		--,PROV_SPEC              
		,'No Data'												AS	PROV_TYPE              		--,PROV_TYPE              
		,''												AS	PROVIDER_PAR_STAT      		--,PROVIDER_PAR_STAT      
		,''												AS	ATT_PROV_ID            		--,ATT_PROV_ID            
		,''												AS	ATT_PROV_FULL_NAME     		--,ATT_PROV_FULL_NAME     
		,''			   									AS	ATT_PROV_NPI           		--,ATT_PROV_NPI           
		,''												AS	REF_PROV_ID            		--,REF_PROV_ID            
		,''												AS	REF_PROV_FULL_NAME     		--,REF_PROV_FULL_NAME     
		,ch.BillingProviderNPI								AS	VENDOR_ID              		--,VENDOR_ID              
		,''											AS	VEND_FULL_NAME      		--,VEND_FULL_NAME         will be a look up from NPPES   
		,''												AS	IRS_TAX_ID             		--,IRS_TAX_ID             
		,ch.DRG										AS	DRG_CODE               		--,DRG_CODE               --Remove leading zero						
		,BillType			AS	BILL_TYPE   
		,AdmitDate           		
		--,CASE WHEN (ch.Inpatient_OutpatientCode = 'Y') 
		--	 THEN ch.FromDate
		--	 ELSE '01/01/1900'			END					AS	ADMISSION_DATE         		--,ADMISSION_DATE         
		,''												AS	AUTH_NUMBER            		--,AUTH_NUMBER            
		,''												AS	ADMIT_SOURCE_CODE      		--,ADMIT_SOURCE_CODE      
		,''												AS	ADMIT_HOUR             		--,ADMIT_HOUR             
		,''												AS	DISCHARGE_HOUR         		--,DISCHARGE_HOUR         
		,''				  								AS	PATIENT_STATUS         		--,PATIENT_STATUS         
		,''							AS	CLAIM_STATUS           		--,CLAIM_STATUS           
		,''												AS	PROCESSING_STATUS      		--,PROCESSING_STATUS      
	   --  ,CASE 
			 --WHEN (ch.Inpatient_OutpatientCode = 'Y' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 0) THEN	'60'			--'I-1-60'
			 --WHEN (ch.Inpatient_OutpatientCode = 'Y' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 1) THEN	'60'			--'I-2-60'
			 --WHEN (ch.Inpatient_OutpatientCode = 'Y' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 0) THEN	'40'			--'I-3-40'
			 --WHEN (ch.Inpatient_OutpatientCode = 'Y' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 1) THEN	'60'			--'I-4-60'
			 --WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 0) THEN	'60'			--'O-5-60'
			 --WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS >0)		AND ch.DischargeStatusCodeFlag = 1) THEN	'60'			--'O-6-60'
			 --WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 0) THEN	'40'			--'O-7-40'
			 --WHEN (ch.Inpatient_OutpatientCode = 'N' AND (ch.LOS =0)		AND ch.DischargeStatusCodeFlag = 1) THEN	'60'			--'O-8-60'
			 --ELSE 'UNKNOWN'	END 		AS	CLAIM_TYPE    
		, ch.BillType as          		CLAIM_TYPE             
		--,CASE WHEN (ch.HLBilledAmount	is null) THEN NULL
		--	 ELSE (ch.HLBilledAmount/100) END 					AS	TOTAL_BILLED_AMT       		--,TOTAL_BILLED_AMT       
		--,CASE WHEN (Ch.HLPaidAmount IS NULL) THEN NULL
		--	 ELSE (ch.HLPaidAmount /100) END 					AS	TOTAL_PAID_AMT         		--,TOTAL_PAID_AMT      
		,0			AS	TOTAL_BILLED_AMT
		,0			AS	TOTAL_PAID_AMT 
		,'' 												AS	CalcdTotalBilledAmount 		--,CalcdTotalBilledAmount 
		,'' 												AS	BENE_PTNT_STUS_CD      		--,BENE_PTNT_STUS_CD      
		,CASE WHEN (ch.DischargeStatus = 'UNK') THEN 0 
			 ELSE  ch.DischargeStatus 	END											AS  discharge_Dispo				--,DISCHARGE_DISPO
		, 'adi.Amerigroup_MedClaimHdr'					AS  SrcAdiTableName
		,ch.MedClaimHdrKey							AS	SrcAdiKey              		--,SrcAdiKey              
		,GetDate()										AS	LoadDate               		--,LoadDate
		--	implicitly loaded by defaults: CreatedDate,CreatedBy,LastUpdatedDate,LastUpdatedBy,
	
	 FROM   (SELECT ch.*, LEff.clmSKey LEffClmSkey, DATEDIFF(dd,ch.FromDate, ch.ToDate)  LOS
				
    				,CASE WHEN ch.DischargeStatus = ' ' THEN 0 WHEN ch.DischargeStatus = '99' THEN 0 ELSE 1 END  DischargeStatusCodeFlag
    			 FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr]  ch
				  
    				JOIN ast.Claim_03_Header_LatestEffective LEff
    				ON ch.MedClaimHdrKey = LEff.LatestClaimAdiKey
    				    AND LEff.LatestClaimAdiKey = LEff.ReplacesAdiKey
    				    AND lEff.SrcClaimType = 'INST'

				
    			 --WHERE ch.ClaimRecordID = 'CLM' gk
				) ch 
				
				
    ;--select dt.LineBilled,dt.LinePaid from [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] dt --ast.Claim_04_Detail_Dedup
	   	 
	COMMIT TRAN LoadPartAHeader;

	-- get total paid
	-- Update total Paid
    UPDATE v set v.TOTAL_PAID_AMT = isNULL(tp.TotalPaid, 0)
	FROM adw.Claims_Headers  v
	   jOIN (SELECT sum(v.LinePaid) TotalPaid, v.Amerigroup_MedClaimDetlKey
				FROM [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl]  v
				GROUP BY  v.Amerigroup_MedClaimDetlKey
				) Tp ON v.SrcAdiKey  = tp.Amerigroup_MedClaimDetlKey
	-- get total billed
	UPDATE h set h.TOTAL_BILLED_AMT = src_Tba.TotBillAmnt	--
	   FROM adw.Claims_Headers H	
		JOIN (SELECT H.SEQ_CLAIM_ID, SUM(cd.LineBilled) TotBillAmnt
			FROM adw.Claims_Headers H	
				JOIN ast.Claim_04_Detail_Dedup dd ON H.SEQ_CLAIM_ID = dd.ClaimSeqClaimId    			 
				JOIN adi.Amerigroup_MedClaimDetl cd ON dd.ClaimDetailSrcAdiKey = cd.Amerigroup_MedClaimDetlKey
			GROUP BY H.SEQ_CLAIM_ID
			) src_Tba on H.SEQ_CLAIM_ID = src_Tba.SEQ_CLAIM_ID;
    			 

	-- if this fails it just stops. How should this work, structure from the WLC or AET COM care Op load, acedw do this soon.
	SELECT @OutCnt = COUNT(*) FROM #OutputTbl; 
	SET @ActionStart = GETDATE();    
	SET @JobStatus =2  -- complete
    
	EXEC amd.sp_AceEtlAudit_Close 
        @AuditId = @AuditID
        , @ActionStopTime = @ActionStart
        , @SourceCount = @InpCnt		  
        , @DestinationCount = @OutCnt
        , @ErrorCount = @ErrCnt
        , @JobStatus = @JobStatus
	   ;
