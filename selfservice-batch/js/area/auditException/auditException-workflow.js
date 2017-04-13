/** Below is the code for generating the audit exception workflow
 * for each of the different types of audit exceptions being created **/

function editAuditRequirement(event,reqId){
	
	toggleOpen(event,reqId);

	$j('.exceptMod-editName').text('Requirement Modification');
	$j('#nav-step1-label').text('Requirement Modification');
	$j('#nav-step2-label').text('Verify & Save');
	$j('#exceptMod-nav-step2').show();
	$j('#exceptMod-valuePrompt').show();
	$j('#exceptMod-requirements').html('Alter at least one value');
	
	$j('#exceptionType').val("reqMod");
	setReqModCounts(reqId);
	setupReqEdit(reqId);
}

function forceReqComplete(event,reqId){
	
	toggleOpen(event,reqId);

	$j('.exceptMod-editName').text('Requirement Force Complete');
	$j('#nav-step1-label').text('Verify & Save');
	
	$j('#exceptionType').val("forceComplete");
	$j('#rnameCheckbox').hide();
	
	setupReqEdit(reqId);
}

function setupReqEdit(reqId){
	
	$j('#'+reqId).find('.reqText').addClass("auditHighlight");
	
	var reqTitle = $j('#'+reqId).find('.reqTitle').html();
	$j(".exceptMod-reqText").html(reqTitle);
	$j('.exceptMod-reqText-label').text('Requirement  ');
	
	$j('.requirement').hide();
	$j('#'+reqId).show();
	$j('#exceptionList').hide();
	hideExceptionButtons();
	
	$j('#selected-reqId').val(reqId);
	
	var pseudo = $j('#'+reqId).attr('pseudo');
	$j("#exceptMod-psuedo").text(pseudo);
	
	showExceptMod1();
}

function editAuditSubrequirement(event,subreqId){
	
	showCurrentSubreq(event,subreqId);
	
	$j('.exceptMod-editName').text('Subrequirement Modification');
	$j('#nav-step1-label').text('Subrequirement Modification');
	$j('#nav-step2-label').text('Verify & Save');
	$j('#exceptMod-nav-step2').show();
	$j('#exceptMod-valuePrompt').show();
	$j('#exceptMod-requirements').html('Alter at least one value');
	
	$j('#exceptionType').val("reqMod");
	setReqModCounts(subreqId);
	
	$j('#reqSubCountLabel').text('Required Course Count');
	$j('.requiredCourseCountEditBox').hide();
	setupSubreqEdit(subreqId);
}

function forceSubreqComplete(event,subreqId){
	
	showCurrentSubreq(event,subreqId);

	$j('.exceptMod-editName').text('Subrequirement Force Complete');
	$j('#nav-step1-label').text('Verify & Save');
	
	$j('#exceptionType').val("forceComplete");
	$j('#rnameCheckbox').hide();
	
	setupSubreqEdit(subreqId);
}

function setupSubreqEdit(subreqId){
	
	$j('#'+subreqId).find('.subreqTitle').addClass("auditHighlight");
	
	var subreqTitle = $j('#'+subreqId).find('.subreqTitle').html();
	$j(".exceptMod-reqText").html(subreqTitle);
	$j('.exceptMod-reqText-label').text('Subrequirement  ');
	
	var reqId = $j("#"+subreqId).parents('.requirement').attr('id');
	$j('#selected-reqId').val(reqId);
	$j('#selected-subreqId').val(subreqId);
	
	var pseudo = $j('#'+subreqId).attr('pseudo');
	$j("#exceptMod-psuedo").text(pseudo);
	
	showExceptMod1();
}

function setReqModCounts(reqId){
	
	var subCount = $j('#'+reqId).attr('rqdsubreq');
	var courseCount = $j('#'+reqId).attr('rqdcount');
	var hourCount = $j('#'+reqId).attr('rqdhours');
	var gpaCount = $j('#'+reqId).attr('rqdgpa');
	
	$j('#req-sub-count-org').html(subCount);
	$j('#req-course-count-org').html(courseCount);
	$j('#req-hour-count-org').html(hourCount);
	$j('#req-gpa-count-org').html(gpaCount);
}

