$j(document).ready(function() {	
	/*input validation listeners */
	$j('#rules :input').change(function() {
		ruleChanges = true;
	});
	
	/*Making TA tables sortable */
	if($j('#disableTAInputs').val() == "true"){
		$j('input').prop('disabled',true);
		$j('textarea').prop('disabled',true);
		$j('select').prop('disabled',true);
		
		//enable navigation inputs		
		$j('#segment-dd').prop('disabled',false);
	}
	else{
		$j( "#sortableRules" ).ariaSortable({
			stop: function (event, ui) {
				updateTaNumbers($j(this),'ruleRow-');
			}
		}).bind( "ariasortablesorted", function( event, data ) {
			updateTaNumbers($j(this),'ruleRow-');
		});
		
		$j( "#sortableSource" ).ariaSortable({
			stop: function (event, ui) {
				
				$j(this).data().uiSortable.currentItem.find(".last_mod_user").val("");
				$j(this).data().uiSortable.currentItem.find(".last_mod_date").val("");
				updateTaNumbers($j(this),'sourceRow-');
			}
		}).bind( "ariasortablesorted", function( event, data ) {
			
			updateTaNumbers($j(this),'sourceRow-');
		});
		
		$j( "#sortableTarget" ).ariaSortable({
			stop: function (event, ui) {
				
				$j(this).data().uiSortable.currentItem.find(".last_mod_user").val("");
				$j(this).data().uiSortable.currentItem.find(".last_mod_date").val("");
				updateTaNumbers($j(this),'targetRow-');
				$j(this).find('[data-toggle="popover"]').popover('hide');
			}
		}).bind( "ariasortablesorted", function( event, data ) {
			
			updateTaNumbers($j(this),'targetRow-');
			$j(this).find('[data-toggle="popover"]').popover('hide');
		});
	}

	/* Modal Listeners */
	createModalListeners();
	
	validateSourceCourses();
	validateTargetCourses();
}); 

function rotateChevron(chevronId){
		 $j("#"+chevronId).toggleClass("fa-chevron-down fa-chevron-right");
}

function changeSegment() {
	taChangesConfirmed = true;
	
	ta.persist = false;
	
	if(taChanges){
		saveTa();
	}
	else{
		redirectTaUrl();
	}
}

function addRule(){
	taChangesConfirmed = true;
	
	ta.redirect = "add";
	
	changeSegment();
}

function editRule(ruleId){
	taChangesConfirmed = true;
	
	ta.redirect = "edit";
	ta.ruleId = ruleId;
	
	changeSegment();
}

function updateTaNumbers($jlist,rowId) {
	$jlist.find('tr').each(function (idx) {
		var row = idx+1;
		$j(this).find('.userSeqNo').text(row);
		if(rowId != null){
			$j(this).attr('id',rowId+row);
		}
		
		if($j(this).find('.selectedRuleText').length){
			$j('#rule-userSeqNo').val(row);
			$j('#ruleLabel-number').text(row);
		}
    });
	$j('#ta-save').removeAttr("disabled");
	taChanges = true;
	ruleChanges = true;
}

function sortRules(){
	
	var intSeqNos = [];
	var tseg = $j("#segment-dd").val();;
	
	$j("#ta-rules tbody tr").each(function(i, row) {
		
		if($j(row).find('.selectedRuleText').length){
			
		}
		else{
			intSeqNos.push($j(row).find('.intSeqNo').val());
		}
		
	});
	
	$j.ajax({
		type: "POST",
		url: "sort-rules.html",
		traditional: true,
		data: {"intSeqNos": intSeqNos,"tseg": tseg},
		dataType: "json",
		success : function(json) {	
			 rulesSorted = true;
			 if(allTaChildrenSaved()){
				 ruleChanges = false;
				 saveTaTabs();
			 }
		},
		error : function(json) {
			 rulesSorted = true;
			 if(allTaChildrenSaved()){
				 ruleChanges = false;
				 saveTaTabs();
			 }
		}
	});
}

function saveSelectedRule() {
	var rule = new Object();
	loadSelectedRule(rule);
	$j.ajax({
		type: "POST",
		url: "save-rule.html",
		traditional: true,
		async: false,
		data: rule,
		 dataType: "json",
		 success : function(json) {	
			 selectedRuleSaved = true;
			 if(allTaChildrenSaved()){
				 ruleChanges = false;
				 saveTaTabs();
			 }
		 },
		 error : function(json) {
			 selectedRuleSaved = true;
			 if(allTaChildrenSaved()){
				 ruleChanges = false;
				 saveTaTabs();
			 }
		 }
	});
}

function loadSelectedRule(rule) {
	  rule.intSeqNo = $j('#rule-intSeqNo').val();
	  rule.userSeqNo = $j('#rule-userSeqNo').val();
	  rule.tseg = $j('#rule-segment').val();
	  rule.cond = $j('#rule-cond').val();
	  rule.limct = $j('#rule-limct').val();
	  rule.limhrs = $j('#rule-limhrs').val();
	  rule.ctlcd = $j('#rule-ctlcd').val();
	  rule.ac = $j('#rule-ac').val();
	  rule.rc = $j('#rule-rc').val();
	  rule.memo = $j('#rule-public_memo').val();
	  rule.privateNote = $j('#rule-private_note').val();	  
	  rule.lastModUser = $j('#rule_last_mod_user').val();
	  var lastModDate = convertToTimeStamp($j('#rule_last_mod_date').val());
	  
		if(lastModDate != ""){
			rule.lastModDate = lastModDate;
		}
		  
	  rule.tastatus = '';
	  if($j('#rule-tastatus').is(':checked')){
		  rule.tastatus = $j('#rule-tastatus').val();
	  }
}

function deleteSelectedRule() {
	
	//remove the rule from the rule list
	$j(".selectedRule").parent("tr").remove();
	$j("#rule-userSeqNo").val(-1);
	updateTaNumbers($j( "#sortableRules" ),'ruleRow-');
	
	changeSegment();
}

function moveSelectedRule(){
	
	taChanges = true;
	ruleChanges = true;
	
	ta.redirect = "edit";
	ta.ruleId = $j("#rule-intSeqNo").val();
	ta.editSeg = $j("#rule-segment").val();
	
	changeSegment();
}

function saveSourcesList() {
	//clear the existing sources before saving
	$j.ajax({
		type: "POST",
		url: "save-source.html",
		traditional: true,
		data: {"clear":"true"},
		dataType: "json",
		success : function(json) {	
			if(allTaChildrenSaved()){
				saveTaTabs();
			} else {
				saveSources();
			}
		},
		error : function(json) {
			if(allTaChildrenSaved()){
				saveTaTabs();
			} else {
				saveSources();
			}
		}
	});
}

