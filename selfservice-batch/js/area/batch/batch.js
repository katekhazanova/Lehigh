
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
	
	$j("#batchSearch").keyup(function () {
    	
        //split the current value of searchInput
        var data = this.value.split(" ");
        
        //create a jquery object of the rows
        var jo = $j(".resultList").find(".odd, .even");
        
        if (this.value == "" || this.value.length < 3) {
        	
        	$j(".resultList").addClass("table-striped");
        	$j(".resultList").find(".odd, .even").show();
            return;
        }
        
        $j(".resultList").removeClass("table-striped");

        var found = 0;
        //Recusively filter the jquery object to get results.
        jo.filter(function (i, v) {
            var $jt = $j(this);
        
            for (var d = 0; d < data.length; ++d) {
                if ($jt.is(":containsIngnoreCase('" + data[d] + "')")) {
                	
                	++found;
                    return true;
                }
            }
            
            if(!$jt.is(":hidden")){
            	$jt.hide();
            }
            return false;
        })
        //show the rows that match.
        .show();
        
    });

});


function updateRadioOnClick(theId){
	
	$(theId+'Radio').checked=true;	
}


function runBatchAndCloneCheck(batchId, cloneDefault){
	var url = $('contextPath').getValue()+'/batch/checkBatch.html';
	
	new Ajax.Request(url, {
	parameters: {batchId : batchId},
	 onSuccess: function(transport) {
	 		
		 	$j("#student-warning").hide();
		 	
	 		var json = transport.responseText.evalJSON();
	 		
	 		var size = json.size;
	 		var alert = json.alert;
	 		
	 		if(alert == true){
	 			
	 			$j("#student-warning").show();
	 			
	 			if (size == 1) {
	 				$j("#student-warning").html("This batch will run audits for 1 student. Do you wish to continue?");
	 			} else {
	 				$j("#student-warning").html("This batch will run audits for "+size+" students. Do you wish to continue?");
	 			}
	 		}
	 		
	 		if(cloneDefault=='clone'){
	 			$j('#clone-batch').attr('checked', true);
	 			$j('#clone-batch').parent().addClass("active");
	 			$j('#replace-batch').attr('checked', false);
	 			$j('#replace-batch').parent().removeClass("active");
	 		}else{
	 			$j('#clone-batch').attr('checked', false);
	 			$j('#clone-batch').parent().removeClass("active");
	 			$j('#replace-batch').attr('checked', true);
	 			$j('#replace-batch').parent().addClass("active");
	 		}
	 		
	 		$j("#run-batchId").val(batchId);
	 		$j('#runBatchModal').modal('show');
	 }
	});
}

function submitRunBatchAndClone(){
	
    $j('#runBatchModal').modal('hide');
	
	var batchId = $j("#run-batchId").val();
	var clone = $j('input[name=clone-batch]:checked').val();
	
	top.location="run_batch.html?batchid="+batchId+"&clone="+clone;
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
	 				var r=confirm("This batch will run audits for 1 student.\n               Do you wish to continue?");
	 			} else {
	 				var r=confirm("This batch will run audits for "+size+" students.\n               Do you wish to continue?");
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
	 				var r=confirm("This batch will run audits for 1 student.\n               Do you wish to continue?");
	 			} else {
	 				var r=confirm("This batch will run audits for "+size+" students.\n               Do you wish to continue?");
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