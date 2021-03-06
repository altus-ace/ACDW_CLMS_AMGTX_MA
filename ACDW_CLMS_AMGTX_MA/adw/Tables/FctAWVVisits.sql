CREATE TABLE [adw].[FctAWVVisits] (
    [FctAWVVisitsSkey]     INT           IDENTITY (1, 1) NOT NULL,
    [CreatedDate]          DATETIME      DEFAULT (getdate()) NULL,
    [CreatedBy]            VARCHAR (50)  DEFAULT (suser_sname()) NULL,
    [LastUpdatedDate]      DATETIME      DEFAULT (getdate()) NULL,
    [LastUpdatedBy]        VARCHAR (50)  DEFAULT (suser_sname()) NULL,
    [AdiKey]               INT           NULL,
    [SrcFileName]          VARCHAR (100) NULL,
    [LoadDate]             DATE          NULL,
    [DataDate]             DATE          NULL,
    [ClientKey]            INT           NULL,
    [ClientMemberKey]      VARCHAR (50)  NULL,
    [EffectiveAsOfDate]    DATE          NULL,
    [ClaimID]              VARCHAR (50)  NULL,
    [PrimaryServiceDate]   DATE          NULL,
    [AWVType]              VARCHAR (20)  NULL,
    [AWVCode]              VARCHAR (10)  NULL,
    [SVCProviderNPI]       VARCHAR (20)  NULL,
    [SVCProviderName]      VARCHAR (100) NULL,
    [SVCProviderSpecialty] VARCHAR (50)  NULL,
    [LastAWVKey]           INT           NULL,
    [LastAWVDate]          DATE          NULL,
    [LastAWVNPI]           VARCHAR (10)  NULL,
    [AttribNPI]            VARCHAR (10)  NULL,
    [AttribTIN]            VARCHAR (10)  NULL,
    CONSTRAINT [FctAWVVisitsSkey_pk] PRIMARY KEY CLUSTERED ([FctAWVVisitsSkey] ASC)
);

