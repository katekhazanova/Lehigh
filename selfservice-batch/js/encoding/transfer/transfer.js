window.onbeforeunload = confirmExit;


$j(document).ready(function() {
	
	//$j('#transferInstTable').dataTable({"data": dataSet});
	
	
	/* Force the primary keys inputs to uppercase */
	
	//search page inputs
	makeInputUpperCase('#schoolID');
	
	//create page inputs
	makeInputUpperCase('#sourceCd');
	makeInputUpperCase('#DPMask');
	
	//edit page inputs
	makeInputUpperCase('#SOURCE_CD');
	makeInputUpperCase('#SOURCE_ID');
	makeInputUpperCase('#DPMASK');
	
	trimInput('.effdte');
	trimInput('.effdte2');
	
	$j('#irefTable').dataTable({
	    "paging":   false,
	    "info":     false,
	    "searching": false,
	    "order": [[ 3, "asc" ]],
	    "columns": [
	                null,
	                null,
	                null,
	                null,
	                null,
	                { "orderable": false },
	                { "orderable": false },
	                { "orderable": false }
	              ]
	} );
	
	$j('#taTable').dataTable({
	    "paging":   false,
	    "info":     false,
	    "searching": false,
	    "order": [[ 4, "asc" ]],
	    "columns": [
	                null,
	                null,
	                null,
	                null,
	                null,
	                null,
	                { "orderable": false },
	                { "orderable": false },
	                { "orderable": false }
	              ]
	} );
	
   $j('[data-toggle="popover"]').popover();
   
   $j('body').on('click', function (e) {
	    $j('[data-toggle="popover"]').each(function () {
	        //the 'is' for buttons that trigger popups
	        //the 'has' for icons within a button that triggers a popup
	        if (!$j(this).is(e.target) && $j(this).has(e.target).length === 0 && $j('.popover').has(e.target).length === 0) {
	            $j(this).popover('hide');
	        }
	    });
	});
    
    $j("#transferInstSearch").keypress(function (evt) {
    	//Deterime where our character code is coming from within the event
    	var charCode = evt.charCode || evt.keyCode;
    	if (charCode  == 13) { //Enter key's keycode
    	return false;
    	}
    });
    
    $j("#transferInstSearch").keyup(function () {
    	
        var seachText = this.value;
        
        //create a jquery object of the rows
        if (this.value == "" || this.value.length < 3) {
        	$j("#searchMessage").show();
        	
        	if($j('#recentInsts').val() != "true"){
            	$j("#transferInstTable").hide();
        	}
        	else{
        		
        		$j("#trasferInstBody tr").hide();
            	$j(".recentInstsRow").show();
        	}

        	$j("#noSchools").hide();
            return;
        }
        
        $j("#searchMessage").hide();
        $j("#transferInstTable").show();
        $j("#noSchools").hide();

        $j("#trasferInstBody tr").hide();
        $j("#trasferInstBody tr:contains('" + seachText + "') ").show();
        
        var found = $j('#trasferInstBody').find('tr:visible').length;
        
        if(found == 0){
        	 $j("#noSchools").show();
        }
        
    });
    
}); 

function makeInputUpperCase(id){
	
	if($j(id).length > 0){
		$j(id).css({textTransform: "uppercase"});
		
		if(id != '#schoolID'){
			$j(id).val($j(id).val().toUpperCase());
		}
		
		$j(id).change(function(){
			$j(this).val($j(this).val().toUpperCase());
		});
	}
}

function trimInput(id){
	
	if($j(id).length > 0){
		
		$j(id).each(function(){
			$j(this).val($j(this).val().trim());
		});
	}
}

function makeInputLowerCase(id){
	
	if($j(id).length > 0){
		$j(id).css({textTransform: "lowercase"});	
		$j(id).val($j(id).val().toLowerCase());
		
		$j(id).change(function(){
			$j(this).val($j(this).val().toLowerCase());
		});
	}
}


//Making a new contains selector for jquery that ignores case
$j.expr[":"].containsIngnoreCase = $j.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $j(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});