function saveSources() {
	$j("#sourceList tbody tr").each(function(i, row) {
		var source = new Object();
		loadSource(source,row);
		if (source.course) {
			$j.ajax({
				type: "POST",
				async: false,
				url: "save-source.html",
				traditional: true,
				data: source,
				dataType: "json",
				success : function(json) {
					sourcesNotSaved--;
					if(allTaChildrenSaved()){
						saveTaTabs();
					}
				},
				error : function(json) {
					sourcesNotSaved--;
					if(allTaChildrenSaved()){
						saveTaTabs();
					}
				}
			});
		} 
		else {
			//dont save a source course if there is no course value
			sourcesNotSaved--;
			if(allTaChildrenSaved()){
				saveTaTabs();
			}
		}
	});
}

function loadSource(source,row) {
	source.intSeqNo = $j(row).find('.intSeqNo').val();
	source.userSeqNo = $j(row).find('.userSeqNo').text();
	source.course = $j(row).find('.course').val();
	source.pflg = $j(row).find('.pflg').val();
	source.ctitle = $j(row).find('.ctitle').val();
	source.limhrs = $j(row).find('.limhrs').val();
	source.ac = $j(row).find('.ac').val();
	source.rc = $j(row).find('.rc').val();
	var effdte = fix_effdte($j(row).find('.effdte').val());
	var effdte2 = fix_effdte($j(row).find('.effdte2').val());
	source.effdte = effdte + effdte2;
	source.lastModUser = $j(row).find('.last_mod_user').val();
	var lastModDate = convertToTimeStamp($j(row).find('.last_mod_date').val());
	source.tflg = '';
	
	if(lastModDate != ""){
		source.lastModDate = lastModDate;
	}
	
	if($j(row).find('.tflg').is(':checked')){
		source.tflg = $j(row).find('.tflg').val();
	}
}

function saveTargetsList() {
	//clear the existing targets before saving
	$j.ajax({
		type: "POST",
		url: "save-target.html",
		traditional: true,
		data: {"clear":"true"},
		dataType: "json",
		success : function(json) {
			if(allTaChildrenSaved()){
				saveTaTabs();
			} else {
				saveTargets();
			}
		},
		error : function(json) {
			if(allTaChildrenSaved()){
				saveTaTabs();
			} else {
				saveTargets();
			}
		}
	});
}

function saveTargets() {
	$j("#targetList tbody tr").each(function(i, row) {
		var target = new Object();
		loadTarget(target,row);
		if (target.course) {
			$j.ajax({
				type: "POST",
				async: false,
				url: "save-target.html",
				traditional: true,
				data: target,
				dataType: "json",
				success : function(json) {
					targetsNotSaved--;
					if(allTaChildrenSaved()){
						saveTaTabs();
					}
				},
				error : function(json) {
					targetsNotSaved--;
					if(allTaChildrenSaved()){
						saveTaTabs();
					}
				}
			});
		} else {
			//dont save a target course if there is no course value
			targetsNotSaved--;
			if(allTaChildrenSaved()){
				saveTaTabs();
			}
		}
	});
}

function loadTarget(target,row) {
	target.intSeqNo = $j(row).find('.intSeqNo').val();
	target.userSeqNo = $j(row).find('.userSeqNo').text();
	target.course = $j(row).find('.course').val();
	target.pflg = $j(row).find('.pflg').val();
	target.ctitle = $j(row).find('.ctitle').val();
	target.limhrs = $j(row).find('.limhrs').val();
	target.cond = $j(row).find('.cond').val();
	target.lastModUser = $j(row).find('.last_mod_user').val();
	var lastModDate = convertToTimeStamp($j(row).find('.last_mod_date').val());
	
	if(lastModDate != ""){
		target.lastModDate = lastModDate;
	}
	
	if($j(row).find('.iflg1').val().trim() != ''){
		target.iflg1 = $j(row).find('.iflg1').val();
	}
	if($j(row).find('.iflg2').val().trim() != ''){
		target.iflg2 = $j(row).find('.iflg2').val();
	}
	if($j(row).find('.iflg3').val().trim() != ''){
		target.iflg3 = $j(row).find('.iflg3').val();
	}
	if($j(row).find('.iflg4').val().trim() != ''){
		target.iflg4 = $j(row).find('.iflg4').val();
	}
	if($j(row).find('.iflg5').val().trim() != ''){
		target.iflg5 = $j(row).find('.iflg5').val();
	}
	
	target.acourse1 = $j(row).find('.acourse1').val();
	target.acourse2 = $j(row).find('.acourse2').val();
	target.acourse3 = $j(row).find('.acourse3').val();
	target.hideIflgs = '';
	if($j(row).find('.hideIflgs').is(':checked')){
		target.hideIflgs = $j(row).find('.hideIflgs').val();
	}
	target.apflg1 = '';
	if($j(row).find('.apflg1').is(':checked')){
		target.apflg1 = $j(row).find('.apflg1').val();
	}
	target.apflg2 = '';
	if($j(row).find('.apflg2').is(':checked')){
		target.apflg2 = $j(row).find('.apflg2').val();
	}
	target.apflg3 = '';
	if($j(row).find('.apflg3').is(':checked')){
		target.apflg3 = $j(row).find('.apflg3').val();
	}
	target.hideAcourse1 = '';
	if($j(row).find('.hide_acourse1').is(':checked')){
		target.hideAcourse1 = $j(row).find('.hide_acourse1').val();
	}
	target.hideAcourse2 = '';
	if($j(row).find('.hide_acourse2').is(':checked')){
		target.hideAcourse2 = $j(row).find('.hide_acourse2').val();
	}
	target.hideAcourse3 = '';
	if($j(row).find('.hide_acourse3').is(':checked')){
		target.hideAcourse3 = $j(row).find('.hide_acourse3').val();
	}
	target.forcehrs = '';
	if($j(row).find('.forcehrs').is(':checked')){
		target.forcehrs = $j(row).find('.forcehrs').val();
	}
	target.tastatus = '';
	if($j(row).find('.tastatus').is(':checked')){
		target.tastatus = $j(row).find('.tastatus').val();
	}
}

