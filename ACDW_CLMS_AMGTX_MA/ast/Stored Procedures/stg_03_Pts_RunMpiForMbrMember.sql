


CREATE	PROCEDURE [ast].[stg_03_Pts_RunMpiForMbrMember]

AS

BEGIN
BEGIN TRAN
BEGIN TRY
		DECLARE @ClientKey INT = 21
			-- SELECT * FROM  [AceMPI].[ast].[MPI_SourceTable]
BEGIN
			TRUNCATE TABLE [AceMPI].[ast].[MPI_SourceTable] 
END


BEGIN
			TRUNCATE TABLE [AceMPI].[ast].[MPI_OUTPUTTABLE] 
END


BEGIN

			INSERT INTO [AceMPI].[ast].[MPI_SourceTable] (
						[ClientSubscriberId]
						, [ClientKey]
						, [MstrMrnKey]
						, [mbrLastName]
						, [mbrFirstName]
						, [mbrMiddleName]
						, [mbrGENDER]
						, [mbrDob]
						, [SrcFileName]
						, [AdiTableName]
						, [ExternalUniqueID]
						, [MbrState]
						, [AdiKey]
						, [LoadDate])
			SELECT		[ClientSubscriberId]
						, [ClientKey]
						, [MstrMrnKey]
						, [mbrLastName]
						, [mbrFirstName]
						, [mbrMiddleName]
						, [mbrGENDER]
						, [mbrDob]
						, [SrcFileName]
						, [AdiTableName]
						, [AdiKey]
						, [MbrState]
						, [mbrStg2_MbrDataUrn]
						, [LoadDate]
			FROM		[ast].[MbrStg2_MbrData] a
			WHERE		DataDate = (SELECT MAX(DataDate) FROM [ast].[MbrStg2_MbrData])
			AND			ClientKey = @ClientKey

			

				-- Run Load_MPI_MasterJob algorithm to Generate Mstrmrnkeys for members
			IF (SELECT COUNT(*) FROM [AceMPI].[ast].[MPI_SourceTable]) >= 1
			EXECUTE ACEMPI.adw.[Load_MasterJob_MPI]


END
		
BEGIN
			--CHECK THIS BEFORE THE NEXT RUN
			--Update stg table with the mstrmrnkeys
			--	BEGIN TRAN				-- rollback -- COMMIT
			UPDATE		ast.MbrStg2_MbrData
			SET			MstrMrnKey = z.MstrMrn
			-- SELECT		z.ClientSubscriberId,a.ClientKey,MstrMrn,a.MstrMrnKey,a.ClientSubscriberId,z.ClientKey --a.ExternalUniqueID,b.ExternalUniqueID,
			FROM		ast.MbrStg2_MbrData a
			JOIN		(	SELECT		ClientSubscriberId, ClientKey,a.ExternalUniqueID,b.ExternalUniqueID bExternalUniqueID
										,MstrMrnKey,MstrMrn
							FROM		AceMPI.ast.MPI_SourceTable a
							JOIN		AceMPI.ast.MPI_OutputTable b
							ON			a.ExternalUniqueID = b.ExternalUniqueID
						)z
			ON			a.ClientSubscriberId = z.ClientSubscriberId
			WHERE		a.ClientKey = @ClientKey
			AND			LoadDate =  (	SELECT	MAX(LoadDate) 
										FROM	ast.MbrStg2_MbrData 
										WHERE	ClientKey = @ClientKey
									)




END

COMMIT
END TRY
BEGIN CATCH
EXECUTE [adw].[usp_MPI_Error_handler]
END CATCH


END
