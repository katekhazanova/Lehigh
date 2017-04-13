

function editSegment(event) {
	
	event = $j.event.fix(event);
	var button = event.currentTarget;
	taChangesConfirmed = true;
	
	ta.persist = false;
	ta.editSeg = $j(button).parents('tr').find(".tsegName").text();
		
	if(taChanges){
		saveTa();
	}
	else{
		redirectTaUrl();
	}
}

function saveSegmentTab(){
	
	//clear the existing segments before saving
	$j.ajax({
		type: "POST",
		url: "save-segment.html",
		traditional: true,
		data: {"clear":"true"},
		 dataType: "json",
			success : function(json) {	
				
				if(allTaChildrenSaved()){
					saveTaTabs();
				}
				else{
					saveSegments();
				}
			},
			error : function(json) {
				
				if(allTaChildrenSaved()){
					saveTaTabs();
				}
				else{
					saveSegments();
				}
			}
	});
}

function saveSegments(){
	
	$j("#segmentList tbody tr").each(function(i, row) {
		
		  var segment = new Object();
		  
		  segment.intSeqNo = $j(row).find('.intSeqNo').val();
		  segment.tseg = $j(row).find('.tsegName').text();
		  segment.hint = $j(row).find('.tsegHint').text();
		  segment.description = $j(row).find('.tsegDesc').val();
		  segment.lastModUser = $j(row).find('.last_mod_user').val();
		  var lastModDate = convertToTimeStamp($j(row).find('.last_mod_date').val());
		  
			if(lastModDate != ""){
				segment.lastModDate = lastModDate;
			}
		  
			$j.ajax({
				type: "POST",
				async: false,
				url: "save-segment.html",
				traditional: true,
				data: segment,
				 dataType: "json",
					success : function(json) {	
						
						segmentsNotSaved--;
						
						if(allTaChildrenSaved()){
							saveTaTabs();
						}
					},
					error : function(json) {
						
						console.log("error saving segment with tseg:"+segment.tseg);
						segmentsNotSaved--;
						
						if(allTaChildrenSaved()){
							saveTaTabs();
						}
					}
			});
	});
}

function syncRules(action,tseg,hint,oldTseg){
	
	$j.ajax({
		type: "POST",
		url: "sync-rules.html",
		traditional: true,
		data: {"action":action,
			   "tseg": tseg,
			   "oldTseg": oldTseg},
		 dataType: "json",
			success : function(json) {
				
				if(action == "delete"){
					
					$j("#segment-dd option[value='"+tseg+"']").remove();
					$j("#rule-segment option[value='"+tseg+"']").remove();
				}
				else if(action == "change"){
					
					$j("#segment-dd option[value='"+oldTseg+"']").text(tseg+" - "+hint);
					$j("#rule-segment option[value='"+oldTseg+"']").text(tseg+" - "+hint);
					$j("#segment-dd option[value='"+oldTseg+"']").val(tseg);
					$j("#rule-segment option[value='"+oldTseg+"']").val(tseg);
				}
			},
			error : function(json) {
				$j.pnotify({
					title: 'Unable to Delete Segment.',
					text: 'There was an error deleting the Segement',
					addclass: 'warning',
					opacity: .8,
					nonblock: true,
					nonblock_opacity: .2
				});
			}
	});
	
}

function popNewSegmentModal() {
	var count =  $j('#segmentList tr').length;
	$j('#segment_save').html('<i class="fa fa-plus"></i> Add');
	$j('#modal_last_mod_date').text('');
	$j('#modal_last_mod_user').text('');
	$j('#last_mod_seg').hide();
	$j('#segmentModal').data('id', count);
	$j('#segmentModal').modal('show');
	return false;
}

function popSegmentModal(id) {
	var row = $j('tr#segmentRow-' + (id + 1));
	$j('#segmentModal').data('id', id);
	
	// get page form values
	var tsegName = row.find('.tsegName').text();
	var tsegHint = row.find('.tsegHint').text();
	var tsegDesc = row.find('.tsegDesc').val();
	var last_mod_date = row.find('.last_mod_date').val();
	var last_mod_user = row.find('.last_mod_user').val();
//	var intSeqNo = row.find('.intSeqNo').text();

	// set modal form values
	$j('#modal_tsegName').val(tsegName);
	$j('#modal_tsegHint').val(tsegHint);
	$j('#modal_tsegDesc').val(tsegDesc);
	$j('#modal_last_mod_date').text(last_mod_date);
	$j('#modal_last_mod_user').text(last_mod_user);
	$j('#segment_save').removeAttr('disabled');
	$j('#last_mod_seg').show();
//	$j('#modal_intSeqNo').val(intSeqNo);
	
	$j('#segment_save').html('Apply changes');
	$j('#segmentModal').modal('show');
	return false;
}