function forceCourseSubrequirement(event, subreqId){
	
	$j('.exceptMod-reqText-label').text('Subrequirement  ');
	$j('.exceptMod-editName').text('Force Course');
	$j('.courseMod-chosen-label').text('Course Forcing :');
	$j('#nav-step1-label').text('Force Course');
	$j('#nav-step2-label').text('Verify & Save');
	
	$j('#exceptionType').val("forceCourse");
	
	$j('#rnameCheckbox').hide();
	$j('.manaul-add-course').hide();
	$j('#course-taken-list').show();
	$j('#course-remove-list').hide();
	$j('#exceptMod-coursePrompt').show();
	$j('#exceptMod-requirements').html('Select at least one course');
	
	$j('#'+subreqId).find('.subreqTitle').addClass("auditHighlight");
	
	showCourseModForm(event,subreqId,null);
}

function addCourseSubrequirement(event, subreqId, fromId){
	
	$j('.exceptMod-reqText-label').text('Subrequirement  ');
	$j('.exceptMod-editName').text('Add Course');
	$j('.courseMod-chosen-label').text('Course Adding :');
	$j('#course-list-label').text('Select a student course:');
	$j('#nav-step1-label').text('Add Course');
	$j('#nav-step2-label').text('Verify & Save');
	
	
	$j('#exceptionType').val("addCourse");
	
	$j('#'+fromId).addClass("auditHighlight");
	
	$j('.manaul-add-course').show();
	$j('#course-taken-list').show();
	$j('#course-remove-list').hide();
	$j('#exceptMod-coursePrompt').show();
	$j('#exceptMod-requirements').html('Select at least one course');
	
	showCourseModForm(event,subreqId,fromId);
}

function removeCourseSubrequirement(event, subreqId,fromId){
	
	$j('.exceptMod-reqText-label').text('Subrequirement  ');
	$j('.exceptMod-editName').text('Remove Course');
	$j('.courseMod-chosen-label').text('Course Removing :');
	$j('#course-list-label').text('Select course(s) you want to remove:');
	$j('#nav-step1-label').text('Remove Course');
	$j('#nav-step2-label').text('Verify & Save');
	
	$j('#exceptionType').val("removeCourse");
	
	$j('#'+fromId).addClass("auditHighlight");
	
	//load the course list courses for removal 
	loadRemoveListCourses(fromId);
	
	$j('.manaul-add-course').hide();
	$j('#course-taken-list').hide();
	$j('#course-remove-list').show();
	$j('#exceptMod-coursePrompt').show();
	$j('#exceptMod-requirements').html('Select at least one course');
	
	showCourseModForm(event,subreqId,fromId);
}

function swapCourseSubrequirement(event, subreqId,fromId){
	
	$j('.exceptMod-reqText-label').text('Subrequirement  ');
	$j('.exceptMod-editName').text('Swap Course');
	$j('.courseMod-chosen-label2').text('Swapping Out :');
	$j('.courseMod-chosen-label').text('Swapping In :');
	$j('#nav-step1-label').text('Swap Out');
	$j('#nav-step2-label').text('Swap In');
	$j('#nav-step3-label').text('Verify & Save');
	
	$j('#exceptMod-nav-step3').show();
	$j('.exceptMod-final2').show();
	$j('#exceptMod-coursePrompt').show();
	$j('#exceptMod-requirements').html('Select at least one course');
	
	$j('#exceptionType').val("swapCourse");
	
	$j('#'+fromId).addClass("auditHighlight");
	
	//load the course list courses for removal 
	loadRemoveListCourses(fromId);
	showCourseModForm(event,subreqId,fromId);
}

function loadRemoveListCourses(fromId){
	
	$j('#removeListTable').empty();
	
	$j('#'+fromId).find('.course').each(function(i){
		var dept = $j(this).attr('department');
		var num = $j(this).attr('number');
		var id = dept.replace(/ /g,"_")+num.replace(/ /g,"_")+i;
		
		var removeCourse = "<tr id=\"remove-course-"+id+"\"><td id=\"remove-course-name-"+id+"\">"+dept+num+"</td>"+ 
   					"<td><button class=\"btn btn-danger btn-xs\" onclick=\"addRemoveChosenCourse('"+id+"')\">" +
   					"<i class=\"fa fa-times\"><span class=\"sr-only\">remove course</span></i></button></td></tr>";
		
		$j('#removeListTable').append(removeCourse);
	});
	
}

