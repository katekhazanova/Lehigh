/** Below is the code for submiting the different 
 * audit expcetion types and runing the audit **/

var eData;

function addAuditException(runAudit){
	
	var url = "add-audit-exception.html";
	
	eData = new Object();
	eData.runAudit = runAudit;
	eData.exceptionType = $j("#exceptionType").val();
	
	loadGeneralOptions();
	
	if(eData.exceptionType == "reqMod"){
		loadReqModOptions();
	}
	
	if(eData.exceptionType == "forceCourse"){
		loadForceCourseOptions();
	}
	
	if(eData.exceptionType == "addCourse"){
		loadReqModOptions();
		loadAddCourseOptions();
	}
	
	if(eData.exceptionType == "removeCourse"){
		loadReqModOptions();
		loadRemoveCourseOptions();
	}
	
	if(eData.exceptionType == "swapCourse"){
		loadReqModOptions();
		loadSwapCourseOptions();
	}
	
	 if(runAudit == "true"){
		 notifyAuditLoading();
	 }
	
	$j.ajax({
		type: "POST",
		url: url,
		traditional: true,
		data: eData,
		 dataType: "json",
			success : function(json) {
				
				notifyExceptionAdded(runAudit,json);

			},
			error : function(json) {
				
				notifyExceptionAddError();
			}
	});
}

function loadReqModOptions(){
	
	 eData.subCount = $j('#req-sub-count-edit').val();
	 eData.hourCount = $j('#req-hour-count-edit').val();
	 eData.courseCount = $j('#req-course-count-edit').val();
	 eData.gpaCount = $j('#req-gpa-count-edit').val();
}

function loadForceCourseOptions(){
	
	eData.course = $j('#final-course-table .chosen-course-name').text();
	eData.courseDate = $j('#final-course-table .chosen-course-date').text();
}

function loadAddCourseOptions(){
	
	var rCourses = [];
	var courseFyts = [];
	var courseLyts = [];
	
	$j('#final-course-table .chosen-course-name').each(function(){
		rCourses.push($j(this).text());
	});
	
	$j('#final-course-table .chosen-course-fyt').each(function(){
		
		courseFyts.push($j(this).text());
		courseLyts.push($j(this).siblings('#final-course-table  .chosen-course-lyt').text());
		
	});
	
	eData.rCourses = rCourses;
	eData.courseFyts = courseFyts;
	eData.courseLyts = courseLyts;
}

function loadRemoveCourseOptions(){
	
	var courses = [];
	
	$j('#final-course-table .chosen-course-name').each(function(){
		courses.push($j(this).text());
	});
	
	eData.courses = courses;
}

function loadSwapCourseOptions(){
	
	var rCourses = [];
	var courses = [];
	var courseFyts = [];
	var courseLyts = [];
	
	$j('#final-course-table2 .chosen-course-name').each(function(){
		courses.push($j(this).text());
	});
	
	$j('#final-course-table .chosen-course-name').each(function(){
		rCourses.push($j(this).text());
	});
	
	$j('#final-course-table .chosen-course-fyt').each(function(){
		
		courseFyts.push($j(this).text());
		courseLyts.push($j(this).siblings('#final-course-table  .chosen-course-lyt').text());
		
	});
	
	eData.rCourses = rCourses;
	eData.courses = courses;
	eData.courseFyts = courseFyts;
	eData.courseLyts = courseLyts;
}

function loadGeneralOptions(){
	 var reqId = $j('#selected-reqId').val();
	 
	 eData.comKey = $j('#audit').attr('com');
	 eData.yearTerm = $j('#audit').attr('catlyt');
	 eData.note = $j('.inputNote').val();
	 eData.memo = $j('.inputMemo').val();
	 eData.authorized = $j('.inputAuthorized').val();
	 eData.by = $j('.inputBy').val();
	 eData.includeip = $j('#audit').attr('includeip');
	 eData.wifread = $j('#audit').attr('wifread');
	 eData.wifdprog = $j('#audit').attr('wifdprog');
	 eData.forcedprog = $j('#audit').attr('forcedprog');
	 eData.forcecatlyt = $j('#audit').attr('forcecatlyt');
	 eData.pseudo  = $j('#exceptMod-psuedo').text();
	 eData.dpmask = $j('#audit').attr('dpmask');
	 eData.evalsw = $j('#audit').attr('evalsw');
	 eData.soprid = $j('#audit').attr('soprid');
	 eData.authCode = ' ';
	 
	 var authCode = checkReqAuthCodes(reqId,'id');
	 
	 if(authCode != "failed"){
		 eData.authCode = authCode;
	 }
	 
	 
	 if($j('#includeDprog').is(':checked')) {
		 eData.dprog = $j('#audit').attr('dprog');
	 }
	 else{
		 eData.dprog = "";
	 }
	 
	 if($j('#includeRname').is(':checked')) {
		 eData.rname = $j('#'+reqId).attr('rname');
	 }
	 else{
		 eData.rname = "";
	 }
}

function notifyAuditLoading(){
	
	$j('#loadingAudit').show();
	
	$j.pnotify({
	    title: 'Attempting to Save Exception and Run Audit...',
	    text: 'Attempting to Save Exception with note: ' + eData.note,
    	addclass: 'custom',
		opacity: .8,
		nonblock: true,
		nonblock_opacity: .2
	});
	
	//showExceptionList();
	//$j('.requirement-buttons').hide();
	//$j('.subrequirement-buttons').hide();
	//$j('.selectfrom-buttons').hide();
}

function notifyExceptionAdded(runAudit, json){
	
	if(runAudit == "true"){
		
		var url = "read.html?id="+json.auditId;
		window.location.replace(url);
		
	}else{
		
		$j('#ExceptionAdded').show();
		showExceptionList();
		$j.pnotify({
		    title: 'New Exception was Saved',
		    text: 'A new Exception was saved with note: ' + eData.note,
	    	addclass: 'custom',
			opacity: .8,
			nonblock: true,
			nonblock_opacity: .2
		});
	}
	
	var intSeqNo = json.intSeqNo;
	var ctlcd = json.ctlcd;
	var canDelete = json.canDelete;
	//var deleteTD = "<td></td>";
	
	//if(canDelete == "true"){
	//	deleteTD = 	"<td><button id=\"remove-exception-"+intSeqNo+"\" class=\"btn btn-danger btn-xs\" onclick=\"removeException('"+intSeqNo+"','"+ctlcd+"')\"><i class=\"fa fa-trash-o\"></i></button></td>";
	//}
	
	var addException= "<tr id=\"exception-"+intSeqNo+"\" class=\"success\">"+
				"<td>"+ctlcd+"</td>"+
		      	"<td>"+eData.note+"</td>"+
		      	"<td>"+eData.authorized+"</td>"+
		      	"<td>"+eData.by+"</td>"+
		      	"</tr>";
		
	$j('#currentExceptions').append(addException);
}

function notifyExceptionAddError(){
	
	$j('#loadingAudit').hide();
	
	$j.pnotify({
	    title: 'Unable to Save New Exeception.',
	    text: 'There was an error saving the exception with note: '+ eData.note,
    	addclass: 'warning',
		opacity: .8,
		nonblock: true,
		nonblock_opacity: .2
	});
}