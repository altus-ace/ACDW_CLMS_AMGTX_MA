CREATE TABLE [adw].[MbrRespParty] (
    [mbrRespPartyKey] INT           IDENTITY (1, 1) NOT NULL,
    [mbrMemberKey]    INT           NOT NULL,
    [ClientMemberKey] VARCHAR (50)  NOT NULL,
    [ClientKey]       INT           NULL,
    [adiKey]          INT           NOT NULL,
    [adiTableName]    VARCHAR (100) NOT NULL,
    [recordFlag]      CHAR (1)      NOT NULL,
    [EffectiveDate]   DATE          NOT NULL,
    [ExpirationDate]  DATE          CONSTRAINT [DF_MbrRespPartyExpirationDate] DEFAULT ('12/31/9999') NOT NULL,
    [LastName]        VARCHAR (100) NULL,
    [FirstName]       VARCHAR (100) NULL,
    [Address1]        VARCHAR (100) NULL,
    [Address2]        VARCHAR (100) NULL,
    [CITY]            VARCHAR (65)  NULL,
    [STATE]           VARCHAR (25)  NULL,
    [ZIP]             VARCHAR (20)  NULL,
    [Phone]           VARCHAR (30)  NULL,
    [LoadDate]        DATE          NOT NULL,
    [DataDate]        DATE          NOT NULL,
    [CreatedDate]     DATETIME2 (7) CONSTRAINT [DF_MbrRespParty_CreateDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)  CONSTRAINT [DF_MbrRespParty_CreateBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate] DATETIME2 (7) CONSTRAINT [DF_MbrRespParty_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]   VARCHAR (50)  CONSTRAINT [DF_MbrRespParty_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    PRIMARY KEY CLUSTERED ([mbrRespPartyKey] ASC)
);

