﻿CREATE TABLE [adi].[Amerigroup_SUPP-MBR] (
    [Amerigroup_SUPP-MBRKey]        INT            IDENTITY (1, 1) NOT NULL,
    [OriginalFileName]              VARCHAR (100)  NOT NULL,
    [SrcFileName]                   VARCHAR (100)  NOT NULL,
    [LoadDate]                      DATE           NOT NULL,
    [CreatedDate]                   DATE           CONSTRAINT [DF_Amerigroup_SUPP-MBR1] DEFAULT (getdate()) NOT NULL,
    [DataDate]                      DATE           NOT NULL,
    [FileDate]                      DATE           NOT NULL,
    [CreatedBy]                     VARCHAR (50)   CONSTRAINT [DF_Amerigroup_SUPP-MBR2] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]               DATETIME       CONSTRAINT [DF_Amerigroup_SUPP-MBR3] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]                 VARCHAR (50)   CONSTRAINT [DF_Amerigroup_SUPP-MBR4] DEFAULT (suser_sname()) NOT NULL,
    [MCID_MASTER_CONSUMER_ID]       BIGINT         NULL,
    [PG_ID]                         VARCHAR (32)   NULL,
    [PG_Name]                       VARCHAR (100)  NULL,
    [PGM_ID]                        VARCHAR (32)   NULL,
    [Panel_ID]                      VARCHAR (32)   NULL,
    [Line_Business]                 VARCHAR (32)   NULL,
    [RiskDrivers]                   VARCHAR (2000) NULL,
    [Condition_based_Opportunities] DECIMAL (9, 3) NULL,
    [CDOIHighPriority]              CHAR (1)       NULL,
    [NeedAnnualVisit]               CHAR (1)       NULL,
    [LastAnnualVisit]               DATE           NULL,
    [Conditions]                    VARCHAR (500)  NULL,
    PRIMARY KEY CLUSTERED ([Amerigroup_SUPP-MBRKey] ASC)
);

