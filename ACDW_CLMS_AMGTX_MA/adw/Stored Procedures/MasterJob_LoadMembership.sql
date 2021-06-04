

CREATE PROCEDURE [adw].[MasterJob_LoadMembership](@DataDate DATE
												,@LoadType VARCHAR(1)
												,@ClientID INT
												,@EffectiveDate DATE
												,@AsOfDate DATE
												,@MbrShipDataDate Date
												,@MbrCrsWkDataDate Date
												,@MbrEligDataDate DATE
												,@LoadDate DATE
												,@LoadDateFrmStg DATE)

AS

	BEGIN

		EXECUTE [adi].[ValidateMemberShip]

	END


	BEGIN
		--Process load into staging
		EXECUTE [ast].[stg_01_pls_ProcessMbrMemberLoadFrmStaging]
							@MbrShipDataDate
							,@MbrEligDataDate
							,@EffectiveDate;
	
	END
	

	BEGIN

		EXECUTE [ast].[stg_02_Pts_ProcessMbrMemberTransformationInStaging]
						@MbrShipDataDate
						,@MbrEligDataDate
						,@EffectiveDate;
	END
	
	BEGIN
		--Process Members MRN and updating staging
		EXECUTE [ast].[stg_03_Pts_RunMpiForMbrMember];
	
	END
	

	BEGIN
			--Validate
		EXECUTE [ast].[stg_04_Validate_stg_Membership]
					@MbrShipDataDate
					,@MbrEligDataDate
					,@EffectiveDate
					,@DataDate;

	END

	BEGIN
			--Process Failed Log
		EXECUTE [ast].[stg_05_Master_FailedLogMbrMember]@DaTaDate,@LoadDateFrmStg; 
	
	END


	BEGIN
		--Process Load DIMs
		EXECUTE	[adw].[PdwMbr_01_LoadHistory]@DaTaDate,@LoadType,@ClientID;
		EXECUTE	[adw].[PdwMbr_02_LoadMember]@DaTaDate,@LoadType,@ClientID,@EffectiveDate;
		EXECUTE	[adw].[PdwMbr_03_LoadDemo]@DaTaDate,@ClientID;
		EXECUTE	[adw].[PdwMbr_04_LoadPhone]@DaTaDate,@ClientID;
		EXECUTE	[adw].[PdwMbr_05_LoadAddress]@DaTaDate,@ClientID;
		EXECUTE	[adw].[PdwMbr_06_LoadPcp]@DaTaDate,@ClientID;
		EXECUTE	[adw].[PdwMbr_08_LoadPlan]@DaTaDate,@ClientID;
		EXECUTE	[adw].[PdwMbr_09_LoadCSPlan]@DaTaDate,@ClientID;
		EXECUTE	[adw].[PdwMbr_11_LoadEmail] @DaTaDate,@ClientID;
	
	END
	
	BEGIN

			--To processed immediately after Dim tables are loaded
	EXECUTE	adw.PupdAllLineageRowsInAdiAndStg @DataDate
	END
	

	BEGIN
		----ENSURE TO PROCESS THE 0 Row Key BEFORE YOU COMMENCE THE BELOW PROCESSING
		---Ste of Management SP to load FctMembership Table
		EXECUTE [adw].[p_Pdw_Master_ProcessFctMembership] @AsOfDate,@ClientID,@DataDate,@LoadDate

	END


	
	
