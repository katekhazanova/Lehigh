var irefChanges = false;
var irefPKChanges = false;
var irefChangesConfirmed = false;
var iref = new Object();

var irefCloneValidationMessage = "";
var irefEditValidationMessage = "";

//var refreshUrl;

$j(document).ready(function() {
	
	if($j('#disableIrefInputs').val() == "true"){
		$j('input').prop('disabled',true);
		$j('textarea').prop('disabled',true);
		$j('select').prop('disabled',true);
	}
	else{
		$j( "#gradeSortable" ).ariaSortable({
			stop: function (event, ui) {
				
			   $j(this).data().uiSortable.currentItem.find(".last_mod_user").val("");
			   $j(this).data().uiSortable.currentItem.find(".last_mod_date").val("");
			   updateGradeNumbers($j(this));
		       $j(this).find('[data-toggle="popover"]').popover('hide');
			}
		}).bind( "ariasortablesorted", function( event, data ) {
			
			updateGradeNumbers($j(this));
			$j(this).find('[data-toggle="popover"]').popover('hide');
		});
	}
	
	/*Data change listeners */
	$j('#iref-form :input').change(function() {	
		$j('#iref-save').removeAttr("disabled");
		irefChanges = true;
		
		var id = $j(this).attr('id');
		
		if (id == 'SOURCE_ID' || id == 'SOURCE_CD' || id == 'FYT') {
			irefPKChanges = true;
		}
		
	});
	
	/* last mode user and date change listeners */

	$j('#gradeSortable :input').change(function(){
		
		$j(this).parents('tr').find(".last_mod_user").val("");
		$j(this).parents('tr').find(".last_mod_date").val("");
	});
	
	$j('#gradeModal :input').change(function(){
		
		$j("#modal_last_mod_user").text("");
		$j("#modal_last_mod_date").text("");
	});
	
	$j('#general, #default, #course, #credit, #gpa :input').change(function(){
		
		$j("#iref_last_mod_user").text("");
		$j("#iref_last_mod_date").text("");
	});
	
	$j('#address :input').change(function(){
		
		$j("#address_last_mod_user").val("");
		$j("#address_last_mod_date").val("");
	});
	
	/*input validation listeners */
	$j('#actc').change(function() {
		
		if($j(this).val() == 'U'){
			$j('#unitscale').removeAttr("disabled");
		}
		else{
			$j('#unitscale').attr("disabled", "disabled");
		}
	});
	
	$j('#refonly').change(function(){
		if($j(this).is(':checked')) {
			$j('#tainstid').attr("disabled", "disabled");
			$j('#tainstcd').attr("disabled", "disabled");
		}
		else {
			$j('#tainstid').removeAttr("disabled");
			$j('#tainstcd').removeAttr("disabled");
		}
	});
	

//	refreshUrl = $j('#iref-refresh').attr('href');
	
	/* Button Listeners */
	$j('#iref-refresh').click(function (e) {
		  if (irefChanges) {
		    e.preventDefault();
		    if (confirm('Restore data from database? All unsaved progress will be lost.')) {
		    	irefChangesConfirmed = true;
		    	window.location.replace($j(this).attr('href'));
		    }
		  }
	});	
	
	/* Modal Listeners */
	$j('#gradeModal').on('hidden.bs.modal', function (e) {
		// removing data from modal
		$j('#modal_ltype').val('');
		$j('#modal_grade').val('');
		$j('#modal_effdte').val('');
		$j('#modal_effdte2').val('');
		$j('#modal_i2uflg').prop('checked', false);
		$j('#modal_ugrade').val('');
		$j('#modal_u2iflg').prop('checked', false);
		$j('#modal_ac').val('');
		$j('#modal_rc').val('');
		$j('#modal_acu').val('');
		$j('#modal_rcu').val('');
		$j('#modal_gpapt').val('');
		$j('#modal_cond1').val('');
		$j('#modal_cond2').val('');
		$j('#modal_ucond1').val('');
		$j('#modal_ucond2').val('');
		$j('#modal_grade_memo').val('');
		$j('#modal_gpacal').val('');
		$j('#modal_addcr').val('');
		$j('#modal_addct').val('');
		$j('#modal_last_mod_date').text('');
		$j('#modal_last_mod_user').text('');
	});
	
	/* Tab Listeners */
//	$j('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
//		var current_tab_id = $j('#iref-form').find('.tab-pane.active').attr('id');
//		$j('#iref-refresh').attr('href', refreshUrl + '&tabid=' + current_tab_id);
//	});
});

