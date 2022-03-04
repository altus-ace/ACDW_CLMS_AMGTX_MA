CREATE TABLE [adi].[Amerigroup_Quality_ColumnDesc] (
    [Amerigroup_QualityColumnDescKey] INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]                VARCHAR (100) NOT NULL,
    [SrcFileName]                     VARCHAR (100) NOT NULL,
    [LoadDate]                        DATE          NOT NULL,
    [CreatedDate]                     DATETIME      CONSTRAINT [Amerigroup_Quality_ColumnDesc1] DEFAULT (getdate()) NULL,
    [DataDate]                        DATE          NOT NULL,
    [FileDate]                        DATE          NOT NULL,
    [CreatedBy]                       VARCHAR (50)  CONSTRAINT [Amerigroup_Quality_ColumnDesc2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]                 DATETIME      CONSTRAINT [Amerigroup_Quality_ColumnDesc3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                   VARCHAR (50)  CONSTRAINT [Amerigroup_Quality_ColumnDesc4] DEFAULT (suser_sname()) NOT NULL,
    [ColumnName]                      VARCHAR (50)  NULL,
    [Description]                     VARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_QualityColumnDescKey] ASC)
);

