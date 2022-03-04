


CREATE PROCEDURE [ast].[stg_05_PupdAllLineageRowsInAdiAndStg](@DataDate DATE) --  [adw].[PupdAllLineageRowsInAdiAndStg]'2021-04-15'

AS

BEGIN
BEGIN TRAN
BEGIN TRY

			
BEGIN



		UPDATE		adi.Amerigroup_Member
		SET			RowStatus = 1  --- SELECT lob,* FROM adi.Amerigroup_Member
		WHERE		LOB = 'MEDICARE'
		AND			RowStatus = 0
		AND			DataDate = @DataDate -- '2021-04-15' --

		UPDATE		adi.Amerigroup_MemberEligibility
		SET			RowStatus = 1  ---- select lob,*
		FROM		adi.Amerigroup_MemberEligibility e
		JOIN		adi.Amerigroup_Member  m
		ON			e.MASTER_CONSUMER_ID = m.MasterConsumerID
		AND			e.DataDate = m.DataDate
		WHERE		LOB = 'MEDICARE'
		AND			e.PG_ID = m.PG_ID
		AND			m.RowStatus = 1
		AND			e.PRDCTSL = 'HMO'
		AND			e.DataDate = @DataDate -- '2021-04-15' 

END

COMMIT
END TRY
BEGIN CATCH
EXECUTE [adw].[usp_MPI_Error_handler]
END CATCH









END