function showCourseModForm(event,subreqId,fromId){
	
	showCurrentSubreq(event,subreqId);
	
	var subreqTitle = $j('#'+subreqId).find('.subreqTitle').html();
	$j(".exceptMod-reqText").html(subreqTitle);
	
	if(fromId == null){
		var pseudo = $j('#'+subreqId).attr('pseudo');
		$j("#exceptMod-psuedo").text(pseudo);
	}
	else{
		var pseudo = $j('#'+fromId).attr('pseudo');
		$j("#exceptMod-psuedo").text(pseudo);
	}
	
	var reqId = $j("#"+subreqId).parents('.requirement').attr('id');
	
	$j('#selected-reqId').val(reqId);
	$j('#selected-subreqId').val(subreqId);
	$j('#exceptMod-nav-step2').show();
	
	$j('#reqSubCountLabel').text('Required Course Count');
	$j('.requiredCourseCountEditBox').hide();
	
	showExceptMod1();
}

function showCurrentSubreq(event,subreqId){
	
	var reqId = $j('#'+subreqId).parents('.requirement').attr('id');
	
	toggleOpen(event,reqId);
	
	$j('.requirement').hide();
	$j('.subrequirement').hide();
	$j('#'+reqId).show();
	$j('#'+subreqId).show();
	$j('#exceptionList').hide();
	hideExceptionButtons();
}

function showExceptionList(){
	
	//remove highlights from the audit
	$j('.reqText').css({border:'none'});
	$j('.subreqTitle').css({border:'none'});
	$j('.selectcourses').css({border:'none'});
	$j('.notcourses').css({border:'none'});
	showExceptMod1();
	
	//display the whole audit
	$j('.requirement').show();
	$j('.subrequirement').show();
	$j('#reqSubCountLabel').text('Required Sub-requirements');
	$j('.requiredCourseCountEditBox').show();
	$j('#exceptMod').hide();
	
	//reset exception specific workflow
	$j('.taken-course').show();
	$j('.reqAddCourse').show();
	$j('#chosen-box').show();
	$j('#chosen-box2').hide();
	$j('.exceptMod-final2').hide();
	$j('#showReqAdustButton').show();
	$j('#hideReqAdustButton').hide();
	$j('#addReqAdjustBox').show();
	
	$j('#chosen-course-table').empty();
	$j('#chosen-course-table2').empty();
	$j('#final-course-table').empty();
	$j('#final-course-table2').empty();
	
	$j('.courseMod-step1').hide();
	$j('.courseMod-step2').hide();
	
	$j('.reqMod').hide();
	$j('.exceptMod-final').hide();
	$j('.forceComplete').hide();
	$j('#rnameCheckbox').show();
	
	//reset inputs
	$j('.form-control').val(' ');
	$j('.req-count-edit').val(0);
	$j('.req-count-edit-decimal').val((0).toFixed(2));
	$j("input#numberSearch").val('');
	$j("input#departSearch").val('');
	
	//reset general workflow
	$j('#exceptMod-next').hide();
	$j('#exceptMod-coursePrompt').hide();
	$j('#exceptMod-valuePrompt').hide();
	$j('#exceptMod-requirements').html('');
	$j('#exceptMod-change-step1').val('false');
	$j('#exceptMod-change-step2').val('false');
	$j('#exceptionType').val("");
	
	$j('#exceptMod-nav-step3').hide();
	$j('#exceptMod-nav-step2').hide();
	
	$j('#exceptionList').show();
	showExceptionButtons();
	
	configsLoaded = false;
}

