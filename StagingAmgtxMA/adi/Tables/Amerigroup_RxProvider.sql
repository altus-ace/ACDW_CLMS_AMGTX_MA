﻿CREATE TABLE [adi].[Amerigroup_RxProvider] (
    [RxProviderKey]                INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]             VARCHAR (100) NOT NULL,
    [SrcFileName]                  VARCHAR (100) NOT NULL,
    [LoadDate]                     DATE          NOT NULL,
    [CreatedDate]                  DATETIME      CONSTRAINT [DF_Amerigroup_RxProvider1] DEFAULT (getdate()) NULL,
    [DataDate]                     DATE          NOT NULL,
    [FileDate]                     DATE          NOT NULL,
    [CreatedBy]                    VARCHAR (50)  CONSTRAINT [DF_Amerigroup_RxProvider2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]              DATETIME      CONSTRAINT [DF_Amerigroup_RxProvider3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                VARCHAR (50)  CONSTRAINT [DF_Amerigroup_RxProvider4] DEFAULT (suser_sname()) NOT NULL,
    [DEA_Number]                   VARCHAR (25)  NULL,
    [BillingProviderLicenseNumber] VARCHAR (25)  NULL,
    [PrescriberNPI]                VARCHAR (25)  NULL,
    [ProviderFirstName]            VARCHAR (50)  NULL,
    [ProviderLastName]             VARCHAR (70)  NULL,
    [ProviderSpecialty]            VARCHAR (50)  NULL,
    [TaxonomyCode]                 VARCHAR (50)  NULL,
    [REDACTFLAG]                   VARCHAR (50)  NULL,
    [PG_ID]                        VARCHAR (50)  NULL,
    [PG_NAME]                      VARCHAR (50)  NULL,
    [TO_Address_Line_1]            VARCHAR (150) NULL,
    [TO_ADDRESS_LINE_2]            VARCHAR (150) NULL,
    [City_Name]                    VARCHAR (50)  NULL,
    [State_Code]                   VARCHAR (20)  NULL,
    [Zip_Code]                     VARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([RxProviderKey] ASC)
);

