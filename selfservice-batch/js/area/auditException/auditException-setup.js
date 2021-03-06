/** Below is the code for setting up the audit exception area
including shrinking audit, adding button listeners, and 
input validation and auto complete **/

$j( document ).ready(function() {
	var exceptionMode = $j('#exceptionMode').val();
	
	if(exceptionMode){
		scaleDownAudit();
		addExceptionsButtons();
		addNextButtonListeners();
		addCourseCatAutoComplete();
		addInputValidation();
	}
});

function addNextButtonListeners(){
	
	//Add listeners to controls enabling the next button in exception work flow
	$j(' .reqAddCourse').click(function(){
		
		if($j('tr[class*=dateRange]').length == 0 && ! $j('.exceptMod-final').is(":visible") ){
			showNextButton();
			hidePrompts();
		}
	});
	
	$j('.reqAdjustButton').click(function(){
		
		if($j('#exceptionType').val() == "reqMod"){
			
			if(! $j('.exceptMod-final').is(":visible") && !isReqValuesDefault()){
				showNextButton();
				hidePrompts();
			}
			else{
				hideNextButton();
				$j('#exceptMod-valuePrompt').show();
			}
		}
	});
	
	$j('.req-count-edit, .req-count-edit-decimal').change(function(){
		
		if($j('#exceptionType').val() == "reqMod"){
		
			if(! $j('.exceptMod-final').is(":visible") && !isReqValuesDefault()){
				showNextButton();
				hidePrompts();
			}
			else{
				hideNextButton();
				$j('#exceptMod-valuePrompt').show();
			}
		}
	});
}

function showNextButton(){
	$j('#exceptMod-next').show();
	$j('#exceptMod-change-step1').val('true');
	$j('#exceptMod-change-step2').val('true');
}

function hideNextButton(){
	$j('#exceptMod-next').hide();
	$j('#exceptMod-change-step1').val('false');
	$j('#exceptMod-change-step2').val('false');
}

function showCoursePrompt(){
	$j('#exceptMod-coursePrompt').show();
	$j('#exceptMod-requirements').html('Select at least one course');
}

function showValuePrompt(){
	$j('#exceptMod-valuePrompt').show();
	$j('#exceptMod-requirements').html('Alter at least one value');
}

function hidePrompts(){
	$j('#exceptMod-coursePrompt').hide();
	$j('#exceptMod-valuePrompt').hide();
	$j('#exceptMod-requirements').html('Can continue');
}

function isReqValuesDefault(){
	
	 var subCount = $j('#req-sub-count-edit').val();
	 var hourCount = $j('#req-hour-count-edit').val();
	 var courseCount = $j('#req-course-count-edit').val();
	 var gpaCount = $j('#req-gpa-count-edit').val();
	 
	 if(subCount != '0' || courseCount != '0' || hourCount !='0.00' || gpaCount != '0.00' ){
		 return false;
	 }
	 
	 return true
}

function addCourseCatAutoComplete(){
	
	//autoComplete being added to the course inputs
	$j("input#departSearch").autocomplete({
		scroll: true,
        minLength: 1,
        source:"get-department.html"
    });
	
	$j("input#numberSearch").autocomplete({
		scroll: true,
        minLength: 0,
        source: function(request, response) {
            $j.ajax({
                url: "get-number.html",
                dataType: "json",
                data: {
                	 term : request.term,
                	 depart : $j("input#departSearch").val()
                	},
                success: function( data) {
                    response(data);
                },
                error: function(jqXHR, textStatus, errorThrown){
                     console.log( textStatus);
                }
            });
        }
    });
}