function updateGradeNumbers($jlist){
	
    $jlist.find('tr').each(function (idx) {
        
    	var row = idx+1;
    	
    	$j(this).find('.userSeqNo').text(row);
    	$j(this).attr('id','gradeRow-'+row);
    });
    
	$j('#iref-save').removeAttr("disabled");
	irefChanges = true;
}

function cloneIref(){
	
	if(irefCloneValidation()){
		
		iref.clone = true;
		saveIref();
	}
	else{
		$j.pnotify({
		    title: 'Unable to clone IREF.',
		    text: irefCloneValidationMessage,
	    	addclass: 'warning',
			opacity: 1,
			nonblock: true,
			nonblock_opacity: .2
		});
	}
}

function irefCloneValidation(){
	
	if(!irefPKChanges){
		
		irefCloneValidationMessage = 'Please change source ID, Source CD, or First Year Term before cloning. ';
		return false;
	}
	
	if($j('#SOURCE_ID').val().trim() == "" || $j('#FYT').val().trim() == "" ){
		
		irefCloneValidationMessage = 'The Source ID and firt Year Term can not be blank. ';
		return false;
	}
	
	return true;
}

function irefEditValidation(){
	
//	if($j('#INAME').val().trim() == ""){
//		
//		irefEditValidationMessage = 'The School Name can not be blank. ';
//		return false;
//	}
	
	if($j('#refonly').is(':checked') && $j('#dinstid').val().trim() == "" ){
		
		irefEditValidationMessage = 'The Default IREF Table InstID must be set when its a Reference Record. ';
		return false;
	}
	
	if($j('#actc').val() == 'U' && $j('#unitscale').val().trim() == ""){
		
		irefEditValidationMessage = 'The Unit Scale must be set when Credit Type is U. ';
		return false;
	}
	
	return true;
}