function showExceptMod1(){
	var exceptionType = $j('#exceptionType').val();
	
	$j('#exceptMod').show();
	
	if($j('#exceptMod-change-step1').val() == "true"){
		$j('#exceptMod-next').show();
		$j('#exceptMod-coursePrompt').hide();
		$j('#exceptMod-valuePrompt').hide();
		$j('#exceptMod-requirements').html('Can continue');
	}
	
	$j('#exceptMod-next').attr("onclick","showExceptMod2()");
	$j('#exceptMod-back').hide();
	
	$j('#exceptMod-nav-step1').addClass('active');
	$j('#exceptMod-nav-step2').removeClass('active');
	$j('#exceptMod-nav-step3').removeClass('active');
	
	if(exceptionType == "reqMod"){
		
		$j('.reqMod').show();
		$j('.reqMod-step1').show();
		$j('.reqMod-step2').hide();
		$j('.exceptMod-final').hide();
	}
	
	if(exceptionType == "forceComplete"){
		
		$j('.forceComplete').show();
		$j('.exceptMod-final').show();
		loadExceptionConfigs(exceptionType);
	}
	
	if(exceptionType == "addCourse" || exceptionType == "forceCourse" 
		|| exceptionType == "removeCourse" ){
		
		setChosenCourseTable();
		addDateRangeLinks();
		
		$j('.courseMod-step1').show();
		$j('.courseMod-step2').hide();
		$j('.exceptMod-final').hide();
	}
	
	if(exceptionType == "swapCourse"){
		
		$j('.courseMod-step1').show();
		$j('.courseMod-step2').hide();
		
		$j('#course-list-label').text('Select course(s) you want to swap out:');
		
		$j('.manaul-add-course').hide();
		$j('#course-taken-list').hide();
		$j('#course-remove-list').show();
		$j('#chosen-box').hide();
		$j('#chosen-box2').show();
	}
}

function showExceptMod2(){
	var exceptionType = $j('#exceptionType').val();
	
	if($j('#exceptMod-change-step1').val() == "true"){
		
		$j('#exceptMod-nav-step1').removeClass('active');
		$j('#exceptMod-nav-step3').removeClass('active');
		$j('#exceptMod-nav-step2').addClass('active');
		
		if(exceptionType == "reqMod"){
			
			$j('#exceptMod-next').hide();
			$j('#exceptMod-back').show();
			$j('#exceptMod-back').attr("onclick","showExceptMod1()");
			$j('.exceptMod-final').show();
			
			
			$j('.reqMod-step1').hide();
			$j('.reqMod-step2').show();
			
			var subCount = $j('#req-sub-count-edit').val();
			var hourCount = $j('#req-hour-count-edit').val();
			var courseCount = $j('#req-course-count-edit').val();
			var gpaCount = $j('#req-gpa-count-edit').val();
			
			$j("#req-sub-count-show").html(subCount);
			$j("#req-hour-count-show").html(hourCount);
			$j("#req-course-count-show").html(courseCount);
			$j("#req-gpa-count-show").html(gpaCount);
			
			loadExceptionConfigs(exceptionType);
		}
		
		if(exceptionType == "addCourse" || exceptionType == "forceCourse" || exceptionType == "removeCourse"){
			
			$j('#exceptMod-next').hide();
			$j('#exceptMod-back').show();
			$j('#exceptMod-back').attr("onclick","showExceptMod1()");
			$j('.exceptMod-final').show();
			
			$j('.courseMod-step1').hide();
			$j('.courseMod-step2').show();
			
			if(exceptionType == "forceCourse"){
				$j('#addReqAdjustBox').hide();
			}
			
			setFinalCourseTable();
			removeDateRangeLinks();
			loadExceptionConfigs(exceptionType);
		}
		
		if(exceptionType == "swapCourse"){
			
			if($j('#exceptMod-change-step2').val() == "true"){
				$j('#exceptMod-next').show();
				$j('#exceptMod-coursePrompt').hide();
				$j('#exceptMod-requirements').html('Can continue');
			}
			else{
				$j('#exceptMod-next').hide();
				$j('#exceptMod-coursePrompt').show();
				$j('#exceptMod-requirements').html('Select at least one course');
			}
			
			$j('#exceptMod-next').attr("onclick","showExceptMod3()");
			$j('#exceptMod-back').show();
			$j('#exceptMod-back').attr("onclick","showExceptMod1()");
			$j('.exceptMod-final').hide();
			
			$j('.courseMod-step1').show();
			$j('.courseMod-step2').hide();
			
			$j('#course-list-label').text('Select course(s) you want to swap In:');
			
			$j('.manaul-add-course').show();
			$j('#course-taken-list').show();
			$j('#course-remove-list').hide();
			$j('#chosen-box').show();
			$j('#chosen-box2').hide();
			
			setChosenCourseTable();
			addDateRangeLinks();
		}
	}
}