function addInputValidation(){
	
//	var gpaCount = $j('#req-gpa-count-edit').val();
	
	//only allow numbers and decimals to be typed into the req adjust fields
	$j('.req-count-edit').keypress(function (e) {
		
	     //if the letter is not digit dont type anything
	     if (e.which != 45 && e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	               return false;
	    }
	     
	});
	
	$j('.req-count-edit-decimal').keypress(function (e) {
		
	     //if the letter is not digit or decimal dont type anything
	     if (e.which != 45 && e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57 )) {
	               return false;
	    }
	});
	
	$j('#req-sub-count-edit').change(function(){
		
	    var countVal = $j(this).val();
	    
	    if(countVal >= 100 || countVal <= -100){
	    	
	    	$j.pnotify({
	    	    title: 'Invalid Required Sub-requirements  ',
	    	    text: 'The Required Sub-requirements can only be a number between 99 and -99',
	        	addclass: 'warning',
	    		opacity: .8,
	    		nonblock: true,
	    		nonblock_opacity: .2
	    	});
	    	
	    	$j('#req-sub-count-edit').parent().addClass('has-error');
	    }
	    else{
	    	$j('#req-sub-count-edit').parent().removeClass('has-error');
	    }
	});
	
	$j('#req-course-count-edit').change(function(){
		
	    var countVal = $j(this).val();
	    
	    if(countVal >= 100 || countVal <= -100){
	    	
	    	$j.pnotify({
	    	    title: 'Invalid Required Course Count',
	    	    text: 'The Required Course Count can only be a number between 99 and -99',
	        	addclass: 'warning',
	    		opacity: .8,
	    		nonblock: true,
	    		nonblock_opacity: .2
	    	});
	    	
	    	$j('#req-course-count-edit').parent().addClass('has-error');
	    }
	    else{
	    	$j('#req-course-count-edit').parent().removeClass('has-error');
	    }
	});
	
	$j('#req-hour-count-edit').change(function(){
		
	    var countVal = $j(this).val();
	    
	    if(!(countVal <= 9999.99 && countVal >= -9999.99)){
	    	
	    	$j.pnotify({
	    	    title: "Required "+$j('#hours-label').val() +"s",
	    	    text: "The Required "+$j('#hours-label').val()+"s can only be a number between 9999.99 and -9999.99",
	        	addclass: 'warning',
	    		opacity: .8,
	    		nonblock: true,
	    		nonblock_opacity: .2
	    	});
	    	
	    	$j('#req-hour-count-edit').parent().addClass('has-error');
	    }
	    else{
	    	$j('#req-hour-count-edit').parent().removeClass('has-error');
	    }
	});
	
	$j('#req-gpa-count-edit').change(function(){
		
	    var countVal = $j(this).val();
	    
	    if(!(countVal <= 999.999 && countVal >= -999.999)){
	    	
	    	$j.pnotify({
	    	    title: 'Invalid Required GPA',
	    	    text: 'The Required GPA can only be a number between 999.999 and -999.999',
	        	addclass: 'warning',
	    		opacity: .8,
	    		nonblock: true,
	    		nonblock_opacity: .2
	    	});
	    	
	    	$j('#req-gpa-count-edit').parent().addClass('has-error');
	    }
	    else{
	    	$j('#req-gpa-count-edit').parent().removeClass('has-error');
	    }
	});
	
	$j(".inputBy").datepicker();
}

function scaleDownAudit(){
	
	$j("#audit").width(650);
	$j("#auditRequirements").width(650);
	$j("#auditRequirements .requirement .reqHeaderTable").width(650);
	$j("#auditRequirements .requirement .reqText").width(590).css({float:"none"});
	$j("#auditRequirements .requirement .requirementTotals .fieldlabel").width(100);
	$j("#auditRequirements .auditSubrequirements .subrequirement .subreqBody ").width(539);
	$j("#auditRequirements .auditSubrequirements .subrequirement .subreqBody .completedCourses .course").width(120);
	$j("#auditRequirements .auditSubrequirements .subrequirement .fromcourses ").width(550);
	$j("#auditRequirements .auditSubrequirements .subrequirement .selectfromcourses").css({display: "block", clear: "both", width: "100%", float: "left"});
	$j("#auditRequirements .auditSubrequirements .subrequirement .selectfromcourses .fromlabel").css({display: "block", clear: "left", float: "left", width: "100%", padding: "2px 0px 2px 3px"});
	$j("#auditRequirements .auditSubrequirements .subrequirement .selectfromcourses .fromcourselist").css({display: "block", clear: "left", float: "left"});
	$j("#auditRequirements .auditSubrequirements .subrequirement .selectfromcourses .selectfrom-buttons").css({display: "block", clear: "right", float: "right"});
	$j("#auditRequirements .auditSubrequirements .subrequirement .notfromcourses .notfrom-buttons").css({display: "block", clear: "right", float: "right"});
	$j("#auditRequirements .auditSubrequirements .subrequirement .notfromcourses").css({display: "block", clear: "both", width: "100%", float: "left"});
	$j("#auditRequirements .auditSubrequirements .subrequirement  .notfromcourses .fromlabel").css({display: "block", clear: "both", width: "100%", float: "left", padding: "2px 0px 2px 3px"});
	$j("#auditRequirements .reqBody").css({paddingLeft: "20px"});
	$j("#auditRequirements .requirement .requirementTotals .number ").css({display: "inline"});
	
	//Hide top and bottom text to save room
	$j(".includeBottomText").hide();
	$j(".includeTopText").hide();
	$j("#endText").hide();
}

