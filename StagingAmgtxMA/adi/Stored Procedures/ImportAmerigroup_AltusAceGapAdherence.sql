

-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert 
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_AltusAceGapAdherence]
	@OriginalFileName varchar(100) ,
	@SrcFileName varchar(100) ,
	--@LoadDate date NOT ,
	--@CreatedDate datetime ,
	@DataDate varchar(10),
	@FileDate varchar(10),
	@CreatedBy varchar(50) ,
	--@LastUpdatedDate datetime NOT ,
	@LastUpdatedBy varchar(50)  ,
	@PGID_ProviderGroupName varchar(50) ,
	@PGID varchar(50) ,
	@ProviderGroupName varchar(50) ,
	@ProviderTIN varchar(50) ,
	@ProviderTINName varchar(50) ,
	@ProviderNPI varchar(50) ,
	@ProviderFirstName varchar(50) ,
	@ProviderLastName varchar(50) ,
	@ProviderCity varchar(50) ,
	@ProviderState varchar(50) ,
	@ProviderZipcode varchar(50) ,
	@AnthemMemberID varchar(50) ,
	@SBSCRBR_ID varchar(50) ,
	@Contract_ID varchar(50) ,
	@PBP varchar(50) ,
	@MemberFirstName varchar(50) ,
	@MemberLastName varchar(50) ,
	@DOB varchar(10) ,
	@MemberPhoneNumber varchar(20) ,
	@DiabetesProportionDaysCovered_PDC varchar(50) ,
	@DiabetesAllowableDays varchar(50) ,
	@DiabetesAdherentPriorYear varchar(50) ,
	@DiabetesDrugNameLastPaidClaim varchar(50) ,
	@DiabetesLastfilldate varchar(10) ,
	@DiabetesDrugLastDaysSupply varchar(50) ,
	@NextRefillDateDiabetes varchar(10) ,
	@PrescriberForDiabetes varchar(50) ,
	@PrescriberNPIForDiabetes varchar(50) ,
	@DaySupplyBenefitEligibilityForDiabetes varchar(50) ,
	@HypertensionProportionDaysCovered_PDC varchar(50) ,
	@HypertensionAllowabledays varchar(50) ,
	@AdherentPriorYear varchar(50) ,
	@HypertensionDrugnamebasedonlastpaidclaim varchar(50) ,
	@Lastfilldate varchar(10) ,
	@HypertensionDrugLastDaysSupply varchar(50) ,
	@NextRefillDateHypertension varchar(50) ,
	@PrescriberforHypertension varchar(50) ,
	@PrescriberNPIforHypertension varchar(50) ,
	@DaySupplyBenefitEligibilityforHypertension varchar(50) ,
	@CholesterolProportionofDaysCovered_PDC varchar(50) ,
	@CholesterolAllowabledays varchar(50) ,
	@CholesterolAdherentPriorYear varchar(50) ,
	@CholesterolDrugnameBasedOnLastPaidClaim varchar(50) ,
	@CholesterolLastfilldate varchar(10) ,
	@Cholesteroldruglastdayssupply varchar(50) ,
	@NextrefillDateCholesterol varchar(10) ,
	@PrescriberforCholesterol varchar(50) ,
	@PrescriberNPIforCholesterol varchar(50) ,
	@DaySupplyBenefitEligibilityForCholesterol varchar(50) ,
	@ExtendedDaySupplyOpportunity varchar(50) ,
	@ClinicalCareCenterCallOutreachResult varchar(50) ,
	@ClinicalPharmacyCareCenterOutreachCallDate varchar(10) ,
	@MTM_CMRCompletion varchar(50) ,
	@CMR_Vendor_Referral_Phone varchar(20) ,
	@Statin_use_inPersonsWDiabetesIndicator varchar(50) ,
	@SUPD_Age_76 varchar(50) ,
	@Statin_use_in_PersonsWCardioVascularDiseaseIndicator varchar(50) ,
	@HomeDeliveryMultidosePackaging varchar(50) ,
	@PharmacyName varchar(50) ,
	@PharmacyPhoneNumber varchar(50) ,
	@LowerCopayOpportunityWHomeDelivery varchar(50),	
	@Lis_Indicator Varchar(50)
            
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--DECLARE @DATE VARCHAR(8) , @YEAR VARCHAR(4), @MONTH VARCHAR(2), @DAY VARCHAR(2)	
	--SET @DATE =  SUBSTRING(@SrcFileName, (CHARINDEX('.',@SrcFileName)-8),8)
	--SET @YEAR = SUBSTRING(@DATE, 5,4)
	--SET @MONTH = SUBSTRING(@DATE, 1,2)
	--SET @DAY = SUBSTRING(@DATE, 3,2)


    INSERT INTO [adi].[Amerigroup_AltusAceGapAdherence]
    (
       [OriginalFileName]
      ,[SrcFileName]
      ,[LoadDate]
      ,[CreatedDate]
      ,[DataDate]
      ,[FileDate]
      ,[CreatedBy]
      ,[LastUpdatedDate]
      ,[LastUpdatedBy]
      ,[PGID_ProviderGroupName]
      ,[PGID]
      ,[ProviderGroupName]
      ,[ProviderTIN]
      ,[ProviderTINName]
      ,[ProviderNPI]
      ,[ProviderFirstName]
      ,[ProviderLastName]
      ,[ProviderCity]
      ,[ProviderState]
      ,[ProviderZipcode]
      ,[AnthemMemberID]
      ,[SBSCRBR_ID]
      ,[Contract_ID]
      ,[PBP]
      ,[MemberFirstName]
      ,[MemberLastName]
      ,[DOB]
      ,[MemberPhoneNumber]
      ,[DiabetesProportionDaysCovered_PDC]
      ,[DiabetesAllowableDays]
      ,[DiabetesAdherentPriorYear]
      ,[DiabetesDrugNameLastPaidClaim]
      ,[DiabetesLastfilldate]
      ,[DiabetesDrugLastDaysSupply]
      ,[NextRefillDateDiabetes]
      ,[PrescriberForDiabetes]
      ,[PrescriberNPIForDiabetes]
      ,[DaySupplyBenefitEligibilityForDiabetes]
      ,[HypertensionProportionDaysCovered_PDC]
      ,[HypertensionAllowabledays]
      ,[AdherentPriorYear]
      ,[HypertensionDrugnamebasedonlastpaidclaim]
      ,[Lastfilldate]
      ,[HypertensionDrugLastDaysSupply]
      ,[NextRefillDateHypertension]
      ,[PrescriberforHypertension]
      ,[PrescriberNPIforHypertension]
      ,[DaySupplyBenefitEligibilityforHypertension]
      ,[CholesterolProportionofDaysCovered_PDC]
      ,[CholesterolAllowabledays]
      ,[CholesterolAdherentPriorYear]
      ,[CholesterolDrugnameBasedOnLastPaidClaim]
      ,[CholesterolLastfilldate]
      ,[Cholesteroldruglastdayssupply]
      ,[NextrefillDateCholesterol]
      ,[PrescriberforCholesterol]
      ,[PrescriberNPIforCholesterol]
      ,[DaySupplyBenefitEligibilityForCholesterol]
      ,[ExtendedDaySupplyOpportunity]
      ,[ClinicalCareCenterCallOutreachResult]
      ,[ClinicalPharmacyCareCenterOutreachCallDate]
      ,[MTM_CMRCompletion]
      ,[CMR_Vendor_Referral_Phone]
      ,[Statin_use_inPersonsWDiabetesIndicator]
      ,[SUPD_Age_76]
      ,[Statin_use_in_PersonsWCardioVascularDiseaseIndicator]
      ,[HomeDeliveryMultidosePackaging]
      ,[PharmacyName]
      ,[PharmacyPhoneNumber]
      ,[LowerCopayOpportunityWHomeDelivery]
	  ,LIS_Indicator
           
	)
		
 VALUES  (
    @OriginalFileName ,
	@SrcFileName ,
	GETDATE(),
	--@LoadDate date NOT ,
	GETDATE(),
	--@CreatedDate datetime ,
	CASE WHEN @DataDate = ''
	THEN NULL
	ELSE CONVERT(DATE,@DataDate)
	END ,
	CASE WHEN @FileDate = ''
	THEN NULL
	ELSE CONVERT(DATE,@FileDate)
	END ,
	@CreatedBy  ,
	GETDATE(),
	--@LastUpdatedDate datetime NOT ,
	@LastUpdatedBy   ,
	@PGID_ProviderGroupName  ,
	@PGID  ,
	@ProviderGroupName  ,
	@ProviderTIN  ,
	@ProviderTINName  ,
	@ProviderNPI  ,
	@ProviderFirstName  ,
	@ProviderLastName  ,
	@ProviderCity  ,
	@ProviderState  ,
	@ProviderZipcode  ,
	@AnthemMemberID  ,
	@SBSCRBR_ID  ,
	@Contract_ID  ,
	@PBP  ,
	@MemberFirstName  ,
	@MemberLastName  ,
	CASE WHEN @DOB = ''
	THEN NULL
	ELSE CONVERT(DATE,@DOB)
	END ,
	@MemberPhoneNumber  ,
	@DiabetesProportionDaysCovered_PDC  ,
	@DiabetesAllowableDays  ,
	@DiabetesAdherentPriorYear  ,
	@DiabetesDrugNameLastPaidClaim  ,
	CASE WHEN @DiabetesLastfilldate = ''
	THEN NULL
	ELSE CONVERT(DATE,@DiabetesLastfilldate)
	END ,
	@DiabetesDrugLastDaysSupply  ,
	CASE WHEN @NextRefillDateDiabetes = ''
	THEN NULL
	ELSE CONVERT(DATE,@NextRefillDateDiabetes)
	END ,
	  
	@PrescriberForDiabetes  ,
	@PrescriberNPIForDiabetes  ,
	@DaySupplyBenefitEligibilityForDiabetes  ,
	@HypertensionProportionDaysCovered_PDC  ,
	@HypertensionAllowabledays  ,
	@AdherentPriorYear  ,
	@HypertensionDrugnamebasedonlastpaidclaim  ,
	CASE WHEN @Lastfilldate = ''
	THEN NULL
	ELSE CONVERT(DATE,@Lastfilldate)
	END ,
	@HypertensionDrugLastDaysSupply  ,
	@NextRefillDateHypertension  ,
	@PrescriberforHypertension  ,
	@PrescriberNPIforHypertension  ,
	@DaySupplyBenefitEligibilityforHypertension  ,
	@CholesterolProportionofDaysCovered_PDC  ,
	@CholesterolAllowabledays  ,
	@CholesterolAdherentPriorYear  ,
	@CholesterolDrugnameBasedOnLastPaidClaim  ,
	CASE WHEN @CholesterolLastfilldate = ''
	THEN NULL
	ELSE CONVERT(DATE,@CholesterolLastfilldate)
	END ,	
	@Cholesteroldruglastdayssupply  ,
	@NextrefillDateCholesterol  ,
	@PrescriberforCholesterol  ,
	@PrescriberNPIforCholesterol  ,
	@DaySupplyBenefitEligibilityForCholesterol  ,
	@ExtendedDaySupplyOpportunity  ,
	@ClinicalCareCenterCallOutreachResult  ,
	@ClinicalPharmacyCareCenterOutreachCallDate ,
	@MTM_CMRCompletion  ,
	@CMR_Vendor_Referral_Phone  ,
	@Statin_use_inPersonsWDiabetesIndicator  ,
	@SUPD_Age_76  ,
	@Statin_use_in_PersonsWCardioVascularDiseaseIndicator  ,
	@HomeDeliveryMultidosePackaging  ,
	@PharmacyName  ,
	@PharmacyPhoneNumber  ,
	@LowerCopayOpportunityWHomeDelivery ,
	@Lis_Indicator
)

END




