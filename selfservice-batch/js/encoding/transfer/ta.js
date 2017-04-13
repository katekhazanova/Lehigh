
//Flags marking area changes
var taChanges = false;
var taPKChanges = false;
var ruleChanges = false;

//saving processing flags
var rulesSorted = true;
var selectedRuleSaved = true;
var segmentsNotSaved = 0;
var sourcesNotSaved = 0;
var targetsNotSaved = 0;
var unsavedChanges = false;

//url pararms
var addRuleParam = "";

var ta = new Object();

var taChangesConfirmed = false;

var taCloneValidationMessage = "";
var taEditValidationMessage = "";

//var refreshUrl = '';

$j(document).ready(function() {
	
	/* check to see if changes previously were made */
	ta.persist = true;
	
	if($j("#unsavedChanges").val() =="true"){
		unsavedChanges = true;
	}
		
	/*input validation listeners */
	$j('#ta-form :input').change(function() {
		
		$j('#ta-save').removeAttr("disabled");
		taChanges = true;
		
		var id = $j(this).attr('id');
		
		if (id == 'SOURCE_ID' || id == 'SOURCE_CD' 
			|| id == 'DPMASK' || id == 'FYT') {
			taPKChanges = true;
		}
	});
	
	/* last mode user and date change listeners */
	$j('#ta-general, #ta-default :input').change(function(){
		
		$j("#ta_last_mod_user").text("");
		$j("#ta_last_mod_date").text("");
	});
	
	$j('#segmentModal :input').change(function(){
		
		$j("#modal_last_mod_user").text("");
		$j("#modal_last_mod_date").text("");
	});
	
	$j('#ruleForm :input').change(function(){
		
		$j("#rule_last_mod_user").val("");
		$j("#rule_last_mod_date").val("");
	});
	

	$j('#sortableSource :input').change(function(){
		
		$j(this).parents('tr').find(".last_mod_user").val("");
		$j(this).parents('tr').find(".last_mod_date").val("");
	});
	
	$j('#sortableTarget :input').change(function(){
		
		$j(this).parents('tr').find(".last_mod_user").val("");
		$j(this).parents('tr').find(".last_mod_date").val("");
	});
	
	$j('#sourceCourseModal :input').change(function(){
		
		$j("#modal_source_last_mod_user").text("");
		$j("#modal_source_last_mod_date").text("");
	});
	
	$j('#targetCourseModal :input').change(function(){
		
		$j("#modal_target_last_mod_user").text("");
		$j("#modal_target_last_mod_date").text("");
	});
	
	/* Input Listeners */
	$j('#modal_tsegName').blur(function (e) {
		if ($j('#modal_tsegName').val().trim() != '') {
			$j('#segment_save').removeAttr('disabled');
		} else {
			$j('#segment_save').attr('disabled', 'disabled');
		}
	});
	$j('#modal_source_course').blur(function (e) {
		if ($j('#modal_source_course').val()) {
			$j('#source_save').removeAttr('disabled');
		} else {
			$j('#source_save').attr('disabled', 'disabled');
		}
	});
	$j('#modal_target_course').blur(function (e) {
		if ($j('#modal_target_course').val()) {
			$j('#target_save').removeAttr('disabled');
		} else {
			$j('#target_save').attr('disabled', 'disabled');
		}
	});
	
	/* Button Listeners */
	$j('#ta-refresh').click(function (e) {
		  if (taChanges || unsavedChanges) {
		    e.preventDefault();
		    if (confirm('Refresh data? All unsaved progress will be lost.')) {
		    	taChangesConfirmed = true;
		    	window.location.replace($j(this).attr('href'));
		    }
		  }
	});
	
//	refreshUrl = $j('#ta-refresh').attr('href');
	
	/* Modal Listeners */
	$j('#segmentModal').on('hidden.bs.modal', function (e) {
		// removing data from modal		
		$j('#modal_tsegName').val('');
		$j('#modal_tsegHint').val('');
		$j('#modal_tsegDesc').val('');
		$j('#segment_save').attr('disabled', 'disabled');
//		$j('#modal_intSeqNo').val('');
	});
	$j('#sourceCourseModal').on('hidden.bs.modal', function (e) {
		// removing data from modal		
		$j('#modal_tsegName').val('');
		$j('#modal_tsegHint').val('');
		$j('#modal_tsegDesc').val('');
		$j('#source_save').attr('disabled', 'disabled');
//		$j('#modal_intSeqNo').val('');
	});
	$j('#targetCourseModal').on('hidden.bs.modal', function (e) {
		// removing data from modal		
		$j('#modal_target_course').val('');
		$j('#modal_target_pflg').val(''); //CHANGE TO DROPDOWN
		$j('#modal_target_ctitle').val('');
		$j('#modal_target_limhrs').val('');
		$j('#modal_target_forcehrs').val('');
		$j('#modal_target_tastatus').val('');
		$j('#modal_target_limhrs').val('');
		$j('#modal_target_cond').val('');
		$j('#target_save').attr('disabled', 'disabled');
//		$j('#modal_intSeqNo').val('');
	});
	
	/* Tab Listeners */
//	$j('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
//		var current_tab_id = $j('#ta-form').find('.tab-pane.active').attr('id');
//		$j('#ta-refresh').attr('href', refreshUrl + '&tabid=' + current_tab_id);
//	});

});