function readCookie(name){
	return(document.cookie.match('(^|; )'+name+'=([^;]*)')||0)[2]
}

function setVisibility(id, visibility) {
	
	if($j('#'+id) ){
		$j('#'+id).css("display", visibility);
	}
}

function createTransferInst(){
	
	var instName = $j("#schoolName").val();
	var sourceId = $j("#schoolID").val();
	
	if(sourceId == ""){
		sourceId = " ";
	}
	
	$j.ajax({
		type: "POST",
		traditional: true,
		url: "create-transferInst.html",
		data: {
			"instName": instName,
			"sourceId": sourceId,
		  },
		 dataType: "json",
			success : function(json) {
				
				if( json.results == "success"){
					var url = encodeURI("institution.html?instName="+instName+"&sourceId="+sourceId);
					window.location.replace(url);
				}
				else{
					$j("#createError").show();

				}
			},
			error : function(json) {
				$j.pnotify({
				    title: 'Unable to Save Transfer Institution.',
				    text: 'There was an error saving the Transfer Institution',
			    	addclass: 'warning',
					opacity: .8,
					nonblock: true,
					nonblock_opacity: .2
				});
			}	
	});
}

function loadEditTransferModal(sourceId){
	
	var instName = $j("[id='instName-"+sourceId+"']").text();
	
	$j('#edit-schoolName').val(instName);
	$j('#edit-sourceId').val(sourceId);

	$j('#editSchoolModal').modal();
}

function editTransferInst(){
	
	var instName = $j('#edit-schoolName').val();
	var sourceId = $j('#edit-sourceId').val();

	
	$j.ajax({
		type: "POST",
		traditional: true,
		url: "edit-transferInst.html",
		data: {
			"instName": instName,
			"sourceId": sourceId,
		  },
		 dataType: "json",
			success : function(json) {
				
				$j("[id='instName-"+sourceId+"']").text(instName);
				$j('#editSchoolModal').modal('toggle');
				
				var url = encodeURI("institution.html?instName="+instName+"&sourceId="+sourceId)
				$j('#instLink-'+sourceId).attr('href',url);
			},
			error : function(json) {
				$j.pnotify({
				    title: 'Unable to Update Transfer Institution.',
				    text: 'There was an error updating the Transfer Institution',
			    	addclass: 'warning',
					opacity: .8,
					nonblock: true,
					nonblock_opacity: .2
				});
			}	
	});
}

function deleteTransferInst(sourceId){
	if (confirm('Delete School and all included information?')) {
		$j.ajax({
			type: "POST",
			traditional: true,
			url: "delete-transferInst.html",
			data: {
				"sourceId": sourceId,
			  },
			 dataType: "json",
				success : function(json) {
					
					if( json.results == "success"){
						
						$j("[id='transferInst-"+sourceId+"']").remove();
						
					}
				},
				error : function(json) {
				}	
		});
	}
}

function fix_effdte(effdte) {
	if (effdte.length != 6) {
		if (effdte.length < 6) {
			var diff = 6 - effdte.length;
			if (diff > 0) {
				for (var x = 0; x < diff; x++) {
					effdte = effdte + ' ';
				}
			}
		} else if (effdte.length > 6) {
			var diff = effdte.length - 6;
			effdte = effdte.substring(0,5);
		}
	}
	return effdte;
}

function convertToTimeStamp(date){
	
	 if(date != null && date != ""){
		  
		  var tempDate = new Date(date)
		  return  jQuery.format.date(tempDate,'yyyy-MM-dd HH:mm:ss');
	  }
	 else{
		 return date;
	 }
}

function confirmExit() {
	
	if (irefChanges && !irefChangesConfirmed) {
		irefChangesConfirmed = false;
		return "You have made changes to Iref fields without clicking the Save button, your changes will be lost.";
	}
	
	if ((taChanges || unsavedChanges) && !taChangesConfirmed) {
		taChangesConfirmed = false;
		return "You have made changes to TA fields without clicking the Save button, your changes will be lost.";
	}
}
