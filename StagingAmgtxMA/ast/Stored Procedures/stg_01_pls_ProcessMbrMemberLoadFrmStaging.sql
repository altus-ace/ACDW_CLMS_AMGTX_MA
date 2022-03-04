

CREATE PROCEDURE [ast].[stg_01_pls_ProcessMbrMemberLoadFrmStaging]-- '2021-12-01','2021-12-01','2021-12-01'
							(@MbrShipLoadDate  DATE
							,@MbrEligLoadDate Date
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
	WHERE				LoadDate = @MbrShipLoadDate 
	AND					LOB = 'Medicare'
	AND					LoadDate BETWEEN EffectiveDate AND TerminationDate
	
	SELECT				@InpCnt, @MbrShipLoadDate
	
	
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
	--DECLARE @MbrShipLoadDate DATE = '2021-12-01'

	IF OBJECT_ID('tempdb..#Prr') IS NOT NULL DROP TABLE #Prr
	CREATE TABLE #Prr(PrKey INT PRIMARY KEY IDENTITY(1,1), NPI VARCHAR(50),ClientNPI VARCHAR(50),AttribTIN VARCHAR(50),ClientTIN VARCHAR(50),MemberID VARCHAR(50))

	INSERT INTO #Prr(PrKey,NPI,ClientNPI,AttribTIN,ClientTIN,MemberID)
	EXECUTE  [adi].[GetMbrNpiAndTin_AMGTX]@MbrShipLoadDate, @Rowstatus,@ClientKey 
	END


	
	--Creating a Temp Table to store Medicare Members
	IF OBJECT_ID('tempdb..#AmgMA') IS NOT NULL DROP TABLE #AmgMA

	--Geting candidate rows for AGTX_MA member month processing DECLARE @MbrShipLoadDate DATE = '2021-12-01' DECLARE @MbrEligLoadDate DATE = '2021-12-01' DECLARE @ClientKey INT = 21
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
							,'Loaded'					AS stgRowStatus
							,e.EligibilityEndDate
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
							,m.PG_ID
							,e.PRDCTSL
							,[adi].[udf_ConvertToCamelCase](m.BNFTPKGName)BNFTPKGName
							,m.BNFTPKGID
							,''			AS [CellPhone] 
							,''			AS [HomePhone]
							,pln.SourceValue
							,pln.TargetValue  AS plnProductPlan
							,plnSub.TargetValue AS plnProductSubPlanName
							,plnCsPln.TargetValue AS csPlnProductSubPlanName
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
							,Responsible_NPI AS srcNPI
							,Responsible_Tax_ID_Could_Contain_SSN   AS srcTIN
							,m.BNFTPKGID AS srcPLN
							,(SELECT LobName FROM lst.list_client WHERE ClientKey = @ClientKey) AS LOB
									--- select top 3 *
				FROM		adi.Amerigroup_Member m 
				LEFT JOIN	adi.Amerigroup_MemberEligibility e
				ON			m.MasterConsumerID = e.MASTER_CONSUMER_ID
				AND			m.PG_ID = e.PG_ID
				LEFT JOIN		(SELECT SourceValue, TargetValue
										,TargetSystem
								FROM	lst.lstPlanMapping a
								WHERE	ClientKey = @ClientKey
								AND		TargetSystem = 'ACDW_Plan'
								AND		@MbrShipLoadDate BETWEEN EffectiveDate AND ExpirationDate
								)pln
				ON			m.BNFTPKGID = pln.SourceValue
				LEFT JOIN		(SELECT SourceValue, TargetValue
										,TargetSystem
								FROM	lst.lstPlanMapping a
								WHERE	ClientKey = @ClientKey
								AND		TargetSystem = 'ACDW_SubPlan'
								AND		@MbrShipLoadDate BETWEEN EffectiveDate AND ExpirationDate
								)plnSub
				ON			m.BNFTPKGID = plnSub.SourceValue
				LEFT JOIN		(SELECT SourceValue, TargetValue
										,TargetSystem
								FROM	lst.lstPlanMapping a
								WHERE	ClientKey = @ClientKey
								AND		TargetSystem = 'CS_AHS'
								AND		@MbrShipLoadDate BETWEEN EffectiveDate AND ExpirationDate
								)plnCsPln
				ON			m.BNFTPKGID = plnCsPln.SourceValue
				LEFT JOIN     (SELECT DISTINCT MemberID
									,AttribTIN ,NPI
									FROM #Prr 
							   )pr
				ON			m.Responsible_NPI = pr.NPI
				AND			m.MasterConsumerID = pr.MemberID
				WHERE		LOB = 'Medicare'
				AND			m.LoadDate = @MbrShipLoadDate
				AND			e.LoadDate = @MbrEligLoadDate
				AND			@MbrEligLoadDate  BETWEEN e.[EligibilityEffectiveDate]  AND e.[EligibilityEndDate] 
				AND			@MbrShipLoadDate  BETWEEN m.EffectiveDate				AND m.[TerminationDate]
				AND			e.PRDCTSL = 'HMO'
			)amg
	
			---   SELECT plnProductPlan,plnProductSubPlanName,stgRowStatus,EligibilityEndDate,NPI,srcNPI,AttribTIN,srcPln,BNFTPKGID,EffectiveDate,* FROM #AmgMA  m
		
		
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
						,[csPlnProductSubPlanName]
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
						,[SubscriberID_Client]
						,[Indicator834]
						,[RiskScore]
						,[OpportunityScore]
						,[MemberStatus]
						,[ProviderChapter]
						,[prvClientEffective]
						,[prvClientExpiration]
						,[LOB]
						, srcNPI
						,srcPln
						,srcTIN)  ---  DECLARE @EffectiveDate DATE = '2021-10-01'
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
						,m.plnProductPlan								AS [plnProductPlan]
						,m.plnProductSubPlanName						AS [plnProductSubPlan]
						,m.plnProductSubPlanName						AS [plnProductSubPlanName]
						,m.csPlnProductSubPlanName						AS [CsplnProductSubPlanName]
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
						,''												AS [SubscriberID_Client]
						,''												AS [Indicator834]
						,0												AS [RiskScore]
						,0												AS [OpportunityScore]
						,''												AS [MemberStatus]
						,''												AS [ProviderChapter]
						,m.EffectiveDate								AS [prvClientEffective]
						,m.TerminationDate								AS [prvClientExpiration]
						,m.LOB											AS [LOB]
						,m.srcNPI										AS srcNPI
						,m.srcPLN										AS srcPLN
						,m.srcTIN										AS srcTIN
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
						,[CellPhone] 
						,[HomePhone]
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
						,[CellPhone]							AS [CellPhone]
						,[HomePhone]							AS [HomePhone]
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