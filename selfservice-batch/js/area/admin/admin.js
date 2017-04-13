
$j(document).ready(function(){
	$j('#admin-sidebar').find('a').each(function(){
		
		if($j(this).text() == $j('#pagetitle').text()){
			$j(this).parent().addClass('active');
		}
	});
	
	$j('#gpaPoints').keypress(function (e) {
	     //if the letter is not digit or decimal dont type anything
	     if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57 )) {
	               return false;
	    }
	 });
});

function limitText(limitField, limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	} 
}


function removeCourseGrade(id){
	
	$j('#deleteId').val(id);
	document.forms["deleteCourseGrade"].submit();
}