CREATE TABLE [lst].[lstAddressType] (
    [CreatedDate]       DATETIME     DEFAULT (getdate()) NOT NULL,
    [CreatedBy]         VARCHAR (50) DEFAULT (suser_sname()) NOT NULL,
    [LastUpdated]       DATETIME     DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]     VARCHAR (50) DEFAULT (suser_sname()) NOT NULL,
    [SrcFileName]       VARCHAR (50) NULL,
    [LoadDate]          DATE         NULL,
    [DataDate]          DATE         NULL,
    [lstAddressTypeKey] INT          IDENTITY (1, 1) NOT NULL,
    [AddressTypeName]   VARCHAR (20) NULL,
    [AddressTypeCode]   VARCHAR (10) NULL,
    [ACTIVE]            CHAR (1)     DEFAULT ('Y') NULL,
    [EffectiveDate]     DATE         DEFAULT (getdate()) NULL,
    [ExpirationDate]    DATE         DEFAULT ('2099-12-31') NULL,
    PRIMARY KEY CLUSTERED ([lstAddressTypeKey] ASC)
);

