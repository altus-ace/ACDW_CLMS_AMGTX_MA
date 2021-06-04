﻿CREATE TABLE [adi].[Amerigroup_RxClaims] (
    [RxClaimsKey]                   INT             IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]              VARCHAR (100)   NOT NULL,
    [SrcFileName]                   VARCHAR (100)   NOT NULL,
    [LoadDate]                      DATE            NOT NULL,
    [CreatedDate]                   DATE            CONSTRAINT [DF_Amerigroup_RxClaims1] DEFAULT (getdate()) NOT NULL,
    [DataDate]                      DATE            NOT NULL,
    [FileDate]                      DATE            NOT NULL,
    [CreatedBy]                     VARCHAR (50)    CONSTRAINT [DF_Amerigroup_RxClaims2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]               DATETIME        CONSTRAINT [DF_Amerigroup_RxClaims3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                 VARCHAR (50)    CONSTRAINT [DF_Amerigroup_RxClaims4] DEFAULT (suser_sname()) NOT NULL,
    [Master_Consumer_ID]            BIGINT          NULL,
    [FilledDate]                    DATE            NULL,
    [NDCNumber]                     VARCHAR (11)    NULL,
    [DEANumber]                     VARCHAR (25)    NULL,
    [PharmacyNumber]                VARCHAR (16)    NULL,
    [PharmacyName]                  VARCHAR (60)    NULL,
    [TherapeuticClass]              VARCHAR (8)     NULL,
    [GenericIndicator]              VARCHAR (7)     NULL,
    [DaysSupplied]                  DECIMAL (5)     NULL,
    [FormularyIndicator]            VARCHAR (5)     NULL,
    [RetailMailIndicator]           VARCHAR (10)    NULL,
    [BilledCharges]                 DECIMAL (18, 2) NULL,
    [Year]                          VARCHAR (4)     NULL,
    [Quarter]                       VARCHAR (6)     NULL,
    [Month]                         VARCHAR (6)     NULL,
    [ProviderLicenseNumber]         VARCHAR (25)    NULL,
    [ScriptWrittenDate]             DATE            NULL,
    [PrescriberName]                VARCHAR (80)    NULL,
    [QuantityDispensed]             DECIMAL (18, 3) NULL,
    [RXNumber]                      VARCHAR (20)    NULL,
    [IngredientCost]                DECIMAL (18, 2) NULL,
    [Copay]                         DECIMAL (18, 2) NULL,
    [LabelName]                     VARCHAR (100)   NULL,
    [PrescriberNPI]                 VARCHAR (25)    NULL,
    [ClaimNbr]                      VARCHAR (24)    NULL,
    [ClaimAdjustmentNumber]         DECIMAL (4)     NULL,
    [ClaimDispositionCode]          VARCHAR (5)     NULL,
    [MemberKey]                     VARCHAR (32)    NULL,
    [Patient_Responsibility_Amount] DECIMAL (18, 2) NULL,
    [Paid_Amount]                   DECIMAL (18, 2) NULL,
    [Allowed_Amount]                DECIMAL (18, 2) NULL,
    [REDACT_FLAG]                   VARCHAR (1)     NULL,
    [PG_ID]                         VARCHAR (32)    NULL,
    [PG_NAME]                       VARCHAR (100)   NULL,
    [CLM_ADJSTMNT_KEY]              VARCHAR (32)    NULL,
    [GL_POST_DT]                    DATE            NULL,
    [Line_Number]                   VARCHAR (6)     NULL,
    [DRG_NM]                        VARCHAR (60)    NULL,
    [StatusCode]                    VARCHAR (5)     NULL,
    [RefillNumber]                  DECIMAL (4)     NULL,
    [Refill]                        DECIMAL (4)     NULL,
    [Claim_Processed_Date]          DATE            NULL,
    [Denial_Reason_Code]            VARCHAR (15)    NULL,
    [Denial_Reason_Description]     VARCHAR (150)   NULL,
    [Compound_Drug]                 VARCHAR (4)     NULL,
    [Dispensing_Fee]                DECIMAL (18, 2) NULL,
    [BillingProviderNPI]            VARCHAR (25)    NULL,
    PRIMARY KEY CLUSTERED ([RxClaimsKey] ASC)
);