function addSourceRow() {
	var insertSource = $j('#insertSource').val();
	if(insertSource >= $j('#sourceList tbody tr').length +1){
		insertSource = $j('#sourceList tbody tr').length +1;
	}
    var row = $j('<tr id="sourceRow-' + insertSource + '" class="ui-state-default"></tr>');
    var move = $j('<td class="move aligncenter"><i class="fa fa-bars"><span class="sr-only">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i></td>');
    var number = $j('<td class="userSeqNo aligncenter">' + insertSource + '</td>');
    var course = $j('<td class="aligncenter"><div class="form-group has-feedback" style="margin-bottom: 0px;"><input type="text" class="course" name="course monoCourse" maxlength="15" style="width: 135px;" onfocus="setVisibility(\'ta_sourcecourseHelp\',\'inline\')" onBlur="setVisibility(\'ta_sourcecourseHelp\',\'none\')"><span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;display:none;"><i class="fa fa-exclamation-triangle"></i></span><span class="sourceCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask. May be intentional - articulation still valid.</span></div></td>');
    var pflg = $j('<td class="aligncenter"><select class="pflg" name="pflg" style="width: 38px;" onfocus="setVisibility(\'ta_sourcepflgHelp\',\'inline\')" onBlur="setVisibility(\'ta_sourcepflgHelp\',\'none\')">' +
    		'<option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspDefault </option>' + 
			'<option value="P">P &nbsp; &nbsp; Pseudo Course</option>' +
			'<option value="R">R &nbsp; &nbsp; Required</option>' +
			'<option value=":">: &nbsp; &nbsp; Course Range</option>' +
			'<option value="1">1 &nbsp; &nbsp; 1 Additional Match</option>' +
			'<option value="2">2 &nbsp; &nbsp; 2 Additional Matches</option>' +
			'<option value="3">3 &nbsp; &nbsp; 3 Additional Matches</option>' +
			'<option value="4">4 &nbsp; &nbsp; 4 Additional Matches</option>' +
			'<option value="5">5 &nbsp; &nbsp; 5 Additional Matches</option>' +
			'<option value="6">6 &nbsp; &nbsp; 6 Additional Matches</option>' +
			'<option value="7">7 &nbsp; &nbsp; 7 Additional Matches</option>' +
			'<option value="8">8 &nbsp; &nbsp; 8 Additional Matches</option>' +
			'<option value="9">9 &nbsp; &nbsp; 9 Additional Matches</option>' +
			'</select></td>');
    var ctitle = $j('<td class="aligncenter"><input type="text" class="ctitle" name="ctitle" maxlength="29" style="width: 235px;" onfocus="setVisibility(\'ta_sourcectitleHelp\',\'inline\')" onBlur="setVisibility(\'ta_sourcectitleHelp\',\'none\')"></td>');
    var tflg = $j('<td class="aligncenter"><input type="checkbox" class="tflg" name="tflg" value="-" onfocus="setVisibility(\'ta_sourcetflgHelp\',\'inline\')" onBlur="setVisibility(\'ta_sourcetflgHelp\',\'none\')"></td>');
    var limhrs = $j('<td class="aligncenter"><input type="text" class="limhrs" name="limhrs" maxlength="5" style="width: 42px;" onfocus="setVisibility(\'ta_sourcelimhrsHelp\',\'inline\')" onBlur="setVisibility(\'ta_sourcelimhrsHelp\',\'none\')"></td>');
    var ac = $j('<td class="aligncenter"><input type="text" class="ac" name="ac" maxlength="1" style="width: 25px;" onfocus="setVisibility(\'ta_sourceacHelp\',\'inline\')" onBlur="setVisibility(\'ta_sourceacHelp\',\'none\')"></td>');
    var rc = $j('<td class="aligncenter"><input type="text" class="rc" name="rc" maxlength="1" style="width: 25px;" onfocus="setVisibility(\'ta_sourcercHelp\',\'inline\')" onBlur="setVisibility(\'ta_sourcercHelp\',\'none\')"></td>');
    var effdte = $j('<td class="aligncenter"><input type="text" class="effdte" name="effdte" maxlength="6" style="width: 50px;" onfocus="setVisibility(\'ta_effdteHelp\',\'inline\')" onBlur="setVisibility(\'ta_effdteHelp\',\'none\')">&nbsp;-&nbsp;<input type="text" class="effdte2" name="effdte2" maxlength="6" style="width: 50px;" onfocus="setVisibility(\'ta_effdteHelp\',\'inline\')" onBlur="setVisibility(\'ta_effdteHelp\',\'none\')"></td>');
    var more = $j('<td class="aligncenter"><a href="#" class="btn btn-default btn-xs" onclick="popSourceCourseModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a>' +
    		'<input type="hidden" class="intSeqNo">' +
			'<input type="hidden" class="last_mod_date" name="last_mod_date">' +
			'<input type="hidden" class="last_mod_user" name="last_mod_user">' +
			'</td>');
    var deleteRow = $j('<td class="aligncenter"><button type="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,\'#sortableSource\',\'#insertSource\',\'sourceRow-\')" title="Delete Course"><i class="fa fa-trash-o"></i></button></td>');
    
    row.append(move);
    row.append(number);
    row.append(course);
    row.append(pflg);
    row.append(ctitle);
    row.append(tflg);
    row.append(limhrs);
    row.append(ac);
    row.append(rc);
    row.append(effdte);
    row.append(more);
    row.append(deleteRow);
    if(insertSource < $j('#sourceList tbody tr').length +1){
    	$j('#sourceRow-'+insertSource).before(row);
    	//reset the row numbers
    	 updateTaNumbers($j('#sortableSource'),"sourceRow-");
    } else {
    	 $j('#sourceList tbody').append(row);
		 $j('#ta-save').removeAttr("disabled");
		 taChanges = true;
		 ruleChanges = true;
    }
    $j( "#sortableSource" ).ariaSortable( 'newRow' ); 
    $j('#insertSource').val($j('#sourceList tbody tr').length +1);
    
    bindOnCourseField(row.find('.course'), 'source');
}

