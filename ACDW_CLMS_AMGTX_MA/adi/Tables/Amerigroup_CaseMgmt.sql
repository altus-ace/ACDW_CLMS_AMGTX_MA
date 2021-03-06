CREATE TABLE [adi].[Amerigroup_CaseMgmt] (
    [Amerigroup_CaseMgmtKey]  INT           IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]        VARCHAR (100) NOT NULL,
    [SrcFileName]             VARCHAR (100) NOT NULL,
    [LoadDate]                DATE          NOT NULL,
    [CreatedDate]             DATE          CONSTRAINT [DF_Amerigroup_CaseMgmt1] DEFAULT (getdate()) NOT NULL,
    [DataDate]                DATE          NOT NULL,
    [FileDate]                DATE          NOT NULL,
    [CreatedBy]               VARCHAR (50)  CONSTRAINT [DF_Amerigroup_CaseMgmt2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]         DATETIME      CONSTRAINT [DF_Amerigroup_CaseMgmt3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]           VARCHAR (50)  CONSTRAINT [DF_Amerigroup_CaseMgmt4] DEFAULT (suser_sname()) NOT NULL,
    [MCID_MASTER_CONSUMER_ID] BIGINT        NULL,
    [HLTH_PGM_ID]             VARCHAR (15)  NULL,
    [HLTH_PGM_NM]             VARCHAR (150) NULL,
    [HLTH_PGM_BGN_DT]         DATE          NULL,
    [HLTH_PGM_END_DT]         DATE          NULL,
    [HLTH_PGM_STTS_CD]        VARCHAR (10)  NULL,
    [RFRNC_NBR]               VARCHAR (25)  NULL,
    [MEMBER_KEY]              VARCHAR (32)  NULL,
    [PG_ID]                   VARCHAR (32)  NULL,
    [PG_NAME]                 VARCHAR (100) NULL,
    [PGM_STTS_RSN_CD]         VARCHAR (10)  NULL,
    [PGM_CASE_CLSFCTN_CD]     VARCHAR (10)  NULL,
    [PGM_CASE_TYPE_CD]        VARCHAR (15)  NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_CaseMgmtKey] ASC)
);