function addExceptionsButtons(){
	
	var reqAdjustButton = "";
	var forceCompleteButton = "";
	var forceCourseButton = "";
	var addCourseButton = "";
	var removeCourseButton = "";
	var swapCourseButton = "";
	
	$j('.requirement-buttons').each(function(){
		var id = $j(this).parents('.requirement').attr('id');
		var pseudo = $j(this).parents('.requirement').attr('pseudo');

		if($j('#reqAdjustButton').val() == "true"){
			reqAdjustButton = "<button class=\"btn btn-req btn-xs\" alt=\"Edit Requirement\" title=\"Edit Requirement\" onclick=\"editAuditRequirement(event,'"+id+"')\"> <i class=\"fa fa-pencil\"><label class=\"sr-only\">Edit Requirement</label></i> </button>";
		}
		
		if($j('#forceCompleteButton').val() == "true" ){
			forceCompleteButton = "<button class=\"btn btn-req btn-xs\" alt=\"Force Requirement Complete\" title=\"Force Requirement Complete\" onclick=\"forceReqComplete(event,'"+id+"')\" > <i class=\"fa fa-check\"><label class=\"sr-only\">Force Requirement Complete</label></i> </button>";
		}
		
		if(pseudo != "" && checkReqAuthCodes(id)  !=  "failed"){
			
			var reqButtons = forceCompleteButton + reqAdjustButton;
			$j(this).html(reqButtons);
		}
	});
	
	$j('.subrequirement-buttons').each(function(){
		var id = $j(this).parents('.subrequirement').attr('id');
		var reqId = $j(this).parents('.requirement').attr('id');
		var pseudo = $j(this).parents('.subrequirement').attr('pseudo');
		
		if($j('#reqAdjustButton').val() == "true"){
			reqAdjustButton = "<button class=\"btn btn-subreq btn-xs\" alt=\"Edit Sub-requirement\" title=\"Edit Sub-requirement\" onclick=\"editAuditSubrequirement(event,'"+id+"')\"> <i class=\"fa fa-pencil\"><label class=\"sr-only\">Edit Sub-requirement</label></i> </button>";
		}
		
		if($j('#forceCompleteButton').val() == "true"){
			forceCompleteButton = "<button class=\"btn btn-subreq btn-xs\" alt=\"Force Sub-requirement Complete\" title=\"Force Sub-Req Complete\" onclick=\"forceSubreqComplete(event,'"+id+"')\" > <i class=\"fa fa-check\"><label class=\"sr-only\">Force Sub-requirement Complete</label></i> </button>";
		}
		
		if($j('#forceCourseButton').val() == "true" && $j('#course-taken-table tr').length > 0){
			forceCourseButton = "<button class=\"btn btn-subreq btn-xs\" alt=\"Force Course\" title=\"Force Course\" onclick=\"forceCourseSubrequirement(event,'"+id+"')\"> <i class=\"fa fa-arrow-down\"><label class=\"sr-only\">Force Course</label></i> </button>";
		}
		
		if(pseudo != "" && checkReqAuthCodes(reqId)  !=  "failed"){
			
			var subReqButtons = forceCourseButton + forceCompleteButton + reqAdjustButton;
			$j(this).html(subReqButtons);
		}
	});
	
	$j('.selectfrom-buttons').each(function(){
		var id = $j(this).parents('.selectcourses').attr('id');
		var pseudo = $j(this).parents('.selectcourses').attr('pseudo');
		var subreqId = $j(this).parents('.subrequirement').attr('id');
		var reqId = $j(this).parents('.requirement').attr('id');
		
		if($j('#addCourseButton').val() == "true"){
			addCourseButton = "<button class=\"btn btn-selectFrom btn-xs\" alt=\"Add Course\" title=\"Add Course\" onclick=\"addCourseSubrequirement(event,'"+subreqId+"','"+id+"')\"> <i class=\"fa fa-plus\"><label class=\"sr-only\">Add Course</label></i> </button>";
		}
		
		if($j('#removeCourseButton').val() == "true"){
			removeCourseButton = "<button class=\"btn btn-selectFrom btn-xs\" alt=\"Remove Course\" title=\"Remove Course\" onclick=\"removeCourseSubrequirement(event,'"+subreqId+"','"+id+"')\"> <i class=\"fa fa-minus\"><label class=\"sr-only\">Remove Course</label></i> </button>";
		}
		
		if($j('#swapCourseButton').val() == "true"){
			swapCourseButton = "<button class=\"btn btn-selectFrom btn-xs\" alt=\"Swap Course\" title=\"Swap Course\" onclick=\"swapCourseSubrequirement(event,'"+subreqId+"','"+id+"')\"> <i class=\"fa fa-exchange\"><label class=\"sr-only\">Swap Course</label></i> </button>";
		}
		
		if(pseudo != "" && checkReqAuthCodes(reqId)  !=  "failed"){
		
			var selectFromButtons = addCourseButton + removeCourseButton + swapCourseButton;
			$j(this).html(selectFromButtons);
		}
	});
	
	$j('.notfrom-buttons').each(function(){
		var id = $j(this).parents('.notcourses').attr('id');
		var pseudo = $j(this).parents('.notcourses').attr('pseudo');
		var subreqId = $j(this).parents('.subrequirement').attr('id');
		var reqId = $j(this).parents('.requirement').attr('id');
		
		if($j('#addCourseButton').val() == "true"){
			addCourseButton = "<button class=\"btn btn-notFrom btn-xs\" alt=\"Add Course\" title=\"Add Course\" onclick=\"addCourseSubrequirement(event,'"+subreqId+"','"+id+"')\"> <i class=\"fa fa-plus\"><label class=\"sr-only\">Add Course</label></i> </button>";
		}
		
		if($j('#removeCourseButton').val() == "true"){
			removeCourseButton = "<button class=\"btn btn-notFrom btn-xs\" alt=\"Remove Course\" title=\"Remove Course\" onclick=\"removeCourseSubrequirement(event,'"+subreqId+"','"+id+"')\"> <i class=\"fa fa-minus\"><label class=\"sr-only\">Remove Course</label></i> </button>";
		}
		
		if($j('#swapCourseButton').val() == "true"){
			swapCourseButton = "<button class=\"btn btn-notFrom btn-xs\" alt=\"Swap Course\" title=\"Swap Course\" onclick=\"swapCourseSubrequirement(event,'"+subreqId+"','"+id+"')\"> <i class=\"fa fa-exchange\"><label class=\"sr-only\">Swap Course</label></i> </button>";
		}
		
		if(pseudo != "" && checkReqAuthCodes(reqId)  !=  "failed"){
		
			var selectFromButtons = addCourseButton + removeCourseButton + swapCourseButton;
			$j(this).html(selectFromButtons);
		}
	});
}


function checkReqAuthCodes(id){
	
	//all authcodes have been trimmed before validating
	
	var authCode1 = $j("#"+id).attr('authcode1').trim();
	var authCode2 = $j("#"+id).attr('authcode2').trim();
	
	var foundCode = "failed";
	
	if( authCode1 == "" && authCode2 == ""){
		
		if(authCodes.length > 0){
			
			if($j.inArray("", authCodes) > -1){
				return " ";
			}
			else{
				return authCodes[0]
			}
		}
		else{
			return " ";
		}
	}
	else{
		$j.each(authCodes, function(index, value){
			
			if(authCode1 == value){
				foundCode = value;
				return false;
			}
		});
		
		 $j.each(authCodes, function(index, value){
			
			if(authCode2 == value){
				
				if(value == "" && foundCode != "failed"){
					return false;
				}
				else{
					foundCode = value;
					return false;
				}
			}
		});
		
		return foundCode
	}
}