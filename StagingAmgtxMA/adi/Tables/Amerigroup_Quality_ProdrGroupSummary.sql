CREATE TABLE [adi].[Amerigroup_Quality_ProdrGroupSummary] (
    [Amerigroup_Quality_ProdrGroupSummaryKey] INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]                        VARCHAR (100) NOT NULL,
    [SrcFileName]                             VARCHAR (100) NOT NULL,
    [LoadDate]                                DATE          NOT NULL,
    [CreatedDate]                             DATETIME      CONSTRAINT [Amerigroup_Quality_ProdrGroupSummary1] DEFAULT (getdate()) NULL,
    [DataDate]                                DATE          NOT NULL,
    [FileDate]                                DATE          NOT NULL,
    [CreatedBy]                               VARCHAR (50)  CONSTRAINT [Amerigroup_Quality_ProdrGroupSummary2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]                         DATETIME      CONSTRAINT [Amerigroup_Quality_ProdrGroupSummary3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                           VARCHAR (50)  CONSTRAINT [Amerigroup_Quality_ProdrGroupSummary4] DEFAULT (suser_sname()) NOT NULL,
    [ProviderGroup]                           VARCHAR (20)  NULL,
    [MeasurementYear]                         VARCHAR (20)  NULL,
    [DateAsOf]                                DATE          NULL,
    [Measure]                                 VARCHAR (50)  NULL,
    [Sub_Measure]                             VARCHAR (50)  NULL,
    [FocusMeasure]                            VARCHAR (20)  NULL,
    [Compliant]                               INT           NULL,
    [Non_Compliant]                           INT           NULL,
    [Eligible_Population]                     INT           NULL,
    [RATE]                                    VARCHAR (10)  NULL,
    [NCQA_QC_Target50thPercentile]            VARCHAR (10)  NULL,
    [MembersTarget_50th]                      VARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_Quality_ProdrGroupSummaryKey] ASC)
);

