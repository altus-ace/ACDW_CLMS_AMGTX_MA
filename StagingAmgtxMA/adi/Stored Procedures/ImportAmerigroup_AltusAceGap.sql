

-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert 
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_AltusAceGap]
  	@OriginalFileName varchar(100)  ,
	@SrcFileName varchar(100)  ,
	--@LoadDate date  ,
	--@CreatedDate date  ,
	@DataDate varchar(10)  ,
	@FileDate varchar(10)  ,
	@CreatedBy varchar(50)  ,
	--@LastUpdatedDate datetime  ,
	@LastUpdatedBy varchar(50)  ,
	@PROV_TIN varchar(20) ,
	@PROV_TIN_NAME varchar(50) ,
	@MCID varchar(20) ,
	@MONTH_RUN varchar(20) ,
	@MBR_SOR_SYSTEM varchar(20) ,
	@REGION varchar(20) ,
	@PRODUCT_DESCRIPTION varchar(50) ,
	@CMS_CONTRACT varchar(20) ,
	@MEDICARE_ID varchar(20) ,
	@HCID varchar(20) ,
	@MEMLNAME varchar(20) ,
	@MEMFNAME varchar(20) ,
	@MEM_DOB varchar(10) ,
	@GENDER varchar(10) ,
	@PRODUCT_TYPE varchar(20) ,
	@MEM_ADDR1 varchar(50) ,
	@MEM_ADDR2 varchar(50) ,
	@MEM_CITY varchar(30) ,
	@MEM_STATE varchar(20) ,
	@MEM_ZIP varchar(15) ,
	@Ethnicity varchar(10) ,
	@MEM_PHONE varchar(20) ,
	@COUNTY_NAME varchar(20) ,
	@Lang_NM varchar(20) ,
	@Lang_CD varchar(20) ,
	@EMP_MASTER varchar(20) ,
	@EMP_GROUP varchar(20) ,
	@PBP_NBR varchar(20) ,
	@PROV_NPI varchar(20) ,
	@PROV_LAST_NAME varchar(20) ,
	@PROV_FIRST_NAME varchar(20) ,
	@PROV_NAME varchar(20) ,
	@PROV_PRAC_ADDR1 varchar(50) ,
	@PROV_PRAC_CITY varchar(20) ,
	@PROV_PRAC_STATE varchar(20) ,
	@PROV_PRAC_ZIP varchar(15) ,
	@PROV_PRAC_COUNTY varchar(20) ,
	@PROV_PRAC_PH1 varchar(20) ,
	@PROV_PRAC_FAX varchar(20) ,
	@PGID varchar(20) ,
	@BCS varchar(20) ,
	@BCS_ServiceDate varchar(10) ,
	@BCS_FILE_ID varchar(20) ,
	@BCS_FILE_DESC varchar(50) ,
	@CBP varchar(20) ,
	@CBP_LastServiceDate varchar(10) ,
	@CBP_HypTenDiagDate varchar(10) ,
	@CBP_HypTenDiagDate2 varchar(10) ,
	@CBP_FILE_ID varchar(20) ,
	@CBP_FILE_DESC varchar(50) ,
	@CDC_HbA1c_Test varchar(20) ,
	@CDC_HbA1c_Test_ServiceDate varchar(10) ,
	@CDC_HbA1c_Test_FILE_ID varchar(20) ,
	@CDC_HbA1c_Test_FILE_DESC varchar(50) ,
	@CDC_HbA1c_LE9 varchar(20) ,
	@CDC_HBA1C_LE9_ServiceDate varchar(10) ,
	@CDC_LastHbA1c_Value varchar(20) ,
	@CDC_HbA1c_LE9_FILE_ID varchar(20) ,
	@CDC_HbA1c_LE9_FILE_DESC varchar(50) ,
	@CDC_EyeExam varchar(20) ,
	@Eye_Exam_TestDate varchar(10) ,
	@CDC_EyeExam_FILE_ID varchar(20) ,
	@CDC_EyeExam_FILE_DESC varchar(50) ,
	@CDC_Nephro varchar(20) ,
	@Nephro_FirstAvailServDate varchar(10) ,
	@CDC_Nephro_FILE_ID varchar(20) ,
	@CDC_Nephro_FILE_DESC varchar(50) ,
	@KED varchar(20) ,
	@KED_ServiceDate varchar(10) ,
	@KED_FILE_ID varchar(20) ,
	@KED_FILE_DESC varchar(50) ,
	@COA_ACP varchar(20) ,
	@ACP_ServiceDate varchar(10) ,
	@COA_ACP_FILE_ID varchar(20) ,
	@COA_ACP_FILE_DESC varchar(50) ,
	@COA_FSA varchar(20) ,
	@FSA_ServiceDate varchar(10) ,
	@COA_FSA_FILE_ID varchar(20) ,
	@COA_FSA_FILE_DESC varchar(50) ,
	@COA_MR varchar(20) ,
	@MR_ServiceDate varchar(10) ,
	@COA_MR_FILE_ID varchar(20) ,
	@COA_MR_FILE_DESC varchar(50) ,
	@COA_PS varchar(20) ,
	@PS_ServiceDate varchar(10) ,
	@COA_PS_FILE_ID varchar(20) ,
	@COA_PS_FILE_DESC varchar(50) ,
	@COL varchar(20) ,
	@COL_Max_ServiceDate varchar(10) ,
	@COL_FILE_ID varchar(20) ,
	@COL_FILE_DESC varchar(50) ,
	@OSW varchar(20) ,
	@OSW_ServiceDate varchar(10) ,
	@OSW_FILE_ID varchar(20) ,
	@OSW_FILE_DESC varchar(50) ,
	@OMW varchar(50) ,
	@OMW_ServiceDate varchar(10) ,
	@OMW_Fracture_Date varchar(10) ,
	@OMW_FILE_ID varchar(50) ,
	@OMW_FILE_DESC varchar(50) ,
	@AOMW varchar(20) ,
	@AOMW_ServiceDate varchar(10) ,
	@AOMW_FRACTURE_DATE varchar(10) ,
	@AOMW_FILE_ID varchar(20) ,
	@AOMW_FILE_DESC varchar(50) ,
	@SPC_REC_TOTAL varchar(20) ,
	@SPC_REC_RxServiceDate varchar(10) ,
	@SPC_REC_FILE_ID varchar(20) ,
	@SPC_REC_FILE_DESC varchar(50) ,
	@FUH_Followup_30 varchar(20) ,
	@FUH_30_LastServiceDate varchar(10) ,
	@FUH_30_Last_Discharge_Date varchar(10) ,
	@FUH_30_FILE_ID varchar(20) ,
	@FUH_30_FILE_DESC varchar(50) ,
	@FUH_Followup_7 varchar(20) ,
	@FUH_7_LastServiceDate varchar(10) ,
	@FUH_7_Last_Discharge_Date varchar(10) ,
	@FUH_7_FILE_ID varchar(20) ,
	@FUH_7_FILE_DESC varchar(50) ,
	@TRC_ENGAGEMENT varchar(20) ,
	@TRC_ENG_LastServiceDate varchar(10) ,
	@TRC_Eng_Last_Discharge_Date varchar(10) ,
	@TRC_Eng_FILE_ID varchar(50) ,
	@TRC_Eng_FILE_DESC varchar(100) ,
	@TRC_RECONCILIATION varchar(50) ,
	@TRC_REC_LastServiceDate varchar(10) ,
	@TRC_Rec_Last_Discharge_Date varchar(10) ,
	@TRC_Rec_FILE_ID varchar(50) ,
	@TRC_Rec_FILE_DESC varchar(100), 
	@PROV_SPECIALTY varchar(100),
	@MBRSHP_SOR_CD varchar(10),
	@CASS_Results varchar(50),
	@Cass_Check varchar(50)

            
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @DATE VARCHAR(8) , @YEAR VARCHAR(4), @MONTH VARCHAR(2), @DAY VARCHAR(2)	
	SET @DATE =  SUBSTRING(@SrcFileName, (CHARINDEX('.',@SrcFileName)-8),8)
	SET @YEAR = SUBSTRING(@DATE, 5,4)
	SET @MONTH = SUBSTRING(@DATE, 1,2)
	SET @DAY = SUBSTRING(@DATE, 3,2)


    INSERT INTO [adi].[Amerigroup_AltusAceGap]
    (
       [OriginalFileName]
      ,[SrcFileName]
      ,[LoadDate]
      ,[CreatedDate]
      ,[DataDate]
      ,[FileDate]
      ,[CreatedBy]
      ,[LastUpdatedDate]
      ,[LastUpdatedBy]
      ,[PROV_TIN]
      ,[PROV_TIN_NAME]
      ,[MCID]
      ,[MONTH_RUN]
      ,[MBR_SOR_SYSTEM]
      ,[REGION]
      ,[PRODUCT_DESCRIPTION]
      ,[CMS_CONTRACT]
      ,[MEDICARE_ID]
      ,[HCID]
      ,[MEMLNAME]
      ,[MEMFNAME]
      ,[MEM_DOB]
      ,[GENDER]
      ,[PRODUCT_TYPE]
      ,[MEM_ADDR1]
      ,[MEM_ADDR2]
      ,[MEM_CITY]
      ,[MEM_STATE]
      ,[MEM_ZIP]
      ,[Ethnicity]
      ,[MEM_PHONE]
      ,[COUNTY_NAME]
      ,[Lang_NM]
      ,[Lang_CD]
      ,[EMP_MASTER]
      ,[EMP_GROUP]
      ,[PBP_NBR]
      ,[PROV_NPI]
      ,[PROV_LAST_NAME]
      ,[PROV_FIRST_NAME]
      ,[PROV_NAME]
      ,[PROV_PRAC_ADDR1]
      ,[PROV_PRAC_CITY]
      ,[PROV_PRAC_STATE]
      ,[PROV_PRAC_ZIP]
      ,[PROV_PRAC_COUNTY]
      ,[PROV_PRAC_PH1]
      ,[PROV_PRAC_FAX]
      ,[PGID]
      ,[BCS]
      ,[BCS_ServiceDate]
      ,[BCS_FILE_ID]
      ,[BCS_FILE_DESC]
      ,[CBP]
      ,[CBP_LastServiceDate]
      ,[CBP_HypTenDiagDate]
      ,[CBP_HypTenDiagDate2]
      ,[CBP_FILE_ID]
      ,[CBP_FILE_DESC]
      ,[CDC_HbA1c_Test]
      ,[CDC_HbA1c_Test_ServiceDate]
      ,[CDC_HbA1c_Test_FILE_ID]
      ,[CDC_HbA1c_Test_FILE_DESC]
      ,[CDC_HbA1c_LE9]
      ,[CDC_HBA1C_LE9_ServiceDate]
      ,[CDC_LastHbA1c_Value]
      ,[CDC_HbA1c_LE9_FILE_ID]
      ,[CDC_HbA1c_LE9_FILE_DESC]
      ,[CDC_EyeExam]
      ,[Eye_Exam_TestDate]
      ,[CDC_EyeExam_FILE_ID]
      ,[CDC_EyeExam_FILE_DESC]
      ,[CDC_Nephro]
      ,[Nephro_FirstAvailServDate]
      ,[CDC_Nephro_FILE_ID]
      ,[CDC_Nephro_FILE_DESC]
      ,[KED]
      ,[KED_ServiceDate]
      ,[KED_FILE_ID]
      ,[KED_FILE_DESC]
      ,[COA_ACP]
      ,[ACP_ServiceDate]
      ,[COA_ACP_FILE_ID]
      ,[COA_ACP_FILE_DESC]
      ,[COA_FSA]
      ,[FSA_ServiceDate]
      ,[COA_FSA_FILE_ID]
      ,[COA_FSA_FILE_DESC]
      ,[COA_MR]
      ,[MR_ServiceDate]
      ,[COA_MR_FILE_ID]
      ,[COA_MR_FILE_DESC]
      ,[COA_PS]
      ,[PS_ServiceDate]
      ,[COA_PS_FILE_ID]
      ,[COA_PS_FILE_DESC]
      ,[COL]
      ,[COL_Max_ServiceDate]
      ,[COL_FILE_ID]
      ,[COL_FILE_DESC]
      ,[OSW]
      ,[OSW_ServiceDate]
      ,[OSW_FILE_ID]
      ,[OSW_FILE_DESC]
      ,[OMW]
      ,[OMW_ServiceDate]
      ,[OMW_Fracture_Date]
      ,[OMW_FILE_ID]
      ,[OMW_FILE_DESC]
      ,[AOMW]
      ,[AOMW_ServiceDate]
      ,[AOMW_FRACTURE_DATE]
      ,[AOMW_FILE_ID]
      ,[AOMW_FILE_DESC]
      ,[SPC_REC_TOTAL]
      ,[SPC_REC_RxServiceDate]
      ,[SPC_REC_FILE_ID]
      ,[SPC_REC_FILE_DESC]
      ,[FUH_Followup_30]
      ,[FUH_30_LastServiceDate]
      ,[FUH_30_Last_Discharge_Date]
      ,[FUH_30_FILE_ID]
      ,[FUH_30_FILE_DESC]
      ,[FUH_Followup_7]
      ,[FUH_7_LastServiceDate]
      ,[FUH_7_Last_Discharge_Date]
      ,[FUH_7_FILE_ID]
      ,[FUH_7_FILE_DESC]
      ,[TRC_ENGAGEMENT]
      ,[TRC_ENG_LastServiceDate]
      ,[TRC_Eng_Last_Discharge_Date]
      ,[TRC_Eng_FILE_ID]
      ,[TRC_Eng_FILE_DESC]
      ,[TRC_RECONCILIATION]
      ,[TRC_REC_LastServiceDate]
      ,[TRC_Rec_Last_Discharge_Date]
      ,[TRC_Rec_FILE_ID]
      ,[TRC_Rec_FILE_DESC]
	  ,[PROV_SPECIALTY]
	  ,[MBRSHP_SOR_CD]
	  ,[CASS_Results]
	  ,[Cass_Check]
	)
		
 VALUES  (
  @OriginalFileName   ,
	@SrcFileName   ,
    DATEADD(mm, DATEDIFF(mm,0, GETDATE()) +1, 0),
	--@LoadDate date  ,
	GETDATE(),
	--@CreatedDate date  ,
	@DataDate   ,
	@FileDate   ,
	@CreatedBy   ,
	GETDATE(),
	--@LastUpdatedDate datetime  ,
	@LastUpdatedBy   ,
	@PROV_TIN  ,
	@PROV_TIN_NAME  ,
	@MCID  ,
	@MONTH_RUN  ,
	@MBR_SOR_SYSTEM  ,
	@REGION  ,
	@PRODUCT_DESCRIPTION  ,
	@CMS_CONTRACT  ,
	@MEDICARE_ID  ,
	@HCID  ,
	@MEMLNAME  ,
	@MEMFNAME  ,

	CASE WHEN @MEM_DOB  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @MEM_DOB )
	END ,
	@GENDER  ,
	@PRODUCT_TYPE  ,
	@MEM_ADDR1  ,
	@MEM_ADDR2  ,
	@MEM_CITY  ,
	@MEM_STATE  ,
	@MEM_ZIP ,
	@Ethnicity  ,
	@MEM_PHONE  ,
	@COUNTY_NAME  ,
	@Lang_NM  ,
	@Lang_CD  ,
	@EMP_MASTER  ,
	@EMP_GROUP  ,
	@PBP_NBR  ,
	@PROV_NPI  ,
	@PROV_LAST_NAME  ,
	@PROV_FIRST_NAME  ,
	@PROV_NAME  ,
	@PROV_PRAC_ADDR1  ,
	@PROV_PRAC_CITY  ,
	@PROV_PRAC_STATE  ,
	@PROV_PRAC_ZIP  ,
	@PROV_PRAC_COUNTY  ,
	@PROV_PRAC_PH1  ,
	@PROV_PRAC_FAX  ,
	@PGID  ,
	@BCS  ,
	CASE WHEN	@BCS_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @BCS_ServiceDate)
	END ,

	@BCS_FILE_ID  ,
	@BCS_FILE_DESC  ,
	@CBP  ,
	
	CASE WHEN @CBP_LastServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@CBP_LastServiceDate )
	END ,
	
	CASE WHEN @CBP_HypTenDiagDate =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @CBP_HypTenDiagDate)
	END ,
	CASE WHEN @CBP_HypTenDiagDate2  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@CBP_HypTenDiagDate2)
	END ,
	@CBP_FILE_ID  ,
	@CBP_FILE_DESC  ,
	@CDC_HbA1c_Test  ,
	CASE WHEN 	@CDC_HbA1c_Test_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,	@CDC_HbA1c_Test_ServiceDate )
	END ,

	@CDC_HbA1c_Test_FILE_ID  ,
	@CDC_HbA1c_Test_FILE_DESC  ,
	@CDC_HbA1c_LE9  ,
	CASE WHEN 	@CDC_HBA1C_LE9_ServiceDate =''
	THEN NULL
	ELSE 
	ConVERT(DATE,	@CDC_HBA1C_LE9_ServiceDate)
	END ,

	@CDC_LastHbA1c_Value  ,
	@CDC_HbA1c_LE9_FILE_ID  ,
	@CDC_HbA1c_LE9_FILE_DESC  ,
	@CDC_EyeExam  ,
	CASE WHEN @Eye_Exam_TestDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@Eye_Exam_TestDate)
	END ,
	
	@CDC_EyeExam_FILE_ID  ,
	@CDC_EyeExam_FILE_DESC  ,
	@CDC_Nephro  ,
	CASE WHEN 	@Nephro_FirstAvailServDate =''
	THEN NULL
	ELSE 
	ConVERT(DATE,	@Nephro_FirstAvailServDate )
	END ,

	@CDC_Nephro_FILE_ID  ,
	@CDC_Nephro_FILE_DESC  ,
	@KED  ,
	CASE WHEN @KED_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@KED_ServiceDate )
	END ,

	
	@KED_FILE_ID  ,
	@KED_FILE_DESC  ,
	@COA_ACP  ,
	CASE WHEN 	@ACP_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,	@ACP_ServiceDate )
	END ,

	@COA_ACP_FILE_ID  ,
	@COA_ACP_FILE_DESC  ,
	@COA_FSA  ,
	CASE WHEN @FSA_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@FSA_ServiceDate  )
	END ,

	@COA_FSA_FILE_ID  ,
	@COA_FSA_FILE_DESC  ,
	@COA_MR  ,
	@MR_ServiceDate  ,
	@COA_MR_FILE_ID  ,
	@COA_MR_FILE_DESC  ,
	@COA_PS  ,
	CASE WHEN 	@PS_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @PS_ServiceDate )
	END ,

	@COA_PS_FILE_ID  ,
	@COA_PS_FILE_DESC  ,
	@COL  ,
	CASE WHEN @COL_Max_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @COL_Max_ServiceDate)
	END ,
	
	@COL_FILE_ID  ,
	@COL_FILE_DESC  ,
	@OSW  ,
	CASE WHEN @OSW_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @OSW_ServiceDate)
	END ,
	
	@OSW_FILE_ID  ,
	@OSW_FILE_DESC  ,
	@OMW  ,
	
	CASE WHEN @OMW_ServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@OMW_ServiceDate )
	END ,
	CASE WHEN @OMW_Fracture_Date  =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@OMW_Fracture_Date)
	END ,
	@OMW_FILE_ID  ,
	@OMW_FILE_DESC  ,
	@AOMW  ,
	
	CASE WHEN @AOMW_ServiceDate =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @AOMW_ServiceDate )
	END ,
	CASE WHEN @AOMW_FRACTURE_DATE  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @AOMW_FRACTURE_DATE)
	END ,
	@AOMW_FILE_ID  ,
	@AOMW_FILE_DESC  ,
	@SPC_REC_TOTAL  ,
	CASE WHEN 	@SPC_REC_RxServiceDate =''
	THEN NULL
	ELSE 
	ConVERT(DATE,@SPC_REC_RxServiceDate)
	END ,
	@SPC_REC_FILE_ID  ,
	@SPC_REC_FILE_DESC  ,
	@FUH_Followup_30  ,
	
	CASE WHEN @FUH_30_LastServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @FUH_30_LastServiceDate)
	END ,
	CASE WHEN @FUH_30_Last_Discharge_Date  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @FUH_30_Last_Discharge_Date)
	END ,
	@FUH_30_FILE_ID  ,
	@FUH_30_FILE_DESC  ,
	@FUH_Followup_7  ,
	CASE WHEN @FUH_7_LastServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, 	@FUH_7_LastServiceDate)
	END ,
	CASE WHEN @FUH_7_Last_Discharge_Date  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @FUH_7_Last_Discharge_Date )
	END ,
	
	@FUH_7_FILE_ID  ,
	@FUH_7_FILE_DESC  ,
	@TRC_ENGAGEMENT  ,
	CASE WHEN @TRC_ENG_LastServiceDate     =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @TRC_ENG_LastServiceDate )
	END ,
	CASE WHEN @TRC_Eng_Last_Discharge_Date   =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @TRC_Eng_Last_Discharge_Date )
	END ,
	@TRC_Eng_FILE_ID  ,
	@TRC_Eng_FILE_DESC  ,
	@TRC_RECONCILIATION  ,
	CASE WHEN @TRC_REC_LastServiceDate  =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @TRC_REC_LastServiceDate )
	END ,
	CASE WHEN @TRC_Rec_Last_Discharge_Date =''
	THEN NULL
	ELSE 
	ConVERT(DATE, @TRC_Rec_Last_Discharge_Date )
	END ,
	@TRC_Rec_FILE_ID  ,
	@TRC_Rec_FILE_DESC ,
	@PROV_SPECIALTY ,
	@MBRSHP_SOR_CD ,
	@CASS_Results ,
	@Cass_Check 
)

END




