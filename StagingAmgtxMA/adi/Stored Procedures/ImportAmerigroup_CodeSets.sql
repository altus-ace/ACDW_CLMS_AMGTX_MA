

-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert 
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_CodeSets]
    @OriginalFileName  varchar(100)  ,
	@SrcFileName  varchar(100)  ,
	@LoadDate varchar(10) ,
	--@CreatedDate  
	@DataDate varchar(10) ,  
	@FileDate varchar(10) , 
	@CreatedBy  varchar(50)  ,
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy  varchar(50)  ,
	@CodeSet  varchar(40) ,
	@CodeValue  varchar(100) ,
	@CodeValueName  varchar(1000) ,
	@SystemRecordCode  varchar(10) ,
	@ProductSystemRecordCode  char(10) 
 
            
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


    INSERT INTO [adi].[Amerigroup_CodeSets]
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
      ,[CodeSet]
      ,[CodeValue]
      ,[CodeValueName]
      ,[SystemRecordCode]
      ,[ProductSystemRecordCode]
     
	)
		
 VALUES  (
       @OriginalFileName    ,
	@SrcFileName   ,
    DATEADD(mm, DATEDIFF(mm,0, GETDATE()) +1, 0),
	--@LoadDate varchar(10) ,
	GETDATE(),
	--@CreatedDate  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
	--@DataDate  ,  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
--	@FileDate  ,  
	@CreatedBy   ,
	GETDATE(),
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy   ,
   
	@CodeSet   ,
	@CodeValue   ,
	@CodeValueName ,
	@SystemRecordCode   ,
	@ProductSystemRecordCode  
 
            
)

END




