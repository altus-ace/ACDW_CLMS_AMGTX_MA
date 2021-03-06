CREATE TABLE [adi].[Amerigroup_AltusAceGapAdherence] (
    [Amerigroup_PharmacyKey]                               INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]                                     VARCHAR (100) NOT NULL,
    [SrcFileName]                                          VARCHAR (100) NOT NULL,
    [LoadDate]                                             DATE          NOT NULL,
    [CreatedDate]                                          DATETIME      CONSTRAINT [DF_Amerigroup_Pharmacy1] DEFAULT (getdate()) NULL,
    [DataDate]                                             DATE          NOT NULL,
    [FileDate]                                             DATE          NOT NULL,
    [CreatedBy]                                            VARCHAR (50)  CONSTRAINT [DF_Amerigroup_Pharmacy2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]                                      DATETIME      CONSTRAINT [DF_Amerigroup_Pharmacy3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                                        VARCHAR (50)  CONSTRAINT [DF_Amerigroup_Pharmacy4] DEFAULT (suser_sname()) NOT NULL,
    [PGID_ProviderGroupName]                               VARCHAR (50)  NULL,
    [PGID]                                                 VARCHAR (50)  NULL,
    [ProviderGroupName]                                    VARCHAR (50)  NULL,
    [ProviderTIN]                                          VARCHAR (50)  NULL,
    [ProviderTINName]                                      VARCHAR (50)  NULL,
    [ProviderNPI]                                          VARCHAR (50)  NULL,
    [ProviderFirstName]                                    VARCHAR (50)  NULL,
    [ProviderLastName]                                     VARCHAR (50)  NULL,
    [ProviderCity]                                         VARCHAR (50)  NULL,
    [ProviderState]                                        VARCHAR (50)  NULL,
    [ProviderZipcode]                                      VARCHAR (50)  NULL,
    [AnthemMemberID]                                       VARCHAR (50)  NULL,
    [SBSCRBR_ID]                                           VARCHAR (50)  NULL,
    [Contract_ID]                                          VARCHAR (50)  NULL,
    [PBP]                                                  VARCHAR (50)  NULL,
    [MemberFirstName]                                      VARCHAR (50)  NULL,
    [MemberLastName]                                       VARCHAR (50)  NULL,
    [DOB]                                                  DATE          NULL,
    [MemberPhoneNumber]                                    VARCHAR (20)  NULL,
    [DiabetesProportionDaysCovered_PDC]                    VARCHAR (50)  NULL,
    [DiabetesAllowableDays]                                VARCHAR (50)  NULL,
    [DiabetesAdherentPriorYear]                            VARCHAR (50)  NULL,
    [DiabetesDrugNameLastPaidClaim]                        VARCHAR (50)  NULL,
    [DiabetesLastfilldate]                                 DATE          NULL,
    [DiabetesDrugLastDaysSupply]                           VARCHAR (50)  NULL,
    [NextRefillDateDiabetes]                               DATE          NULL,
    [PrescriberForDiabetes]                                VARCHAR (50)  NULL,
    [PrescriberNPIForDiabetes]                             VARCHAR (50)  NULL,
    [DaySupplyBenefitEligibilityForDiabetes]               VARCHAR (50)  NULL,
    [HypertensionProportionDaysCovered_PDC]                VARCHAR (50)  NULL,
    [HypertensionAllowabledays]                            VARCHAR (50)  NULL,
    [AdherentPriorYear]                                    VARCHAR (50)  NULL,
    [HypertensionDrugnamebasedonlastpaidclaim]             VARCHAR (50)  NULL,
    [Lastfilldate]                                         DATE          NULL,
    [HypertensionDrugLastDaysSupply]                       VARCHAR (50)  NULL,
    [NextRefillDateHypertension]                           VARCHAR (50)  NULL,
    [PrescriberforHypertension]                            VARCHAR (50)  NULL,
    [PrescriberNPIforHypertension]                         VARCHAR (50)  NULL,
    [DaySupplyBenefitEligibilityforHypertension]           VARCHAR (50)  NULL,
    [CholesterolProportionofDaysCovered_PDC]               VARCHAR (50)  NULL,
    [CholesterolAllowabledays]                             VARCHAR (50)  NULL,
    [CholesterolAdherentPriorYear]                         VARCHAR (50)  NULL,
    [CholesterolDrugnameBasedOnLastPaidClaim]              VARCHAR (50)  NULL,
    [CholesterolLastfilldate]                              DATE          NULL,
    [Cholesteroldruglastdayssupply]                        VARCHAR (50)  NULL,
    [NextrefillDateCholesterol]                            DATE          NULL,
    [PrescriberforCholesterol]                             VARCHAR (50)  NULL,
    [PrescriberNPIforCholesterol]                          VARCHAR (50)  NULL,
    [DaySupplyBenefitEligibilityForCholesterol]            VARCHAR (50)  NULL,
    [ExtendedDaySupplyOpportunity]                         VARCHAR (50)  NULL,
    [ClinicalCareCenterCallOutreachResult]                 VARCHAR (50)  NULL,
    [ClinicalPharmacyCareCenterOutreachCallDate]           DATE          NULL,
    [MTM_CMRCompletion]                                    VARCHAR (50)  NULL,
    [CMR_Vendor_Referral_Phone]                            VARCHAR (20)  NULL,
    [Statin_use_inPersonsWDiabetesIndicator]               VARCHAR (50)  NULL,
    [SUPD_Age_76]                                          VARCHAR (50)  NULL,
    [Statin_use_in_PersonsWCardioVascularDiseaseIndicator] VARCHAR (50)  NULL,
    [HomeDeliveryMultidosePackaging]                       VARCHAR (50)  NULL,
    [PharmacyName]                                         VARCHAR (50)  NULL,
    [PharmacyPhoneNumber]                                  VARCHAR (50)  NULL,
    [LowerCopayOpportunityWHomeDelivery]                   VARCHAR (50)  NULL,
    [RowStatus]                                            TINYINT       DEFAULT ((0)) NULL,
    [LIS_Indicator]                                        VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_PharmacyKey] ASC)
);

