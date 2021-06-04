




-- =============================================
-- Author:		Brit Akhile
-- Create date: 2021/05/11
-- Using the new latest version of provider roster, Select Valid Npis
--, Npi and Tins and assign Tins to Npis with invalid Tins
/*
	Step 1: Declare a table variable
	Step 2: Check to see if these NPIs exist in our roster 
			(Note that after the left join, if it still remains Null, then NPI does not exist in our roster
			, ie (Might not be in our contract))
	Step 3: Assign the TIN to NPIs that exist
	Step 4: Update AttribTIN from the roster
*/
-- =============================================

CREATE PROCEDURE [adi].[GetMbrNpiAndTin_AMGTX] (@DataDate DATE, @RowStatus INT,@ClientKey INT) -- [adi].[GetMbrNpiAndTin_AMGTX]'2021-04-15',0,21

AS
					-- DECLARE @LoadDate DATE = '2021-04-15' DECLARE @RowStatus INT = 0 DECLARE @ClientKey INT = 21
					IF OBJECT_ID('tempdb..#Pr') IS NOT NULL DROP TABLE #Pr
					CREATE TABLE #Pr(PrKey INT PRIMARY KEY IDENTITY(1,1),NPI VARCHAR(50),ClientNPI VARCHAR(50),AttribTIN VARCHAR(50),ClientTIN VARCHAR(50),MemberID VARCHAR(50))

					INSERT INTO #Pr(NPI,AttribTIN,ClientNPI,ClientTIN,MemberID)
					SELECT	pr.NPI
							,pr.AttribTIN
							,src.Responsible_NPI			AS	ClientNPI
							,src.Responsible_Tax_ID_Could_Contain_SSN	AS	ClientTIN 
							,src.MasterConsumerID 
					FROM		(SELECT		DISTINCT m.MasterConsumerID,m.Responsible_NPI,M.DataDate,m.LoadDate
											,m.Responsible_Tax_ID_Could_Contain_SSN
								 FROM		adi.Amerigroup_Member m 
								 LEFT JOIN	adi.Amerigroup_MemberEligibility e
								 ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
								 AND		m.PG_ID = e.PG_ID 
								 AND		m.DataDate = e.DataDate 
								 WHERE		m.DataDate =  @DataDate
								) src
					LEFT JOIN	(SELECT		* 
								 FROM		[ACECAREDW].adw.tvf_AllClient_ProviderRoster (@ClientKey,@DataDate,1)
								 )pr
					ON			pr.NPI = src.Responsible_NPI 
					AND			pr.AttribTIN = src.Responsible_Tax_ID_Could_Contain_SSN
					
					
					/*Step 4. Update AttribTIN from the roster */
					--This other part is not applicable to AetnaMA
					
					UPDATE		#Pr
					SET			NPI = (CASE WHEN Toasg.ClientNPI = Toasg.prNPI THEN Toasg.ClientNPI END)
								, AttribTIN = (CASE WHEN Toasg.ClientTIN <> Toasg.prTIN THEN Toasg.prTIN  END)
					FROM		#Pr pr  --  SELECT * FROM #PR pr
					JOIN		(  ---  SELECT * FROM (
							--Step 2 
								--Step 3 
									SELECT		*
									FROM		(
												 SELECT	NPI,AttribTIN,ClientNPI,ClientTIN
												 FROM	#Pr 
												 WHERE	NPI IS NULL
												)noMatch
									LEFT JOIN	(SELECT		NPI AS prNPI,AttribTIN AS prTIN
												 FROM		ACECAREDW.[adw].[tvf_AllClient_ProviderRoster_TinRank](@ClientKey,@DataDate,1) 
												 ) a
									ON			noMatch.ClientNPI = prNPI
							)Toasg
					ON		pr.ClientNPI= Toasg.prNPI 
					
					
					
					SELECT	*
					FROM	#Pr 
					

					
