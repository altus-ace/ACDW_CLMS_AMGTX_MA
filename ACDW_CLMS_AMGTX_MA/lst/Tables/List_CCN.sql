CREATE TABLE [lst].[List_CCN] (
    [CreatedDate]                    DATETIME        DEFAULT (getdate()) NULL,
    [CreatedBy]                      VARCHAR (20)    DEFAULT (suser_sname()) NULL,
    [LastUpdated]                    DATETIME        DEFAULT (getdate()) NULL,
    [LastUpdatedBy]                  VARCHAR (20)    DEFAULT (suser_sname()) NULL,
    [SrcFileName]                    VARCHAR (50)    NULL,
    [ACTIVE]                         CHAR (1)        NULL,
    [EffectiveDate]                  DATE            NOT NULL,
    [ExpirationDate]                 DATE            NOT NULL,
    [lstCNNKey]                      INT             IDENTITY (1, 1) NOT NULL,
    [PRVDR_CTGRY_SBTYP_CD]           VARCHAR (10)    NULL,
    [PRVDR_CTGRY_CD]                 VARCHAR (10)    NULL,
    [CHOW_CNT]                       INT             NULL,
    [CHOW_DT]                        DATE            NULL,
    [CITY_NAME]                      VARCHAR (50)    NULL,
    [ACPTBL_POC_SW]                  VARCHAR (50)    NULL,
    [CMPLNC_STUS_CD]                 VARCHAR (10)    NULL,
    [SSA_CNTY_CD]                    VARCHAR (10)    NULL,
    [CROSS_REF_PROVIDER_NUMBER]      VARCHAR (20)    NULL,
    [CRTFCTN_DT]                     DATE            NULL,
    [ELGBLTY_SW]                     VARCHAR (20)    NULL,
    [FAC_NAME]                       VARCHAR (100)   NULL,
    [INTRMDRY_CARR_CD]               VARCHAR (10)    NULL,
    [MDCD_VNDR_NUM]                  VARCHAR (10)    NULL,
    [ORGNL_PRTCPTN_DT]               DATE            NULL,
    [CHOW_PRIOR_DT]                  DATE            NULL,
    [INTRMDRY_CARR_PRIOR_CD]         VARCHAR (10)    NULL,
    [PRVDR_NUM]                      VARCHAR (10)    NULL,
    [RGN_CD]                         VARCHAR (10)    NULL,
    [SKLTN_REC_SW]                   VARCHAR (10)    NULL,
    [STATE_CD]                       VARCHAR (10)    NULL,
    [SSA_STATE_CD]                   VARCHAR (10)    NULL,
    [STATE_RGN_CD]                   VARCHAR (10)    NULL,
    [ST_ADR]                         VARCHAR (50)    NULL,
    [PHNE_NUM]                       VARCHAR (10)    NULL,
    [PGM_TRMNTN_CD]                  VARCHAR (10)    NULL,
    [TRMNTN_EXPRTN_DT]               DATE            NULL,
    [CRTFCTN_ACTN_TYPE_CD]           VARCHAR (10)    NULL,
    [GNRL_CNTL_TYPE_CD]              VARCHAR (10)    NULL,
    [ZIP_CD]                         VARCHAR (10)    NULL,
    [FIPS_STATE_CD]                  VARCHAR (10)    NULL,
    [FIPS_CNTY_CD]                   VARCHAR (10)    NULL,
    [CBSA_URBN_RRL_IND]              VARCHAR (10)    NULL,
    [CBSA_CD]                        VARCHAR (10)    NULL,
    [ACRDTN_EFCTV_DT]                DATE            NULL,
    [ACRDTN_EXPRTN_DT]               DATE            NULL,
    [ACRDTN_TYPE_CD]                 VARCHAR (10)    NULL,
    [TOT_AFLTD_AMBLNC_SRVC_CNT]      INT             NULL,
    [TOT_AFLTD_ASC_CNT]              INT             NULL,
    [TOT_COLCTD_HOSP_CNT]            INT             NULL,
    [TOT_AFLTD_ESRD_CNT]             INT             NULL,
    [TOT_AFLTD_FQHC_CNT]             INT             NULL,
    [TOT_AFLTD_HHA_CNT]              INT             NULL,
    [TOT_AFLTD_HOSPC_CNT]            INT             NULL,
    [TOT_AFLTD_OPO_CNT]              INT             NULL,
    [TOT_AFLTD_PRTF_CNT]             INT             NULL,
    [TOT_AFLTD_RHC_CNT]              INT             NULL,
    [TOT_AFLTD_SNF_CNT]              INT             NULL,
    [AFLTD_PRVDR_CNT]                INT             NULL,
    [RSDNT_PGM_ALPTHC_SW]            VARCHAR (10)    NULL,
    [RSDNT_PGM_DNTL_SW]              VARCHAR (10)    NULL,
    [RSDNT_PGM_OSTPTHC_SW]           VARCHAR (10)    NULL,
    [RSDNT_PGM_OTHR_SW]              VARCHAR (10)    NULL,
    [RSDNT_PGM_PDTRC_SW]             VARCHAR (10)    NULL,
    [LAB_SRVC_CD]                    VARCHAR (10)    NULL,
    [PHRMCY_SRVC_CD]                 VARCHAR (10)    NULL,
    [RDLGY_SRVC_CD]                  VARCHAR (10)    NULL,
    [ASC_BGN_SRVC_DT]                DATE            NULL,
    [FREESTNDNG_ASC_SW]              VARCHAR (10)    NULL,
    [OVRRD_BED_CNT_SW]               VARCHAR (10)    NULL,
    [CRTFD_BED_CNT]                  INT             NULL,
    [ICFIID_BED_CNT]                 INT             NULL,
    [MDCD_NF_BED_CNT]                INT             NULL,
    [MDCR_SNF_BED_CNT]               INT             NULL,
    [MDCR_MDCD_SNF_BED_CNT]          INT             NULL,
    [AIDS_BED_CNT]                   INT             NULL,
    [ALZHMR_BED_CNT]                 INT             NULL,
    [DLYS_BED_CNT]                   INT             NULL,
    [DSBL_CHLDRN_BED_CNT]            INT             NULL,
    [HEAD_TRMA_BED_CNT]              INT             NULL,
    [HOSPC_BED_CNT]                  INT             NULL,
    [HNTGTN_DEASE_BED_CNT]           INT             NULL,
    [REHAB_BED_CNT]                  INT             NULL,
    [VNTLTR_BED_CNT]                 INT             NULL,
    [BED_CNT]                        INT             NULL,
    [BRNCH_CNT]                      INT             NULL,
    [BRNCH_OPRTN_SW]                 VARCHAR (10)    NULL,
    [CAH_PSYCH_DPU_SW]               VARCHAR (10)    NULL,
    [CAH_REHAB_DPU_SW]               VARCHAR (10)    NULL,
    [CAH_SB_SW]                      VARCHAR (10)    NULL,
    [CRDC_CTHRTZTN_PRCDR_ROOMS_CNT]  INT             NULL,
    [GNRL_FAC_TYPE_CD]               VARCHAR (10)    NULL,
    [CHOW_SW]                        VARCHAR (10)    NULL,
    [CLIA_ID_NUMBER_1]               VARCHAR (20)    NULL,
    [CLIA_ID_NUMBER_2]               VARCHAR (20)    NULL,
    [CLIA_ID_NUMBER_3]               VARCHAR (20)    NULL,
    [CLIA_ID_NUMBER_4]               VARCHAR (20)    NULL,
    [CLIA_ID_NUMBER_5]               VARCHAR (20)    NULL,
    [COLCTN_STUS_SW]                 VARCHAR (10)    NULL,
    [RN_24_HR_WVR_SW]                VARCHAR (10)    NULL,
    [RN_7_DAY_WVR_SW]                VARCHAR (10)    NULL,
    [BED_PER_ROOM_WVR_SW]            VARCHAR (20)    NULL,
    [LSC_WVR_SW]                     VARCHAR (20)    NULL,
    [ROOM_SIZE_WVR_SW]               VARCHAR (20)    NULL,
    [ENDSCPY_PRCDR_ROOMS_CNT]        INT             NULL,
    [ESRD_NTWRK_NUM]                 VARCHAR (20)    NULL,
    [EXPRMT_RSRCH_CNDCTD_SW]         VARCHAR (20)    NULL,
    [FAX_PHNE_NUM]                   VARCHAR (20)    NULL,
    [FY_END_MO_DAY_CD]               VARCHAR (10)    NULL,
    [FQHC_APPROVED_RHC_PROVIDER_NUM] VARCHAR (20)    NULL,
    [FED_FUNDD_FQHC_SW]              VARCHAR (20)    NULL,
    [HHA_QLFYD_OPT_SPCH_SW]          VARCHAR (20)    NULL,
    [HH_AIDE_TRNG_PGM_CD]            VARCHAR (10)    NULL,
    [HOME_TRNG_SPRT_ONLY_SRVC_SW]    VARCHAR (20)    NULL,
    [MDCR_HOSPC_SW]                  VARCHAR (20)    NULL,
    [HOSP_BSD_SW]                    VARCHAR (20)    NULL,
    [INCNTR_NCTRNL_SRVC_SW]          VARCHAR (20)    NULL,
    [LTC_CROSS_REF_PROVIDER_NUMBER]  VARCHAR (20)    NULL,
    [MDCL_SCHL_AFLTN_CD]             VARCHAR (10)    NULL,
    [MEDICARE_HOSPICE_PROVIDER_NUM]  VARCHAR (20)    NULL,
    [MDCD_MDCR_PRTCPTG_PRVDR_SW]     VARCHAR (20)    NULL,
    [MEDICARE_MEDICAID_PRVDR_NUMBER] VARCHAR (20)    NULL,
    [MLT_FAC_ORG_NAME]               VARCHAR (20)    NULL,
    [MLT_OWND_FAC_ORG_SW]            VARCHAR (20)    NULL,
    [NCRY_PRVDR_DSGNTD_DT]           DATE            NULL,
    [NCRY_PRVDR_DSGNTD_AS_SW]        VARCHAR (20)    NULL,
    [NCRY_PRVDR_LOST_DT]             DATE            NULL,
    [MEET_1861_SW]                   VARCHAR (20)    NULL,
    [NPP_TYPE_CD]                    VARCHAR (10)    NULL,
    [TOT_OFSITE_CNCR_HOSP_CNT]       INT             NULL,
    [TOT_OFSITE_CHLDRN_HOSP_CNT]     INT             NULL,
    [TOT_OFSITE_EMER_DEPT_CNT]       INT             NULL,
    [TOT_OFSITE_INPTNT_LCTN_CNT]     INT             NULL,
    [TOT_OFSITE_LTC_HOSP_CNT]        INT             NULL,
    [TOT_OFSITE_OPTHLMC_SRGRY_CNT]   INT             NULL,
    [TOT_OFSITE_OTHR_LCTN_CNT]       INT             NULL,
    [TOT_OFSITE_PSYCH_HOSP_CNT]      INT             NULL,
    [TOT_OFSITE_PSYCH_UNIT_CNT]      INT             NULL,
    [TOT_OFSITE_REHAB_HOSP_CNT]      INT             NULL,
    [TOT_OFSITE_REHAB_UNIT_CNT]      INT             NULL,
    [TOT_OFSITE_URGNT_CARE_CNTR_CNT] INT             NULL,
    [OFSITE_LCTN_CNT]                INT             NULL,
    [OPRTG_ROOM_CNT]                 INT             NULL,
    [ORGNZ_FMLY_MBR_GRP_SW]          VARCHAR (20)    NULL,
    [ORGNZ_RSDNT_GRP_SW]             VARCHAR (20)    NULL,
    [PARENT_PROVIDER_NUMBER]         VARCHAR (20)    NULL,
    [FQHC_APRVD_RHC_SW]              VARCHAR (20)    NULL,
    [MDCR_PRTCPTN_OP_PT_SPCH_SW]     VARCHAR (20)    NULL,
    [PGM_PRTCPTN_CD]                 VARCHAR (10)    NULL,
    [PRVDR_BSD_FAC_SW]               VARCHAR (20)    NULL,
    [PRVNC_CD]                       VARCHAR (10)    NULL,
    [PSYCH_UNIT_BED_CNT]             INT             NULL,
    [PSYCH_UNIT_EFCTV_DT]            DATE            NULL,
    [PSYCH_UNIT_SW]                  VARCHAR (20)    NULL,
    [PSYCH_UNIT_TRMNTN_CD]           VARCHAR (10)    NULL,
    [PSYCH_UNIT_TRMNTN_DT]           DATE            NULL,
    [REHAB_UNIT_BED_CNT]             INT             NULL,
    [REHAB_UNIT_EFCTV_DT]            DATE            NULL,
    [REHAB_UNIT_SW]                  VARCHAR (20)    NULL,
    [REHAB_UNIT_TRMNTN_CD]           VARCHAR (10)    NULL,
    [REHAB_UNIT_TRMNTN_DT]           DATE            NULL,
    [RELATED_PROVIDER_NUMBER]        VARCHAR (10)    NULL,
    [ACUTE_RNL_DLYS_SRVC_CD]         VARCHAR (10)    NULL,
    [PSYCH_SRVC_CD]                  VARCHAR (10)    NULL,
    [HH_AIDE_SRVC_CD]                VARCHAR (10)    NULL,
    [ALCHL_DRUG_SRVC_CD]             VARCHAR (10)    NULL,
    [ANSTHSA_SRVC_CD]                VARCHAR (10)    NULL,
    [APLNC_EQUIP_SRVC_CD]            VARCHAR (10)    NULL,
    [AUDLGY_SRVC_CD]                 VARCHAR (10)    NULL,
    [BLOOD_SRVC_OFSITE_RSDNT_SW]     VARCHAR (10)    NULL,
    [BLOOD_SRVC_ONST_NRSDNT_SW]      VARCHAR (10)    NULL,
    [BLOOD_SRVC_ONST_RSDNT_SW]       VARCHAR (10)    NULL,
    [BURN_CARE_UNIT_SRVC_CD]         VARCHAR (10)    NULL,
    [CRDC_CTHRTZTN_LAB_SRVC_CD]      VARCHAR (10)    NULL,
    [OPEN_HRT_SRGRY_SRVC_CD]         VARCHAR (10)    NULL,
    [CARF_IP_REHAB_SRVC_CD]          VARCHAR (10)    NULL,
    [CHMTHRPY_SRVC_CD]               VARCHAR (10)    NULL,
    [CHRPRCTIC_SRVC_CD]              VARCHAR (10)    NULL,
    [CL_SRVC_OFSITE_RSDNT_SW]        VARCHAR (20)    NULL,
    [CL_SRVC_ONST_NRSDNT_SW]         VARCHAR (20)    NULL,
    [CL_SRVC_ONST_RSDNT_SW]          VARCHAR (20)    NULL,
    [CL_SRVC_CD]                     VARCHAR (10)    NULL,
    [CRNRY_CARE_UNIT_SRVC_CD]        VARCHAR (10)    NULL,
    [CNSLNG_SRVC_CD]                 VARCHAR (10)    NULL,
    [CT_SCAN_SRVC_CD]                VARCHAR (10)    NULL,
    [DNTL_SRVC_CD]                   VARCHAR (10)    NULL,
    [DNTL_SRVC_OFSITE_RSDNT_SW]      VARCHAR (20)    NULL,
    [DNTL_SRVC_ONST_NRSDNT_SW]       VARCHAR (20)    NULL,
    [DNTL_SRVC_ONST_RSDNT_SW]        VARCHAR (20)    NULL,
    [SHCK_TRMA_SRVC_CD]              VARCHAR (10)    NULL,
    [DGNSTC_RDLGY_SRVC_CD]           VARCHAR (10)    NULL,
    [DTRY_SRVC_CD]                   VARCHAR (10)    NULL,
    [DTRY_OFSITE_RSDNT_SW]           VARCHAR (20)    NULL,
    [DTRY_ONST_NRSDNT_SW]            VARCHAR (20)    NULL,
    [DTRY_ONST_RSDNT_SW]             VARCHAR (20)    NULL,
    [DCTD_ER_SRVC_CD]                VARCHAR (10)    NULL,
    [EMER_PSYCH_SRVC_CD]             VARCHAR (10)    NULL,
    [XTRCRPRL_SHCK_LTHTRPTR_SRVC_CD] VARCHAR (10)    NULL,
    [FRNSC_PSYCH_SRVC_CD]            VARCHAR (10)    NULL,
    [GRTRC_PSYCH_SRVC_CD]            VARCHAR (10)    NULL,
    [GRNTLGCL_SPCLTY_SRVC_CD]        VARCHAR (10)    NULL,
    [SP_HOME_TRNG_SPRT_HD_SW]        VARCHAR (20)    NULL,
    [HMDLYS_SRVC_SW]                 VARCHAR (20)    NULL,
    [HMMKR_SRVC_CD]                  VARCHAR (10)    NULL,
    [HSEKPNG_SRVC_OFSITE_RSDNT_SW]   VARCHAR (20)    NULL,
    [HSEKPNG_SRVC_ONST_NRSDNT_SW]    VARCHAR (20)    NULL,
    [HSEKPNG_SRVC_ONST_RSDNT_SW]     VARCHAR (20)    NULL,
    [IP_SRGCL_SRVC_CD]               VARCHAR (10)    NULL,
    [INTRN_RSDNT_SRVC_CD]            VARCHAR (10)    NULL,
    [MDCL_SCL_SRVC_CD]               VARCHAR (10)    NULL,
    [MDCL_SUPLY_SRVC_CD]             VARCHAR (10)    NULL,
    [ICU_SRVC_CD]                    VARCHAR (10)    NULL,
    [MDCR_TRNSPLNT_CNTR_SRVC_CD]     VARCHAR (10)    NULL,
    [MENTL_HLTH_OFSITE_RSDNT_SW]     VARCHAR (20)    NULL,
    [MENTL_HLTH_ONST_NRSDNT_SW]      VARCHAR (20)    NULL,
    [MENTL_HLTH_ONST_RSDNT_SW]       VARCHAR (10)    NULL,
    [MGNTC_RSNC_IMG_SRVC_CD]         VARCHAR (10)    NULL,
    [NEONTL_ICU_SRVC_CD]             VARCHAR (10)    NULL,
    [NEONTL_NRSRY_SRVC_CD]           VARCHAR (10)    NULL,
    [NRSRGCL_SRVC_CD]                VARCHAR (10)    NULL,
    [ORGN_TRNSPLNT_SRVC_CD]          VARCHAR (10)    NULL,
    [NUCLR_MDCN_SRVC_CD]             VARCHAR (10)    NULL,
    [NRSNG_SRVC_EMPLEE_SW]           VARCHAR (20)    NULL,
    [NRSNG_SRVC_CNTRCTR_SW]          VARCHAR (20)    NULL,
    [NRSNG_SRVC_ARNGMT_SW]           VARCHAR (20)    NULL,
    [NRSNG_SRVC_CD]                  VARCHAR (10)    NULL,
    [NRSNG_SRVC_OFSITE_RSDNT_SW]     VARCHAR (20)    NULL,
    [NRSNG_SRVC_ONST_NRSDNT_SW]      VARCHAR (20)    NULL,
    [NRSNG_SRVC_ONST_RSDNT_SW]       VARCHAR (20)    NULL,
    [NTRTNL_GDNC_SRVC_CD]            VARCHAR (10)    NULL,
    [OB_SRVC_CD]                     VARCHAR (10)    NULL,
    [OPTHLMC_SRGY_SRVC_CD]           VARCHAR (10)    NULL,
    [OPTMTRC_SRVC_CD]                VARCHAR (10)    NULL,
    [OPRTG_ROOM_SRVC_CD]             VARCHAR (10)    NULL,
    [ORTHPDC_SRGY_SRVC_CD]           VARCHAR (10)    NULL,
    [ORTHTC_PRSTHTC_EMPLEE_SW]       VARCHAR (20)    NULL,
    [ORTHTC_PRSTHTC_CNTRCTR_SW]      VARCHAR (20)    NULL,
    [ORTHTC_PRSTHTC_ARNGMT_SW]       VARCHAR (20)    NULL,
    [OT_EMPLEE_SW]                   VARCHAR (20)    NULL,
    [OT_CNTRCTR_SW]                  VARCHAR (20)    NULL,
    [OT_ARNGMT_SW]                   VARCHAR (20)    NULL,
    [OT_SRVC_CD]                     VARCHAR (10)    NULL,
    [OT_SRVC_OFSITE_RSDNT_SW]        VARCHAR (20)    NULL,
    [OT_SRVC_ONST_NRSDNT_SW]         VARCHAR (20)    NULL,
    [OT_SRVC_ONST_RSDNT_SW]          VARCHAR (20)    NULL,
    [OTHR_SRVC_CD]                   VARCHAR (10)    NULL,
    [OP_SRVC_CD]                     VARCHAR (10)    NULL,
    [OP_PSYCH_SRVC_CD]               VARCHAR (10)    NULL,
    [OP_REHAB_SRVC_CD]               VARCHAR (10)    NULL,
    [OP_SRGRY_UNIT_SRVC_CD]          VARCHAR (10)    NULL,
    [PED_SRVC_CD]                    VARCHAR (10)    NULL,
    [PED_ICU_SRVC_CD]                VARCHAR (10)    NULL,
    [SP_HOME_TRNG_SPRT_PD_SW]        VARCHAR (20)    NULL,
    [PRTNL_DLYS_SRVC_SW]             VARCHAR (20)    NULL,
    [PET_SCAN_SRVC_CD]               VARCHAR (20)    NULL,
    [PHRMCY_SRVC_OFSITE_RSDNT_SW]    VARCHAR (20)    NULL,
    [PHRMCY_SRVC_ONST_NRSDNT_SW]     VARCHAR (20)    NULL,
    [PHRMCY_SRVC_ONST_RSDNT_SW]      VARCHAR (20)    NULL,
    [PHYSN_EMPLEE_SW]                VARCHAR (20)    NULL,
    [PHYSN_CNTRCTR_SW]               VARCHAR (20)    NULL,
    [PHYSN_ARNGMT_SW]                VARCHAR (20)    NULL,
    [PHYSN_SRVC_CD]                  VARCHAR (20)    NULL,
    [PHYSN_EXT_SRVC_OFSITE_RSDNT_SW] VARCHAR (20)    NULL,
    [PHYSN_EXT_SRVC_ONST_NRSDNT_SW]  VARCHAR (20)    NULL,
    [PHYSN_EXT_SRVC_ONST_RSDNT_SW]   VARCHAR (20)    NULL,
    [PHYSN_SRVC_OFSITE_RSDNT_SW]     VARCHAR (20)    NULL,
    [PHYSN_SRVC_ONST_NRSDNT_SW]      VARCHAR (20)    NULL,
    [PHYSN_SRVC_ONST_RSDNT_SW]       VARCHAR (20)    NULL,
    [PDTRY_SRVC_OFSITE_RSDNT_SW]     VARCHAR (20)    NULL,
    [PDTRY_SRVC_ONST_NRSDNT_SW]      VARCHAR (20)    NULL,
    [PDTRY_SRVC_ONST_RSDNT_SW]       VARCHAR (20)    NULL,
    [PSTOPRTV_RCVRY_SRVC_CD]         VARCHAR (10)    NULL,
    [CHLD_ADLSCNT_PSYCH_SRVC_CD]     VARCHAR (10)    NULL,
    [PSYCHLGCL_EMPLEE_SW]            VARCHAR (20)    NULL,
    [PSYCHLGCL_CNTRCTR_SW]           VARCHAR (20)    NULL,
    [PSYCHLGCL_ARNGMT_SW]            VARCHAR (20)    NULL,
    [PT_EMPLEE_SW]                   VARCHAR (20)    NULL,
    [PT_CNTRCTR_SW]                  VARCHAR (20)    NULL,
    [PT_ARNGMT_SW]                   VARCHAR (20)    NULL,
    [PT_SRVC_CD]                     VARCHAR (10)    NULL,
    [PT_OFSITE_RSDNT_SW]             VARCHAR (20)    NULL,
    [PT_ONST_NRSDNT_SW]              VARCHAR (20)    NULL,
    [PT_ONST_RSDNT_SW]               VARCHAR (20)    NULL,
    [RCNSTRCTN_SRGY_SRVC_CD]         VARCHAR (10)    NULL,
    [RSPRTRY_CARE_EMPLEE_SW]         VARCHAR (20)    NULL,
    [RSPRTRY_CARE_CNTRCTR_SW]        VARCHAR (20)    NULL,
    [RSPRTRY_CARE_ARNGMT_SW]         VARCHAR (20)    NULL,
    [RSPRTRY_CARE_SRVC_CD]           VARCHAR (10)    NULL,
    [SHRT_TERM_IP_SRVC_CD]           VARCHAR (10)    NULL,
    [SCL_EMPLEE_SW]                  VARCHAR (20)    NULL,
    [SCL_CNTRCTR_SW]                 VARCHAR (20)    NULL,
    [SCL_ARNGMT_SW]                  VARCHAR (20)    NULL,
    [SCL_SRVC_CD]                    VARCHAR (10)    NULL,
    [SCL_WORK_SRVC_OFSITE_RSDNT_SW]  VARCHAR (20)    NULL,
    [SCL_WORK_SRVC_ONST_NRSDNT_SW]   VARCHAR (20)    NULL,
    [SCL_WORK_SRVC_ONST_RSDNT_SW]    VARCHAR (20)    NULL,
    [SPCH_PTHLGY_EMPLEE_SW]          VARCHAR (20)    NULL,
    [SPCH_PTHLGY_CNTRCTR_SW]         VARCHAR (20)    NULL,
    [SPCH_PTHLGY_ARNGMT_SW]          VARCHAR (20)    NULL,
    [SPCH_PTHLGY_SRVC_CD]            VARCHAR (10)    NULL,
    [SPCH_PTHLGY_OFSITE_RSDNT_SW]    VARCHAR (20)    NULL,
    [SPCH_PTHLGY_ONST_NRSDNT_SW]     VARCHAR (20)    NULL,
    [SPCH_PTHLGY_ONST_RSDNT_SW]      VARCHAR (20)    NULL,
    [SPCH_THRPY_SRVC_CD]             VARCHAR (10)    NULL,
    [SRGCL_ICU_SRVC_CD]              VARCHAR (10)    NULL,
    [ACTVTY_OTHR_OFSITE_RSDNT_SW]    VARCHAR (20)    NULL,
    [ACTVTY_OTHR_ONST_NRSDNT_SW]     VARCHAR (20)    NULL,
    [ACTVTY_OTHR_ONST_RSDNT_SW]      VARCHAR (20)    NULL,
    [SCL_SRVC_OTHR_OFSITE_RSDNT_SW]  VARCHAR (20)    NULL,
    [SCL_SRVC_OTHR_ONST_NRSDNT_SW]   VARCHAR (20)    NULL,
    [SCL_SRVC_OTHR_ONST_RSDNT_SW]    VARCHAR (20)    NULL,
    [ACTVTY_OFSITE_RSDNT_SW]         VARCHAR (20)    NULL,
    [ACTVTY_ONST_NRSDNT_SW]          VARCHAR (20)    NULL,
    [ACTVTY_ONST_RSDNT_SW]           VARCHAR (20)    NULL,
    [THRPTC_RDLGY_SRVC_CD]           VARCHAR (10)    NULL,
    [THRPTC_RCRTNL_OFSITE_RSDNT_SW]  VARCHAR (20)    NULL,
    [THRPTC_RCRTNL_ONST_NRSDNT_SW]   VARCHAR (20)    NULL,
    [THRPTC_RCRTNL_ONST_RSDNT_SW]    VARCHAR (20)    NULL,
    [URGNT_CARE_SRVC_CD]             VARCHAR (10)    NULL,
    [VCTNL_GDNC_SRVC_CD]             VARCHAR (10)    NULL,
    [VCTNL_SRVC_OFSITE_RSDNT_SW]     VARCHAR (20)    NULL,
    [VCTNL_SRVC_ONST_NRSDNT_SW]      VARCHAR (20)    NULL,
    [VCTNL_SRVC_ONST_RSDNT_SW]       VARCHAR (20)    NULL,
    [DGNSTC_XRAY_OFSITE_RSDNT_SW]    VARCHAR (20)    NULL,
    [DGNSTC_XRAY_ONST_NRSDNT_SW]     VARCHAR (20)    NULL,
    [DGNSTC_XRAY_ONST_RSDNT_SW]      VARCHAR (20)    NULL,
    [ACUTE_RESP_CARE_CD]             VARCHAR (10)    NULL,
    [OVRRD_STFG_SW]                  VARCHAR (20)    NULL,
    [PROFNL_ADMIN_CNTRCT_CNT]        INT             NULL,
    [PROFNL_ADMIN_FLTM_CNT]          INT             NULL,
    [PROFNL_ADMIN_PRTM_CNT]          INT             NULL,
    [HH_AIDE_EMPLEE_CNT]             INT             NULL,
    [HH_AIDE_VLNTR_CNT]              INT             NULL,
    [PRSNEL_OTHR_CNT]                DECIMAL (30, 2) NULL,
    [NRS_AIDE_CNTRCT_CNT]            INT             NULL,
    [NRS_AIDE_FLTM_CNT]              INT             NULL,
    [NRS_AIDE_PRTM_CNT]              INT             NULL,
    [CNSLR_EMPLEE_CNT]               INT             NULL,
    [CNSLR_VLNTR_CNT]                INT             NULL,
    [CRNA_CNT]                       DECIMAL (30, 2) NULL,
    [DNTST_CNTRCT_CNT]               INT             NULL,
    [DNTST_FLTM_CNT]                 INT             NULL,
    [DNTST_PRTM_CNT]                 INT             NULL,
    [DIETN_CNT]                      DECIMAL (30, 2) NULL,
    [DIETN_CNTRCT_CNT]               INT             NULL,
    [DIETN_FLTM_CNT]                 INT             NULL,
    [DIETN_PRTM_CNT]                 INT             NULL,
    [DRCT_CARE_PRSNEL_CNT]           INT             NULL,
    [FOOD_SRVC_CNTRCT_CNT]           INT             NULL,
    [FOOD_SRVC_FLTM_CNT]             INT             NULL,
    [FOOD_SRVC_PRTM_CNT]             INT             NULL,
    [HH_AIDE_CNT]                    INT             NULL,
    [HMMKR_EMPLEE_CNT]               INT             NULL,
    [HMMKR_VLNTR_CNT]                INT             NULL,
    [HSEKPNG_CNTRCT_CNT]             INT             NULL,
    [HSEKPNG_FLTM_CNT]               INT             NULL,
    [HSEKPNG_PRTM_CNT]               INT             NULL,
    [LAB_TCHNCN_CNT]                 DECIMAL (30, 2) NULL,
    [LPN_CNT]                        INT             NULL,
    [LPN_LVN_CNT]                    DECIMAL (30, 2) NULL,
    [LPN_LVN_CNTRCT_CNT]             INT             NULL,
    [LPN_LVN_FLTM_CNT]               INT             NULL,
    [LPN_LVN_PRTM_CNT]               INT             NULL,
    [LPN_LVN_VLNTR_CNT]              INT             NULL,
    [MDCL_DRCTR_CNTRCT_CNT]          INT             NULL,
    [MDCL_DRCTR_FLTM_CNT]            INT             NULL,
    [MDCL_DRCTR_PRTM_CNT]            INT             NULL,
    [MDCL_SCL_WORKR_CNT]             DECIMAL (30, 2) NULL,
    [MDCL_SCL_WORKR_VLNTR_CNT]       INT             NULL,
    [MDCL_TCHNLGST_CNT]              DECIMAL (30, 2) NULL,
    [MDCTN_AIDE_CNTRCT_CNT]          INT             NULL,
    [MDCTN_AIDE_FLTM_CNT]            INT             NULL,
    [MDCTN_AIDE_PRTM_CNT]            INT             NULL,
    [MENTL_HLTH_SRVC_CNTRCT_CNT]     INT             NULL,
    [MENTL_HLTH_SRVC_FLTM_CNT]       INT             NULL,
    [MENTL_HLTH_SRVC_PRTM_CNT]       INT             NULL,
    [NUCLR_MDCN_TCHNCN_CNT]          DECIMAL (30, 2) NULL,
    [NAT_CNTRCT_CNT]                 INT             NULL,
    [NAT_FLTM_CNT]                   INT             NULL,
    [NAT_PRTM_CNT]                   INT             NULL,
    [NRS_PRCTNR_CNT]                 DECIMAL (30, 2) NULL,
    [NRS_ADMINV_CNTRCT_CNT]          INT             NULL,
    [NRS_ADMINV_FLTM_CNT]            INT             NULL,
    [NRS_ADMINV_PRTM_CNT]            INT             NULL,
    [OCPTNL_THRPST_CNT]              DECIMAL (30, 2) NULL,
    [OCPTNL_THRPST_CNTRCT_CNT]       INT             NULL,
    [OCPTNL_THRPST_FLTM_CNT]         INT             NULL,
    [OCPTNL_THRPST_PRTM_CNT]         INT             NULL,
    [OT_AIDE_CNTRCT_CNT]             INT             NULL,
    [OT_AIDE_FLTM_CNT]               INT             NULL,
    [OT_AIDE_PRTM_CNT]               INT             NULL,
    [OT_ASTNT_CNTRCT_CNT]            INT             NULL,
    [OT_ASTNT_FLTM_CNT]              INT             NULL,
    [OT_ASTNT_PRTM_CNT]              INT             NULL,
    [VLNTR_OTHR_CNT]                 INT             NULL,
    [ACTVTY_STF_OTHR_CNTRCT_CNT]     INT             NULL,
    [ACTVTY_STF_OTHR_FLTM_CNT]       INT             NULL,
    [ACTVTY_STF_OTHR_PRTM_CNT]       INT             NULL,
    [PHYSN_OTHR_CNTRCT_CNT]          INT             NULL,
    [PHYSN_OTHR_FLTM_CNT]            INT             NULL,
    [PHYSN_OTHR_PRTM_CNT]            INT             NULL,
    [SCL_SRVC_OTHR_STF_CNTRCT_CNT]   INT             NULL,
    [SCL_SRVC_OTHR_STF_FLTM_CNT]     INT             NULL,
    [SCL_SRVC_OTHR_STF_PRTM_CNT]     INT             NULL,
    [STF_OTHR_CNTRCT_CNT]            INT             NULL,
    [STF_OTHR_FLTM_CNT]              INT             NULL,
    [STF_OTHR_PRTM_CNT]              INT             NULL,
    [PHRMCST_CNTRCT_CNT]             INT             NULL,
    [PHRMCST_FLTM_CNT]               INT             NULL,
    [PHRMCST_PRTM_CNT]               INT             NULL,
    [PHYS_THRPST_CNTRCT_CNT]         INT             NULL,
    [PHYS_THRPST_FLTM_CNT]           INT             NULL,
    [PHYS_THRPST_PRTM_CNT]           INT             NULL,
    [PHYSN_CNT]                      DECIMAL (30, 2) NULL,
    [PHYSN_VLNTR_CNT]                INT             NULL,
    [PHYSN_ASTNT_CNT]                DECIMAL (30, 2) NULL,
    [PHYSN_EXT_CNTRCT_CNT]           INT             NULL,
    [PHYSN_EXT_FLTM_CNT]             INT             NULL,
    [PHYSN_EXT_PRTM_CNT]             INT             NULL,
    [RSDNT_PHYSN_CNT]                DECIMAL (30, 2) NULL,
    [PDTRST_CNTRCT_CNT]              INT             NULL,
    [PDTRST_FLTM_CNT]                INT             NULL,
    [PDTRST_PRTM_CNT]                INT             NULL,
    [PSYCHLGST_CNT]                  DECIMAL (30, 2) NULL,
    [PHYS_THRPST_STF_CNT]            INT             NULL,
    [PHYS_THRPST_CNT]                DECIMAL (30, 2) NULL,
    [PHYS_THRPST_ARNGMT_CNT]         INT             NULL,
    [PT_AIDE_CNTRCT_CNT]             INT             NULL,
    [PT_AIDE_FLTM_CNT]               INT             NULL,
    [PT_AIDE_PRTM_CNT]               INT             NULL,
    [PT_ASTNT_CNTRCT_CNT]            INT             NULL,
    [PT_ASTNT_FLTM_CNT]              INT             NULL,
    [PT_ASTNT_PRTM_CNT]              INT             NULL,
    [ACTVTY_PROFNL_CNTRCT_CNT]       INT             NULL,
    [ACTVTY_PROFNL_FLTM_CNT]         INT             NULL,
    [ACTVTY_PROFNL_PRTM_CNT]         INT             NULL,
    [RDLGY_TCHNCN_CNT]               DECIMAL (30, 2) NULL,
    [REG_PHRMCST_CNT]                DECIMAL (30, 2) NULL,
    [INHLTN_THRPST_CNT]              DECIMAL (30, 2) NULL,
    [RN_CNT]                         DECIMAL (30, 2) NULL,
    [RN_CNTRCT_CNT]                  INT             NULL,
    [RN_FLTM_CNT]                    INT             NULL,
    [RN_PRTM_CNT]                    INT             NULL,
    [RN_VLNTR_CNT]                   INT             NULL,
    [RN_DRCTR_CNTRCT_CNT]            INT             NULL,
    [RN_DRCTR_FLTM_CNT]              INT             NULL,
    [RN_DRCTR_PRTM_CNT]              INT             NULL,
    [SCL_WORKR_CNT]                  INT             NULL,
    [SCL_WORKR_CNTRCT_CNT]           INT             NULL,
    [SCL_WORKR_FLTM_CNT]             INT             NULL,
    [SCL_WORKR_PRTM_CNT]             INT             NULL,
    [SPCH_PTHLGST_ARNGMT_CNT]        INT             NULL,
    [SPCH_PTHLGST_CNTRCT_CNT]        INT             NULL,
    [SPCH_PTHLGST_FLTM_CNT]          INT             NULL,
    [SPCH_PTHLGST_PRTM_CNT]          INT             NULL,
    [SPCH_PTHLGST_CNT]               INT             NULL,
    [SPCH_PTHLGST_AUDLGST_CNT]       DECIMAL (30, 2) NULL,
    [TCHNCL_STF_NUM]                 VARCHAR (20)    NULL,
    [TCHNCN_CNT]                     INT             NULL,
    [THRPTC_RCRTNL_CNTRCT_CNT]       INT             NULL,
    [THRPTC_RCRTNL_FLTM_CNT]         INT             NULL,
    [THRPTC_RCRTNL_PRTM_CNT]         INT             NULL,
    [EMPLEE_CNT]                     INT             NULL,
    [VLNTR_CNT]                      INT             NULL,
    [SBUNIT_CNT]                     INT             NULL,
    [SBUNIT_SW]                      VARCHAR (20)    NULL,
    [SBUNIT_OPRTN_SW]                VARCHAR (20)    NULL,
    [DNTL_SRGRY_SW]                  VARCHAR (20)    NULL,
    [OTLRYNGLGY_SRGRY_SW]            VARCHAR (20)    NULL,
    [ENDSCPY_SRGRY_SW]               VARCHAR (20)    NULL,
    [OB_GYN_SRGRY_SW]                VARCHAR (20)    NULL,
    [OPTHMLGY_SRGRY_SW]              VARCHAR (20)    NULL,
    [ORTHPDC_SRGRY_SW]               VARCHAR (20)    NULL,
    [OTHR_SRGRY_SW]                  VARCHAR (20)    NULL,
    [PAIN_SRGRY_SW]                  VARCHAR (20)    NULL,
    [PLSTC_SRGRY_SW]                 VARCHAR (20)    NULL,
    [FT_SRGRY_SW]                    VARCHAR (20)    NULL,
    [SB_SW]                          VARCHAR (20)    NULL,
    [SB_SIZE_CD]                     VARCHAR (10)    NULL,
    [TCHNLGST_2_YR_RDLGC_CNT]        INT             NULL,
    [TCHNLGST_ASCT_DGR_CNT]          INT             NULL,
    [TCHNLGST_BS_BA_DGR_CNT]         INT             NULL,
    [DLYS_STN_CNT]                   INT             NULL,
    PRIMARY KEY CLUSTERED ([lstCNNKey] ASC)
);

