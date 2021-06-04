








CREATE FUNCTION [adw].[tvf_FctMembership](@DataDate	DATE
)
RETURNS TABLE
AS
RETURN
(
SELECT
    /* Fct Mbr Metadata and keys */

    FMbr.FctMembershipSkey AS FctMembershipSkey, 
    FMbr.CreatedDate AS CreatedDate, 
    FMbr.CreatedBy AS CreatedBy, 
    FMbr.LastUpdatedDate AS LastUpdatedDate, 
    FMbr.LastUpdatedBy AS LastUpdatedBy, 
    FMbr.FctMembershipSkey AS AdiKey, 
    'adw.FctMembership_Dev' AS SrcFileName, 
    FMbr.RowEffectiveDate AS RowEffectiveDate, 
    FMbr.RowExpirationDate AS RowExpirationDate, 
    Fmbr.ClientKey AS ClientKey, 
    FMbr.Ace_ID AS Ace_ID, 
    FMbr.ClientMemberKey AS ClientMemberKey, 
    FMbr.ClientMemberKey AS MemberID, 
    FMbr.MbrMonth AS MbrMonth, 
    FMbr.MbrYear AS MbrYear,

    /* Mbr Membership	  */

    --dMbr.adiKey MbrAdiKey, --dMbr.adiTableName MbrAdiTableName, 	--dMbr.EffectiveDate MbrEffectiveDate, 	--dMbr.ExpirationDate MbrExpirationDate,
    
    /* Mbr Demographics */ --FMbr.MbrDemographicKey,     
    --dDem.adiKey MDemoAdiKey, dDem.adiTableName MDemoAdiTableName, dDem.EffectiveDate MDemoEffectiveDate,  dDem.ExpirationDate MDemoExpirationDate, 			        
    dDem.MBI AS MBI, 
    ddem.HICN AS HICN, 
    dDem.MedicaidID AS MedicaidID, 

    '' AS Relationship, --
    dDem.FirstName AS FirstName, 
    dDem.MiddleName AS MiddleName, 
    dDem.LastName AS LastName, 
    dDem.Gender AS Gender, 
    dDem.DOB AS DOB, 
    dDem.DOD AS DOD, 
    dDem.SSN AS MemberSSN,     
    FMbr.AgeGroup20Years AS AgeGroup20Years, 
    FMbr.AgeGroup10Years AS AgeGroup10Years, 
    FMbr.AgeGroup5Years AS AgeGroup5Years, 
    dDem.PrimaryLanguage AS LanguageCode, 
    dDem.Ethnicity AS Ethnicity, 
    dDem.Race AS Race, 
    dDem.mbrInsuranceCardIdNum AS CardID,     
    '' AS FamilyID,
    /* Mbr Plan fields */ --FMbr.MbrPlanKey, dPlan.adiKey MPlanAdiKey,dPlan.adiTableName MPlanAdiTableName,dPlan.EffectiveDate MPlanEffectiveDate,dPlan.ExpirationDate MPlanExpirationDate

    '' AS MedicaidMedicareDualEligibleIndicator, 
    '' AS PersonMonthCreatedfromClaimIndicator,         
    dPlan.ProductPlan, 
    dPlan.ProductSubPlan, 
    dPlan.ProductSubPlanName, 
    dPlan.MbrIsDualCoverage, 
    dPlan.DualEligiblityStatus, 
    dPlan.ClientPlanEffective, 
    '' AS BenefitType, 
    Client.ClientShortName AS LOB,

    /* Cs Plan */    --FMbr.MbrCsPlanKey, --dCsPlan.adiKey ,-- dCsPlan.EffectiveDate, dCsPlan.ExpirationDate 
    '' AS PlanID, 
    '' AS ProductCode, 
    '' AS SubgrpID, 
    dCsPlan.MbrCsSubPlan,     
    dCsPlan.MbrCsSubPlanName,
    '' AS PlanName, 
    '' AS PlanType, 
    '' AS PlanTier, 
    '' AS Contract, 
    --     dCsPlan.MbrCsSubPlan, 						
    --     dCsPlan.MbrCsSubPlanName, 					
    --     dCsPlan.planHistoryStatus,					

    /* Mbr Pcp */    --FMbr.MbrPCPKey, dPcp.adiKey, dPcp.adiTableName, dPcp.EffectiveDate,dPcp.ExpirationDate,dPcp.AutoAssigned,
    dPcp.NPI AS NPI, 
    dPcp.TIN AS PcpPracticeTIN, 
    ProviderRost.FirstName AS ProviderFirstName, 
    '' AS ProviderMI, 
    ProviderRost.LastName AS ProviderLastName, 
    ProviderRost.GroupName AS ProviderPracticeName, 
    ProviderRost.PrimaryAddress AS ProviderAddressLine1, 
    '' AS ProviderAddressLine2, 
    ProviderRost.PrimaryCity AS ProviderCity, 
    '' AS ProviderCounty, 
    ProviderRost.PrimaryZipcode AS ProviderZip, 
    ProviderRost.PrimaryAddressPhoneNum AS ProviderPhone, 
    ProviderRost.PrimarySpeciality AS ProviderSpecialty, 
    ProviderRost.fctProviderRosterSkey, ProviderRost.EffectiveDate, 
    '' AS ProviderNetwork, 
    '' AS SpecialistStatus, 
    '' AS GroupOrPrivatePractice, 
    ProviderRost.PrimaryPOD	  AS ProviderPOD, 
    ProviderRost.Chapter		  AS ProviderChapter,
    
    /* Mbr Phones */    
    dHomePhone.PhoneNumber	   AS MemberHomePhone, 
    ''							AS MemberCellPhone,     ---dMobilePhone.PhoneNumber
    ''							AS MemberWorkPhone,   ---dWorkPhone.PhoneNumber
    
    /* Mbr Home Address */
    dAddHome.Address1	   AS MemberHomeAddress, --	FMbr.MbrPhoneKey_Home, 							     
    dAddHome.Address2	   AS MemberHomeAddress1, 
    dAddHome.CITY		   AS MemberHomeCity, 
    dAddHome.STATE		   AS MemberHomeState, 
    dAddHome.ZIP		   AS MemberHomeZip, 
    dAddHome.COUNTY		   AS CountyName, 
    '' AS CountyNumber, 
    '' AS Region, 
    '' AS POD, 

    /* Mbr Work Address */
    --dAddWork.Address1	   AS MemberWorkAddress, 
    --dAddWork.Address2 	   AS MemberWorkAddress1,
    --dAddWork.CITY	  	   AS MemberWorkCity, 
    --dAddWork.STATE	  	   AS MemberWorkState, 
    --dAddWork.ZIP 		   AS MemberWorkZip, 
    --dAddWork.COUNTY		   AS MemberWorkCounty,
    
    --dEmail.EmailAddress,

    /* MbrRespParty */    
    --dRespParty.LastName	   AS RespParty_LastName, 
    --dRespParty.FirstName	   AS RespParty_FirstName, 
    --dRespParty.Address1	   AS RespParty_Address1, 
    --dRespParty.Address2	   AS RespParty_Address2, 
    --dRespParty.CITY		   AS RespParty_City, 
    --dRespParty.[STATE]	   AS RespParty_State,  
    --dRespParty.ZIP		   AS RespParty_Zip, 
    --dRespParty.Phone	   AS RespParty_Phone, 

    FMbr.SubscriberIndicator, 
    FMbr.MemberIndicator, 
    FMbr.CurrentAge, 
    FMbr.MemberStatus, 
    FMbr.EnrollementStatus, 
    FMbr.AceRiskScore AS AceRiskScore, 
    FMbr.AceRiskScoreLevel AS AceRiskScoreLevel, 
    FMbr.ClientRiskScore AS ClientRiskScore, 
    FMbr.ClientRiskScoreLevel AS ClientRiskScoreLevel, 
    FMbr.RiskScoreUtilization AS RiskScoreUtilization, 
    FMbr.RiskScoreClinical AS RiskScoreClinical, 
    FMbr.RiskScoreHRA AS RiskScoreHRA, 
    FMbr.RiskScorePlaceHolder AS RiskScorePlaceHolder, 
    FMbr.EnrollmentYear AS EnrollmentYear, 
    FMbr.EnrollmentQuarter AS EnrollmentQuarter, 
    FMbr.EnrollmentYearQuarter AS EnrollmentYearQuarter, 
    FMbr.EnrollmentYearMonth AS EnrollmentYearMonth, 
    FMbr.EligibleYear AS EligibleYear, 
    FMbr.EligibilityQuarter AS EligibilityQuarter, 
    FMbr.EligibilityYearQuarter AS EligibilityYearQuarter, 
    FMbr.EligibilityYearMonth AS EligibilityYearMonth, 
    FMbr.MemberCount AS MemberCount, 
    FMbr.AvgMemberCount AS AvgMemberCount, 
    FMbr.SubscriberCount AS SubscriberCount, 
    FMbr.AvgSubscriberCount AS AvgSubscriberCount, 
    FMbr.PersonCreatedCount AS PersonCreatedCount, 
    FMbr.MemberMonths AS MemberMonths, 
    FMbr.SubscriberMonths AS SubscriberMonths, 
    FMbr.FamilyRatio AS FamilyRatio, 
    FMbr.AvgAge AS AvgAge, 
    FMbr.NoOfMonths AS NoOfMonths, 
    FMbr.MemberCurrentEffectiveDate AS MemberCurrentEffectiveDate, 
    FMbr.MemberCurrentExpirationDate AS MemberCurrentExpirationDate, 
    FMbr.Active AS Active, 
    FMbr.Excluded,
    FMbr.MbrMemberKey,
    FMbr.MbrDemographicKey,
    FMbr.MbrPCPKey,
    FMbr.MbrPlanKey,
    FMbr.MbrCsPlanKey,
    FMbr.MbrRespPartyKey,
    FMbr.MbrAddressKey_Home,
    FMbr.MbrAddressKey_Work,
    FMbr.MbrPhoneKey_Home,
    FMbr.MbrPhoneKey_Mobile,
    FMbr.MbrPhoneKey_Work,
    FMbr.MbrEmailKey,
	FMbr.DataDate,
	FMbr.LoadDate
	--	SELECT * 
FROM adw.[FctMembership_Dev] FMbr
     JOIN lst.list_Client Client ON FMbr.ClientKey = Client.ClientKey
     JOIN adw.MbrMember dMbr ON FMbr.MbrMemberKey = dMbr.mbrMemberKey
     JOIN adw.MbrDemographic dDem ON FMbr.MbrDemographicKey = dDem.mbrDemographicKey
     JOIN adw.MbrPlan dPlan ON FMbr.MbrPlanKey = dPlan.mbrPlanKey
     JOIN adw.mbrCsPlan dCsPlan ON FMbr.MbrCsPlanKey = dCsPlan.mbrCsPlanKey
     JOIN adw.MbrPcp dPcp ON FMbr.MbrPCPKey = dPcp.mbrPcpKey
     JOIN adw.MbrPhone dHomePhone ON fmbr.MbrPhoneKey_Home = dHomePhone.mbrPhoneKey
     --JOIN adw.MbrPhone dMobilePhone ON fmbr.MbrPhoneKey_Mobile = dMobilePhone.mbrPhoneKey
     --JOIN adw.MbrPhone dWorkPhone ON fmbr.MbrPhoneKey_Work = dWorkPhone.mbrPhoneKey
     JOIN adw.MbrAddress dAddHome ON FMbr.MbrAddressKey_Home = dAddHome.mbrAddressKey	
     --JOIN adw.MbrAddress dAddWork ON FMbr.MbrAddressKey_Work = dAddWork.mbrAddressKey
     --JOIN adw.MbrEmail dEmail ON FMbr.MbrEmailKey = dEmail.mbrEmailKey
     --JOIN adw.MbrRespParty dRespParty ON FMbr.MbrRespPartyKey = dRespParty.mbrRespPartyKey	
	JOIN (SELECT DISTINCT pr.NPI NPI, pr.AttribTIN  TIN, pr.FirstName AS FirstName
			 , pr.LastName as LastName, pr.AttribTINName AS GroupName
			 , pr.PrimaryAddress AS PrimaryAddress,  '' as ProviderAddress2   
			 , pr.PrimaryCity AS PrimaryCity,  pr.PrimaryZipcode AS PrimaryZipcode, pr.PrimaryAddressPhoneNumber AS PrimaryAddressPhoneNum, 
			 pr.ProviderSpecialty AS PrimarySpeciality, pr.fctProviderRosterSkey fctProviderRosterSkey, CONVERT(date, pr.LastUpdatedDate) EffectiveDate, 
			 pr.Chapter AS PrimaryPOD, pr.Chapter AS Chapter
			 FROM (SELECT * FROM (
						SELECT * --,ROW_NUMBER()OVER(PARTITION BY NPI, AttribTIN ORDER BY RowEffectiveDate) NpiCnt
							FROM [ACECAREDW].adw.tvf_AllClient_ProviderRoster (21,@DataDate,1) pr 
									JOIN (	SELECT  * 
												FROM (
														SELECT	pry.TIN,PrimaryAddress,PrimaryCity
																,PrimaryState,PrimaryZipcode
																, PrimaryAddressPhoneNumber
																, ROW_NUMBER()OVER(PARTITION BY pry.TIN ORDER BY pry.DataDate DESC)RwCnt
														FROM	[ACECAREDW].[adw].[FctProviderPracticePrimaryAddress] pry
														JOIN	[ACECAREDW].[adw].[FctProviderPracticeBillingAddress] bil
														ON		pry.TIN = bil.TIN
														)a
												WHERE	 RwCnt = 1
													)pry 
									ON				pr.AttribTIN = pry.TIN
									)pr 
					) pr
				) ProviderRost
		  ON dPcp.NPI = ProviderRost.NPI 
		  AND dPcp.TIN = ProviderRost.TIN
		  

	--LEFT JOIN adw.fctProviderRoster ProviderRost
     --LEFT JOIN (SELECT pr.*
	--		 , ROW_NUMBER() OVER (PARTITION BY PR.TIN, pr.GroupName, PR.NPI, PR.ClientKey, PR.Chapter , pr.RowEffectiveDate, pr.effectiveDate ORDER BY pr.fctProviderRosterSkey) aAddRowNum
	--		 FROM adw.fctProviderRoster PR )ProviderRost
--	   ON dPcp.NPI = ProviderRost.NPI
--		  AND dPcp.TIN = ProviderRost.TIN
--		  --AND ProviderRost.aAddRowNum = 1
--		  AND FMbr.RowEffectiveDate BETWEEN ProviderRost.RowEffectiveDate and ProviderRost.RowExpirationDate
--JOIN adw.
--where FMbr.MbrYear = 2020 and FMbr.MbrMonth = 1
)
