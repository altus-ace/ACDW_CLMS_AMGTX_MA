
CREATE PROCEDURE [adw].[pdw_LoadIntoFctMembership](@DataDate DATE)

AS
    
	INSERT	INTO adw.FctMembership([CreatedDate]  --  select * from adw.FctMembership
								,[CreatedBy]
								,[LastUpdatedDate]
								,[LastUpdatedBy]
								,[AdiKey]
								,[SrcFileName]
								,[AdiTableName]
								,[LoadDate]
								,[DataDate]
								,[RwEffectiveDate]
								,[RwExpirationDate]
								,[ClientKey]
								,[Ace_ID]
								,[ClientMemberKey]
								,[MBI]
								,[HICN]
								,[SubscriberIndicator]
								,[MemberIndicator]
								,[Relationship]
								,[FirstName]
								,[MiddleName]
								,[LastName]
								,[Gender]
								,[DOB]
								,[DOD]
								,[MemberSSN]
								,[CurrentAge]
								,[AgeGroup20Years]
								,[AgeGroup10Years]
								,[AgeGroup5Years]
								,[MbrMonth]
								,[MbrYear]
								,[LanguageCode]
								,[Ethnicity]
								,[Race]
								,[MemberHomeAddress]
								,[MemberHomeAddress1]
								,[MemberHomeCity]
								,[MemberHomeState]
								,[CountyName]
								,[CountyNumber]
								,[Region]
								,[POD]
								,[MemberHomeZip]
								,[MemberMailingAddress]
								,[MemberMailingAddress1]
								,[MemberMailingCity]
								,[MemberMailingState]
								,[MemberMailingZip]
								,[MemberPhone]
								,[MemberCellPhone]
								,[MemberHomePhone]
								,[MedicaidMedicareDualEligibleIndicator]
								,[PersonMonthCreatedfromClaimIndicator]
								,[MemberStatus]
								,[EnrollementStatus]
								,[MemberID]
								,[MedicaidID]
								,[CardID]
								,[FamilyID]
								,[BenefitType]
								,[LOB]
								,[PlanID]
								,[ProductCode]
								,[SubgrpID]
								,[SubgrpName]
								,[PlanName]
								,[PlanType]
								,[PlanTier]
								,[Contract]
								,[NPI]
								,[PcpPracticeTIN]
								,[ProviderFirstName]
								,[ProviderMI]
								,[ProviderLastName]
								,[ProviderPracticeName]
								,[ProviderAddressLine1]
								,[ProviderAddressLine2]
								,[ProviderCity]
								,[ProviderCounty]
								,[ProviderZip]
								,[ProviderPhone]
								,[ProviderSpecialty]
								,[ProviderNetwork]
								,[SpecialistStatus]
								,[GroupOrPrivatePractice]
								,[ProviderPOD]
								,[ProviderChapter]
								,[AceRiskScore]
								,[AceRiskScoreLevel]
								,[ClientRiskScore]
								,[ClientRiskScoreLevel]
								,[RiskScoreUtilization]
								,[RiskScoreClinical]
								,[RiskScoreHRA]
								,[RiskScorePlaceHolder]
								,[EnrollmentYear]
								,[EnrollmentQuarter]
								,[EnrollmentYearQuarter]
								,[EnrollmentYearMonth]
								,[EligibleYear]
								,[EligibilityQuarter]
								,[EligibilityYearQuarter]
								,[EligibilityYearMonth]
								,[MemberCount]
								,[AvgMemberCount]
								,[SubscriberCount]
								,[AvgSubscriberCount]
								,[PersonCreatedCount]
								,[MemberMonths]
								,[SubscriberMonths]
								,[FamilyRatio]
								,[AvgAge]
								,[NoOfMonths]
								,[MemberCurrentEffectiveDate]
								,[MemberCurrentExpirationDate]
								,[Active]
								,[Excluded]
								 ,[MbrMemberKey]
								,[MbrDemographicKey]
								,[MbrPlanKey]
								,[MbrCsPlanKey]
								,[MbrPCPKey]
								,[MbrPhoneKey_Home]
								,[MbrPhoneKey_Mobile]
								,[MbrPhoneKey_Work]
								,[MbrAddressKey_Home]
								,[MbrAddressKey_Work]
								,[MbrEmailKey]
								,[MbrRespPartyKey]
								)
	SELECT						fm.CreatedDate, 
								fm.CreatedBy, 
								fm.LastUpdatedDate, 
								fm.LastUpdatedBy, 
								fm.AdiKey, 
								fm.SrcFileName,
								'adw.vw_fctMembership'    AS AdiTableName,
								[LoadDate],
								[DataDate],
								fm.RowEffectiveDate, 
								fm.RowExpirationDate, ----'2021-01-31',--
								fm.ClientKey, 
								fm.Ace_ID, 
								fm.ClientMemberKey, 
								fm.MBI, 
								fm.HICN, 
								fm.SubscriberIndicator, 
								fm.MemberIndicator, 
								fm.Relationship, 
								fm.FirstName, 
								fm.MiddleName, 
								fm.LastName, 
								fm.Gender, 
								fm.DOB, 
								fm.DOD, 
								fm.MemberSSN, 
								fm.CurrentAge, 
								fm.AgeGroup20Years, 
								fm.AgeGroup10Years, 
								fm.AgeGroup5Years, 
								fm.MbrMonth, 
								fm.MbrYear, 
								fm.LanguageCode, 
								fm.Ethnicity, 
								fm.Race, 
								fm.MemberHomeAddress, 
								fm.MemberHomeAddress1, 
								fm.MemberHomeCity, 
								fm.MemberHomeState, 
								[adi].[udf_ConvertToCamelCase](ISNULL(fm.CountyName,'')) CountyName,
								fm.CountyNumber, 
								fm.Region, 
								fm.POD, 
								fm.[MemberHomeZip],
								''				AS		[MemberMailingAddress],
								''				AS		[MemberMailingAddress1],
								''				AS		[MemberMailingCity],
								''				AS		[MemberMailingState],
								fm.MemberHomeZip, 
								fm.MemberHomePhone, 
								fm.MemberCellPhone, 
								fm.MemberWorkPhone, 
								fm.MedicaidMedicareDualEligibleIndicator, 
								fm.PersonMonthCreatedfromClaimIndicator, 
								fm.MemberStatus, 
								fm.EnrollementStatus, 
								fm.MemberID, 
								fm.MedicaidID, 
								fm.CardID, 
								fm.FamilyID, 
								fm.BenefitType, 
								fm.LOB, 
								fm.PlanID, 
								fm.ProductCode, 
								fm.SubgrpID, 
								fm.MbrCsSubPlanName, 
								fm.PlanName, 
								fm.PlanType, 
								fm.PlanTier, 
								fm.Contract, 
								fm.NPI, 
								fm.PcpPracticeTIN, 
								[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderFirstName,'')) ProviderFirstName
								,fm.ProviderMI
								,[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderLastName,'')) ProviderLastName
								,[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderPracticeName, ''))ProviderPracticeName
								,[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderAddressLine1,'')) ProviderAddressLine1
								,[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderAddressLine2,'')) ProviderAddressLine2
								,[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderCity, '')) ProviderCity
								,[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderCounty,'')) ProviderCounty
								,fm.ProviderZip, 
								[lst].[fnStripNonNumericChar](fm.ProviderPhone) ProviderPhone,
								[adi].[udf_ConvertToCamelCase](ISNULL(fm.ProviderSpecialty,'')) ProviderSpecialty,
								fm.ProviderNetwork, 
								fm.SpecialistStatus, 
								fm.GroupOrPrivatePractice, 
								fm.ProviderPOD, 
								fm.ProviderChapter, 
								fm.AceRiskScore, 
								fm.AceRiskScoreLevel, 
								fm.ClientRiskScore, 
								fm.ClientRiskScoreLevel, 
								fm.RiskScoreUtilization, 
								fm.RiskScoreClinical, 
								fm.RiskScoreHRA, 
								fm.RiskScorePlaceHolder, 
								fm.EnrollmentYear, 
								fm.EnrollmentQuarter, 
								fm.EnrollmentYearQuarter, 
								fm.EnrollmentYearMonth, 
								fm.EligibleYear, 
								fm.EligibilityQuarter, 
								fm.EligibilityYearQuarter, 
								fm.EligibilityYearMonth, 
								fm.MemberCount, 
								fm.AvgMemberCount, 
								fm.SubscriberCount, 
								fm.AvgSubscriberCount, 
								fm.PersonCreatedCount, 
								fm.MemberMonths, 
								fm.SubscriberMonths, 
								fm.FamilyRatio, 
								fm.AvgAge, 
								fm.NoOfMonths, 
								fm.MemberCurrentEffectiveDate, 
								fm.MemberCurrentExpirationDate, 
								fm.Active, 
								fm.Excluded,
								[MbrMemberKey]
								,[MbrDemographicKey]
								,[MbrPlanKey]
								,[MbrCsPlanKey]
								,[MbrPCPKey]
								,[MbrPhoneKey_Home]
								,[MbrPhoneKey_Mobile]
								,[MbrPhoneKey_Work]
								,[MbrAddressKey_Home]
								,[MbrAddressKey_Work]
								,[MbrEmailKey]
								,[MbrRespPartyKey]
	FROM						[adw].[tvf_FctMembership] (@DataDate) fm 
	WHERE						DataDate = @DataDate
					




