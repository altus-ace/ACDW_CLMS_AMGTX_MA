

CREATE PROCEDURE [ast].[stg_02_Pts_ProcessMbrMemberTransformationInStaging]
							(@MbrShipDataDate  DATE
							,@MbrEligDataDate Date
							,@EffectiveDate DATE)

AS

BEGIN
BEGIN TRAN
BEGIN TRY
						DECLARE @AuditId INT;    
						DECLARE @JobStatus tinyInt = 1    
						DECLARE @JobType SmallInt = 9	  
						DECLARE @ClientKey INT	 = 21; 
						DECLARE @JobName VARCHAR(100) = 'AGMTX_MA MbrMember';
						DECLARE @ActionStart DATETIME2 = GETDATE();
						DECLARE @SrcName VARCHAR(100) = 'adi.Amerigroup_Member'
						DECLARE @DestName VARCHAR(100) = ''
						DECLARE @ErrorName VARCHAR(100) = 'NA';
						DECLARE @InpCnt INT = -1;
						DECLARE @OutCnt INT = -1;
						DECLARE @ErrCnt INT = -1;
	SELECT				@InpCnt = COUNT(AmerigroupMemberKey)    
	FROM				[adi].[Amerigroup_Member] 
	WHERE				DataDate = @MbrShipDataDate 
	AND					LOB = 'Medicare'
	AND					DataDate BETWEEN EffectiveDate AND TerminationDate
	
	SELECT				@InpCnt, @MbrShipDataDate
	
	
	EXEC				amd.sp_AceEtlAudit_Open 
						@AuditID = @AuditID OUTPUT
						, @AuditStatus = @JobStatus
						, @JobType = @JobType
						, @ClientKey = @ClientKey
						, @JobName = @JobName
						, @ActionStartTime = @ActionStart
						, @InputSourceName = @SrcName
						, @DestinationName = @DestName
						, @ErrorName = @ErrorName
						;

		BEGIN			--- More unidentified biz rules to be built here
					---- DECLARE @EffectiveDate DATE = '2021-04-01'
					--Update MbrNPIFlg
					UPDATE ast.MbrStg2_MbrData
					SET MbrNPIFlg = (CASE WHEN prvNPI IS NULL THEN 0 ELSE 1 END)
					WHERE	EffectiveDate = @EffectiveDate
					AND		DataDate = @MbrShipDataDate

					--Update MbrPlnFlg
					UPDATE ast.MbrStg2_MbrData
					SET MbrPlnFlg = (CASE WHEN plnProductSubPlanName IS NULL THEN 0 ELSE 1 END)
					WHERE	EffectiveDate = @EffectiveDate
					AND		DataDate = @MbrShipDataDate
					
					--Update MbrFlgCount
					UPDATE ast.MbrStg2_MbrData
					SET MbrFlgCount = OutputResult  --- Select OutputResult,MbrFlgCount,*
					FROM	ast.MbrStg2_MbrData trg
					JOIN 	(SELECT CASE WHEN MbrCount >1 
										THEN MbrCount ELSE 1 END OutputResult
										,ClientSubscriberId
											FROM (
												SELECT	 COUNT(*) MbrCount
														,ClientSubscriberId
												FROM	 ast.MbrStg2_MbrData
												GROUP BY ClientSubscriberId
												)cnt
										)src
					ON		trg.ClientSubscriberId = src.ClientSubscriberId
					
					--Count for Npi
					SELECT	COUNT(*)
					FROM	[ast].[MbrStg2_MbrData]	-- 
					WHERE	DataDate = @MbrShipDataDate
					AND		EffectiveDate = @EffectiveDate
					AND		MbrNPIFlg = 1
						
					--Count for Pln
					SELECT	COUNT(*)
					FROM	[ast].[MbrStg2_MbrData]	-- 
					WHERE	DataDate = @MbrShipDataDate
					AND		EffectiveDate = @EffectiveDate
					AND		MbrPlnFlg = 1

					--Summary
					SELECT	COUNT(*)RecCnt, stgRowStatus
							,MbrFlgCount,MbrNPIFlg,MbrPlnFlg
							,DataDate,EffectiveDate
					FROM	ACDW_CLMS_AMGTX_MA.ast.MbrStg2_MbrData 
					GROUP BY stgRowStatus
							 ,MbrFlgCount,MbrNPIFlg,MbrPlnFlg
							 ,DataDate,EffectiveDate
					ORDER BY DataDate DESC
	


		SET					@ActionStart  = GETDATE();
		SET					@JobStatus =2  
	    				
		EXEC				amd.sp_AceEtlAudit_Close 
							@AuditId = @AuditID
							, @ActionStopTime = @ActionStart
							, @SourceCount = @InpCnt		  
							, @DestinationCount = @OutCnt
							, @ErrorCount = @ErrCnt
							, @JobStatus = @JobStatus

		END			
		
COMMIT
END TRY
BEGIN CATCH
EXECUTE [adw].[usp_MPI_Error_handler]
END CATCH

END

