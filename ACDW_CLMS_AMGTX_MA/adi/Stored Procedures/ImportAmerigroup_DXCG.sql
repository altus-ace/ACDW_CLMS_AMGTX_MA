


-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert 
-- ============================================
CREATE PROCEDURE [adi].[ImportAmerigroup_DXCG]
    @OriginalFileName  varchar(100)  ,
	@SrcFileName  varchar(100)  ,
	@LoadDate varchar(10) ,
	--@CreatedDate  
	@DataDate varchar(10) ,  
	@FileDate varchar(10) , 
	@CreatedBy  varchar(50)  ,
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy  varchar(50)  ,
   	@MasterConsumerID  bigint ,
	@EncounterMedicalModels_UnweightedRetrospectiveRiskScore  decimal(6, 3) ,
	@EncounterMedicalModels_UnweightedProspectiveRiskScore  decimal(6, 3) ,
	@EncounterMedicalModels_WeightedRetrospectiveRiskScore  decimal(6, 3) ,
	@EncounterMedicalModels_WeightedprospectiveRiskScore  decimal(6, 3) ,
	@RX_IP_UnweightedRetrospectiveRiskScore  decimal(6, 3) ,
	@RX_IP_UnweightedProspectiveRiskScore  decimal(6, 3) ,
	@RX_IP_WeightedRetrospectiveRiskScore  decimal(6, 3) ,
	@RX_IP_WeightedProspectiveRiskScore  decimal(6, 3) ,
	@MedicalPharmacy_WeightedRetrospectiveRiskScore  decimal(6, 3) ,
	@MedicalPharmacy_WeightedProspectiveRiskScore  decimal(6, 3) ,
	@MemberKey  varchar(32) ,
	@PG_ID  varchar(32) ,
	@PG_NAME  varchar(100) 
            
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


    INSERT INTO [adi].[Amerigroup_DXCG]
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
      ,[EncounterMedicalModels_UnweightedRetrospectiveRiskScore]
      ,[EncounterMedicalModels_UnweightedProspectiveRiskScore]
      ,[EncounterMedicalModels_WeightedRetrospectiveRiskScore]
      ,[EncounterMedicalModels_WeightedprospectiveRiskScore]
      ,[RX_IP_UnweightedRetrospectiveRiskScore]
      ,[RX_IP_UnweightedProspectiveRiskScore]
      ,[RX_IP_WeightedRetrospectiveRiskScore]
      ,[RX_IP_WeightedProspectiveRiskScore]
      ,[MedicalPharmacy_WeightedRetrospectiveRiskScore]
      ,[MedicalPharmacy_WeightedProspectiveRiskScore]
      ,[MemberKey]
      ,[PG_ID]
      ,[PG_NAME]
	)
		
 VALUES  (
    @OriginalFileName    ,
	@SrcFileName    ,
	GETDATE(),
--	@LoadDate  ,
	GETDATE(),
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
	--@DataDate  ,  
	CONVERT(DATE, @YEAR + '-' + @MONTH + '-' + @DAY),
--	@FileDate  , 
	 
	@CreatedBy    ,
	GETDATE(),
	--@LastUpdatedDate  @datetime   ,
	@LastUpdatedBy    ,
   	@MasterConsumerID   ,
	@EncounterMedicalModels_UnweightedRetrospectiveRiskScore   ,
	@EncounterMedicalModels_UnweightedProspectiveRiskScore   ,
	@EncounterMedicalModels_WeightedRetrospectiveRiskScore   ,
	@EncounterMedicalModels_WeightedprospectiveRiskScore   ,
	@RX_IP_UnweightedRetrospectiveRiskScore   ,
	@RX_IP_UnweightedProspectiveRiskScore   ,
	@RX_IP_WeightedRetrospectiveRiskScore   ,
	@RX_IP_WeightedProspectiveRiskScore   ,
	@MedicalPharmacy_WeightedRetrospectiveRiskScore   ,
	@MedicalPharmacy_WeightedProspectiveRiskScore   ,
	@MemberKey   ,
	@PG_ID   ,
	@PG_NAME   
            
)

END




