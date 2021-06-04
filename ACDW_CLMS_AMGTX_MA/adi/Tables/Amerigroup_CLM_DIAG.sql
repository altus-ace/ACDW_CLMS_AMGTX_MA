CREATE TABLE [adi].[Amerigroup_CLM_DIAG] (
    [Amerigroup_CLM_DIAGKey] INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]       VARCHAR (100) NOT NULL,
    [SrcFileName]            VARCHAR (100) NOT NULL,
    [LoadDate]               DATE          NOT NULL,
    [CreatedDate]            DATE          CONSTRAINT [DF_Amerigroup_CLM_DIAG1] DEFAULT (getdate()) NOT NULL,
    [DataDate]               DATE          NOT NULL,
    [FileDate]               DATE          NOT NULL,
    [CreatedBy]              VARCHAR (50)  CONSTRAINT [DF_Amerigroup_CLM_DIAG2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]        DATETIME      CONSTRAINT [DF_Amerigroup_CLM_DIAG3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]          VARCHAR (50)  CONSTRAINT [DF_Amerigroup_CLM_DIAG4] DEFAULT (suser_sname()) NOT NULL,
    [ClaimNbr]               VARCHAR (24)  NULL,
    [ClaimAdjustmentNum]     DECIMAL (4)   NULL,
    [ClaimDispositionCode]   VARCHAR (5)   NULL,
    [PG_ID]                  VARCHAR (32)  NULL,
    [PG_NAME]                VARCHAR (100) NULL,
    [CLM_ADJSTMNT_KEY]       CHAR (32)     NULL,
    [SEQUENCENUMBER]         DECIMAL (2)   NULL,
    [DIAG_CD]                VARCHAR (10)  NULL,
    [LINE_Number]            VARCHAR (6)   NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_CLM_DIAGKey] ASC)
);