function addTargetRow() {
	var insertTarget = $j('#insertTarget').val();
	if(insertTarget >= $j('#targetList tbody tr').length +1){
		insertTarget = $j('#targetList tbody tr').length +1;
	}
    var row = $j('<tr id="targetRow-' + insertTarget + '" class="ui-state-default"></tr>');
    var move = $j('<td class="move aligncenter"><i class="fa fa-bars"><span class="sr-only">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i></td>'); 
    var number = $j('<td class="userSeqNo aligncenter">' + insertTarget + '</td>');
    var course = $j('<td class="aligncenter"><div class="form-group has-feedback" style="margin-bottom: 0px;"><input type="text" class="course monoCourse" name="course monoCourse" maxlength="15" style="width: 135px;" onfocus="setVisibility(\'ta_targetcourseHelp\',\'inline\')" onBlur="setVisibility(\'ta_targetcourseHelp\',\'none\')"><span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;display:none;"><i class="fa fa-exclamation-triangle"></i></span><span class="targetCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask. May be intentional - articulation still valid.</span></div></td>');
    var pflg = $j('<td class="aligncenter"><select class="pflg" name="pflg" style="width: 38px;" onfocus="setVisibility(\'ta_targetpflgHelp\',\'inline\')" onBlur="setVisibility(\'ta_targetpflgHelp\',\'none\')"><option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspDefault </option><option value="P">P &nbsp; &nbsp; Pseudo Course</option><option value="D">D &nbsp; &nbsp;Dummy Course</option><option value="X">X &nbsp; &nbsp; Dummy Pseudo Course</option><option value="Z">Z &nbsp; &nbsp; Eliminate residual credit/GPA</option></select></td>');
    var ctitle = $j('<td class="aligncenter"><input type="text" value="" class="ctitle" name="ctitle" maxlength="29" style="width: 235px;" onfocus="setVisibility(\'ta_targetctitleHelp\',\'inline\')" onBlur="setVisibility(\'ta_targetctitleHelp\',\'none\')"></td>');
    var limhrs = $j('<td class="aligncenter"><input type="text" value="" class="limhrs" name="limhrs" maxlength="5" style="width: 42px;" onfocus="setVisibility(\'ta_targetlimhrsHelp\',\'inline\')" onBlur="setVisibility(\'ta_targetlimhrsHelp\',\'none\')"></td>');
    var forcehrs = $j('<td class="aligncenter"><input type="checkbox" value="F" class="forcehrs" name="forcehrs" onfocus="setVisibility(\'ta_forcehrsHelp\',\'inline\')" onBlur="setVisibility(\'ta_forcehrsHelp\',\'none\')"></td>');
    var tastatus = $j('<td class="aligncenter"><input type="checkbox" value="H" class="tastatus" name="tastatus" onfocus="setVisibility(\'ta_tastatus3Help\',\'inline\')" onBlur="setVisibility(\'ta_tastatus3Help\',\'none\')"></td>');
    var targetAlt = $j('<td class="aligncenter"><a href="#" class="targetAlt btn btn-xs btn-info" rel="popover" data-html="true" data-placement="top" disabled="disabled" onclick="return false;"><i class="fa fa-list-ol"></i></a></td>');
    var targetFlag = $j('<td class="aligncenter"><a href="#" class="targetFlag btn btn-xs btn-info" rel="popover" data-html="true" data-placement="top" disabled="disabled" onclick="return false;"><i class="fa fa-flag"></i></a></td>');
    var more = $j('<td class="aligncenter"><a href="#" class="btn btn-default btn-xs" type="button" onclick="popTargetCourseModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a>' +
    		'<span style="display:none;"><input type="checkbox" class="apflg1" name="apflg1" value="P" /></span>' +
    		'<span style="display:none;"><input type="checkbox" class="apflg2" name="apflg2" value="P" /></span>' +
    		'<span style="display:none;"><input type="checkbox" class="apflg3" name="apflg3" value="P" /></span>' +
    		'<span style="display:none;"><input type="checkbox" class="hide_acourse1" name="hide_acourse1" value="P" /></span>' +
    		'<span style="display:none;"><input type="checkbox" class="hide_acourse2" name="hide_acourse2" value="P" /></span>' +
    		'<span style="display:none;"><input type="checkbox" class="hide_acourse3" name="hide_acourse3" value="P" /></span>' +
    		'<span style="display:none;"><input type="checkbox" class="hideIflgs" name="hideIflgs" value="P" /></span>' +
    		'<input type="hidden" class="intSeqNo">' +
    		'<input type="hidden" class="cond" name="cond" maxlength="1">' +
    		'<input type="hidden" class="iflg1" name="iflg1" maxlength="3">' +
    		'<input type="hidden" class="iflg2" name="iflg2" maxlength="3">' +
    		'<input type="hidden" class="iflg3" name="iflg3" maxlength="3">' +
    		'<input type="hidden" class="iflg4" name="iflg4" maxlength="3">' +
    		'<input type="hidden" class="iflg5" name="iflg5" maxlength="3">' +
    		'<input type="hidden" class="acourse1" name="acourse1" maxlength="15">' +
    		'<input type="hidden" class="acourse2" name="acourse2" maxlength="15">' +
    		'<input type="hidden" class="acourse3" name="acourse3" maxlength="15">' +
    		'<input type="hidden" class="last_mod_date" name="last_mod_date">' +
    		'<input type="hidden" class="last_mod_user" name="last_mod_user">' +
    		'</td>');
    var deleteRow = $j('<td class="aligncenter"><button type="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,\'#sortableTarget\',\'#insertTarget\',\'targetRow-\')" title="Delete Course"><i class="fa fa-trash-o"></i></button></td>');
       
    row.append(move);
    row.append(number);
    row.append(course);
    row.append(pflg);
    row.append(ctitle);
    row.append(limhrs);
    row.append(forcehrs);
    row.append(tastatus);
    row.append(targetAlt);
    row.append(targetFlag);
    row.append(more);
    row.append(deleteRow);
        if(insertTarget < $j('#target tr').length +1){
    	$j('#targetRow-'+insertTarget).before(row);
    	//reset the row numbers
    	 updateTaNumbers($j('#sortableTarget'),"targetRow-");
    } else {
    	 $j('#targetList tbody').append(row);   	 
		 $j('#ta-save').removeAttr("disabled");
		 taChanges = true;
		 ruleChanges = true;
    }
    $j( "#sortableTarget" ).ariaSortable( 'newRow' ); 
    $j('#insertTarget').val($j('#targetList tbody tr').length +1);
    bindOnCourseField(row.find('.course'), 'target');
}

