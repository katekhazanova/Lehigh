$j( document ).ready(function() {
	
	if($j('#uppercaseStuno').val() == "true"){
		
		//force the search to uppercase
		$j("#stuno").css({textTransform: "uppercase"});
		
		$j('#stuno').change(function(){
			$j(this).val($j(this).val().toUpperCase());
		});
		
		//force the create and edit to uppercase
		$j("#comp_id\\.stuMaster\\.stuno").css({textTransform: "uppercase"});
		
		$j('#comp_id\\.stuMaster\\.stuno').change(function(){
			$j(this).val($j(this).val().toUpperCase());
		});
	}
});

