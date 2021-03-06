CREATE TABLE [adi].[Amerigroup_Monthly_CodeSets] (
    [Amerigroup_MonthlyCodeSetsSKey] INT            IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]               VARCHAR (100)  NOT NULL,
    [SrcFileName]                    VARCHAR (100)  NOT NULL,
    [LoadDate]                       DATE           NOT NULL,
    [CreatedDate]                    DATETIME       CONSTRAINT [DF_Amerigroup_Monthly_CodeSets1] DEFAULT (getdate()) NULL,
    [DataDate]                       DATE           NOT NULL,
    [FileDate]                       DATE           NOT NULL,
    [CreatedBy]                      VARCHAR (50)   CONSTRAINT [DF_Amerigroup_Monthly_CodeSets2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]                DATETIME       CONSTRAINT [DF_Amerigroup_Monthly_CodeSets3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                  VARCHAR (50)   CONSTRAINT [DF_Amerigroup_Monthly_CodeSets4] DEFAULT (suser_sname()) NOT NULL,
    [CodeSet]                        VARCHAR (40)   NULL,
    [CodeValue]                      VARCHAR (100)  NULL,
    [CodeValueName]                  VARCHAR (1000) NULL,
    [SystemRecordCode]               VARCHAR (10)   NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_MonthlyCodeSetsSKey] ASC)
);