function applySegmentModal() {
	// get modal form values
	var tsegName = $j('#modal_tsegName').val();
	var tsegHint = $j('#modal_tsegHint').val();
	var tsegDesc = $j('#modal_tsegDesc').val();
//	var intSeqNo = $j('#modal_intSeqNo').val();
	var last_mod_date = $j('#modal_last_mod_date').text();
	var last_mod_user = $j('#modal_last_mod_user').text();
	
	var id = $j('#segmentModal').data('id');
	var row = $j('tr#segmentRow-' + (id + 1));
	if (row.length > 0) {
//		IF EXISTING ROW
		
		//update the existing rules
		var oldTseg = row.find('.tsegName').text();
		syncRules("change",tsegName,tsegHint,oldTseg);
		
//		set page form values
		row.find('.tsegName').text(tsegName);
		row.find('.tsegHint').text(tsegHint);
		row.find('.tsegDesc').val(tsegDesc);
		row.find('.last_mod_date').val(last_mod_date);
		row.find('.last_mod_user').val(last_mod_user);
		var segmentDescButton = row.find('.segmentDescButton');
		if (tsegDesc) {
			segmentDescButton.attr('data-content', tsegDesc);
			segmentDescButton.removeAttr('title');
			segmentDescButton.attr('data-original-title', 'Memo');
			segmentDescButton.removeAttr('disabled', '');
		} else {
			segmentDescButton.removeAttr('data-content');
			segmentDescButton.attr('title', 'Memo');
			segmentDescButton.removeAttr('data-original-title');
			segmentDescButton.attr('disabled', 'disabled');
		}
		
		
//		row.find('.intSeqNo').text(intSeqNo);
	} else {
//		IF NEW ROW
		var count =  $j('#segmentList tr').length;
		var row = $j('<tr id="segmentRow-' + id + '" class="ui-state-default"></tr>');
	    var number = $j('<td id="userSeqNo" class="aligncenter vAlignMid">' + count + '</td>');
	    var name = $j('<td class="tsegName">' + tsegName + '</td>');
	    var hint = $j('<td class="tsegHint">' + tsegHint + '</td>');
	    var desc = '';
	    if (tsegDesc) {
	    	desc = $j('<td class="aligncenter vAlignMid"><a href="#" tabindex="0" class="segmentDescButton btn btn-info btn-xs" role="button" data-placement="auto top" data-toggle="popover" title data-content="' + tsegDesc + '" data-original-title="Memo" onclick="return false;"><i class="fa fa-file-text-o"></i></a></td><input type="hidden" class="tsegDesc" value="' + tsegDesc + '" />');
	    	$j('.segmentDescButton').popover();
	    } else {
	    	desc = $j('<td class="aligncenter vAlignMid"><a href="#" tabindex="0" class="segmentDescButton btn btn-info btn-xs" disabled="disabled" role="button" data-placement="auto top" data-toggle="popover" title="Memo" onclick="return false;"><i class="fa fa-file-text-o"></i></a></td><input type="hidden" class="tsegDesc" />');
	    }
	    var more = $j('<td class="aligncenter vAlignMid"><a href="#" tabindex="0" class="btn btn-default btn-xs" role="button" onclick="popSegmentModal(' + (count - 1) + ');return false;"><i class="fa fa-ellipsis-h"></i></a></td>');
	    var edit =	$j('<td class="aligncenter vAlignMid"><a href="#" tabindex="0" class="btn btn-default btn-xs" role="button" onclick="editSegment(event);return false;"><i class="fa fa-edit"></i></a></td>');
	    var deleteRow = $j('<td class="aligncenter vAlignMid"><a href="#" tabindex="0" role="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,\'#sortableSegment\',\'none\')" title="Delete Course"><i class="fa fa-trash-o"></i></button></td>');
	    var extraContent = '<input type="hidden" class="intSeqNo" />'
	    					+'<input type="hidden" value="'+last_mod_user+'" class="last_mod_user" />'
	    					+'<input type="hidden" value="'+last_mod_date+'" class="last_mod_date" />';

	    row.append(number);
	    row.append(name);
	    row.append(hint);
	    row.append(desc);
	    row.append(more);
	    row.append(edit);
	    row.append(deleteRow);
	    row.append(extraContent);
	    
	    //add the segement to the rules tab drop downs
	    $j('#segment-dd').append($j("<option></option>").attr("value",tsegName).text(tsegName+" - "+tsegHint)); 
	    $j('#rule-segment').append($j("<option></option>").attr("value",tsegName).text(tsegName+" - "+tsegHint)); 
	  
	    $j('#segmentList tbody').append(row);
	    $j('#ta-save').removeAttr("disabled");
	    taChanges = true;
	}
	row.find('.segmentDescButton').popover();
	$j('#segmentModal').modal('hide');
	
	return false;
}