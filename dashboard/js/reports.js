
$( document ).ready(function() {
	
	forceUppercase( "#reportsForm input[name='dprogList']" );
	forceUppercase( "#reportsForm input[name='dprnameList']" );
	forceUppercase( "#reportsForm input[name='courseList']" );
	forceUppercase( "#reportsForm input[name='studentList']" );
	forceUppercase( "#reportsForm input[name='sourceIdList']" );
	forceUppercase( "#reportsForm input[name='ctlcdList']" );
	forceUppercase( "#reportsForm input[name='ctlcd']" );
	
	forceUppercase( "#reportsForm input[name='instidq']" );
	forceUppercase( "#reportsForm input[name='instid']" );
	forceUppercase( "#reportsForm input[name='instcd']" );
});

function forceUppercase(id){
	
	$(id).css({textTransform: "uppercase"});
	$(id).keyup(function(){
		$(this).val($(this).val().toUpperCase());
	});	
}
