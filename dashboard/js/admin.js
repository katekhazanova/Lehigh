
$(document).ready(function(){
	$('#admin-sidebar').find('a').each(function(){
		
		if($(this).text() == $('#pagetitle').text()){
			$(this).parent().addClass('active');
		}
	});
	
	$('#gpaPoints').keypress(function (e) {
	     //if the letter is not digit or decimal dont type anything
	     if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57 )) {
	               return false;
	    }
	 });
	
	$("#addPlanNote").validate({
		rules: {
		    code: {
		      required: true
		    },
		    description: {
		      required: true
		    },
		}
	});
});

function limitText(limitField, limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	} 
}


function removeCourseGrade(id){
	
	$('#deleteId').val(id);
	document.forms["deleteCourseGrade"].submit();
}

function removePlanNote(id){
	
	$('#deleteId').val(id);
	document.forms["deletePlanNote"].submit();
}