function popSourceCourseModal(event) {
	
	event = $j.event.fix(event);
	var button = event.currentTarget;
	var row = $j(button).parents('tr');
	$j('#sourceCourseModal').data('id', $j(row).attr('id'));
	// get page form values
	var course = row.find('.course').val();
	var pflg = row.find('.pflg :selected').val();
	var ctitle = row.find('.ctitle').val();
	var tflg = false;
	if (row.find('.tflg').is(":checked")) {	
		tflg = true;
	}
	var limhrs = row.find('.limhrs').val();
	var ac = row.find('.ac').val();
	var rc = row.find('.rc').val();
	var effdte = row.find('.effdte').val();
	var effdte2 = row.find('.effdte2').val();
	var crsMsk = $j('#sourceCrsMsk').text();
	var last_mod_date = row.find('.last_mod_date').val();
	var last_mod_user = row.find('.last_mod_user').val();
	// set modal form values
	$j('#modal_source_course').val(course);
	$j('#modal_source_pflg').val(pflg);
	$j('#modal_source_ctitle').val(ctitle);
	if (tflg) {	
		$j('#modal_source_tflg').prop('checked', true);
	} else {
		$j('#modal_source_tflg').prop('checked', false);
	}
	$j('#modal_source_limhrs').val(limhrs);
	$j('#modal_source_ac').val(ac);
	$j('#modal_source_rc').val(rc);
	$j('#modal_source_effdte').val(effdte);
	$j('#modal_source_effdte2').val(effdte2);
	$j('#modal_source_last_mod_date').text(last_mod_date);
	$j('#modal_source_last_mod_user').text(last_mod_user);
	$j('#modal_source_crsMsk').text(crsMsk);
	checkModalCrs('source');
	$j('#source_save').removeAttr('disabled');
	$j('#sourceCourseModal').modal('show');
	return false;
}

function applySourceCourseModal() {
	// get modal form values
	var course = $j('#modal_source_course').val();
	var pflg = $j('#modal_source_pflg :selected').val();
	var ctitle = $j('#modal_source_ctitle').val();
	var tflg = false;
	if ($j('#modal_source_tflg').is(":checked")) {
		tflg = true;
	}
	var limhrs = $j('#modal_source_limhrs').val();
	var ac = $j('#modal_source_ac').val();
	var rc = $j('#modal_source_rc').val();
	var effdte = $j('#modal_source_effdte').val();
	var effdte2 = $j('#modal_source_effdte2').val();
	var last_mod_date = $j('#modal_source_last_mod_date').text();
	var last_mod_user= $j('#modal_source_last_mod_user').text();
	var id = $j('#sourceCourseModal').data('id');
	var row = $j('#' + id);
	
	// set page form values
	row.find('.course').val(course).css('color', $j('#modal_source_course').css('color'));
	row.find('.pflg').val(pflg);
	row.find('.ctitle').val(ctitle);
	if (tflg) {
		row.find('.tflg').prop('checked', true);
	} else {
		row.find('.tflg').prop('checked', false);	
	}	
	row.find('.limhrs').val(limhrs);
	row.find('.ac').val(ac);
	row.find('.rc').val(rc);
	row.find('.effdte').val(effdte);
	row.find('.effdte2').val(effdte2);
	row.find('.last_mod_date').val(last_mod_date);
	row.find('.last_mod_user').val(last_mod_user);
	
	$j('#sourceCourseModal').modal('hide');
	return false;
}

function popTargetCourseModal(event) {
	event = $j.event.fix(event);
	var button = event.currentTarget;
	var row = $j(button).parents('tr');
	$j('#targetCourseModal').data('id', $j(row).attr('id'));
	// get page form values
	var course = row.find('.course').val();
	var pflg = row.find('.pflg :selected').val();
	var ctitle = row.find('.ctitle').val();
	var limhrs = row.find('.limhrs').val();
	var cond = row.find('.cond').val();
	var iflg1 = row.find('.iflg1').val();
	var iflg2 = row.find('.iflg2').val();
	var iflg3 = row.find('.iflg3').val();
	var iflg4 = row.find('.iflg4').val();
	var iflg5 = row.find('.iflg5').val();
	var acourse1 = row.find('.acourse1').val();
	var acourse2 = row.find('.acourse2').val();
	var acourse3 = row.find('.acourse3').val();
	var hideIflgs = false;
	if (row.find('.hideIflgs').is(":checked")) {
		hideIflgs = true;
	}
	var apflg1 = false;
	if (row.find('.apflg1').is(":checked")) {
		apflg1 = true;
	}
	var apflg2 = false;
	if (row.find('.apflg2').is(":checked")) {	
		apflg2 = true;
	}
	var apflg3 = false;
	if (row.find('.apflg3').is(":checked")) {	
		apflg3 = true;
	}
	var hide_acourse1 = false;
	if (row.find('.hide_acourse1').is(":checked")) {	
		hide_acourse1 = true;
	}
	var hide_acourse2 = false;
	if (row.find('.hide_acourse2').is(":checked")) {	
		hide_acourse2 = true;
	}
	var hide_acourse3 = false;
	if (row.find('.hide_acourse3').is(":checked")) {	
		hide_acourse3 = true;
	}
	var last_mod_date = row.find('.last_mod_date').val();
	var last_mod_user = row.find('.last_mod_user').val();
	var forcehrs = false;
	if (row.find('.forcehrs').is(":checked")) {	
		forcehrs = true;
	}
	var tastatus = false;
	if (row.find('.tastatus').is(":checked")) {	
		tastatus = true;
	}
	var crsMsk = $j('#targetCrsMsk').text();
	// set modal form values
	$j('#modal_target_course').val(course);
	$j('#modal_target_pflg').val(pflg);
	$j('#modal_target_ctitle').val(ctitle);
	$j('#modal_target_limhrs').val(limhrs);
	$j('#modal_target_cond').val(cond);
	$j('#modal_target_iflg1').val(iflg1);
	$j('#modal_target_iflg2').val(iflg2);
	$j('#modal_target_iflg3').val(iflg3);
	$j('#modal_target_iflg4').val(iflg4);
	$j('#modal_target_iflg5').val(iflg5);
	$j('#modal_target_acourse1').val(acourse1);
	$j('#modal_target_acourse2').val(acourse2);
	$j('#modal_target_acourse3').val(acourse3);
	if (hideIflgs) {
		$j('#modal_target_hideIflgs').prop('checked', true);
	} else {
		$j('#modal_target_hideIflgs').prop('checked', false);
	}
	if (apflg1) {
		$j('#modal_target_apflg1').prop('checked', true);
	} else {
		$j('#modal_target_apflg1').prop('checked', false);
	}
	if (apflg2) {	
		$j('#modal_target_apflg2').prop('checked', true);
	} else {
		$j('#modal_target_apflg2').prop('checked', false);
	}
	if (apflg3) {	
		$j('#modal_target_apflg3').prop('checked', true);
	} else {
		$j('#modal_target_apflg3').prop('checked', false);
	}
	if (hide_acourse1) {	
		$j('#modal_target_hide_acourse1').prop('checked', true);
	} else {
		$j('#modal_target_hide_acourse1').prop('checked', false);
	}
	if (hide_acourse2) {	
		$j('#modal_target_hide_acourse2').prop('checked', true);
	} else {
		$j('#modal_target_hide_acourse2').prop('checked', false);
	}
	if (hide_acourse3) {	
		$j('#modal_target_hide_acourse3').prop('checked', true);
	} else {
		$j('#modal_target_hide_acourse3').prop('checked', false);
	}
	$j('#modal_target_last_mod_date').text(last_mod_date);
	$j('#modal_target_last_mod_user').text(last_mod_user);
	if (forcehrs) {	
		$j('#modal_target_forcehrs').prop('checked', true);
	} else {
		$j('#modal_target_forcehrs').prop('checked', false);
	}
	if (tastatus) {	
		$j('#modal_target_tastatus').prop('checked', true);
	} else {
		$j('#modal_target_tastatus').prop('checked', false);
	}
	$j('#modal_target_crsMsk').text(crsMsk);
	checkModalCrs('target');
	$j('#target_save').removeAttr('disabled');
	$j('#targetCourseModal').modal('show');
	return false;
}

