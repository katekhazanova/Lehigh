
$j( document ).ready(function() {
	
	if( $j('#userid').length ){
		$j("#userid").prop('disabled', true);
		$j("#userid").after("<spand id=\"loadingBatchShare\"><i class=\"fa fa-spinner fa-spin\" aria-hidden=\"true\"></i> <strong>Loading...</strong></span>");

	    $j.ajax({
	        url: "shareAutoComplete.html",
	        dataType: "json",
	        success: function( data ) {
	            $j( "#userid" ).autocomplete({
	                source: data,
	            });
	            $j("#userid").prop('disabled', false);
	            $j("#loadingBatchShare").hide();
	        }
	     });
	}  

});


function updateRadioOnClick(theId){
	
	$(theId+'Radio').checked=true;	
}

function runBatchCheck(batchId){
	var url = $('contextPath').getValue()+'/batch/checkBatch.html';
	
	new Ajax.Request(url, {
	parameters: {batchId : batchId},
	 onSuccess: function(transport) {
	 		
	 		var json = transport.responseText.evalJSON();
	 		
	 		var size = json.size;
	 		var alert = json.alert;
	 		
	 		if(alert == true){
	 			
	 			if (size == 1) {
	 				var r=confirm("Warning: This batch will run audits for 1 student.\n               Do you wish to continue?");
	 			} else {
	 				var r=confirm("Warning: This batch will run audits for "+size+" students.\n               Do you wish to continue?");
	 			}
	      	
				if (r==true){
				
				  	top.location="run_batch.html?batchid="+batchId;
				}
	 		}
	 		else{
	 		
	 			top.location="run_batch.html?batchid="+batchId;
	 		}
	
	 }
	});
}

function checkBatch(){
	var url = $('contextPath').getValue()+'/batch/checkBatch.html';
	
	new Ajax.Request(url, {
	 onSuccess: function(transport) {
	 		
	 		var json = transport.responseText.evalJSON();
	 		
	 		var size = json.size;
	 		var alert = json.alert;
	 		
	 		if(alert == true){
	 			
	 			if (size == 1) {
	 				var r=confirm("Warning: This batch will run audits for 1 student.\n               Do you wish to continue?");
	 			} else {
	 				var r=confirm("Warning: This batch will run audits for "+size+" students.\n               Do you wish to continue?");
	 			}
	      	
				if (r==true){
				
				  	top.location="schedule.html";
				}
	 		}
	 		else{
	 		
	 			top.location="schedule.html";
	 		}
	
	 }
	});

}