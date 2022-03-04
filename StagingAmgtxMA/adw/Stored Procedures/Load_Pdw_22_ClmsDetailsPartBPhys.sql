
/* XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */

CREATE PROCEDURE [adw].[Load_Pdw_22_ClmsDetailsPartBPhys]
AS 
    /* prepare logging */
    DECLARE @AuditId INT;    
    DECLARE @JobStatus tinyInt = 1    -- 1 in process , 2 Completed
    DECLARE @JobType SmallInt = 8	  -- ADW load
    DECLARE @ClientKey INT	 = 16; -- mssp
    DECLARE @JobName VARCHAR(100) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @ActionStart DATETIME2 = GETDATE();
    DECLARE @SrcName VARCHAR(100) = '[ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr]'
    DECLARE @DestName VARCHAR(100) = 'adw.Claims_Details'
    DECLARE @ErrorName VARCHAR(100) = 'NA';
    DECLARE @InpCnt INT = -1;
    DECLARE @OutCnt INT = -1;
    DECLARE @ErrCnt INT = -1;
	
     SELECT @InpCnt = COUNT(cl.Amerigroup_MedClaimDetlKey)    
    FROM ast.Claim_04_Detail_Dedup ast
	   JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
		  ON ast.ClaimDetailSrcAdiKey = cl.Amerigroup_MedClaimDetlKey
		  and ast.SrcClaimType = 'PROF'
    ;

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
    CREATE TABLE #OutputTbl (ID INT NOT NULL PRIMARY KEY);	
    
    INSERT INTO adw.Claims_Details
               (	CLAIM_NUMBER                
				,SUBSCRIBER_ID				
				,SEQ_CLAIM_ID                
				,LINE_NUMBER                 
				,SUB_LINE_CODE               
				,DETAIL_SVC_DATE             
				,SVC_TO_DATE                 
				,PROCEDURE_CODE              
				,MODIFIER_CODE_1             
				,MODIFIER_CODE_2             
				,MODIFIER_CODE_3             
				,MODIFIER_CODE_4             
				,REVENUE_CODE                
				,PLACE_OF_SVC_CODE1          
				,PLACE_OF_SVC_CODE2          
				,PLACE_OF_SVC_CODE3          
				,QUANTITY                    
				,BILLED_AMT                  
				,PAID_AMT                    
				,NDC_CODE                    
				,RX_GENERIC_BRAND_IND        
				,RX_SUPPLY_DAYS              
				,RX_DISPENSING_FEE_AMT       
				,RX_INGREDIENT_AMT           
				,RX_FORMULARY_IND            
				,RX_DATE_PRESCRIPTION_WRITTEN
				,RX_DATE_PRESCRIPTION_FILLED	
				,PRESCRIBING_PROV_TYPE_ID		
				,PRESCRIBING_PROV_ID			
				,BRAND_NAME                  
				,DRUG_STRENGTH_DESC          
				,GPI                         
				,GPI_DESC                    
				,CONTROLLED_DRUG_IND         
				,COMPOUND_CODE            
				,SrcAdiTableName
				,SrcAdiKey                   
				, LoadDate                    				
				)
    OUTPUT Inserted.ClaimsDetailsKey INTO #OutputTbl(ID)	
    SELECT	 cl.ClaimNbr						 AS claim_number 				
			, cHdr.MasterConsumerID						 as SUbScriberId				
			, cl.ClaimNbr						 AS seq_Claim_ID				
			, cl.LineNumber				 AS line_Number 				
			, cl.StatusCode				 AS SUB_LINE_CODE 				
			, ISNULL(cl.FromDate, '1/1/1900')	 AS DETAIL_SVC_DATE 			
			, ISNULL(cl.EndDate, '1/1/1900')	 AS SVC_TO_DATE 				
			,' cl.HCPCS_CPTCode'	 		    		 AS PROCEDURE_CODE				
			, cl.HealthServiceCodeModifier			 AS MODIFIER_CODE_1 			
			, cl.HealthServiceCodeModifier			 AS MODIFIER_CODE_2 			
		  	,''								 AS MODIFIER_CODE_3 			
			,''								 AS MODIFIER_CODE_4 			
			, -1						   		 AS REVENUE_CODE				
			, cl.PlaceService		 		 AS PLACE_OF_SVC_CODE1														
			,''								 AS PLACE_OF_SVC_CODE2 			
			,'' 								 AS PLACE_OF_SVC_CODE3			
			, 1  				 AS QUANTITY					
			, ''								 AS BILLED_AMT				  	
			, CASE WHEN (cl.LinePaid is null) THEN NULL
				ELSE (cl.LinePaid/100) END 	 AS Paid_amt      				
			,''								 AS NDC_CODE					
			,''								 AS RX_GENERIC_BRAND_IND			
			,''								 AS RX_SUPPLY_DAYS				
			,''								 AS RX_DISPENSING_FEE_AMT															
			,''								 AS RX_INGREDIENT_AMT			
			,''								 AS RX_FORMULARY_IND			
			,''								 AS RX_DATE_PRESCRIPTION_WRITTEN   
			,''								 AS RX_DATE_PRESCRIPTION_FILLED	
			,''								 AS PRESCRIBING_PROV_TYPE_ID		
			,''								 AS PRESCRIBING_PROV_ID			
			,''								 AS BRAND_NAME					
			,''								 AS DRUG_STRENGTH_DESC			
			,''								 AS GPI						
			,''								 AS GPI_DESC					
			,''								 AS CONTROLLED_DRUG_IND			
			,''								 AS COMPOUND_CODE				
			,'Steward_BCBS_ProfessionallClaim'		 AS SrcAdiTableName				
			, cl.Amerigroup_MedClaimDetlKey			 AS SrcAdiKey					
			,GetDate()						 AS LoadDate					
			  -- implicit CreatedDate, CreatedBy, LastUpdatedDate, LastUpdatedBy
	    FROM ast.Claim_04_Detail_Dedup ast
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cl
			 ON ast.ClaimDetailSrcAdiKey = cl.Amerigroup_MedClaimDetlKey
			 and ast.SrcClaimType = 'PROF'
		  JOIN ast.Claim_03_Header_LatestEffective astHdr ON ast.ClaimSeqClaimId = astHdr.LatestClaimID
		  JOIN [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimDetl] cHdr
			 ON astHdr.LatestClaimAdiKey = cHdr.Amerigroup_MedClaimDetlKey
			 and astHdr.SrcClaimType = 'PROF'
	   ORDER BY cl.ClaimNbr, cl.LineNumber
	   ;

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

