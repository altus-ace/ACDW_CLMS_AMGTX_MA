

-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert 
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_MA_WellnessVisits]
  	@OriginalFileName varchar(100)  ,
	@SrcFileName varchar(100)  ,
	--@LoadDate date  ,
	--@CreatedDate date  ,
	@DataDate varchar(10)  ,
	@FileDate varchar(10)  ,
	@CreatedBy varchar(50)  ,
	--@LastUpdatedDate datetime  ,
	@LastUpdatedBy varchar(50)  ,
	@MMR_Year [varchar](50) ,
	@ProviderFullName [varchar](50),
	@ProviderNPI [varchar](20) ,
	@HICN [varchar](50), 
	@MemberLastName [varchar](50),
	@MemberFirstName [varchar](50),
	@MemberBirthDate varchar(12),
	@EffectiveDate varchar(12),
	@MinProviderAffiliationDate varchar(12),
	@MaxProviderAffiliationDate varchar(12),
	@MemberPhone [varchar](15) ,
	@MemberAddress [varchar](50) ,
	@MemberCity [varchar](50) ,
	@MemberState [varchar](50) ,
	@MemberZip [varchar](10) ,
	@MbrsWithClaims [varchar](50),
	@MbrsWithOfficeVisits [varchar](50),
	@MbrsWithPCPVisits [varchar](50) ,
	@MbrsWithWellnessVisits [varchar](50) ,
	@MbrsWithAnnualPlannedVisits [varchar](50)          
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
	--DECLARE @DATE VARCHAR(8) , @YEAR VARCHAR(4), @MONTH VARCHAR(2), @DAY VARCHAR(2)	
	--SET @DATE =  SUBSTRING(@SrcFileName, (CHARINDEX('.',@SrcFileName)-8),8)
	--SET @YEAR = SUBSTRING(@DATE, 5,4)
	--SET @MONTH = SUBSTRING(@DATE, 1,2)
	--SET @DAY = SUBSTRING(@DATE, 3,2)


    INSERT INTO [adi].[Amerigroup_MA_WellnessVisits]
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
      ,[MMR_Year]
      ,[ProviderFullName]
      ,[ProviderNPI]
      ,[HICN]
      ,[MemberLastName]
      ,[MemberFirstName]
      ,[MemberBirthDate]
      ,[EffectiveDate]
      ,[MinProviderAffiliationDate]
      ,[MaxProviderAffiliationDate]
      ,[MemberPhone]
      ,[MemberAddress]
      ,[MemberCity]
      ,[MemberState]
      ,[MemberZip]
      ,[MbrsWithClaims]
      ,[MbrsWithOfficeVisits]
      ,[MbrsWithPCPVisits]
      ,[MbrsWithWellnessVisits]
      ,[MbrsWithAnnualPlannedVisits]
	)
		
 VALUES  (
 
 
	@OriginalFileName  ,
	@SrcFileName ,
	GETDATE(),
	--@LoadDate date  ,
	GETDATE(),
	--@CreatedDate date  ,
	CASE WHEN @DataDate  =''
	THEN NULL
	ELSE
	CONVERT(DATE, @DataDate)
	END,
	CASE WHEN @FileDate =''
	THEN NULL
	ELSE
	CONVERT(DATE, @FileDate)
	END,
	@CreatedBy ,
	GETDATE(),
	--@LastUpdatedDate datetime  ,
	@LastUpdatedBy   ,
	@MMR_Year  ,
	@ProviderFullName ,
	@ProviderNPI  ,
	@HICN , 
	@MemberLastName ,
	@MemberFirstName ,
	CASE WHEN @MemberBirthDate  =''
	THEN NULL
	ELSE
	CONVERT(DATE, @MemberBirthDate)
	END,
	CASE WHEN @EffectiveDate =''
	THEN NULL
	ELSE
	CONVERT(DATE, @EffectiveDate)
	END,
	CASE WHEN @MinProviderAffiliationDate =''
	THEN NULL
	ELSE
	CONVERT(DATE, @MinProviderAffiliationDate)
	END,	 
	CASE WHEN @MaxProviderAffiliationDate =''
	THEN NULL
	ELSE
	CONVERT(DATE, @MaxProviderAffiliationDate)
	END,	
	@MemberPhone ,
	@MemberAddress  ,
	@MemberCity  ,
	@MemberState ,
	@MemberZip  ,
	@MbrsWithClaims ,
	@MbrsWithOfficeVisits ,
	@MbrsWithPCPVisits  ,
	@MbrsWithWellnessVisits  ,
	@MbrsWithAnnualPlannedVisits 
)

END