function applyTargetCourseModal() {
	// get modal form values
	var course = $j('#modal_target_course').val();
	var pflg = $j('#modal_target_pflg :selected').val();
	var ctitle = $j('#modal_target_ctitle').val();
	var limhrs = $j('#modal_target_limhrs').val();
	var cond = $j('#modal_target_cond').val();
	var iflg1 = $j('#modal_target_iflg1').val();
	var iflg2 = $j('#modal_target_iflg2').val();
	var iflg3 = $j('#modal_target_iflg3').val();
	var iflg4 = $j('#modal_target_iflg4').val();
	var iflg5 = $j('#modal_target_iflg5').val();
	var acourse1 = $j('#modal_target_acourse1').val();
	var acourse2 = $j('#modal_target_acourse2').val();
	var acourse3 = $j('#modal_target_acourse3').val();
	var hideIflgs = false;
	if ($j('#modal_target_hideIflgs').is(":checked")) {
		hideIflgs = true;
	}
	var apflg1 = false;
	if ($j('#modal_target_apflg1').is(":checked")) {
		apflg1 = true;
	}
	var apflg2 = false;
	if ($j('#modal_target_apflg2').is(":checked")) {
		apflg2 = true;
	}
	var apflg3 = false;
	if ($j('#modal_target_apflg3').is(":checked")) {
		apflg3 = true;
	}
	var hide_acourse1 = false;
	if ($j('#modal_target_hide_acourse1').is(":checked")) {
		hide_acourse1 = true;
	}
	var hide_acourse2 = false;
	if ($j('#modal_target_hide_acourse2').is(":checked")) {
		hide_acourse2 = true;
	}
	var hide_acourse3 = false;
	if ($j('#modal_target_hide_acourse3').is(":checked")) {
		hide_acourse3 = true;
	}
	var last_mod_date = $j('#modal_target_last_mod_date').text();
	var last_mod_user= $j('#modal_target_last_mod_user').text();	
	var forcehrs = false;
	if ($j('#modal_target_forcehrs').is(":checked")) {
		forcehrs = true;
	}
	var tastatus = false;
	if ($j('#modal_target_tastatus').is(":checked")) {
		tastatus = true;
	}
	var id = $j('#targetCourseModal').data('id');
	var row = $j('#' + id);
	// set page form values
	row.find('.course').val(course).css('color', $j('#modal_target_course').css('color'));
	row.find('.pflg').val(pflg);
	row.find('.ctitle').val(ctitle);
	row.find('.limhrs').val(limhrs);
	row.find('.cond').val(cond);
	if (forcehrs) {
		row.find('.forcehrs').prop('checked', true);
	} else {
		row.find('.forcehrs').prop('checked', false);	
	}
	if (tastatus) {
		row.find('.tastatus').prop('checked', true);
	} else {
		row.find('.tastatus').prop('checked', false);	
	}
	row.find('.iflg1').val(iflg1);
	row.find('.iflg2').val(iflg2);
	row.find('.iflg3').val(iflg3);
	row.find('.iflg4').val(iflg4);
	row.find('.iflg5').val(iflg5);
	row.find('.acourse1').val(acourse1);
	row.find('.acourse2').val(acourse2);
	row.find('.acourse3').val(acourse3);
	
	var hideIflgsTxt = "";
	
	if (hideIflgs) {
		row.find('.hideIflgs').prop('checked', true);
		hideIflgsTxt = "<b>All Flags Hidden</b>";
	} else {
		row.find('.hideIflgs').prop('checked', false);
	}
	
	var isPseudoIcon = '<i class="fa fa-check acourseCheck"><span class="sr-only">This acourse is a pseudo course</span></i>';
	var notPseudoIcon = '<i class="fa fa-close acourseX"><span class="sr-only">This acourse is not a pseudo course</span></i>';
	var isHiddenIcon =  '<i class="fa fa-check acourseCheck"><span class="sr-only">This acourse is hidden</span></i>';
	var notHiddenIcon = '<i class="fa fa-close acourseX"><span class="sr-only">This acourse is not hidden</span></i>';
	
	var acourse1HideText, acourse1PseudoText, acourse2HideText, acourse2PseudoText, acourse3HideText, acourse3PseudoText;	
	
	if (apflg1) {
		row.find('.apflg1').prop('checked', true);
		acourse1PseudoText = isPseudoIcon;
	} else {
		row.find('.apflg1').prop('checked', false);
		acourse1PseudoText = notPseudoIcon;
	}
	if (apflg2) {
		row.find('.apflg2').prop('checked', true);
		acourse2PseudoText = isPseudoIcon;
	} else {
		row.find('.apflg2').prop('checked', false);
		acourse2PseudoText = notPseudoIcon;
	}
	if (apflg3) {
		row.find('.apflg3').prop('checked', true);
		acourse3PseudoText = isPseudoIcon;
	} else {
		row.find('.apflg3').prop('checked', false);
		acourse3PseudoText = notPseudoIcon;
	}		
	
	if (hide_acourse1) {
		row.find('.hide_acourse1').prop('checked', true);
		acourse1HideText = isHiddenIcon;
	} else {
		row.find('.hide_acourse1').prop('checked', false);
		acourse1HideText = notHiddenIcon;
	}
	if (hide_acourse2) {
		row.find('.hide_acourse2').prop('checked', true);
		acourse2HideText = isHiddenIcon;
	} else {
		row.find('.hide_acourse2').prop('checked', false);
		acourse2HideText = notHiddenIcon;
	}
	if (hide_acourse3) {
		row.find('.hide_acourse3').prop('checked', true);
		acourse3HideText = isHiddenIcon;
	} else {
		row.find('.hide_acourse3').prop('checked', false);
		acourse3HideText = notHiddenIcon;
	}
	
	var targetAlt = row.find('.targetAlt');
	if (acourse1 || acourse2 || acourse3) {		
		
		targetAlt.attr('data-content', 
				'<table><tr class="acourseTH"><th>Acourse</th><th>Pseudo</th><th>Hidden</th></tr>'+
				'<tr><td>' + acourse1 + '</td><td class="acourse">' + acourse1PseudoText + '</td><td class="acourse">' + acourse1HideText + '</td></tr>' +
				'<tr><td>' + acourse2 + '</td><td class="acourse">' + acourse2PseudoText + '</td><td class="acourse">' + acourse2HideText + '</td></tr>' +
				'<tr><td>' + acourse3 + '</td><td class="acourse">' + acourse3PseudoText + '</td><td class="acourse">' + acourse3HideText + '</td></tr></table>');
		
		targetAlt.removeAttr('title');
		targetAlt.attr('data-original-title', 'Alternate Courses');
		targetAlt.removeAttr('disabled', '');
	} else {
		targetAlt.removeAttr('data-content');
		targetAlt.attr('title', 'Alternate Courses');
		targetAlt.removeAttr('data-original-title');
		targetAlt.attr('disabled', 'disabled');
	}
	targetAlt.popover();
	var targetFlag = row.find('.targetFlag');
	if (iflg1 || iflg2 || iflg3 || iflg4 || iflg5) {
		targetFlag.attr('data-content', iflg1 + '<br>' + iflg2 + '<br>' + iflg3 + '<br>' + iflg4 + '<br>' + iflg5 + '<br>' + hideIflgsTxt);
		targetFlag.removeAttr('title');
		targetFlag.attr('data-original-title', 'Flags');
		targetFlag.removeAttr('disabled', '');
	} else {
		targetFlag.removeAttr('data-content');
		targetFlag.attr('title', 'Flags');
		targetFlag.removeAttr('data-original-title');
		targetFlag.attr('disabled', 'disabled');
	}
	targetFlag.popover();
	row.find('.last_mod_date').val(last_mod_date);
	row.find('.last_mod_user').val(last_mod_user);
	
	$j('#targetCourseModal').modal('hide');
	return false;
}

