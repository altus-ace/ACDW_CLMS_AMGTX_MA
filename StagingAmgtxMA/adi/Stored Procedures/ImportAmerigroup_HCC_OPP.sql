

-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert 
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_HCC_OPP]
    @OriginalFileName  varchar(100)  ,
	@SrcFileName  varchar(100)  ,
	@LoadDate varchar(10) ,
	--@CreatedDate  
	@DataDate varchar(10) ,  
	@FileDate varchar(10) , 
	@CreatedBy  varchar(50)  ,
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy  varchar(50)  ,
    @MCID_MASTER_CONSUMER_ID  bigint ,
	@PG_ID  varchar(32) ,
	@PGM_ID  varchar(32) ,
	@Panel_ID  varchar(32) ,
	@HCCChronicIndicator  varchar(5) ,
	@ModelVersion  varchar(10) ,
	@HCCNum  varchar(10) ,
	@HCCDescription  varchar(100) ,
	@ICD10Code  varchar(10) ,
	@ICD10CodeDescription  varchar(2000) ,
	@HCCStatus  varchar(10) ,
	@RiskFactorCoefficient  decimal(9, 3) ,
	@HCCPaymentYear  int 
            
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


    INSERT INTO [adi].[Amerigroup_HCC-OPP]
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
      ,[MCID_MASTER_CONSUMER_ID]
      ,[PG_ID]
      ,[PGM_ID]
      ,[Panel_ID]
      ,[HCCChronicIndicator]
      ,[ModelVersion]
      ,[HCCNum]
      ,[HCCDescription]
      ,[ICD10Code]
      ,[ICD10CodeDescription]
      ,[HCCStatus]
      ,[RiskFactorCoefficient]
      ,[HCCPaymentYear]
	)
		
 VALUES  (
   @OriginalFileName    ,
	@SrcFileName    ,
    DATEADD(mm, DATEDIFF(mm,0, GETDATE()) +1, 0),
	--@LoadDate  ,
	GETDATE(),
	--@CreatedDate  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
	--@DataDate  ,  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
--	@FileDate  , 
	@CreatedBy    ,
	GETDATE(),
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy    ,
    @MCID_MASTER_CONSUMER_ID   ,
	@PG_ID   ,
	@PGM_ID   ,
	@Panel_ID   ,
	@HCCChronicIndicator   ,
	@ModelVersion   ,
	@HCCNum   ,
	@HCCDescription   ,
	@ICD10Code   ,
	@ICD10CodeDescription   ,
	@HCCStatus   ,
	@RiskFactorCoefficient   ,
	@HCCPaymentYear    
            
)

END




