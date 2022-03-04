CREATE TABLE [adi].[Amerigroup_Quality_MeasureDefinition] (
    [Amerigroup_Quality_MeasureDefinKey] INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]                   VARCHAR (100) NOT NULL,
    [SrcFileName]                        VARCHAR (100) NOT NULL,
    [LoadDate]                           DATE          NOT NULL,
    [CreatedDate]                        DATETIME      CONSTRAINT [Amerigroup_Quality_MeasureDefin1] DEFAULT (getdate()) NULL,
    [DataDate]                           DATE          NOT NULL,
    [FileDate]                           DATE          NOT NULL,
    [CreatedBy]                          VARCHAR (50)  CONSTRAINT [Amerigroup_Quality_MeasureDefin2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]                    DATETIME      CONSTRAINT [Amerigroup_Quality_MeasureDefin3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                      VARCHAR (50)  CONSTRAINT [Amerigroup_Quality_MeasureDefin4] DEFAULT (suser_sname()) NOT NULL,
    [Measure]                            VARCHAR (50)  NOT NULL,
    [SubMeasure]                         VARCHAR (50)  NOT NULL,
    [Definition]                         VARCHAR (500) NOT NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_Quality_MeasureDefinKey] ASC)
);