function validateSourceCourses(){
	
	var sourceCourses = $j('tr[id^=sourceRow]');
	sourceCourses.each(function() {
		makeInputUpperCase(this);
		var row = $j(this);
		var course = row.find('.course').val();
		var crsMsk = $j('#sourceCrsMsk').text();
		var is_anyc = '*';
		if ($j('#anyc')) {
			is_anyc = $j('#anyc').val();	
		}
		var is_blankc = '#';
		if ($j('#blankc')) {
			is_blankc = $j('#blankc').val();
		}
		
		bindOnCourseField(row.find('.course'), 'source');
		checkCrsCase(row.find('.course'),'source');
		var courseOk = checkCrsMsk(course, crsMsk, is_anyc, is_blankc);
		
		if (!courseOk) {
			row.find('.course').css('color', 'red');
			row.find('.crsMskError').show();
			row.find('.form-control-feedback').show();
			row.find(".has-feedback").attr("title","Course does not match the course mask. May be intentional - articulation still valid.");
		} else {
			row.find('.course').css('color', 'black');
			row.find('.crsMskError').hide();
			row.find('.form-control-feedback').hide();
			row.find(".has-feedback").attr("title","Course");
		}
	});
}

function validateTargetCourses(){

	var targetCourses = $j('tr[id^=targetRow-]');
	targetCourses.each(function() {
		var row = $j(this);
		var course = row.find('.course').val();
		var crsMsk = $j('#targetCrsMsk').text();
		var is_anyc = '*';
		if ($j('#anyc')) {
			is_anyc = $j('#anyc').val();	
		}
		var is_blankc = '#';
		if ($j('#blankc')) {
			is_blankc = $j('#blankc').val();
		}
		
		bindOnCourseField(row.find('.course'), 'target');
		checkCrsCase(row.find('.course'),'target');
		var courseOk = checkCrsMsk(course, crsMsk, is_anyc, is_blankc);
		
		if (!courseOk) {
			row.find('.course').css('color', 'red');
			row.find('.crsMskError').show();
			row.find('.form-control-feedback').show();
			row.find(".has-feedback").attr("title","Course does not match the course mask. May be intentional - articulation still valid.");
		} else {
			row.find('.course').css('color', 'black');
			row.find('.crsMskError').hide();
			row.find('.form-control-feedback').hide();
			row.find(".has-feedback").attr("title","Course");
		}
	});
}

function checkCrsCase(course, type){
	
	var crscase = "";
	
	if(type == "source"){
		
		crscase = $j('#sourceCrsCase').val();
	}else if(type == "target"){
		
		crscase = $j('#targetCrsCase').val();
	}
	
	if( crscase == "U"){
		
		makeInputUpperCase(course);
	}else if( crscase == "L"){
		
		makeInputLowerCase(course);
	}	
}