function createIref(){
	
	var fyt = $j("#fyt").val();
	var sourceCd = $j("#sourceCd").val();
	
	if ($j.trim(fyt) == ""){
		fyt = "000000"; 
	}
		
	
	if(sourceCd == ""){
		sourceCd = " ";
	}
	
	
	$j.ajax({
		type: "POST",
		traditional: true,
		url: "create-iref.html",
		data: {
			"fyt": fyt,
			"sourceCd": sourceCd,
		  },
		 dataType: "json",
			success : function(json) {
				
				if( json.results == "success"){
					var url = "iref.html?fyt="+escape(fyt)+"&sourceCd="+escape(sourceCd);
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

function deleteIref(irefId,fyt,sourceCd){
	if (confirm('Delete IREF Table and all included information?')) {
		$j.ajax({
			type: "POST",
			traditional: true,
			url: "delete-iref.html",
			data: {
				"fyt": fyt,
				"sourceCd": sourceCd,
			  },
			 dataType: "json",
				success : function(json) {
					
					if( json.results == "success"){
						
						$j('#'+irefId).remove();
					}
				},
				error : function(json) {
				}	
		});
	}
}



function saveIref(){
	
	irefChangesConfirmed = true;
	
	if(irefChanges){
		
		if(irefEditValidation()){
			
			$j('#savingTAMessage').show();
			
			loadIrefGeneralTab();
			loadIrefDefaultTableTab();
			loadIrefCourseTab();
			
			if($j('#creditTab').length){
				loadIrefCreditTab();
			}
			
			if($j('#gpaTab').length){
				loadIrefGpaTab();
			}
			
			if($j('#addressTab').length){
				loadIrefAddressTab();
			}
			
			
			//This method will also save the rest of the tabs
			saveGradeTab();
		}
		else{
			
			$j.pnotify({
			    title: 'Unable to Save IREF.',
			    text: irefEditValidationMessage,
		    	addclass: 'warning',
				opacity: 1,
				nonblock: true,
				nonblock_opacity: .2
			});
		}
	}	
}

var gradesNotSaved = 0;

function saveGradeTab(){
	
	gradesNotSaved = $j("#gradeTable tbody tr").length;
	
	//clear the existing grades before saving
	$j.ajax({
		type: "POST",
		url: "save-grade.html",
		traditional: true,
		data: {"clear":"true"},
		 dataType: "json",
			success : function(json) {	
				
				if(gradesNotSaved == 0){
					saveIrefTabs();
				}
				else{
					saveGrades();
				}
			},
			error : function(json) {
				
				if(gradesNotSaved == 0){
					saveIrefTabs();
				}
				else{
					saveGrades();
				}
			}
	});


}

function saveGrades(){
	
	$j("#gradeTable tbody tr").each(function(i, row) {
		
		  var grade = new Object();
		  
		  loadGradeValues(grade,row);
		  
			$j.ajax({
				type: "POST",
				async: false,
				url: "save-grade.html",
				traditional: true,
				data: grade,
				 dataType: "json",
					success : function(json) {	
						
						gradesNotSaved--;
						
						if(gradesNotSaved == 0){
							saveIrefTabs();
						}
					},
					error : function(json) {
						
						gradesNotSaved--;
						
						if(gradesNotSaved == 0){
							saveIrefTabs();
						}
					}
			});
	});
}

function saveIrefTabs(){
		
	$j.ajax({
		type: "POST",
		url: "save-iref.html",
		traditional: true,
		data: iref,
		 dataType: "json",
			success : function(json) {
				
				if(iref.clone){
					var url = encodeURI("institution.html");
					window.location.replace(url);
				}
				else{
					
					$j('#savingTAMessage').hide();
					
					var url = "iref.html?sourceCd="+escape(iref.sourceCd)+"&fyt="+escape(iref.mrfyt);
					window.location.replace(url);
				}
			},
			error : function(json) {
				
				$j.pnotify({
				    title: 'Unable to Save IREF.',
				    text: 'There was an error saving the IREF',
			    	addclass: 'warning',
					opacity: .8,
					nonblock: true,
					nonblock_opacity: .2
				});
				
				$j('#savingTAMessage').hide();
			}
	});
}

function loadGradeValues(grade,row){
	
	  grade.intSeqNo = $j(row).find('.intSeqNo').val();
	  grade.userSeqNo = $j(row).find('.userSeqNo').text();
	  grade.ltype = $j(row).find('.ltype').val();
	  grade.grade = $j(row).find('.grade').val();
	  grade.ac = $j(row).find('.ac').val();
	  grade.rc = $j(row).find('.rc').val();
	  grade.acu = $j(row).find('.acu').val();
	  grade.rcu = $j(row).find('.rcu').val();
	  grade.ugrade = $j(row).find('.ugrade').val();
	  grade.gpapt = $j(row).find('.gpapt').val();
	  grade.gpacal = $j(row).find('.gpacal').val();
	  grade.addcr = $j(row).find('.addcr').val();
	  grade.addct = $j(row).find('.addct').val();
	  grade.cond1 = $j(row).find('.cond1').val();
	  grade.cond2 = $j(row).find('.cond2').val();
	  grade.ucond1 = $j(row).find('.ucond1').val();
	  grade.ucond2 = $j(row).find('.ucond2').val();
	  grade.lastModUser = $j(row).find('.last_mod_user').val();
	  var lastModDate = convertToTimeStamp($j(row).find('.last_mod_date').val());
	  
		if(lastModDate != ""){
			grade.lastModDate = lastModDate;
		}
	  
	  var effdte = fix_effdte($j(row).find('.effdte').val());
	  var effdte2 = fix_effdte($j(row).find('.effdte2').val());
	  grade.effdte = effdte + effdte2;
	  grade.i2uflg = '';
	  grade.u2iflg = '';
	  if($j(row).find('.i2uflg').is(':checked')){
		  grade.i2uflg = $j(row).find('.i2uflg').val();
	  }
	  
	  if($j(row).find('.u2iflg').is(':checked')){
		  grade.u2iflg = $j(row).find('.u2iflg').val();
	  }
	  
	  //hidden Inputs
	  grade.memo = $j(row).find('.grade_memo').val();
}

function loadIrefGeneralTab(){
	
	iref.iname = $j('#INAME').val();
	iref.status = '';
	iref.sourceId = $j('#SOURCE_ID').val();
	iref.sourceCd = $j('#SOURCE_CD').val();
	iref.mrfyt = $j('#FYT').val();
	iref.lyt = $j('#LYT').val();
	iref.sourceidq = $j('#sourceidq').val();
	iref.rptinstid = $j('#RPINSTID').val();
	iref.grdcase = $j('#grdcase').val();
	iref.grdreq = '';
	iref.lastModUser = $j("#iref_last_mod_user").text();
	var lastModDate = convertToTimeStamp($j("#iref_last_mod_date").text());
	
	if(lastModDate != ""){
		iref.lastModDate = lastModDate;
	}
	
	if($j('#grdreq').is(':checked')){
		iref.grdreq = $j('#grdreq').val();
	}
	
	if($j('#STATUS').is(':checked')){
		iref.status = $j('#STATUS').val();
	}
}

function loadIrefDefaultTableTab(){
	
	iref.refonly = '';
	iref.dinstid = $j('#dinstid').val();
	iref.dinstcd = $j('#dinstcd').val();
	iref.tainstid = $j('#tainstid').val();
	iref.tainstcd = $j('#tainstcd').val();
	
	if($j('#refonly').is(':checked')){
		iref.refonly = $j('#refonly').val();
	}
}

function loadIrefCourseTab(){
	
	iref.crsmask = $j('#crsmask').val();
	iref.crscase = $j('#crscase').val();
	iref.deptbgn = $j('#deptbgn').val();
	iref.deptend = $j('#deptend').val();
	iref.crsbgn = $j('#crsbgn').val();
	iref.crsend = $j('#crsend').val();
	iref.actc = $j('#actc').val();
	iref.unitscale = $j('#unitscale').val();
	iref.bacc = $j('#bacc').val();
	iref.refucond1 = $j('#refucond1').val();
	iref.refucond2 = $j('#refucond2').val();
}

function loadIrefCreditTab(){
	
	iref.cscale = $j('#cscale').val();
	iref.dcourse = $j('#dcourse').val();
	iref.cassign = $j('#cassign').val();
	iref.cexcess = $j('#cexcess').val();
	iref.cfinal = $j('#cfinal').val();
	iref.dpflg = '';
	
	if($j('#dpflg').is(':checked')){
		iref.dpflg = $j('#dpflg').val();
	}
}

function loadIrefGpaTab(){
	
	iref.gpascale = $j('#gpascale').val();
	iref.gparule = $j('#gparule').val();
	iref.grule = $j('#grule').val();
	iref.dgrade = $j('#dgrade').val();
	iref.d0grade = $j('#d0grade').val();
}

function loadIrefAddressTab(){
	
	iref.address1 = $j('#ADDRESS1').val();
	iref.address2 = $j('#ADDRESS2').val();
	iref.locationq = $j('#LOCATIONQ').val();
	iref.locationid = $j('#LOCATIONID').val();
	iref.contactcd = $j('#CONTACTCD').val();
	iref.contactname = $j('#CONTACTNAME').val();
	iref.city = $j('#CITY').val();
	iref.state = $j('#STATE').val();
	iref.commnoq = $j('#COMMNOQ').val();
	iref.fax = $j('#FAX').val();
	iref.zip = $j('#ZIP').val();
	iref.country = $j('#COUNTRY').val();
	iref.phone = $j('#PHONE').val();
	iref.email = $j('#E_MAIL').val();
	iref.memo = $j('#ADDRESS_MEMO').val();
	iref.addressUser = $j("#address_last_mod_user").val();
	var addressDate =  convertToTimeStamp($j("#address_last_mod_date").val());
	
	if(addressDate != ""){
		iref.addressDate = addressDate;
	}
	
}

/* js for Adding rows - IREF Grade */

function addRowGrade() {

	var insertGrade = $j('#insertGrade').val();

	if (insertGrade >= $j('#grade tr').length) {
		insertGrade = $j('#grade tr').length;
	}

	var homeIref = $j('#homeIref').val();

	// create rows
	var row = $j('<tr id="gradeRow-' + insertGrade + '" class="ui-state-default"></tr>');
    var move = $j('<td class="move aligncenter"><i class=\"fa fa-bars\"><span class=\"sr-only\">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i></td>');
    var number = $j('<td class="userSeqNo aligncenter">' + insertGrade + '</td>');
    var i2uflg = '';
    if (homeIref == "true") {
 	 	i2uflg = $j('<td class="aligncenter"><input class="i2uflg" type="checkbox" style="margin-left: 0px;float: none;" value="Y" onfocus="setVisibility(\'iref_i2uflgHelp\',\'inline\')" onBlur="setVisibility(\'iref_i2uflgHelp\',\'none\')"></td>');
    } else {
 	 	i2uflg = $j('<td class="aligncenter" style="display: none;"><input class="i2uflg" type="checkbox" style="display: none; margin-left: 0px;float: none;" value="Y" checked onfocus="setVisibility(\'iref_i2uflgHelp\',\'inline\')" onBlur="setVisibility(\'iref_i2uflgHelp\',\'none\')"></td>');
    }
    var ltype = $j('<td class="aligncenter"><select class="ltype" name="ltype" onfocus="setVisibility(\'iref_ltypeHelp\',\'inline\')" onBlur="setVisibility(\'iref_ltypeHelp\',\'none\')"><option value="G">Grade</option><option value="C">Condition</option><option value="F">Flag</option><option value="A">Average</option><option value="S">SPEEDE</option></select></td>');
    var grade = $j('<td class="aligncenter"><input type="text" value="" class="grade" name="grade" maxlength="4" style="width: 40px;" onfocus="setVisibility(\'iref_gradeHelp\',\'inline\')" onBlur="setVisibility(\'iref_gradeHelp\',\'none\')"></td>');
    var ac = $j('<td class="aligncenter"><input type="text" value="" class="ac" name="ac" maxlength="1" style="width: 25px;" onfocus="setVisibility(\'iref_acHelp\',\'inline\')" onBlur="setVisibility(\'iref_acHelp\',\'none\')"></td>');
    var rc = $j('<td class="aligncenter"><input type="text" value="" class="rc" name="rc" maxlength="1" style="width: 25px;" onfocus="setVisibility(\'iref_rcHelp\',\'inline\')" onBlur="setVisibility(\'iref_rcHelp\',\'none\')"></td>');
    var u2iflg = '';
    if (homeIref == "true") {
    	u2iflg = $j('<td class="aligncenter"><input class="u2iflg" type="checkbox" style="margin-left: 0px;float: none;" value="Y" onfocus="setVisibility(\'iref_u2iflgHelp\',\'inline\')" onBlur="setVisibility(\'iref_u2iflgHelp\',\'none\')"></td>');
    } else {
    	u2iflg = $j('<td class="aligncenter" style="display: none;"><input class="u2iflg" type="checkbox" style="margin-left: 0px;float: none;" value="Y" onfocus="setVisibility(\'iref_u2iflgHelp\',\'inline\')" onBlur="setVisibility(\'iref_u2iflgHelp\',\'none\')"></td>');	
    }	
    var ugrade = '';
    if (homeIref == "true") {
    	ugrade = $j('<td class="aligncenter"><input class="ugrade" type="text" value="" name="ugrade" maxlength="4" style="width: 40px;" onfocus="setVisibility(\'iref_ugradeHomeHelp\',\'inline\')" onBlur="setVisibility(\'iref_ugradeHomeHelp\',\'none\')"></td>');
    } else{
    	ugrade = $j('<td class="aligncenter"><input class="ugrade" type="text" value="" name="ugrade" maxlength="4" style="width: 40px;" onfocus="setVisibility(\'iref_ugradeSourceHelp\',\'inline\')" onBlur="setVisibility(\'iref_ugradeSourceHelp\',\'none\')"></td>');
    }
    var acu = '';
    if (homeIref == "true") {
    	acu = $j('<td class="aligncenter"><input type="text" value="" class="acu" name="acu" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_acuHelp\',\'inline\')" onBlur="setVisibility(\'iref_acuHelp\',\'none\')"></td>');
    } else {
    	acu = $j('<td class="aligncenter" style="display:none;"><input type="text" value="" class="acu" name="acu" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_acuHelp\',\'inline\')" onBlur="setVisibility(\'iref_acuHelp\',\'none\')"></td>');	
    }
    var rcu = '';
    if (homeIref == "true") {
    	rcu = $j('<td class="aligncenter"><input type="text" value="" class="rcu" name="rcu" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_rcuHelp\',\'inline\')" onBlur="setVisibility(\'iref_rcuHelp\',\'none\')"></td>');
    } else {
    	rcu = $j('<td class="aligncenter" style="display:none;"><input type="text" value="" class="rcu" name="rcu" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_rcuHelp\',\'inline\')" onBlur="setVisibility(\'iref_rcuHelp\',\'none\')"></td>');	
    }
    var gpapt = $j('<td class="aligncenter"><input type="text" value="0" class="gpapt" name="gpapt" maxlength="10" style="width: 42px;" onfocus="setVisibility(\'iref_gpaptHelp\',\'inline\')" onBlur="setVisibility(\'iref_gpaptHelp\',\'none\')"></td>'); 
    var gpacal = $j('<td class="aligncenter"><select class="gpacal" name="gpacal" style="width: 38px;" onfocus="setVisibility(\'iref_gpacalHelp\',\'inline\')" onBlur="setVisibility(\'iref_gpacalHelp\',\'none\')"><option value="N">N &nbsp &nbsp No</option><option value="Y">Y &nbsp &nbsp Yes</option><option value="V">V &nbsp &nbsp >=</option><option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspNo Change </option></select></td>');    
    var addcr = $j('<td class="aligncenter"><select class="addcr" name="addcr" style="width: 38px;" onfocus="setVisibility(\'iref_addcrHelp\',\'inline\')" onBlur="setVisibility(\'iref_addcrHelp\',\'none\')"><option value="N">N &nbsp &nbsp No</option><option value="Y">Y &nbsp &nbsp Yes</option><option value="I">I &nbsp &nbsp &nbspDirectly Input</option><option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspNo Change </option></select></td>');    
    var addct = '';
    if (homeIref == "true") {
    	addct = $j('<td class="aligncenter"><select class="addct" name="addct" style="width: 38px;" onfocus="setVisibility(\'iref_addctHomeHelp\',\'inline\')" onBlur="setVisibility(\'iref_addctHomeHelp\',\'none\')"><option value="1">1 &nbsp &nbsp Acceptable</option><option value="0">0 &nbsp &nbsp Not Acceptable</option><option value="X">X &nbsp &nbsp Tentatively Acceptable</option></select></td>');
    } else {
    	addct = $j('<td class="aligncenter"><select class="addct" name="addct" style="width: 38px;" onfocus="setVisibility(\'iref_addctSourceHelp\',\'inline\')" onBlur="setVisibility(\'iref_addctSourceHelp\',\'none\')"><option value="1">1 &nbsp &nbsp Acceptable</option><option value="0">0 &nbsp &nbsp Not Acceptable</option><option value="X">X &nbsp &nbsp Tentatively Acceptable</option></select></td>');
    }
    var cond1 = $j('<td class="aligncenter"><input type="text" value="" class="cond1" name="cond1" maxlength="1" style="width: 25px;" onfocus="setVisibility(\'iref_cond1Help\',\'inline\')" onBlur="setVisibility(\'iref_cond1Help\',\'none\')"></td>');
    var cond2 = $j('<td class="aligncenter"><input type="text" value="" class="cond2" name="cond2" maxlength="1" style="width: 25px;" onfocus="setVisibility(\'iref_cond2Help\',\'inline\')" onBlur="setVisibility(\'iref_cond2Help\',\'none\')"></td>');
    var ucond1 = '';
    if (homeIref == "true") {
    	ucond1 = $j('<td class="aligncenter"><input type="text" value="" class="ucond1" name="ucond1" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_ucond1Help\',\'inline\')" onBlur="setVisibility(\'iref_ucond1Help\',\'none\')"></td>');
    } else {
    	ucond1 = $j('<td class="aligncenter" style="display:none;"><input type="text" value="" class="ucond1" name="ucond1" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_ucond1Help\',\'inline\')" onBlur="setVisibility(\'iref_ucond1Help\',\'none\')"></td>');
    }
    var ucond2 = '';
    if (homeIref == "true") {
    	ucond2 = $j('<td class="aligncenter"><input type="text" value="" class="ucond2" name="ucond2" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_ucond2Help\',\'inline\')" onBlur="setVisibility(\'iref_ucond2Help\',\'none\')"></td>');
    } else {
    	ucond2 = $j('<td class="aligncenter" style="display:none;"><input type="text" value="" class="ucond2" name="ucond2" maxlength="3" style="width: 30px;" onfocus="setVisibility(\'iref_ucond2Help\',\'inline\')" onBlur="setVisibility(\'iref_ucond2Help\',\'none\')"></td>');
    }
    var effdte = $j('<td class="aligncenter"><input type="text" value="" class="effdte" name="effdte" maxlength="6" style="width: 50px;" onfocus="setVisibility(\'iref_effdteHelp\',\'inline\')" onBlur="setVisibility(\'iref_effdteHelp\',\'none\')">&nbsp-&nbsp;<input type="text" value="" class="effdte2" name="effdte2" maxlength="6" style="width: 50px;" onfocus="setVisibility(\'iref_effdteHelp\',\'inline\')" onBlur="setVisibility(\'iref_effdteHelp\',\'none\')"></td>');
    var memo = $j('<td class="aligncenter"><a href="#" class="gradeMemoButton btn btn-info btn-xs" name="gradeMemoButton" type="button" data-placement="auto top" data-toggle="popover" title="Memo" onclick="return false;" disabled="disabled"><i class="fa fa-file-text-o"></i></a></td>');
    var more = $j('<td class="aligncenter"><a href="#" class="btn btn-default btn-xs" type="button" onclick="popGradeModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a></td>');
    var deleteRow = $j('<td class="aligncenter"><button type="button" class="btn btn-danger btn-xs deleteGrade" onclick="delRowGrade(event)" title="Delete Course"><i class="fa fa-trash-o"></i></button></td>');
    var extraContent = '<input type="hidden" class="intSeqNo" />' +
		'<input type="hidden" class="grade_memo" />' +
		'<input type="hidden" class="lastModDate" />' +
		'<input type="hidden" class="lastModUser" />';
    
    // append data to row
    row.append(move);
    row.append(number);
    row.append(ltype);
 	row.append(i2uflg);
    row.append(grade);
    row.append(ac);
    row.append(rc);
	row.append(u2iflg);
    row.append(ugrade);
    row.append(acu);
    row.append(rcu);
    row.append(gpapt);
    row.append(gpacal);
    row.append(addcr);
    row.append(addct);
    row.append(cond1);
    row.append(cond2);
   	row.append(ucond1);
   	row.append(ucond2);
    row.append(effdte);
    row.append(memo);
    row.append(more);
    row.append(deleteRow);
    row.append(extraContent);

    if (insertGrade < $j('#grade tr').length) {
    	$j('#gradeRow-'+insertGrade).before(row);
    	//reset the row numbers
    	 updateGradeNumbers($j('#gradeSortable'));
    } else {
    	$j('#gradeTable tbody').append(row);
    	$j('#iref-save').removeAttr("disabled");
    	irefChanges = true;
    }

    $j( "#gradeSortable" ).ariaSortable( 'newRow' ); 
    $j('#insertGrade').val($j('#grade tr').length);
}

function delRowGrade(event) {
    
	event = $j.event.fix(event);
	var button = event.currentTarget;
	var row = $j(button).parents('tr');
	$j(row).remove();
	
	updateGradeNumbers($j('#gradeSortable'));
	
	var insertGrade = parseInt($j('#insertGrade').val()) -1;
	$j('#insertGrade').val(insertGrade);
}

function popGradeModal(event) {
	
	event = $j.event.fix(event);
	var button = event.currentTarget;
	var row = $j(button).parents('tr');
	$j('#gradeModal').data('id', $j(row).attr('id'));
	
	// get page form values
	var ltype = row.find('.ltype :selected').val();
	var grade = row.find('.grade').val();
	var effdte = row.find('.effdte').val();
	var effdte2 = row.find('.effdte2').val();
	var i2uflg = false;
	if (row.find('.i2uflg').is(":checked")) {	
		i2uflg = true;
	}
	var ugrade = row.find('.ugrade').val();
	var u2iflg = false;
	if (row.find('.u2iflg').is(":checked")) {	
		u2iflg = true;
	}
	var ac = row.find('.ac').val();
	var rc = row.find('.rc').val();
	var acu = row.find('.acu').val();
	var rcu = row.find('.rcu').val();
	var gpapt = row.find('.gpapt').val();
	var cond1 = row.find('.cond1').val();
	var cond2 = row.find('.cond2').val();
	var ucond1 = row.find('.ucond1').val();
	var ucond2 = row.find('.ucond2').val();
	var grade_memo = row.find('.grade_memo').val();
	var gpacal = row.find('.gpacal :selected').val();
	var addcr = row.find('.addcr :selected').val();
	var addct = row.find('.addct :selected').val();
	var last_mod_date = row.find('.last_mod_date').val();
	var last_mod_user = row.find('.last_mod_user').val();
	
	// set modal form values
	$j('#modal_ltype').val(ltype);
	$j('#modal_grade').val(grade);
	$j('#modal_effdte').val(effdte);
	$j('#modal_effdte2').val(effdte2);
	if (i2uflg) {
		$j('#modal_i2uflg').prop('checked', true);
	} else {
		$j('#modal_i2uflg').prop('checked', false);
	}
	$j('#modal_ugrade').val(ugrade);
	if (u2iflg) {	
		$j('#modal_u2iflg').prop('checked', true);
	} else {
		$j('#modal_u2iflg').prop('checked', false);
	}
	$j('#modal_ac').val(ac);
	$j('#modal_rc').val(rc);
	$j('#modal_acu').val(acu);
	$j('#modal_rcu').val(rcu);
	$j('#modal_gpapt').val(gpapt);
	$j('#modal_cond1').val(cond1);
	$j('#modal_cond2').val(cond2);
	$j('#modal_ucond1').val(ucond1);
	$j('#modal_ucond2').val(ucond2);
	$j('#modal_grade_memo').val(grade_memo);
	$j('#modal_gpacal').val(gpacal);
	$j('#modal_addcr').val(addcr);
	$j('#modal_addct').val(addct);
	$j('#modal_last_mod_date').text(last_mod_date);
	$j('#modal_last_mod_user').text(last_mod_user);
	
	$j('#gradeModal').modal('show');
	return false;
}

function applyGradeModal() {
	// get modal form values
	var ltype = $j('#modal_ltype :selected').val();
	var grade = $j('#modal_grade').val();
	var effdte = $j('#modal_effdte').val();
	var effdte2 = $j('#modal_effdte2').val();
	var i2uflg = false;
	if ($j('#modal_i2uflg').is(":checked")) {
		i2uflg = true;
	}
	var ugrade = $j('#modal_ugrade').val();
	var u2iflg = false;
	if ($j('#modal_u2iflg').is(":checked")) {
		u2iflg = true;
	}
	var ac = $j('#modal_ac').val();
	var rc = $j('#modal_rc').val();
	var acu = $j('#modal_acu').val();
	var rcu = $j('#modal_rcu').val();
	var gpapt = $j('#modal_gpapt').val();
	var cond1 = $j('#modal_cond1').val();
	var cond2 = $j('#modal_cond2').val();
	var ucond1 = $j('#modal_ucond1').val();
	var ucond2 = $j('#modal_ucond2').val();
	var grade_memo = $j('#modal_grade_memo').val();
	var gpacal = $j('#modal_gpacal :selected').val();
	var addcr = $j('#modal_addcr :selected').val();
	var addct = $j('#modal_addct :selected').val();
	var last_mod_date = $j('#modal_last_mod_date').text();
	var last_mod_user = $j('#modal_last_mod_user').text();

	var id = $j('#gradeModal').data('id');
	var row = $j('#' + id );

	// set page form values
	row.find('.ltype').val(ltype);
	row.find('.grade').val(grade);
	row.find('.effdte').val(effdte);
	row.find('.effdte2').val(effdte2);
	if (i2uflg) {
		row.find('.i2uflg').prop('checked', true);
	} else {
		row.find('.i2uflg').prop('checked', false);	
	}	
	row.find('.ugrade').val(ugrade);
	if (u2iflg) {
		row.find('.u2iflg').prop('checked', true);
	} else {
		row.find('.u2iflg').prop('checked', false);	
	}
	row.find('.ac').val(ac);
	row.find('.rc').val(rc);
	row.find('.acu').val(acu);
	row.find('.rcu').val(rcu);
	row.find('.gpapt').val(gpapt);
	row.find('.cond1').val(cond1);
	row.find('.cond2').val(cond2);
	row.find('.ucond1').val(ucond1);
	row.find('.ucond2').val(ucond2);
	row.find('.grade_memo').val(grade_memo);
	var gradeMemoButton = row.find('.gradeMemoButton');
	if (grade_memo) {
		gradeMemoButton.attr('data-content', grade_memo);
		gradeMemoButton.removeAttr('title');
		gradeMemoButton.attr('data-original-title', 'Memo');
		gradeMemoButton.removeAttr('disabled', '');
	} else {
		gradeMemoButton.removeAttr('data-content');
		gradeMemoButton.attr('title', 'Memo');
		gradeMemoButton.removeAttr('data-original-title');
		gradeMemoButton.attr('disabled', 'disabled');
	}
	gradeMemoButton.popover();
	row.find('.gpacal').val(gpacal);
	row.find('.addcr').val(addcr);
	row.find('.addct').val(addct);
	row.find('.last_mod_date').val(last_mod_date);
	row.find('.last_mod_user').val(last_mod_user);
	$j('#gradeModal').modal('hide');
	
	return false;
}

