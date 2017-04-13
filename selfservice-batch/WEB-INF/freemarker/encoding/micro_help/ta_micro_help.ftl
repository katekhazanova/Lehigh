<div class="helpWizard" >
	<span class="wizard1">
		<button id="defaultMicroHelp" name="defaultMicroHelp" autofocus type="button" class="btn btn-microHelp btn-xs" onfocus="setVisibility('ta_defaultHelp','inline')" onBlur="setVisibility('ta_defaultHelp','none')" onclick="setVisibility('ta_defaultHelp','inline'); document.getElementById('defaultMicroHelp').focus();">
			<i class="fa fa-lightbulb-o"></i>
		</button>
	</span>
	
	<span id="ta_defaultHelp" style="display: none;">
		<span style="font-style: italic;">Putting your cursor in a field will display the microhelp for that field. The formatting is as follows:</span> DATABASE NAME: Description of the field. (max # of characters) 
	</span>
	
	<span id="ta_inameHelp" style="display: none;">
		INAME: Field used to label the institution identified by the InstID/InstCD combination. (60 characters)
	</span>
	
	<span id="ta_sourceidHelp" style="display: none;">
		SOURCE_ID: Unique code to identify this institution. (8 characters)
	</span>

	<span id="ta_tastatus1Help" style="display: none;">
		TASTATUS: Check this box to hide the table from Transferology and reference audits. 
	</span>
	
	<span id="ta_tastatus2Help" style="display: none;">
		TASTATUS: Check this box to hide this rule from Transferology and reference audits. 
	</span>
	
	<span id="ta_tastatus3Help" style="display: none;">
		TASTATUS: Check this box to hide this target course from Transferology and reference audits. 
	</span>

	<span id="ta_sourcecdHelp" style="display: none;">
		SOURCE_CD: Optional value to identify a necessary subset of this institution. Generally not used for source institutions. (3 characters)
	</span>

	<span id="ta_dpmaskHelp" style="display: none;">
		DPMASK: Arbitrary field that enables different articulations for different degree programs. (15 characters)
	</span>

	<span id="ta_fytHelp" style="display: none;">
		FYT: Courses beyond this date will not match this table. (6 characters)
	</span>

	<span id="ta_lytHelp" style="display: none;">
		LYT: Courses beyond this date will not match this table. (6 characters)
	</span>

	<span id="ta_dinstidHelp" style="display: none;">
		DINSTID: If needed, points to articulation table for use in any articulations not accomplished here. (8 characters)
	</span>

	<span id="ta_dinstcdHelp" style="display: none;">
		DINSTCD: Not commonly used for transfer schools. Can be used to identify a subset of the institution set in the Default InstID. (3 characters)
	</span>

	<span id="ta_univdpmaskHelp" style="display: none;">
		UNIV_DPMASK: Completes the articulation process using the universal tables; enable the primary institution's TA tables to be used for remaining articulation. 
	</span>

	<span id="ta_memoHelp" style="display: none;">
		MEMO: Documentation for internal use only; comment here regarding changes made. (256 characters)
	</span>

	<span id="ta_tsegHelp" style="display: none;">
		TSEG: Arbitrary label assigned to categorize a group of TA rules. (7 characters)
	</span>

	<span id="ta_tseghintHelp" style="display: none;">
		TSegHint: Short hint that describes the segment; an arbitrary explanation of segment content. (25 characters)
	</span>

	<span id="ta_tsegdescHelp" style="display: none;">
		DESCRIPTION: Long definition of the segment; an internal working area for further description and notes. (255 characters)
	</span>
	
	<span id="ta_rulenumHelp" style="display: none;">
		INT_SEQ_NO: Internal sequence number of this rule. Identifies the order of this rule within it's segment. (9 characters)
	</span>

	<span id="ta_condHelp" style="display: none;">
		COND: Code used to put a universal condition code on the articulated course for this particular rule. (1 characters)
	</span>

	<span id="ta_limctHelp" style="display: none;">
		LIMCT: Minimum number of passed source courses required. (2 characters)
	</span>

	<span id="ta_limhrsHelp" style="display: none;">
		LIMHRS: Minimum number of summed credits for all source courses if all are not required for the articulation. (10 characters, precision 5)
	</span>

	<span id="ta_ctlcdHelp" style="display: none;">
		CTLCD: Special processing code control enabling differing uses of the COM field. (2 characters)
	</span>

	<span id="ta_acHelp" style="display: none;">
		AC: Condition code for the source course . (1 characters)
	</span>

	<span id="ta_rcHelp" style="display: none;">
		RC: Courses carrying this condition code are not allowed to meet this rule. (1 characters)
	</span>

	<span id="ta_publicmemoHelp" style="display: none;">
		MEMO: Intended for Transferology display; cannot be suppressed. (255 characters)
	</span>

	<span id="ta_privatenoteHelp" style="display: none;">
		TCA_RULE_PRIVATE_NOTE: Internal use notes hidden from Transferology. (255 characters)
	</span>

	<span id="ta_sourcecourseHelp" style="display: none;">
		COURSE: Incoming transfer course. Use the backslash "\" to have Self-Service auto-format the course to fit the department begin/end on save. (15 characters)
	</span>

	<span id="ta_sourcepflgHelp" style="display: none;">
		PFLG: Used to designate that the incoming source course is a pseudo or to enable non-default processing. 
	</span>

	<span id="ta_sourcectitleHelp" style="display: none;">
		CTITLE: Title of the source course, if needed. (29 characters)
	</span>

	<span id="ta_sourcetflgHelp" style="display: none;">
		TFLG: If checked, the title to be matched prior to articulation; if not checked, the title will not affect articulation. 
	</span>

	<span id="ta_sourcelimhrsHelp" style="display: none;">
		LIMHRS: Minimum number of articulated home/target hours the course must carry to match this rule. (5 characters)
	</span>

	<span id="ta_sourceacHelp" style="display: none;">
		AC: Course condition code this source course must have to meet this rule. (1 characters)
	</span>

	<span id="ta_sourcercHelp" style="display: none;">
		RC: Course condition code that this course course cannot have to meet this rule. (1 characters)
	</span>

	<span id="ta_effdteHelp" style="display: none;">
		EFFDTE: Date within which this course must have been taken to meet this rule. (12 characters)
	</span>

	<span id="ta_targetcourseHelp" style="display: none;">
		COURSE: Home (AKA Target) course created when this articulation occurs. Use the backslash "\" to have Self-Service auto-format the course to fit the department begin/end on save. (15 characters)
	</span>

	<span id="ta_targetpflgHelp" style="display: none;">
		PFLG: Used to designate that the course created is a pseudo or to accomplish other articulation processes. 
	</span>

	<span id="ta_targetctitleHelp" style="display: none;">
		CTITLE: Optional title line for the articulated course created. (29 characters)
	</span>

	<span id="ta_targetlimhrsHelp" style="display: none;">
		LIMHRS: Specifies non-default credit hours awarded to the created course. (5 characters)
	</span>

	<span id="ta_forcehrsHelp" style="display: none;">
		FORCEHRS: If checked, the hours placed in target hours field will be assigned to the created course; used to assign hours differently than the default. 
	</span>

	<span id="ta_acourse1Help" style="display: none;">
		ACOURSE1: Alternate course identity; additional course value for use in matching in the audit for this specific target course. (15 characters)
	</span>

	<span id="ta_apflg1Help" style="display: none;">
		APPFLG1: Pseudo course identifier. If checked, designates this course as a pseudo course. 
	</span>

	<span id="ta_hideacourse1Help" style="display: none;">
		HIDE_ACOURSE1: Check this box to hide this course from Transferology and reference audits. 
	</span>

	<span id="ta_acourse2Help" style="display: none;">
		ACOURSE2: Alternate course identity; additional course value for use in matching in the audit for this specific target course. (15 characters)
	</span>

	<span id="ta_apflg2Help" style="display: none;">
		APPFLG2: Pseudo course identifier. If checked, designates this course as a pseudo course. 
	</span>

	<span id="ta_hideacourse2Help" style="display: none;">
		HIDE_ACOURSE2: Check this box to hide this course from Transferology and reference audits. 
	</span>

	<span id="ta_acourse3Help" style="display: none;">
		ACOURSE3: Alternate course identity; additional course value for use in matching in the audit for this specific target course. (15 characters)
	</span>

	<span id="ta_apflg3Help" style="display: none;">
		APPFLG3: Pseudo course identifier. If checked, designates this course as a pseudo course. 
	</span>

	<span id="ta_hideacourse3Help" style="display: none;">
		HIDE_ACOURSE3: Check this box to hide this course from Transferology and reference audits.
	</span>

	<span id="ta_iflg1Help" style="display: none;">
		IFLG1: Institutional course flag to assign to this specific target course. (3 characters)
	</span>

	<span id="ta_iflg2Help" style="display: none;">
		IFLG2: Institutional course flag to assign to this specific target course. (3 characters)
	</span>

	<span id="ta_iflg3Help" style="display: none;">
		IFLG3: Institutional course flag to assign to this specific target course. (3 characters)
	</span>

	<span id="ta_iflg4Help" style="display: none;">
		IFLG4: Institutional course flag to assign to this specific target course. (3 characters)
	</span>

	<span id="ta_iflg5Help" style="display: none;">
		IFLG5: Institutional course flag to assign to this specific target course. (3 characters)
	</span>

	<span id="ta_hideiflgsHelp" style="display: none;">
		HIDE_IFLGS: Hide all five iflags from Transferology and reference audits.
	</span>

	<span id="ta_targetcondHelp" style="display: none;">
		COND: Course condition code assigned to this specific articulated course. (1 characters)
	</span>

</div>