function cloneTa(){
	
	if(taCloneValidation()){
		
		ta.clone = true;
		saveTa();
	}
	else{
		$j.pnotify({
		    title: 'Unable to clone Transfer Articulation.',
		    text: taCloneValidationMessage,
	    	addclass: 'warning',
			opacity: 1,
			nonblock: true,
			nonblock_opacity: .2
		});
	}
}

function taCloneValidation(){
	
	if(!taPKChanges){
		
		taCloneValidationMessage = 'Please change source ID, Source CD, DP Mask, or First Year Term before cloning. ';
		return false;
	}
	
	if($j('#SOURCE_ID').val().trim() == "" || $j('#FYT').val().trim() == "" ){
		
		taCloneValidationMessage = 'The Source ID and First Year Term can not be blank. ';
		return false;
	}
	
	return true;
}

function taEditValidation(){
	
//	if($j('#INAME').val().trim() == ""){
//		
//		taEditValidationMessage = 'The School Name can not be blank. ';
//		return false;
//	}
	
	return true;
}

function createTA(){
	
	var fyt = $j("#fyt").val();
	var sourceCd = $j("#sourceCd").val();
	var dpmask = $j('#DPMask').val();
	
	if ($j.trim(fyt) == ""){
		fyt = "000000"; 
	}
	
	if(sourceCd == ""){
		sourceCd = " ";
	}
	
	$j.ajax({
		type: "POST",
		traditional: true,
		url: "create-TA.html",
		data: {
			"fyt": fyt,
			"sourceCd": sourceCd,
			"dpmask": dpmask,
		  },
		 dataType: "json",
			success : function(json) {
				
				if( json.results == "success"){
					var url = "ta.html?fyt="+escape(fyt)+"&sourceCd="+escape(sourceCd)+"&dpmask="+escape(dpmask);
					window.location.replace(url);
				}
				else{
					$j("#createError").show();
				}
			},
			error : function(json) {
			}	
	});
}

function deleteTA(taId,fyt,sourceCd,dpmask){
	if (confirm('Delete TA Table and all included information?')) {
		$j.ajax({
			type: "POST",
			traditional: true,
			url: "delete-ta.html",
			data: {
				"fyt": fyt,
				"sourceCd": sourceCd,
				"dpmask": dpmask,
			  },
			 dataType: "json",
				success : function(json) {
					
					if( json.results == "success"){
						
						$j('#'+taId).remove();
					}
				},
				error : function(json) {
				}	
		});
	}
}

function saveTa(){
	taChangesConfirmed = true;
	
	if(taEditValidation()){
		
		if(ta.persist == true){
			$j('#savingTAMessage').show();
		}
		
		loadTaGeneralTab();
		loadTaDefuatTableTab();
		
		//reset all the ajax flags
		segmentsNotSaved = $j("#segmentList tbody tr").length;
		
		if(ruleChanges){
			selectedRuleSaved = false;
			sourcesNotSaved = $j("#sourceList tbody tr").length;
			targetsNotSaved = $j("#targetList tbody tr").length;
			rulesSorted = false;
		}
		
		//these methods will call to save the TaMaster
		saveSegmentTab();
		
		if(ruleChanges){
			saveSelectedRule();
			saveSourcesList();
			saveTargetsList();
			sortRules();
		}
	}
	else{
		
		$j.pnotify({
		    title: 'Unable to Save Transfer Articulation.',
		    text: taEditValidationMessage,
	    	addclass: 'warning',
			opacity: 1,
			nonblock: true,
			nonblock_opacity: .2
		});
	}
}

