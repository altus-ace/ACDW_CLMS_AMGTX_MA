

CREATE PROCEDURE [ast].[stg_01_pls_ProcessMbrMemberLoadFrmStaging]
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


	BEGIN
	DECLARE @Rowstatus INT = 0
	--DECLARE @ClientKey INT = 21
	--DECLARE @LoadDate DATE = @MbrShipDataDate

	IF OBJECT_ID('tempdb..#Prr') IS NOT NULL DROP TABLE #Prr
	CREATE TABLE #Prr(PrKey INT PRIMARY KEY IDENTITY(1,1), NPI VARCHAR(50),ClientNPI VARCHAR(50),AttribTIN VARCHAR(50),ClientTIN VARCHAR(50),MemberID VARCHAR(50))

	INSERT INTO #Prr(PrKey,NPI,ClientNPI,AttribTIN,ClientTIN,MemberID)
	EXECUTE  [adi].[GetMbrNpiAndTin_AMGTX] @MbrShipDataDate,@Rowstatus,@ClientKey 
	END


	
	--Creating a Temp Table to store Medicare Members
	IF OBJECT_ID('tempdb..#AmgMA') IS NOT NULL DROP TABLE #AmgMA

	--Geting candidate rows for AGTX_MA member month processing
	SELECT	*  
	INTO	#AmgMA
	FROM	(
				SELECT		 e.MASTER_CONSUMER_ID
							,CASE WHEN e.MASTER_CONSUMER_ID IS NULL THEN 'No Member in Eligibility File' 
								ELSE m.MasterConsumerID 
								END MasterConsumerID
							,m.SrcFileName
							,(SELECT ClientKey	
								FROM lst.list_client
								WHERE ClientShortName = 'AMTX_MA') AS ClientKey
							,'adi.Amerigroup_Member'	AS AdiTableName
							,m.AmerigroupMemberKey		AS AdiKey
							,CASE WHEN NPI IS NOT NULL 
								THEN 'Valid' 
								ELSE 'Not Valid' 
								END						AS stgRowStatus
							,m.LoadDate
							,m.DataDate
							,m.TerminationDate
							,[adi].[udf_ConvertToCamelCase](m.FirstName)FirstName
							,[adi].[udf_ConvertToCamelCase](m.LastName) LastName
							,m.DateofBirth
							,[adi].[udf_ConvertToCamelCase](m.MemberAddress) MemberAddress
							,[adi].[udf_ConvertToCamelCase](m.MemberCity) MemberCity
							,m.MemberState
							,m.MemberZip
							,m.MemberCounty
							,[lst].[fnStripNonNumericChar](m.MemberPhone) MemberPhone
							,[adi].[udf_ConvertToCamelCase](REPLACE(m.PrimaryLanguage,'(Default)','')) PrimaryLanguage
							,m.Gender
							,e.EligibilityEndDate
							,m.PG_ID
							,e.PRDCTSL
							,m.LOB
							,[adi].[udf_ConvertToCamelCase](m.BNFTPKGName)BNFTPKGName
							,m.BNFTPKGID
							,CONVERT(VARCHAR(100),'No Plan') AS PlnSubGroupName 
							,pl.SourceValue
							,m.PLAN_DESC
							,e.EligibilityEffectiveDate
							,m.EffectiveDate
							,e.RXBNFLG
							,pr.NPI
							,pr.AttribTIN
							, ( CASE WHEN BNFTPKGName LIKE '%DUAL%' 
									THEN 'Is Dual' 
									ELSE 'Not Dual' END)  plnMbrIsDualCoverage
							, ( CASE WHEN BNFTPKGName LIKE '%DUAL%' 
									THEN 'Y' 
									ELSE 'N' END) AS Member_Dual_Eligible_Flag
									--- select *
				FROM		adi.Amerigroup_Member m 
				LEFT JOIN	adi.Amerigroup_MemberEligibility e
				ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
				AND			m.PG_ID = e.PG_ID
				LEFT JOIN		(SELECT  *
								FROM	lst.lstPlanMapping a
								WHERE	ClientKey = 21
								AND		TargetSystem = 'ACDW'
								AND		GETDATE() BETWEEN EffectiveDate AND ExpirationDate
								AND		ACTIVE = 'Y'
								)pl
				ON			m.BNFTPKGID = pl.SourceValue
				LEFT JOIN     (SELECT DISTINCT MemberID
									,AttribTIN ,NPI
									FROM #Prr 
							   )pr
				ON			m.Responsible_NPI = pr.NPI
				AND			m.MasterConsumerID = pr.MemberID
				WHERE		LOB = 'Medicare'
				AND			m.DataDate = @MbrShipDataDate
				AND			e.DataDate = @MbrEligDataDate
				AND			@MbrShipDataDate  BETWEEN e.[EligibilityEffectiveDate]  AND e.[EligibilityEndDate] 
				AND			@MbrEligDataDate  BETWEEN m.EffectiveDate				AND m.[TerminationDate]
				AND			e.PRDCTSL = 'HMO'
			)amg
	
			---   select PlnSubGroupName,SourceValue,* from	#AmgMA  m 

		---Deriving plans
				UPDATE	#AmgMA
				SET		PlnSubGroupName = TargetValue -- select TargetValue,MasterConsumerID,pln.SourceValue,mbr.PlnSubGroupName
				FROM		#AmgMA mbr
				LEFT JOIN	( SELECT  *
							  FROM	lst.lstPlanMapping a
							  WHERE	ClientKey = 21
							  AND		TargetSystem = 'CS_AHS'
							  AND		GETDATE() BETWEEN EffectiveDate AND ExpirationDate
							  AND		ACTIVE = 'Y'
							) pln
				ON			mbr.BNFTPKGID = pln.SourceValue
				WHERE		pln.ClientKey = 21
				AND			pln.TargetSystem = 'CS_AHS'
		
	BEGIN
	--Processing into membership Staging

	INSERT INTO			[ast].[MbrStg2_MbrData]					
						([ClientSubscriberId] 
						,[ClientKey]																				
						,[MstrMrnKey]		
						,[mbrLastName]
						,[mbrMiddleName]
						,[mbrFirstName]
						,[mbrGENDER]
						,[mbrDob]
						,[HICN]
						,[MBI]
						,[mbrPrimaryLanguage]
						,[prvNPI]
						,[prvTIN]
						,[prvAutoAssign]
						,[plnProductPlan]
						,[plnProductSubPlan]
						,[plnProductSubPlanName]
						,[plnMbrIsDualCoverage]
						,[EffectiveDate]
						,[Member_Dual_Eligible_Flag] 
						,[plnClientPlanEffective]
						,[SrcFileName]
						,[AdiTableName]
						,[AdiKey]
						,[stgRowStatus]
						,[LoadDate]
						,[DataDate]
						,[plnClientPlanEndDate]
						,[MbrState] 
						,[MemberOriginalEffectiveDate]
						,[MemberOriginalEndDate]
						,[MbrCity]
						,[SubscriberID_SHCN_BCBS]
						,[Indicator834]
						,[RiskScore]
						,[OpportunityScore]
						,[MemberStatus]
						,[ProviderChapter]
						,[prvClientEffective]
						,[prvClientExpiration]
						)  ---  DECLARE @EffectiveDate DATE = '2021-04-01'
		SELECT			m.MasterConsumerID								AS ClientSubscriberId
						,ClientKey										AS ClientKey
						,0												AS MstrMrnKey
						,m.LastName										AS mbrLastName
						,''												AS mbrMiddleName
						,FirstName										AS mbrFirstName
						,m.Gender										AS mbrGENDER
						,m.DateofBirth									AS mbrDob
						,''												AS HICN
						,''												AS MBI
						,m.PrimaryLanguage								AS [mbrPrimaryLanguage]
						,m.NPI											AS [prvNPI]
						,m.AttribTIN									AS [prvTIN]
						,''												AS [prvAutoAssign]
						,m.LOB											AS [plnProductPlan]
						,m.BNFTPKGName									AS [plnProductSubPlan]
						,m.PlnSubGroupName								AS [plnProductSubPlanName]
						,m.plnMbrIsDualCoverage							AS [plnMbrIsDualCoverage]
						,@EffectiveDate									AS [EffectiveDate]
						,m.[Member_Dual_Eligible_Flag]					AS [Member_Dual_Eligible_Flag] 
						,EligibilityEffectiveDate						AS [plnClientPlanEffective]
						,SrcFileName									AS SrcFileName
						,AdiTableName									AS AdiTableName
						,AdiKey											AS AdiKey
						,stgRowStatus									AS stgRowStatus
						,LoadDate										AS LoadDate
						,DataDate										AS DataDate
						,EligibilityEndDate								AS [plnClientPlanEndDate]	
						,m.MemberState									AS [MbrState]
						,m.EligibilityEffectiveDate						AS [MemberOriginalEffectiveDate]
						,m.EligibilityEndDate							AS [MemberOriginalEndDate]
						,m.MemberCity									AS  [MbrCity]
						,''												AS [SubscriberID_SHCN_BCBS]
						,''												AS [Indicator834]
						,0												AS [RiskScore]
						,0												AS [OpportunityScore]
						,''												AS [MemberStatus]
						,''												AS [ProviderChapter]
						,m.EffectiveDate								AS [prvClientEffective]
						,m.TerminationDate								AS [prvClientExpiration]
		FROM			#AmgMA m
		
		END


		BEGIN
		--Load Members Email,addresses and Phone into staging

		INSERT INTO		[ast].[MbrStg2_PhoneAddEmail]
						(							 
						[ClientMemberKey]
						,[SrcFileName]
						,[LoadType]
						,[LoadDate]
						,[DataDate]
						,[AdiTableName]
						,[AdiKey]
						,[lstPhoneTypeKey]
						,[PhoneNumber]
						,[PhoneCarrierType]
						,[PhoneIsPrimary]
						,[lstAddressTypeKey] 
						,[AddAddress1]
						,[AddAddress2]
						,[AddCity]
						,[AddState]
						,[AddZip]
						,[AddCounty]
						,[lstEmailTypeKey]
						,[EmailAddress]
						,[EmailIsPrimary]
						,[stgRowStatus]
						,[ClientKey]
						)
		SELECT			DISTINCT																
						MasterConsumerID						AS [ClientMemberKey]
						,src.SrcFileName						AS [SrcFileName]
						,'P'									AS [LoadType]
						,src.LoadDate							AS [LoadDate]
						,src.DataDate							AS [DataDate]
						,src.AdiTableName						AS [AdiTableName]
						,src.AdiKey								AS [AdiKey]	
						,1										AS [lstPhoneTypeKey]
						,src.MemberPhone						AS [PhoneNumber]
						,0										AS [PhoneCarrierType]
						,0										AS [PhoneIsPrimary]
						,1										AS [lstAddressTypeKey]
						,src.MemberAddress						AS [AddAddress1]
						,''										AS [AddAddress2]
						,src.MemberCity							AS [AddCity]
						,src.MemberState						AS [AddState]
						,src.MemberZip							AS [AddZip]
						,src.MemberCounty						AS [AddCounty]
						,0										AS [lstEmailTypeKey]
						,''										AS [EmailAddress]
						,0										AS [EmailIsPrimary]
						,[stgRowStatus]							AS [stgRowStatus]
						,ClientKey								AS [ClientKey]	 							
		FROM			#AmgMA src
	

	


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