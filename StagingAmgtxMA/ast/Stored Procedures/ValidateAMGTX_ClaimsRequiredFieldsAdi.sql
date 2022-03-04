-- exec [ast].[ValidateAMGTX_ClaimsRequiredFieldsAdi] 3
CREATE PROCEDURE [ast].[ValidateAMGTX_ClaimsRequiredFieldsAdi] (
    @ClientKey INT 
    )
AS 
BEGIN 
    /* Objective: 
    1. for required columns in claims CHECK IF it matches the List table domain
	   a. return the not matching
    2. for 

    */
    
    --declare @clientkey int = 1;
    SELECT 'Look up distinct value for each required field from the Adi'
    Select 'If needed use decoder table to get to a meaningful domain'
    SELECT ' Fields that must be profiled: '
 union select    'CMS_CertNum							'
 union select    'SVC_PROV_ID         					'
 union select    'SVC_PROV_FULL_NAME  					'
 union select    'PROVIDER_PAR_STAT     				'
 union select    'ATT_PROV_ID           				'
 union select    'ATT_PROV_FULL_NAME    				'
 union select    'ATT_PROV_NPI          				'
 union select    'REF_PROV_ID           				'
 union select    'VEND_FULL_NAME    					'
 union select    'IRS_TAX_ID        					'
 union select    'AUTH_NUMBER       					'
 union select    'ADMIT_SOURCE_CODE 					'
 union select    'ADMIT_HOUR        					'
 union select    'DISCHARGE_HOUR    					'
 union select    'PATIENT_STATUS    					'
 union select    'CLAIM_STATUS      					'
 union select    'PROCESSING_STATUS 					'
 union select    'CalcdTotalBilledAmount 				'
 union select    'BENE_PTNT_STUS_CD      				'
 union select    'BILLED_AMT							'
 union select    'MODIFIER_CODE_3						'
 union select    'MODIFIER_CODE_4						'
 union select    ' PLACE_OF_SVC_CODE2					'
 union select    'PLACE_OF_SVC_CODE3					'
 union select    'NDC_CODE								'
 union select    'RX_GENERIC_BRAND_IND					'
 union select    'RX_SUPPLY_DAYS						'
 union select    'RX_DISPENSING_FEE_AMT					'
 union select    'RX_INGREDIENT_AMT						'
 union select    'RX_FORMULARY_IND						'
 union select    'RX_DATE_PRESCRIPTION_WRITTEN			'
 union select    'RX_DATE_PRESCRIPTION_FILLED			'
 union select    'PRESCRIBING_PROV_TYPE_ID				'
 union select    'PRESCRIBING_PROV_ID					'
 union select    'BRAND_NAME							'
 union select    'DRUG_STRENGTH_DESC					'
 union select    'GPI									'
 union select    'GPI_DESC								'
 union select    'CONTROLLED_DRUG_IND					'
 union select    'COMPOUND_CODE							'
 union select    'ICD_FLAG								'
 union select    'DIAGPOA								'
 union select    'MEDICARE_NO							'
 union select    'PAT_CONTROL_NO						'
 union select    'ICD_PRIM_DIAG 						'
 union select    'REF_PROV_FULL_NAME					'
 union select    'IRS_TAX_ID         					'
 union select    'DRG_CODE           					'
 union select    'CLAIM_TYPE							'
 union select    'discharge_Dispo						'
 	
	select 'P:\Information Technology\00_Work Folder\Onboarding\AMGTX_MA\Technical Documents\ST_AMGTX_Institutional Claims.xlsx'
    
	
/* 
    1. NEED TO BE GROUP BY to flaten
    2. Need to have a code filter where appropriate, code type value is the field Name in the adi table
    3. left Join to the Lst table when possible so we can evaluate gaps 
*/


    /* add a query for each field */
	
	SELECT TOP 10 h.ServiceproviderId ,h.PG_ID,p.ProviderFirstName+' '+p.ProviderLastName AS SVC_PROV_FULL_NAME
	 FROM   [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] h
	left join  [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedProvider] p on h.PG_ID=p.PG_ID
	GROUP BY h.ServiceproviderId ,h.PG_ID,p.ProviderFirstName,p.ProviderLastName 

	 SELECT AttendingProviderNPI FROM   [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] h
		WHERE AttendingProviderNPI <> 'UNK'

		
 SELECT h.ReferringProviderLicenseNum,p.PROV_LCNS_ID,p.ProviderFirstName+' '+p.ProviderLastName AS FULLNAME FROM   [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedClaimHdr] h
 left join  [ACDW_CLMS_AMGTX_MA].[adi].[Amerigroup_MedProvider] p on h.ReferringProviderLicenseNum=p.PROV_LCNS_ID
 WHERE ReferringProviderLicenseNum <> 'UNK'
 group by h.ReferringProviderLicenseNum,p.PROV_LCNS_ID ,p.ProviderFirstName,p.ProviderLastName 

  
END;