function showExceptMod3(){
	var exceptionType = $j('#exceptionType').val();
	
	if($j('#exceptMod-change-step1').val() == "true" 
		&& $j('#exceptMod-change-step2').val() == "true"){
		
		$j('#exceptMod-nav-step1').removeClass('active');
		$j('#exceptMod-nav-step3').addClass('active');
		$j('#exceptMod-nav-step2').removeClass('active');
		
		if(exceptionType == "swapCourse"){
			
			$j('#exceptMod-next').hide();
			$j('#exceptMod-back').show();
			$j('#exceptMod-back').attr("onclick","showExceptMod2()");
			$j('.exceptMod-final').show();
			
			$j('.courseMod-step1').hide();
			$j('.courseMod-step2').show();
			
			setFinalCourseTable();
			removeDateRangeLinks();
			loadExceptionConfigs(exceptionType);
		}
	}
}

function addDateRangeLinks(){
	
	$j('.dateRange-nolink').each(function(){
		
		var html = $j(this).html();
		var courseId = $j(this).parents('.chosen-course-row').attr('courseid');
		
		$j(this).after("<a class=\"dateRange-link\" onclick=\"showDateRange('"+courseId+"'); return false;\" style=\"text-decoration: underline; cursor: pointer;\">"+html+"</a>");
		$j(this).remove();
	});
	
	$j('.addDate-nolink').each(function(){
		
		var courseId = $j(this).parents('.chosen-course-row').attr('courseid');
		
		$j(this).after("<a class=\"addDate-link\" href=\"#\" onclick=\"showDateRange('"+courseId+"');return false;\" style=\"text-decoration: underline; cursor: pointer;\">Add Date</a>");
		$j(this).remove();
	});
}

function removeDateRangeLinks(){
	
	$j('.dateRange-link').each(function(){
		
		var html = $j(this).html();
		$j(this).after("<span class=\"dateRange-nolink\">"+html+"</span>");
		$j(this).remove();
	});
	
	$j('.addDate-link').each(function(){
		
		$j(this).after("<span class=\"addDate-nolink\">Not Taken</span>");
		$j(this).remove();
	});
}

function removeException(intSeqNo, ctlcd){
	
	$j("#exception-"+intSeqNo).addClass("danger");
	
	$j.ajax({
		type: "POST",
		traditional: true,
		url: "delete-exception.html",
		data: {
			"intSeqNo": intSeqNo,
			"ctlcd": ctlcd,
		  },
		 dataType: "json",
			success : function(json) {
				$j("#exception-"+intSeqNo).remove();
				
			},
			error : function(json) {
			}
	});
}

var cName, cHours, cTitle, cGrade, cDate = "";

function manualAddChosenCourse(){
	
	$j.ajax({
		type: "POST",
		traditional: true,
		url: "get-catalog-course.html",
		data: {
			"number": $j("input#numberSearch").val(),
			"depart": $j("input#departSearch").val(),
		  },
		 dataType: "json",
			success : function(json) {
				
				cName = json.course;
				cHours = "("+json.hours+" "+$j('#hours-label').val()+"s)";
				cTitle = json.title;
				cGrade = "";
				cDate = "";
				
				var chosenRow = createChosenCourse(json.courseId);
				
				$j('#chosen-course-table').append(chosenRow);
				$j('#chosen-course-table').show();
				
				$j("input#numberSearch").val('');
				$j("input#departSearch").val('');

			},
			error : function(json) {
			}
	});
}

