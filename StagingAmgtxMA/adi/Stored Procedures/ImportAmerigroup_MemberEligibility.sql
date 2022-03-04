
-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert Cigna MA AWV to DB
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_MemberEligibility]
    @OriginalFileName  varchar(100)  ,
	@SrcFileName  varchar(100)  ,
	@LoadDate varchar(10) ,
	--@CreatedDate  
	@DataDate varchar(10) ,  
	@FileDate varchar(10) , 
	@CreatedBy  varchar(50)  ,
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy  varchar(50)  ,
	@MASTER_CONSUMER_ID [bigint] ,
	@EligibilityEffectiveDate varchar(10) ,
	@EligibilityEndDate varchar(10) ,
	@PG_ID [varchar](32) ,
	@PG_NAME [varchar](150) ,
	@PRDCTSL [varchar](32) ,
	@RXBNFLG [varchar](3)    
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

    INSERT INTO [adi].[Amerigroup_MemberEligibility]
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
      ,[MASTER_CONSUMER_ID]
      ,[EligibilityEffectiveDate]
      ,[EligibilityEndDate]
      ,[PG_ID]
      ,[PG_NAME]
      ,[PRDCTSL]
      ,[RXBNFLG]
	  ,[RowStatus]
	)
		
 VALUES  (
    @OriginalFileName ,
	@SrcFileName  ,
	DATEADD(mm, DATEDIFF(mm,0, GETDATE()) +1, 0),
	--CASE WHEN @LoadDate  = ''
	--THEN NULL
	--ELSE CONVERT(DATE, @LoadDate )
	--END ,
	GETDATE(),
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
	--@DataDate  ,  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
--	@FileDate  , 
	@CreatedBy   ,
	GETDATE(),
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy    ,
	@MASTER_CONSUMER_ID  ,
	CASE WHEN @EligibilityEffectiveDate  = ''
	THEN NULL
	ELSE CONVERT(DATE, @EligibilityEffectiveDate )
	END ,	
	CASE WHEN @EligibilityEndDate  = ''
	THEN NULL
	ELSE CONVERT(DATE, @EligibilityEndDate )
	END ,	
	@PG_ID ,
	@PG_NAME ,
	@PRDCTSL  ,
	@RXBNFLG ,
	0

)

END