function checkCrsMsk(course, crsMsk, is_anyc, is_blankc) {
	//Only check until you have reached the coursemask length - anything longer will be kicked out above!
	for (var x = 0; x < course.length; x++) {
		
		var ls_testchar = course.charAt(x);
		var ls_maskchar = crsMsk.charAt(x);
		
		if (crsMsk.length < course.length ) {
			return false;
		}
		else if(crsMsk.length > course.length){
			
			var rightPad = crsMsk.length - course.length;
			course += new Array(rightPad+1).join(' ');
		}
		
		if (ls_testchar != is_anyc) {
			if (ls_maskchar == '') {
				ls_maskchar = ' ';
			}
//			console.log('Testing ' + ls_maskchar + ' and Found ' + ls_testchar + ' at ' + x);
			switch(ls_maskchar) {
			    case '*':
			    	//CONTINUE
			        break;
			    case 'A':

			        if (ls_testchar.toUpperCase().charCodeAt(0) < 65 || ls_testchar.toUpperCase().charCodeAt(0) > 90) {
//			        	console.log('Not printable at ' + x);
			        	return false;
			        }
			        break;
			    case '?':
			        if ((ls_testchar == ' ' || ls_testchar == is_blankc)) {
			        	break;
			        }
			        else if(ls_testchar.toUpperCase().charCodeAt(0) < 65 || ls_testchar.toUpperCase().charCodeAt(0) > 90){
			        	return false;
			        }
			    	break;
			    case '9':
					if (!$j.isNumeric(ls_testchar)) {
//						console.log('Found non-numeric at ' + x);
						return false;
					}
					break;
			    case 'Z':
			    	if (ls_testchar == ' ' || ls_testchar == is_blankc) {
//			    		console.log('Found Z at (' + ls_maskchar + ') ' + x);
			    		break;
			    	}
			    	else if(!$j.isNumeric(ls_testchar)){
			    		
			    		return false;
			    	}
			    	break;
			    case 'X':
			    	if (ls_testchar == ' ') {
//			    		console.log('Found ' + ls_testchar  + ' at ' + x);
			    		return false;
			    	}
			    	if (ls_testchar == is_blankc) {
//			    		console.log('Found A at ' + x);
			    		return false;
			    	}
		    		break;
			    case ' ':
			    	if (ls_testchar != ' ' && ls_testchar != is_blankc) {
			    		return false;
			    	}
			    	break;
			    case '/':
			    	if (ls_testchar != '/') {
			    		return false;
			    	}
			    	break;
			    case '-':
			    	if (ls_testchar != '-') {
			    		return false;
			    	}
			    	break;
			    case ':':
			    	if (ls_testchar != ':') {
			    		return false;
			    	}
			    	break;
			    case '.':
			    	if (ls_testchar != '.') {
			    		return false;
			    	}
			    	break;
			    default:
					var errmsg = "Undefined character in Course Mask field: " + ls_maskchar
					console.log('Course Mask Error: ' + errmsg);
			    	return false;
			}
		}
	}
	return true;
}

function bindOnCourseField(object, type) {
	
	checkCrsCase(object,type);
	
	object.bind('blur', function (e) {
		var course = $j(this).val();
		var crsMsk = '';
		if (type == 'source') {
			crsMsk = $j('#sourceCrsMsk').text();
		} else { //if (type == 'target') {
			crsMsk = $j('#targetCrsMsk').text();
		}
		var is_anyc = '*';
		if ($j('#anyc')) {
			is_anyc = $j('#anyc').val();	
		}
		var is_blankc = '#';
		if ($j('#blankc')) {
			is_blankc = $j('#blankc').val();
		}
		
		checkCrsCase(this,type);
		var courseOk = checkCrsMsk(course, crsMsk, is_anyc, is_blankc);
		if (!courseOk) {
			$j(this).css('color', 'red');
			$j(this).parent().find('.crsMskError').show();
			$j(this).parent().find('.form-control-feedback').show();
			$j(this).parent(".has-feedback").attr("title","Course does not match the course mask. May be intentional - articulation still valid.");
		} else {
			$j(this).css('color', 'black');
			$j(this).parent().find('.crsMskError').hide();
			$j(this).parent().find('.form-control-feedback').hide();
			$j(this).parent(".has-feedback").attr("title","Course");
		}
	});
}

function checkModalCrs(type) {
	var is_anyc = '*';
	if ($j('#anyc')) {
		is_anyc = $j('#anyc').val();	
	}
	var is_blankc = '#';
	if ($j('#blankc')) {
		is_blankc = $j('#blankc').val();
	}
	
	checkCrsCase($j('#modal_' + type + '_course'),type);
	var targetCourseOk = checkCrsMsk($j('#modal_' + type + '_course').val(), $j('#' + type + 'List').find('td').find('span.crsMsk').text(), is_anyc, is_blankc);
	if (!targetCourseOk) {
		$j('#modal_' + type + '_course').css('color', 'red');
		$j('#modal_' + type + '_course').parent().find('.form-control-feedback').show();
		$j('#modal_' + type + '_course').parent().find('.crsMskError').show();
	} else {
		$j('#modal_' + type + '_course').css('color', 'black');
		$j('#modal_' + type + '_course').parent().find('.form-control-feedback').hide();
		$j('#modal_' + type + '_course').parent().find('.crsMskError').hide();
	}
}

function createModalListeners(){
	
	$j('#sourceCourseModal').on('hidden.bs.modal', function (e) {
		// removing data from modal
		$j('#modal_source_course').val('');
		$j('#modal_source_pflg').val('');
		$j('#modal_source_ctitle').val('');
		$j('#modal_source_tflg').prop('checked', false);
		$j('#modal_source_limhrs').val('');
		$j('#modal_source_ac').val('');
		$j('#modal_source_rc').val('');
		$j('#modal_source_effdte').val('');
		$j('#modal_source_effdte2').val('');
		$j('#modal_source_last_mod_date').text('');
		$j('#modal_source_last_mod_user').text('');
		// UNSURE IF NEEDED YET
		// $j('#targetCourseModal').data('id', '');
	});
	
	$j('#targetCourseModal').on('hidden.bs.modal', function (e) {
		// removing data from modal
		$j('#modal_target_course').val('');
		$j('#modal_target_pflg :selected').val('');
		$j('#modal_target_ctitle').val('');
		$j('#modal_target_limhrs').val('');
		$j('#modal_target_cond').val('');
		$j('#modal_target_iflg1').val('');
		$j('#modal_target_iflg2').val('');
		$j('#modal_target_iflg3').val('');
		$j('#modal_target_iflg4').val('');
		$j('#modal_target_iflg5').val('');
		$j('#modal_target_acourse1').val('');
		$j('#modal_target_acourse2').val('');
		$j('#modal_target_acourse3').val('');
		$j('#modal_target_hideIflgs').prop('checked', true);
		$j('#modal_target_apflg1').prop('checked', true);
		$j('#modal_target_apflg2').prop('checked', true);
		$j('#modal_target_apflg3').prop('checked', true);
		$j('#modal_target_hide_acourse1').prop('checked', false);
		$j('#modal_target_hide_acourse2').prop('checked', false);
		$j('#modal_target_hide_acourse3').prop('checked', false);
		$j('#modal_target_last_mod_date').text('');
		$j('#modal_target_last_mod_user').text('');	
		$j('#modal_target_forcehrs').prop('checked', false);
		$j('#modal_target_tastatus').prop('checked', false);
		// UNSURE IF NEEDED YET
		// $j('#targetCourseModal').data('id', '');
	});
	
	$j('#modal_source_course').bind('blur', function (e) {
		checkModalCrs('source');
	});
	
	$j('#modal_target_course').bind('blur', function (e) {
		checkModalCrs('target');
	});
}