function addRemoveChosenCourse(courseId){
	
	var exceptionType = $j('#exceptionType').val();
	
	$j('#exceptMod-next').show(); 
	$j('#exceptMod-coursePrompt').hide();
	$j('#exceptMod-requirements').html('Can continue');
	$j('#exceptMod-change-step1').val('true');
	
	var course = $j("[id='remove-course-name-"+courseId+"']").text();
	var onclick  = "";
	
	if(exceptionType != "swapCourse"){
		onclick = "onclick=\"removeChosenCourse('"+courseId+"')\"";
	}
	else{
		onclick = "onclick=\"removeChosenCourse2('"+courseId+"')\"";
	}
	
	var chosenRow = "<tr  class=\"chosen-course-row\"id=\"chosen-course-"+courseId+"\" courseid=\""+courseId+"\"><td>"+
	"<span id=\"chosen-course-name-"+courseId+"\" class=\"chosen-course-name exc-course\">"+course+"</span></td>"+
	"</td><td class=\"exc-stuff\">"+
	"<button id=\"remove-chosen-"+courseId+"\" class=\"btn btn-danger btn-xs\" style=\"margin-bottom: 7px;\" "+onclick+" ><i class=\"fa fa-trash-o\"><span class=\"sr-only\">remove course</span></i></button>"+
	"</td></tr>";
	
	
	if(exceptionType != "swapCourse"){
		$j('#chosen-course-table').append(chosenRow);
		$j('#chosen-course-table').show();
		$j("[id='remove-course-"+courseId+"']").hide();
	}
	else{
		$j('#chosen-course-table2').append(chosenRow);
		$j('#chosen-course-table2').show();
		$j("[id='remove-course-"+courseId+"']").hide();
	}
}

function addChosenCourse(courseId){
	
	cName = $j('[id="exc-course-name-'+courseId+'"]').text();
	cHours = $j('[id="exc-course-hours-'+courseId+'"]').text();
	cTitle = $j('[id="exc-course-title-'+courseId+'"]').text();
	cGrade = $j('[id="exc-course-grade-'+courseId+'"]').text();
	cDate = "";
	
	if($j('#exceptionType').val() == "forceCourse"){
		$j('.reqAddCourse').hide();
		cDate = $j('[id="exc-course-date-'+courseId+'"]').val();
	}
	
	var chosenRow = createChosenCourse(courseId);
	
	$j('#chosen-course-table').append(chosenRow);
	$j('#chosen-course-table').show();
	$j('[id="exc-course-'+courseId+'"]').hide();
}

function createChosenCourse(courseId){
	
	if(cDate == ""){
		cDate = "<a  class=\"addDate-link\" href=\"#\" onclick=\"showDateRange('"+courseId+"'); return false;\" style=\"text-decoration: underline; cursor: pointer;\">Add Date</a>";
	}
	
	var dateRange = "<a class=\"dateRange-link\" href=\"#\" tabindex=\"0\" onclick=\"showDateRange('"+courseId+"');return false;\" style=\"text-decoration: underline; cursor: pointer;\">" +
					"<span id=\"chosen-course-fyt-"+courseId+"\"  class=\"chosen-course-fyt exc-term3\" ></span>-" +
					"<span id=\"chosen-course-lyt-"+courseId+"\"  class=\"chosen-course-lyt exc-term3\" ></span></a>";
	
	var chosenRow = "<tr  class=\"chosen-course-row\"id=\"chosen-course-"+courseId+"\" courseid=\""+courseId+"\"><td>"+
		"<span id=\"chosen-course-name-"+courseId+"\" class=\"chosen-course-name exc-course\">"+cName+"</span><br>"+
		"<span id=\"chosen-course-dateRange-"+courseId+"\" style=\"display:none;\">"+dateRange+"</span>"+
		"<span id=\"chosen-course-date-"+courseId+"\"  class=\"chosen-course-date exc-term3\">"+cDate+"</span><br>"+
		"<span id=\"chosen-course-hours-"+courseId+"\"  class=\"chosen-course-hours exc-hours\">"+cHours+"</span>" +
		"<span id=\"chosen-course-grade-"+courseId+"\"  class=\"chosen-course-grade exc-grade\">"+cGrade+"</span><br>"+
		"<span id=\"chosen-course-title-"+courseId+"\"  class=\"chosen-course-title exc-title2\">"+cTitle+"</span>"+
		"</td><td class=\"exc-stuff\">"+
		"<button id=\"remove-chosen-"+courseId+"\" class=\"btn btn-danger btn-xs\" style=\"margin-bottom: 7px;\" onclick=\"removeChosenCourse('"+courseId+"')\"><i class=\"fa fa-trash-o\"><span class=\"sr-only\">remove course</span></i></button>"+
		"</td></tr>";
	
	return chosenRow;
}

