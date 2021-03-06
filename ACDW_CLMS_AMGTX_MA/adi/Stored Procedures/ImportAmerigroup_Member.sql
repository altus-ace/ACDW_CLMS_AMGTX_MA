
-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert Cigna MA AWV to DB
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_Member]
    @OriginalFileName  varchar(100)  ,
	@SrcFileName  varchar(100)  ,
	@LoadDate varchar(10) ,
	--@CreatedDate  
	@DataDate varchar(10) ,  
	@FileDate varchar(10) , 
	@CreatedBy  varchar(50)  ,
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy  varchar(50)  ,
	@MasterConsumerID  bigint  ,
	@MemberCode  varchar(3) ,
	@HealthCardIdentifier  varchar(50) ,
	@DateofBirth  varchar(10)  ,
	@Gender varchar(10)  ,
	@FirstName  varchar(50) ,
	@LastName  varchar(50) ,
	@PCPAssignmentMethodCode  varchar(3) ,
	@BusinessUnit  varchar(150) ,
	@MemberAddress  varchar(200) ,
	@MemberCity  varchar(50) ,
	@MemberState  varchar(50) ,
	@MemberZip  varchar(10) ,
	@PrimaryLanguage  varchar(500) ,
	@GroupNumber  varchar(20) ,
	@GroupName  varchar(100) ,
	@SubgroupNum  varchar(32) ,
	@SubgroupName  varchar(100) ,
	@BNFTPKGID  varchar(25) ,
	@Responsible_Tax_ID_Could_Contain_SSN  varchar(15) ,
	@EffectiveDate varchar(10) ,
	@TerminationDate  varchar(10) ,
	@MemberPhone  varchar(10) ,
	@BNFTPKGName  varchar(200) ,
	@MemberKey  varchar(32) ,
	@AlphaPrefixID  varchar(3) ,
	@FundingChartfieldCode  varchar(3) ,
	@Responsible_NPI  varchar(15) ,
	@EnterpriseMembercode  varchar(3) ,
	@MemberSequenceNumber  varchar(15) ,
	@ChronicCareFlag  varchar(10) ,
	@PLN_ST_CD  varchar(3) ,
	@HOST_IND_CD  varchar(1) ,
	@JAA_IND_CD  varchar(3) ,
	@INSERT_UPDATE_IND  varchar(1) ,
	@ATRBN_TRMNTN_RSN_CD  varchar(10) ,
	@REDACT_FLAG  varchar(1) ,
	@Contract_Type  varchar(5) ,
	@PROD_SOR_CD  varchar(10) ,
	@PG_ID  varchar(32) ,
	@PG_NAME  varchar(100) ,
	@PGM_ID  varchar(32) ,
	@Panel_ID  varchar(32) ,
	@PLAN_DESC  varchar(80) ,
	@Medicaid_could_contain_ssn  varchar(20) ,
	@HICN_could_contain_ssn  varchar(20) ,
	@Ethnicity  varchar(7) ,
	@WrittenLanguage  varchar(500) ,
	@MemberCounty  varchar(25) ,
	@LOB  varchar(100) 
	
            
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

    INSERT INTO [adi].[Amerigroup_Member]
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
      ,[MasterConsumerID]
      ,[MemberCode]
      ,[HealthCardIdentifier]
      ,[DateofBirth]
	  ,[Gender]
      ,[FirstName]
      ,[LastName]
      ,[PCPAssignmentMethodCode]
      ,[BusinessUnit]
      ,[MemberAddress]
      ,[MemberCity]
      ,[MemberState]
      ,[MemberZip]
      ,[PrimaryLanguage]
      ,[GroupNumber]
      ,[GroupName]
      ,[SubgroupNum]
      ,[SubgroupName]
      ,[BNFTPKGID]
      ,[Responsible_Tax_ID_Could_Contain_SSN]
      ,[EffectiveDate]
      ,[TerminationDate]
      ,[MemberPhone]
      ,[BNFTPKGName]
      ,[MemberKey]
      ,[AlphaPrefixID]
      ,[FundingChartfieldCode]
      ,[Responsible_NPI]
      ,[EnterpriseMembercode]
      ,[MemberSequenceNumber]
      ,[ChronicCareFlag]
      ,[PLN_ST_CD]
      ,[HOST_IND_CD]
      ,[JAA_IND_CD]
      ,[INSERT_UPDATE_IND]
      ,[ATRBN_TRMNTN_RSN_CD]
      ,[REDACT_FLAG]
      ,[Contract_Type]
      ,[PROD_SOR_CD]
      ,[PG_ID]
      ,[PG_NAME]
      ,[PGM_ID]
      ,[Panel_ID]
      ,[PLAN_DESC]
      ,[Medicaid_could_contain_ssn]
      ,[HICN_could_contain_ssn]
      ,[Ethnicity]
      ,[WrittenLanguage]
      ,[MemberCounty]
      ,[LOB]	
	  ,[RowStatus]
	)
		
 VALUES  (
  @OriginalFileName    ,
	@SrcFileName    ,
	GETDATE() ,
	GETDATE(),
	--@CreatedDate  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
	--@DataDate  ,  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
--	@FileDate  , 
	@CreatedBy   ,
	GETDATE(),
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy    ,
	@MasterConsumerID   ,
	@MemberCode   ,
	@HealthCardIdentifier   ,
	@DateofBirth    ,
	@Gender,
	@FirstName  ,
	@LastName  ,
	@PCPAssignmentMethodCode  ,
	@BusinessUnit   ,
	@MemberAddress   ,
	@MemberCity   ,
	@MemberState   ,
	@MemberZip   ,
	@PrimaryLanguage   ,
	@GroupNumber   ,
	@GroupName   ,
	@SubgroupNum   ,
	@SubgroupName   ,
	@BNFTPKGID   ,
	@Responsible_Tax_ID_Could_Contain_SSN   ,
	@EffectiveDate  ,
	@TerminationDate   ,
	@MemberPhone   ,
	@BNFTPKGName   ,
	@MemberKey   ,
	@AlphaPrefixID  ,
	@FundingChartfieldCode   ,
	@Responsible_NPI  ,
	@EnterpriseMembercode   ,
	@MemberSequenceNumber   ,
	@ChronicCareFlag   ,
	@PLN_ST_CD   ,
	@HOST_IND_CD   ,
	@JAA_IND_CD  ,
	@INSERT_UPDATE_IND   ,
	@ATRBN_TRMNTN_RSN_CD   ,
	@REDACT_FLAG   ,
	@Contract_Type   ,
	@PROD_SOR_CD   ,
	@PG_ID   ,
	@PG_NAME   ,
	@PGM_ID   ,
	@Panel_ID   ,
	@PLAN_DESC   ,
	@Medicaid_could_contain_ssn   ,
	@HICN_could_contain_ssn   ,
	@Ethnicity   ,
	@WrittenLanguage   ,
	@MemberCounty   ,
	@LOB  ,         
    0

)

END




