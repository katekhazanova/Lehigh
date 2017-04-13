
$( document ).ready(function() {

	//force the search to uppercase
	$("#comkey, #stunos").css({textTransform: "uppercase"});

	if( $('#stunos').length > 0 && $('#stunos').val().length == 0){
		$('#stunos-button').prop( "disabled", true );
	}

	if( $('#stuno').length > 0 && $('#stuno').val().length == 0){
		$('#stuno-button').prop( "disabled", true );
	}
	
    $("#stuname").keypress(function (evt) {
    	//Deterime where our character code is coming from within the event
    	var charCode = evt.charCode || evt.keyCode;
    	if (charCode  == 13 && $('#stuname').val().length < 3) { //Enter key's keycode
    	return false;
    	}
    });
    
    $("#partialStuno").keypress(function (evt) {
    	//Deterime where our character code is coming from within the event
    	var charCode = evt.charCode || evt.keyCode;
    	if (charCode  == 13 &&  $('#partialStuno').val().length < 3) { //Enter key's keycode
    	return false;
    	}
    });
    
    $("#stuno").keypress(function (evt) {
    	//Deterime where our character code is coming from within the event
    	var charCode = evt.charCode || evt.keyCode;
    	if (charCode  == 13 &&  $('#stuno').val().length < 3) { //Enter key's keycode
    	return false;
    	}
    });

});

function processAudit(){
	var url = $('#contextPath').val() +  "/auditProcessing.ajax";
	
	$('.student-audits').each(function(){
		
		var stuno = $(this).attr('stuno');

		$.ajax({
			type: "POST",
			url: url,
			traditional: true,
			data: {"stuno": stuno},
			dataType: "json",
			success : function(json) {
				
				$("[id='student-"+stuno+"']").replaceWith(json.displayAllAuditInfo);
			},
			error : function(json) {
				$("[id='student-"+stuno+"']").find('.spinner').replaceWith("<div style=\"color: red;\">Processing Error</div>");
			}
		});
	});

}

function checkSearch(id){

	var searchSize = $('#'+id).val().length;

	if(searchSize >= 3){
		$('#'+id+'-button').prop( "disabled", false );
	}
	else{
		$('#'+id+'-button').prop( "disabled", true );
	}
}

function updateRunConfigs(){

	var url =  $('#contextPath').val() + "/auditviewer/updateRunOptions.ajax";

	var runConfigs = new Object();

	runConfigs.comkey = $('#comkey').val();
	runConfigs.serverName1 = $('#serverName1').val();
	runConfigs.serverName2 = $('#serverName2').val();
	runConfigs.startLine = $('#startLine').val();
	runConfigs.evalsw = $('#evalsw').val();
	runConfigs.soprid = $('#soprid').val();

	$.ajax({
		type: "POST",
		url: url,
		traditional: true,
		data: runConfigs,
		dataType: "json",
		success : function(json) {
		},
		error : function(json) {
			alert("Unable to update Run options!");
		}
	});
}


function updateStunoList(action){

	var url =  $('#contextPath').val() + "/auditviewer/updateStunoList.ajax";

	var stunoList = "";
	var submitUpdate = false;

	if(action == "clear"){
		$('#stunos').val('');
		submitUpdate = true;
		stunoList = "clear";
		$('#stunos-button').prop( "disabled", true );
	}

	if(action == "add"){

		var count = 0;

		$('.stuno:checked').each(function(){

			if(count > 0){
				stunoList +=  ", " + $(this).val().trim();
			}
			else{
				stunoList = $(this).val().trim();
			}
			++count;
		});

		if(count > 0){
			submitUpdate = true;
		}
		else{
			alert("Please select at least one student.");

		}
	}

	if(action == "update"){
		submitUpdate = true;
		stunoList = $('#stunos').val();

		if($('#stunos').val().length == 0){
			$('#stunos-button').prop( "disabled", true );
		}
		else{
			$('#stunos-button').prop( "disabled", false );
		}
	}

	if(submitUpdate){
		$.ajax({
			type: "POST",
			url: url,
			traditional: true,
			data: {"stunos": stunoList,"action": action},
			dataType: "json",
			success : function(json) {

				if(action == "add"){
					window.location.replace( $('#contextPath').val() + '/auditviewer/home.html#runAudits');
				}
			},
			error : function(json) {
				alert("Unable to update StunoList!");
			}
		});
	}
}

function compareAudits(){

	var count = 0;
	var jobids = new Array();

	$('.jobID:checked').each(function(){

		jobids[count] = $(this).val();
		++count;
	});

	if(count == 2){
		window.open( $('#contextPath').val() +  "/auditviewer/compareAudits.html?previous=true&jobid1=" + jobids[0] + "&jobid2=" + jobids[1],'_blank');
	}
	else if(count == 1){
		window.open($('#contextPath').val() + "/auditviewer/auditViewSingle.html?previous=true&jobid=" + jobids[0],'_blank');
	}
	else if(count == 0){
		alert("Select a Jobid");
	}
	else{
		alert("Select no more than 2 Jobids");
	}
}