function showDateRange(courseId){
	
	var dateRange = "<tr class=\"dateRange-"+courseId+"\"  style=\"border-top: 0px;\">"+
						"<td style=\"border-top: 0px;padding-bottom: 2px;font-weight: bold;\">FYT <input type=\"text\" style=\"width: 80px;display: inline;\" class=\"form-control\" id=\"fyt-"+courseId+"\" maxlength=\"6\"> </td>"+
						"<td class=\"exc-stuff\"><button class=\"btn btn-danger btn-xs\" alt=\"Cancel Date Range\" title=\"Cancel Date Range\" onclick=\"cancelDateRange('"+courseId+"')\"><i class=\"fa fa-undo\"></i></button></td></tr>"+
					"<tr class=\"dateRange-"+courseId+"\" style=\"border-top: 0px;\">"+
						"<td style=\"border-top: 0px;padding-bottom: 2px;font-weight: bold;\">LYT <input type=\"text\" style=\"width: 80px;display: inline;\" class=\"form-control\" id=\"lyt-"+courseId+"\" maxlength=\"6\"> </td>"+
						"<td class=\"exc-stuff\"><button class=\"btn btn-success btn-xs\" alt=\"Save Date Range\" title=\"Save Date Range\" onclick=\"addDateRange('"+courseId+"')\"><i class=\"fa fa-save\"></i></button></td></tr>";
	
	var fyt = $j("[id='chosen-course-fyt-"+courseId+"']").text();
	var lyt = $j("[id='chosen-course-lyt-"+courseId+"']").text();
	
	$j("[id='chosen-course-"+courseId+"']").after(dateRange);
	$j('[id="fyt-'+courseId+'"]').val(fyt)
	$j('[id="lyt-'+courseId+'"]').val(lyt);
	
	$j("[id='chosen-course-date-"+courseId+"']").hide();
	$j("[id='remove-chosen-"+courseId+"']").hide();
	$j("[id='chosen-course-dateRange-"+courseId+"']").hide();
	$j('#exceptMod-next').hide();
}

function addDateRange(courseId){
	
	var fyt = $j('[id="fyt-'+courseId+'"]').val();
	var lyt = $j('[id="lyt-'+courseId+'"]').val();
	
	if(fyt != "" && lyt == ""){
		$j('[id="lyt-'+courseId+'"]').parent().addClass("has-error");
	}
	else if (fyt == "" && lyt != ""){
		$j('[id="fyt-'+courseId+'"]').parent().addClass("has-error");
	}
	else if (fyt == "" && lyt == ""){
		cancelDateRange(courseId);
	}
	else{
		$j("[id='chosen-course-fyt-"+courseId+"']").text(fyt);
		$j("[id='chosen-course-lyt-"+courseId+"']").text(lyt);
		
		$j('[class="dateRange-'+courseId+'"]').remove();
		$j("[id='remove-chosen-"+courseId+"']").show();
		$j("[id='chosen-course-dateRange-"+courseId+"']").show();
		
		if($j('tr[class*=dateRange]').length == 0){
			$j('#exceptMod-next').show();
		}
	}
}

function cancelDateRange(courseId){
	
	$j('[class="dateRange-'+courseId+'"]').remove();
	$j("[id='remove-chosen-"+courseId+"']").show();
	
	var fyt = $j("[id='chosen-course-fyt-"+courseId+"']").text();
	var lyt = $j("[id='chosen-course-lyt-"+courseId+"']").text();
	
	if( lyt == "" && fyt == ""){
		$j("[id='chosen-course-date-"+courseId+"']").show();
	}
	else{
		$j("[id='chosen-course-dateRange-"+courseId+"']").show();
	}
	
	if($j('tr[class*=dateRange]').length == 0){
		$j('#exceptMod-next').show();
	}
}

function setFinalCourseTable(){
	
	var chosenRows = $j('#chosen-course-table').html();
	$j('#final-course-table').append(chosenRows);
	$j('#final-course-table .exc-stuff').hide();
	$j('#chosen-course-table').empty();
	
	var chosenRows2 = $j('#chosen-course-table2').html();
	$j('#final-course-table2').append(chosenRows2);
	$j('#final-course-table2 .exc-stuff').hide();
	$j('#chosen-course-table2').empty();
}

