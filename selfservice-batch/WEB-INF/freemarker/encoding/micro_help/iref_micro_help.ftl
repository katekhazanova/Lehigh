


<div class="helpWizard" >
	<span class="wizard1">
		<button id="defaultMicroHelp" name="defaultMicroHelp" autofocus type="button" class="btn btn-microHelp btn-xs" onfocus="setVisibility('iref_defaultHelp','inline')" onBlur="setVisibility('iref_defaultHelp','none')" onclick="setVisibility('iref_defaultHelp','inline'); document.getElementById('defaultMicroHelp').focus();">
			<i class="fa fa-lightbulb-o"></i>
		</button>
		
	</span>
	
	<span id="iref_defaultHelp" style="display: none;">
		<span style="font-style: italic;">Putting your cursor in a field will display the microhelp for that field. The formatting is as follows:</span> DATABASE NAME: Description of the field. (max # of characters) 
	</span>
	
	<span id="iref_sourceidHelp" style="display: none;">
		SOURCE_ID: Unique code to identify this institution. Should match the type of code selected in the InstIDQ field. (8 characters)
	</span>
	
	<span id="iref_sourcecdHelp" style="display: none;">
		SOURCE_CD: Optional value to identify a necessary subset of this institution. Generally not used for source institutions. (3 characters)
	</span>
	
	<span id="iref_inameHelp" style="display: none;">
		INAME: Field used to label the institution identified by the InstID/InstCD combination. (60 characters)
	</span>
	
	<span id="iref_mrfytHelp" style="display: none;">
		FYT: Courses before this date will not match this table. (6 characters)
	</span>
	
	<span id="iref_lytHelp" style="display: none;">
		LYT: Courses beyond this date will not match this table. (6 characters)
	</span>
	
	<span id="iref_rpinstidHelp" style="display: none;">
		RPTINSTID: Label used to identify courses from this institution on the audit. (8 characters)
	</span>
	
	<span id="iref_refonlyHelp" style="display: none;">
		REFONLY: When checked, all rules from this institution, including the TA tables, are defined using the specified default IREF. Only the School Name and Report InstID will come from this table. 
	</span>
	
	<span id="iref_grdcaseHelp" style="display: none;">
		GRDCASE: The required letter case of course grades for this institution. 
	</span>
	
	<span id="iref_grdreqHelp" style="display: none;">
		GRDREQ: When checked, a grade is required when manually entering courses. 
	</span>
	
	<span id="iref_statusHelp" style="display: none;">
		STATUS: Check this box to hide this table from Transferology and Reference Audits. 
	</span>
	
	<span id="iref_sourceidqHelp" style="display: none;">
		INSTIDQ: Coding scheme used for this source institution. Defaults to the InstIDQ used for the Home IREF Table. Don't change unless intentionally different for Transferology. 
	</span>
	
	<span id="iref_dinstidHelp" style="display: none;">
		DINSTID: Identifies a default or additional set of values to be used in evaluating courses. (8 characters)
	</span>
	
	<span id="iref_dinstcdHelp" style="display: none;">
		DINSTCD: Not commonly used for transfer schools. Can be used to identify a subset of the institution set in the Default IREF Table InstID. (3 characters)
	</span>
	
	<span id="iref_tainstidHelp" style="display: none;">
		TAINSTID: Identifies a default set of transfer articulation rules. If populated, rules will come from this transfer articulation table only.(8 characters)
	</span>
	
	<span id="iref_tainstcdHelp" style="display: none;">
		TAINSTCD: Not commonly used for transfer schools. Can be used to identify a subset of the institution set in the Default TA Table InstID. (3 characters)
	</span>
	
	<span id="iref_crsmaskHelp" style="display: none;">
		CRSMASK: Special characters used to identify valid entries for department and course numbers. (15 characters)
	</span>
	
	<span id="iref_crscaseHelp" style="display: none;">
		CRSCASE: The required letter case used to enter courses.
	</span>
	
	<span id="iref_deptbgnHelp" style="display: none;">
		DEPTBGN: The literal position (ex. 1, 2, or 3) in which the course department should begin. (2 digits)
	</span>
	
	<span id="iref_deptendHelp" style="display: none;">
		DEPTEND: The literal position in which the course department should end. (2 digits)
	</span>
	
	<span id="iref_crsbgnHelp" style="display: none;">
		CRSBGN: The literal position (ex. 1, 2, or 3) in which the course number should begin. (2 digits)
	</span>
	
	<span id="iref_crsendHelp" style="display: none;">
		CRSEND: The literal position in which the course number should end. (2 digits)
	</span>
	
	<span id="iref_baccHelp" style="display: none;">
		BACC: Generally identifies when an institution primarily recommends credit by alternate methods. 
	</span>
	
	<span id="iref_actcHelp" style="display: none;">
		ACTC: Defines the type of credit offered by this institution. 
	</span>
	
	<span id="iref_unitscaleHelp" style="display: none;">
		UNITSCALE: Defines number of credit hours granted per single unit from this institution; enabled only when "U-Unit Credit" is selected in Credit Type. (6 digits)
	</span>
	
	<span id="iref_refucond1Help" style="display: none;">
		REFUCOND1: Universal condition code to be assigned to every course from this institution. (3 characters)
	</span>
	
	<span id="iref_refucond2Help" style="display: none;">
		REFUCOND2: Universal condition code to be assigned to every course from this institution. (3 characters)
	</span>
	
	<span id="iref_refucond3Help" style="display: none;">
		REFUCOND3: Universal condition code to be assigned to every course from this institution. (3 characters)
	</span>
	
	<span id="iref_cscaleHelp" style="display: none;">
		CSCALE: Defines the decimal precision used in processing credit from a transfer institution. 
	</span>
	
	<span id="iref_cassignHelp" style="display: none;">
		CASSIGN: Defines how excess credit should be rounded or truncated. 
	</span>
	
	<span id="iref_cexcessHelp" style="display: none;">
		CEXCESS: Determines how to handle leftover articulation credit if articulation results in excess credit. 
	</span>
	
	<span id="iref_cfinalHelp" style="display: none;">
		CFINAL: How to treat the accumulated excess articulation credit for the last evaluation group for an institution. 
	</span>
	
	<span id="iref_dcourseHelp" style="display: none;">
		DCOURSE: If desired, the literal course created to contain the excess credit. (15 characters)
	</span>
	
	<span id="iref_dpflgHelp" style="display: none;">
		DPFLG: Check this to indicate the Default Course is actually a pseudo course. 
	</span>
	
	<span id="iref_gpascaleHelp" style="display: none;">
		GPASCALE: Determines the placement of the decimal point when reporting a GPA. 
	</span>
	
	<span id="iref_dgradeHelp" style="display: none;">
		DGRADE: The default grade to use when two or more passed courses with different grades combine. (4 characters)
	</span>
	
	<span id="iref_d0gradeHelp" style="display: none;">
		D0GRADE: The default grade to use when two or more non-passed courses with different grades combine. (4 characters)
	</span>
	
	<span id="iref_gparuleHelp" style="display: none;">
		GPARULE: The field instructs u.achieve when to follow an unlike GPA assignment rule. 
	</span>
	
	<span id="iref_gruleHelp" style="display: none;">
		GRULE: Defines the value to be used when courses with different grades combine. 
	</span>
	
	<span id="iref_ltypeHelp" style="display: none;">
		LTYPE: Line entry type (choose one). 
	</span>
	
	<span id="iref_i2uflgHelp" style="display: none;">
		I2UFLG: Verifies that information is coming from a transfer institution to be used by the home institution. 
	</span>
	
	<span id="iref_gradeHelp" style="display: none;">
		GRADE: Value corresponding with the selected Type; represents either a grade or a flag assigned to a course. (4 characters)
	</span>
	
	<span id="iref_acHelp" style="display: none;">
		AC: Test for a course with this condition code in addition to the incoming grade value for a source course for this line to be processed. (1 character)
	</span>
	
	<span id="iref_rcHelp" style="display: none;">
		RC: Test for a course with this condition code, in addition to the incoming grade value for a source course, for this line to not be processed. (1 character)
	</span>
	
	<span id="iref_u2iflgHelp" style="display: none;">
		U2IFLG: Value in the Univ Grade field coming in to be evaluated for use by the home institution. 
	</span>
	
	<span id="iref_ugradeHomeHelp" style="display: none;">
		UGRADE: The key matching value that is either a universal grade or a universal condition code to be evaluated on this line. (4 characters)
	</span>
	
	<span id="iref_ugradeSourceHelp" style="display: none;">
		UGRADE: Universal grade assigned to the incoming source grade. (4 characters)
	</span>
	
	<span id="iref_acuHelp" style="display: none;">
		ACU: Test for Universal Condition Code that is matched on this course in addition to the universal grade. (3 characters)
	</span>
	
	<span id="iref_rcuHelp" style="display: none;">
		RCU: Test for Universal Condition Code that, if matched in addition to the universal grade, will prevent the course from matching this line. (3 characters)
	</span>
	
	<span id="iref_gpaptHelp" style="display: none;">
		GPAPT: Grade point value per credit unit. (10 characters, precision 5)
	</span>
	
	<span id="iref_gpacalHelp" style="display: none;">
		GPACAL: Determines whether this course counts in the GPA calculation. 
	</span>
	
	<span id="iref_addcrHelp" style="display: none;">
		ADDCR: Course credit control; controls whether this course will be assigned any earned credit. 
	</span>
	
	<span id="iref_addctHomeHelp" style="display: none;">
		ADDCT: Indicates a course as counting as a completed course that can satisfy an audit requirement. 
	</span>
	
	<span id="iref_addctSourceHelp" style="display: none;">
		ADDCT: Generally indicates whether a course with this line's grade is acceptable or not. Courses with the same add count value may be allowed to combine.
	</span>
	
	<span id="iref_cond1Help" style="display: none;">
		COND1: Assigns Course Condition Code. (1 character)
	</span>
	
	<span id="iref_cond2Help" style="display: none;">
		COND2: Assigns Course Condition Code. (1 character)
	</span>
	
	<span id="iref_ucond1Help" style="display: none;">
		UCOND1: Assigns Universal Course Condition Code for use in the transfer articulation process. (3 characters)
	</span>
	
	<span id="iref_ucond2Help" style="display: none;">
		UCOND2: Assigns Universal Course Condition Code for use in the transfer articulation process. (3 characters)
	</span>
	
	<span id="iref_effdteHelp" style="display: none;">
		EFFDTE: Course must match this date range in addition to other values to match this line (Format: YYYYTT-YYYYTT). (12 characters)
	</span>
	
	<span id="iref_address1Help" style="display: none;">
		ADDRESS1: Street Address. (35 characters)
	</span>
	
	<span id="iref_address2Help" style="display: none;">
		ADDRESS2: Street Address. (35 characters)
	</span>
	
	<span id="iref_cityHelp" style="display: none;">
		CITY: City. (30 characters)
	</span>
	
	<span id="iref_stateHelp" style="display: none;">
		STATE: State. (2 characters)
	</span>
	
	<span id="iref_zipHelp" style="display: none;">
		ZIP: Zip Code. (10 characters)
	</span>
	
	<span id="iref_countryHelp" style="display: none;">
		COUNTRY: Country. (3 characters)
	</span>
	
	<span id="iref_locationqHelp" style="display: none;">
		LOCATIONQ: Location qualifier; corresponds to the Location ID. 
	</span>
	
	<span id="iref_locationidHelp" style="display: none;">
		LOCATIONID: Location ID; corresponds to the Location Qualifier. (25 characters)
	</span>
	
	<span id="iref_contactcdHelp" style="display: none;">
		CONTACTCD: Code identifying the major duty or responsibility of the person/group named as the contact. 
	</span>
	
	<span id="iref_contactnameHelp" style="display: none;">
		CONTACTNAME: Contact name. (35 characters)
	</span>
	
	<span id="iref_commnoqHelp" style="display: none;">
		COMMNOQ: Preferred communication method. 
	</span>
	
	<span id="iref_faxHelp" style="display: none;">
		FAX: Fax number. (25 characters)
	</span>
	
	<span id="iref_phoneHelp" style="display: none;">
		PHONE: Phone number. (25 characters)
	</span>
	
	<span id="iref_emailHelp" style="display: none;">
		E_MAIL: Email address. (80 characters)
	</span>
	
	<span id="iref_addressmemoHelp" style="display: none;">
		MEMO: Comments. (255 characters)
	</span>

</div> 