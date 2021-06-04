


CREATE PROCEDURE [adw].[PupdAllLineageRowsInAdiAndStg](@DataDate DATE) --  [adw].[PupdAllLineageRowsInAdiAndStg]'2021-04-15'

AS
		--- Check this before you run
BEGIN
		/*Updating all lineages from adi to staging*/

		UPDATE		ast.MbrStg2_MbrData
		SET			stgRowStatus = 'Exported'
		WHERE		stgRowStatus = 'VALID'
		AND			DataDate = @DataDate

END


BEGIN

		UPDATE		adi.Amerigroup_Member
		SET			RowStatus = 1  --- SELECT * FROM adi.Amerigroup_Member
		WHERE		LOB = 'MEDICARE'
		AND			RowStatus = 0
		AND			DataDate = @DataDate -- '2021-04-15' --

		UPDATE		adi.Amerigroup_MemberEligibility
		SET			RowStatus = 1  ---- select *
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
