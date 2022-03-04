---DONT RUN SP UNTIL VALIDATION FROM ADI
CREATE PROCEDURE [adw].[Load_Pdw_15_ClmsMemsCCLF8]
    (@MaxDataDate DATE = '12/31/2099')
AS -- insert Claims.Members
    DECLARE @DataDate Date = @maxDataDate;
	/* prepare logging */
    DECLARE @AuditId INT;    
    DECLARE @JobStatus tinyInt = 1    -- 1 in process , 2 Completed
    DECLARE @JobType SmallInt = 8	  -- Adw load
    DECLARE @ClientKey INT	 = 16; -- mssp
    DECLARE @JobName VARCHAR(100) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @ActionStart DATETIME2 = GETDATE();
    DECLARE @SrcName VARCHAR(100) = 'adw.vw_Dashboard_Membership'
    DECLARE @DestName VARCHAR(100) = 'adw.Claims_Member'
    DECLARE @ErrorName VARCHAR(100) = 'NA';
    DECLARE @InpCnt INT = -1;
    DECLARE @OutCnt INT = -1;
    DECLARE @ErrCnt INT = -1;
	
    SELECT @InpCnt = COUNT(*) 
    --declare @datadate date = '01/01/2021'
    --SELECT * 
   FROM adw.vw_Dashboard_Membership mbr
    JOIN (SELECT m.ClientKey, m.ClientMemberKey, Max(m.RwEffectiveDate) rwEffectiveDate
  FROM adw.vw_Dashboard_Membership m
  GROUP BY m.clientKey, m.ClientMemberKey) LatestMember
  ON mbr.ClientKey = LatestMember.ClientKey
AND mbr.ClientMemberKey = LatestMember.ClientMemberKey
AND mbr.RwEffectiveDate = LatestMember.rwEffectiveDate	;

    
     

	EXEC amd.sp_AceEtlAudit_Open 
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
	CREATE TABLE #OutputTbl (ID VARCHAR(50) NOT NULL PRIMARY KEY);	

    INSERT INTO adw.Claims_Member
           (SUBSCRIBER_ID
		   , IsActiveMember
           ,DOB
           ,MEMB_LAST_NAME
           ,MEMB_MIDDLE_INITIAL
           ,MEMB_FIRST_NAME        
		   ,MEDICAID_NO
		   ,MEDICARE_NO
           ,Gender
           ,MEMB_ZIP
		   ,COMPANY_CODE
		   ,LINE_OF_BUSINESS_DESC
		   ,SrcAdiTableName
		   ,SrcAdiKey
		   ,LoadDate
		   )
	OUTPUT inserted.SUBSCRIBER_ID INTO #OutputTbl(ID)
    SELECT 
	   mbr.ClientMemberKey				AS SUBSCRIBER_ID		    
		,CASE WHEN (LatestMember.rwEffectiveDate = mbr.RwEffectiveDate) then 1 else 0 end as IsActiveMember									
		, mbr.DOB							AS DOB				  	   
		,mbr.LastName						AS MEMB_LAST_NAME		    
		,mbr.MiddleName						AS MEMB_MIDDLE_INITIAL	    
		,mbr.FirstName					AS MEMB_FIRST_NAME	    
		,  mbr.MedicaidID								AS MEDICAID_NO
		, ''								  AS MEDICARE_NO
		,mbr.Gender						AS GENDER			    
		,mbr.MemberHomeZip						  	AS MEMB_ZIP			    
		,mbr.ClientKey									AS COMPANY_CODE
		,mbr.SubgrpName									AS LINE_OF_BUSINESS_DESC
		,'adw.vw_Dashboard_Membership' AS SrcAdiTableName
		, mbr.ClientMemberKey	AS SrcAdiKey
		, GetDate()							AS LoadDate
		-- implicit: CreatedDate, CreatedBy, LastUpdatedDate, LastUpdatedBy
	   FROM adw.vw_Dashboard_Membership mbr
    JOIN (SELECT m.ClientKey, m.ClientMemberKey, Max(m.RwEffectiveDate) rwEffectiveDate
  FROM adw.vw_Dashboard_Membership m
  GROUP BY m.clientKey, m.ClientMemberKey) LatestMember
  ON mbr.ClientKey = LatestMember.ClientKey
AND mbr.ClientMemberKey = LatestMember.ClientMemberKey
AND mbr.RwEffectiveDate = LatestMember.rwEffectiveDate	;

	SELECT @OutCnt = COUNT(*) FROM #OutputTbl; 
	SET @ActionStart = GETDATE();    
	SET @JobStatus =2  -- complete
    
	EXEC amd.sp_AceEtlAudit_Close 
        @AuditId = @AuditID
        , @ActionStopTime = @ActionStart
        , @SourceCount = @InpCnt		  
        , @DestinationCount = @OutCnt
        , @ErrorCount = @ErrCnt
        , @JobStatus = @JobStatus
	   ;