function setChosenCourseTable(){
	
	var rowCount = $j('#final-course-table tr').length;
	
	if( rowCount > 0){
		
		var chosenRows = $j('#final-course-table').html();
		$j('#chosen-course-table').append(chosenRows);
		$j('#chosen-course-table .exc-stuff').show();
		$j('#final-course-table').empty();
	}
	
	var rowCount2 = $j('#final-course-table2 tr').length;
	
	if( rowCount2 > 0){
		
		var chosenRows = $j('#final-course-table2').html();
		$j('#chosen-course-table2').append(chosenRows);
		$j('#chosen-course-table2 .exc-stuff').show();
		$j('#final-course-table2').empty();
	}
}

function removeChosenCourse(courseId){
	
	var exceptionType = $j('#exceptionType').val();
	
	$j('[ id="chosen-course-'+courseId+'"]').remove();
	$j('[ id="exc-course-'+courseId+'"]').show();
	$j('[ id="remove-course-'+courseId+'"]').show();
	$j('.reqAddCourse').show();
	
	var rowCount = $j('#chosen-course-table tr').length;
	
	if( rowCount == 0 ){
		$j('#exceptMod-next').hide();
		$j('#exceptMod-coursePrompt').show();
		$j('#exceptMod-requirements').html('Select at least one course');
		
		if(exceptionType != "swapCourse"){
			$j('#exceptMod-change-step1').val('false');
		}
		else{
			$j('#exceptMod-change-step2').val('false');
		}
	}
}

function removeChosenCourse2(courseId){
	
	$j('[ id="chosen-course-'+courseId+'"]').remove();
	$j('[ id="exc-course-'+courseId+'"]').show();
	$j('[ id="remove-course-'+courseId+'"]').show();
	$j('.reqAddCourse').show();
	
	var rowCount2 = $j('#chosen-course-table2 tr').length;
	
	if(rowCount2 == 0 ){
		$j('#exceptMod-next').hide();
		$j('#exceptMod-coursePrompt').show();
		$j('#exceptMod-requirements').html('Select at least one course');
		$j('#exceptMod-change-step1').val('false');
	}
}

function showReqAdjust(){
	
	$j('#showReqAdustButton').hide();
	$j('#hideReqAdustButton').show();
	
	var subreqId = $j('#selected-subreqId').val();
	setReqModCounts(subreqId);
	
	$j('.reqMod').show();
	$j('.reqMod-step1').show();
	$j('.reqMod-step2').hide();
}

function hideReqAdjust(){
	
	$j('#showReqAdustButton').show();
	$j('#hideReqAdustButton').hide();
	
	$j('.req-count-edit').val(0);
	$j('.req-count-edit-decimal').val((0).toFixed(2));
	
	$j('.reqMod').hide();
	$j('.reqMod-step1').hide();
}


function hideExceptionButtons(){
	
	$j('.requirement-buttons').hide();
	$j('.subrequirement-buttons').hide();
	$j('.selectfrom-buttons').hide();
	$j('.notfrom-buttons').hide();
}

function showExceptionButtons(){
	
	$j('.requirement-buttons').show();
	$j('.subrequirement-buttons').show();
	$j('.selectfrom-buttons').show();
	$j('.notfrom-buttons').show();
}

function toggleOpen(event,reqId){
	
	jQuery.fn.notExists = function(){return this.length == 0;}
	
	//stop toggle if req is already open
	if($j('#'+reqId).find('.reqBody').is(":visible") ){
		var e = $j.event.fix(event);
		 e.stopPropagation();
	}
}

var configsLoaded = false;

function loadExceptionConfigs(exceptionType){
	
	if( !configsLoaded){
		configsLoaded = true;
		
		var url = "get-exception-configs.html";
		
		$j.ajax({
			type: "POST",
			url: url,
			traditional: true,
			data: {'exceptionType': exceptionType},
			 dataType: "json",
				success : function(json) {
					
					$j('.inputNote').val(json.note);
					$j('.inputMemo').val(json.memo);
					$j('.inputAuthorized ').val(json.name);
					$j('.inputBy').val(json.date);
					$j('#includeDprog').prop('checked', json.restrictToDprog);
					$j('#includeRname').prop('checked', json.restrictToReq);
				},
				error : function(json) {}
		});
	}
	

}
