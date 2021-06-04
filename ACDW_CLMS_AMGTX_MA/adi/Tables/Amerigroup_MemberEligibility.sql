CREATE TABLE [adi].[Amerigroup_MemberEligibility] (
    [MemberEligibilityKey]     INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]         VARCHAR (100) NOT NULL,
    [SrcFileName]              VARCHAR (100) NOT NULL,
    [LoadDate]                 DATE          NOT NULL,
    [CreatedDate]              DATE          CONSTRAINT [DF_Amerigroup_MemberEligibility1] DEFAULT (getdate()) NOT NULL,
    [DataDate]                 DATE          NOT NULL,
    [FileDate]                 DATE          NOT NULL,
    [CreatedBy]                VARCHAR (50)  CONSTRAINT [DF_Amerigroup_MemberEligibility2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]          DATETIME      CONSTRAINT [DF_Amerigroup_MemberEligibility3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]            VARCHAR (50)  CONSTRAINT [DF_Amerigroup_MemberEligibility4] DEFAULT (suser_sname()) NOT NULL,
    [MASTER_CONSUMER_ID]       BIGINT        NULL,
    [EligibilityEffectiveDate] DATE          NULL,
    [EligibilityEndDate]       DATE          NULL,
    [PG_ID]                    VARCHAR (32)  NULL,
    [PG_NAME]                  VARCHAR (150) NULL,
    [PRDCTSL]                  VARCHAR (32)  NULL,
    [RXBNFLG]                  VARCHAR (3)   NULL,
    [RowStatus]                TINYINT       NOT NULL,
    PRIMARY KEY CLUSTERED ([MemberEligibilityKey] ASC)
);

