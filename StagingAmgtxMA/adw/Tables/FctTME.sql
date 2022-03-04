﻿CREATE TABLE [adw].[FctTME] (
    [FctTMEKey]          INT             IDENTITY (1, 1) NOT NULL,
    [CreatedDate]        DATETIME        DEFAULT (getdate()) NULL,
    [CreatedBy]          VARCHAR (20)    DEFAULT (suser_sname()) NULL,
    [LastUpdatedDate]    DATETIME        DEFAULT (getdate()) NULL,
    [LastUpdatedBy]      VARCHAR (20)    DEFAULT (suser_sname()) NULL,
    [AdiKey]             INT             NULL,
    [adiTableName]       VARCHAR (100)   NULL,
    [SrcFileName]        VARCHAR (100)   NULL,
    [LoadDate]           DATE            NULL,
    [DataDate]           DATE            NULL,
    [ClientKey]          INT             NULL,
    [ClientMemberKey]    VARCHAR (50)    NULL,
    [EffectiveAsOfDate]  DATE            NULL,
    [AttribNPI]          VARCHAR (10)    NULL,
    [AttribTIN]          VARCHAR (10)    NULL,
    [PrimSvcYr]          INT             NULL,
    [PrimSvcMth]         INT             NULL,
    [CntClaims]          INT             NULL,
    [TotPaidAmt]         DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [HHAPaidAmt]         DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [SNFPaidAmt]         DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [OPPaidAmt]          DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [HospicePaidAmt]     DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [IPPaidAmt]          DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PhyPaidAmt]         DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [OtherPaidAmt]       DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefCntClaims]      INT             NULL,
    [PrefTotPaidAmt]     DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefHHAPaidAmt]     DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefSNFPaidAmt]     DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefOPPaidAmt]      DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefHospicePaidAmt] DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefIPPaidAmt]      DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefPhyPaidAmt]     DECIMAL (15, 2) DEFAULT ((0)) NULL,
    [PrefOtherPaidAmt]   DECIMAL (15, 2) DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([FctTMEKey] ASC)
);