function allTaChildrenSaved(){
	
	if(segmentsNotSaved == 0 && selectedRuleSaved && rulesSorted
			&& sourcesNotSaved == 0 && targetsNotSaved == 0){
		return true;
	}
	else{
		return false;
	}
}

function saveTaTabs(){
	
	$j.ajax({
		type: "POST",
		url: "save-ta.html",
		traditional: true,
		data: ta,
		 dataType: "json",
			success : function(json) {
				
				redirectTaUrl();
			},
			error : function(json) {
				
				$j.pnotify({
				    title: 'Unable to Save TA.',
				    text: 'There was an error saving the TA',
			    	addclass: 'warning',
					opacity: .8,
					nonblock: true,
					nonblock_opacity: .2
				});
			}
	});
}

function redirectTaUrl(){
	
	var url = null;
	var fyt = $j("#ta-fyt").text();
	var sourceCd = $j("#ta-sourceCd").text();
	var dpmask = $j("#ta-dpmask").text();
	
	if(sourceCd == ""){
		sourceCd = " ";
	}
	if(dpmask == ""){
		dpmask = " ";
	}
	
	if(ta.clone){
		
		//if it was a clone then redirect to the list page
		url = "institution.html";
	}
	else if(ta.persist == false){
		
		//if persist is false then must be making a page change check which type and redirect
		var segment = "";
		if(ta.editSeg){
			segment = ta.editSeg;
		}
		else{
			segment = $j("#segment-dd").val();
		}
		
		url = "ta.html?fyt="+escape(fyt)+"&sourceCd="+escape(sourceCd)+"&dpmask="+escape(dpmask)+"&segment="+escape(segment);
		
		if(ta.redirect =="add"){
			url += "&addRule="+escape($j('#insertRule').val());
		}
		else if(ta.redirect == "edit"){
			url += "&ruleId="+escape(ta.ruleId);
		}
	}
	else{
		
		//reload the selected rule if it was a save
		var segment = $j("#rule-segment").val();
		var ruleNum = $j('#rule-userSeqNo').val();
		var ruleId = $j('#rule-intSeqNo').val();
		
		url = "ta.html?fyt="+escape(fyt)+"&sourceCd="+escape(sourceCd)+"&dpmask="+escape(dpmask)+"&segment="+escape(segment)+"&refresh=true";
		
		if(ruleId > 0){
			url += "&ruleId="+escape(ruleId);
		}
		else{
			url += "&ruleNum="+escape(ruleNum);
		}
	}
	window.location.replace(url);
}


function loadTaGeneralTab(){
	
	ta.iname = $j('#INAME').val();
	ta.tastatus = '';
	ta.univDpmask = '';
	ta.sourceId = $j('#SOURCE_ID').val();
	ta.sourceCd = $j('#SOURCE_CD').val();
	ta.dpmask = $j('#DPMASK').val();
	ta.fyt = $j('#FYT').val();
	ta.lyt = $j('#LYT').val();
	ta.memo = $j('#MEMO').val();
	ta.lastModUser = $j("#ta_last_mod_user").text();
	var lastModDate = convertToTimeStamp($j("#ta_last_mod_date").text());
	
	if(lastModDate != ""){
		ta.lastModDate = lastModDate;
	}
	
	if($j('#TASTATUS').is(':checked')){
		ta.tastatus = $j('#TASTATUS').val();
	}
	
	if($j('#UNIVDPMASK').is(':checked')){
		ta.univDpmask = $j('#UNIVDPMASK').val();
	}
}

function loadTaDefuatTableTab(){
	
	ta.dinstid = $j('#dinstid').val();
	ta.dinstcd = $j('#dinstcd').val();
}

function delTaRow(event,tableId,insertId,rowId) {
    
	event = $j.event.fix(event);
	var button = event.currentTarget;
	var row = $j(button).parents('tr');
	
	if(tableId == "#sortableSegment"){
		
		var tseg = $j(row).find('.tsegName').text();
		syncRules("delete",tseg,'','');
	}
	
	$j(row).remove();
	
	updateTaNumbers($j(tableId),rowId);
	
	if(insertId != 'none'){
		var insertGrade = parseInt($j(insertId).val()) -1;
		$j(insertId).val(insertGrade);
	}
}
