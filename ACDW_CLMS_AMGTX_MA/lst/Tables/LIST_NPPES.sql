CREATE TABLE [lst].[LIST_NPPES] (
    [NPI]                VARCHAR (20)  NOT NULL,
    [EntityType]         VARCHAR (20)  NULL,
    [EIN]                VARCHAR (50)  NULL,
    [LBN]                VARCHAR (100) NULL,
    [LBN_Name]           VARCHAR (200) NULL,
    [LastName]           VARCHAR (100) NULL,
    [FirstName]          VARCHAR (100) NULL,
    [PracticeAddress1]   VARCHAR (100) NULL,
    [PracticeAddress2]   VARCHAR (50)  NULL,
    [PracticeCity]       VARCHAR (100) NULL,
    [PracticeState]      VARCHAR (50)  NULL,
    [PracticeZip]        VARCHAR (10)  NULL,
    [PracticePhone]      VARCHAR (20)  NULL,
    [PracticeFax]        VARCHAR (20)  NULL,
    [PracticeLastUpdate] VARCHAR (20)  NULL,
    [Taxonomy1]          VARCHAR (50)  NULL,
    [Taxonomy2]          VARCHAR (50)  NULL,
    [Taxonomy3]          VARCHAR (50)  NULL,
    [SrcFileName]        VARCHAR (100) NULL,
    [DataDate]           DATE          DEFAULT ('1/1/2018') NOT NULL,
    [CreatedDate]        DATETIME      CONSTRAINT [DF_lstListNppes_CreateDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]          VARCHAR (50)  CONSTRAINT [DF_lstListNppes_CreateBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]    DATETIME      CONSTRAINT [DF_lstListNppes_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]      VARCHAR (50)  CONSTRAINT [DF_lstListNppes_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    CONSTRAINT [PK_LIST_NPPES] PRIMARY KEY CLUSTERED ([NPI] ASC)
);

