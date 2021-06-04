﻿


CREATE VIEW [adw].[vw_Dashboard_Membership]
AS 
    -- Purpose: creates a Persiste
    SELECT fct.FctMembershipSkey, 
       fct.CreatedDate, 
       fct.CreatedBy, 
       fct.LastUpdatedDate, 
       fct.LastUpdatedBy, 
       fct.AdiKey, 
       fct.SrcFileName, 
       fct.AdiTableName, 
       fct.LoadDate, 
       fct.DataDate, 
       fct.RwEffectiveDate, 
       fct.RwExpirationDate, 
       fct.ClientKey, 
       fct.Ace_ID, 
       fct.ClientMemberKey, 
       fct.MBI, 
       fct.HICN, 
       fct.SubscriberIndicator, 
       fct.MemberIndicator, 
       fct.Relationship, 
       fct.FirstName, 
       fct.MiddleName, 
       fct.LastName, 
       fct.Gender, 
       fct.DOB, 
       fct.DOD, 
       fct.MemberSSN, 
       fct.CurrentAge, 
       fct.AgeGroup20Years, 
       fct.AgeGroup10Years, 
       fct.AgeGroup5Years, 
       fct.MbrMonth, 
       fct.MbrYear, 
       fct.LanguageCode, 
       fct.Ethnicity, 
       fct.Race, 
       fct.MemberHomeAddress, 
       fct.MemberHomeAddress1, 
       fct.MemberHomeCity, 
       fct.MemberHomeState, 
       fct.CountyName, 
       fct.CountyNumber, 
       fct.Region, 
       fct.POD, 
       fct.MemberHomeZip, 
       fct.MemberMailingAddress, 
       fct.MemberMailingAddress1, 
       fct.MemberMailingCity, 
       fct.MemberMailingState, 
       fct.MemberMailingZip, 
       fct.MemberPhone, 
       fct.MemberCellPhone, 
       fct.MemberHomePhone, 
       fct.MedicaidMedicareDualEligibleIndicator, 
       fct.PersonMonthCreatedfromClaimIndicator, 
       fct.MemberStatus, 
       fct.EnrollementStatus, 
       fct.MemberID, 
       fct.MedicaidID, 
       fct.CardID, 
       fct.FamilyID, 
       fct.BenefitType, 
       fct.LOB, 
       fct.PlanID, 
       fct.ProductCode, 
       fct.SubgrpID, 
       fct.SubgrpName, 
       fct.PlanName, 
       fct.PlanType, 
       fct.PlanTier, 
       fct.Contract, 
       fct.NPI, 
       fct.PcpPracticeTIN, 
       fct.ProviderFirstName, 
       fct.ProviderMI, 
       fct.ProviderLastName, 
       fct.ProviderPracticeName, 
       fct.ProviderAddressLine1, 
       fct.ProviderAddressLine2, 
       fct.ProviderCity, 
       fct.ProviderCounty, 
       fct.ProviderZip, 
       fct.ProviderPhone, 
       fct.ProviderSpecialty, 
       fct.ProviderNetwork, 
       fct.SpecialistStatus, 
       fct.GroupOrPrivatePractice, 
       fct.ProviderPOD, 
       fct.ProviderChapter, 
       fct.AceRiskScore, 
       fct.AceRiskScoreLevel, 
       fct.ClientRiskScore, 
       fct.ClientRiskScoreLevel, 
       fct.RiskScoreUtilization, 
       fct.RiskScoreClinical, 
       fct.RiskScoreHRA, 
       fct.RiskScorePlaceHolder, 
       fct.EnrollmentYear, 
       fct.EnrollmentQuarter, 
       fct.EnrollmentYearQuarter, 
       fct.EnrollmentYearMonth, 
       fct.EligibleYear, 
       fct.EligibilityQuarter, 
       fct.EligibilityYearQuarter, 
       fct.EligibilityYearMonth, 
       fct.MemberCount, 
       fct.AvgMemberCount, 
       fct.SubscriberCount, 
       fct.AvgSubscriberCount, 
       fct.PersonCreatedCount, 
       fct.MemberMonths, 
       fct.SubscriberMonths, 
       fct.FamilyRatio, 
       fct.AvgAge, 
       fct.NoOfMonths, 
       fct.MemberCurrentEffectiveDate, 
       fct.MemberCurrentExpirationDate, 
       fct.Active
FROM adw.FctMembership fct;
