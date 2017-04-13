function runProgram(programName) {
	
	var json =  { };
	json.program = programName;
	
	$j.getJSON('runProgram.html', json,  
			function(data) {
		
		var items = [];
		$j.each(data, function(key, val) {
			items.push(val);
		});
		
		if (items[0].complete == "complete") {
			$j.pnotify({
			    title: 'Submitted Audit Request',
			    text: 'for program: ' + programName,
		    	addclass: 'custom',
				opacity: .8,
				nonblock: true,
				nonblock_opacity: .2
			});
			$j("#alertbox").html("Submitted audit request for program: " + programName + ".");
		} else if (items[0].complete == "timeout") {
			$j.pnotify({
			    title: 'Unable to Submit Audit Request',
			    text: 'You cannot submit more than 10 audit requests every minute.',
		    	addclass: 'warning',
				opacity: .8,
				nonblock: true,
				nonblock_opacity: .2
			});
			$j("#alertbox").html("Unable to Submit Audit Request. You cannot submit more than 10 audit requests every minute.");
		} else {
			$j.pnotify({
			    title: 'Error Submitting Audit Request',
			    text: 'There was a server error submitting your request.',
		    	addclass: 'warning',
				opacity: .8,
				nonblock: true,
				nonblock_opacity: .2
			});
			$j("#alertbox").html("Error submitting audit request. There was a server error submitting your request.");
		}		
		
	 });
		
	$j('#auditList').show();
	
}

function loadPrograms(ngram, divid) {
	
	$j.getJSON('loadPrograms.html', {
	     "ngram" : ngram 
	   },  function(data) {
		  
		   var items = [];
			$j.each(data, function(key, val) {
				items.push(val);
			});
			
			var arrayLength = items.length;
			document.getElementById("filterNum").innerHTML=" " + arrayLength + "";
			if (arrayLength>0) {
				var elem = $j("#programs");
				elem.html("");
				for (var i in items) {
					if (items[i].displayText !== undefined) {
						
						var firstBar = new Number(items[i].AHpercent);
						if (firstBar > 100) {
							firstBar = 100;
						}
						var secondBar = new Number(items[i].Hpercent);
						if (secondBar > 100) {
							secondBar = 100;
						}
						if (items[i].isCurrentDprog == "true") {
							var text = "<div tabindex=\"0\" class=\"list-sel\" data-name=\""+items[i].displayText+"\"><table width=\"100%\"><tr>" +
								"<td width=\"80%\"><span style=\"font-weight: bold;font-size: 14px;\"><i class='fa fa-bookmark'></i> Current Program:</span> " + items[i].displayText + "<table width=\"80%\" style=\"margin-top: 10px;\"><tr><td><div class=\"progress progress-totalhrs\" style=\"margin-bottom: 0px;\">" +
								"<div class=\"progress-bar progress-bar-applied\" style=\"width: " + firstBar + "%;\"><span class=\"sr-only\">" + firstBar +
								"% of your courses</span></div><div class=\"progress-bar progress-bar-completed\" style=\"width: " + (secondBar-firstBar) + 
								"%;\"><span class=\"sr-only\">" + secondBar + "% of your courses</span></div></td></tr></table>" + items[i].courseHours + 
								" of your " + items[i].completedHours + " completed course hours match the " + items[i].totalHours + " minimum hours needed to complete this program. Please run an audit to confirm." +
								"</td><td width=\"20%\"> <a href=\"#\" onclick=\"runProgram('"+items[i].name+"')\" class=\"btn btn-primary\">Run Audit</a></td></tr></table></div>";
						} else {
							var text = "<div tabindex=\"0\" class=\"list-base prog-list\" data-name=\""+items[i].displayText+"\"><table width=\"100%\"><tr>" +
								"<td width=\"80%\">" + items[i].displayText + "<table width=\"80%\" style=\"margin-top: 10px;\"><tr><td><div class=\"progress\" style=\"margin-bottom: 0px;\">" +
								"<div class=\"progress-bar progress-bar-applied\" style=\"width: " + firstBar + "%;\"><span class=\"sr-only\">" + firstBar +
								"% of your courses</span></div><div class=\"progress-bar progress-bar-completed\" style=\"width: " + (secondBar-firstBar) +
								"%;\"><span class=\"sr-only\">" + secondBar + "% of your courses</span></div></td></tr></table>" + items[i].courseHours + 
								" of your " + items[i].completedHours + " completed course hours match the " +	items[i].totalHours + " minimum hours needed to complete this program. Please run an audit to confirm." +
								"</td><td width=\"20%\"> <a href=\"#\" onclick=\"runProgram('"+items[i].name+"')\" class=\"btn btn-primary\">Run Audit</a></td></tr></table></div>";
						}
						elem.append(text);
						
					}

				}
				elem.append("</div>");
			}
			
			document.getElementById('programs').scrollTop = 0;			
			
			var filter = function() {
				var numShown = 0
				var programInput = $j('#programSearch').val().toLowerCase();
				$j('div[class^="list-base prog"], div[class^="list-sel"]').each(function (i) {
					var progTitle = $j(this).attr('data-name').toLowerCase();
					$j(this).hide();
					if (progTitle.indexOf(programInput) !== -1) {
						$j(this).show();
						numShown++;
					}

					document.getElementById("filterNum").innerHTML=numShown;
					if (numShown != 1) {
						document.getElementById("filterNumS").innerHTML="s";
					} else {
						document.getElementById("filterNumS").innerHTML="";
					}
				});
			}

			$j('#programSearch').bind("keyup",filter);
			
			var filter2 = function() {
				var programInput = $j('#programGroupSearch').val().toLowerCase();
				$j('a[class^="list-base prgGrp prgLink"]').each(function (i) {
					var progTitle = $j(this).attr('data-name').toLowerCase();
					$j(this).hide();
					if (progTitle.indexOf(programInput) !== -1) {
						$j(this).show();
					}
				});
			}

			$j('#programGroupSearch').bind("keyup",filter2);
		   
	   });
	
	$j('a[class^="list-base prgGrp prgLink"]').each(function (i) {
		$j(this).removeClass("p_sel");
	});
	$j('#'+divid).addClass("p_sel");
	
}

function loadProgramsToRun() {
	
	$j.getJSON('loadProgramsToRun.html', 
		function(data) {
		  
		   var items = [];
			$j.each(data, function(key, val) {
				items.push(val);
			});
			
			var atleastOne = 0;
			var arrayLength = items.length;
			if (arrayLength>0) {
				var elem = $j("#programsToRun");
				elem.html("");
				for (var i = 0; i < arrayLength; i++) {
					var obj = items[i];
						if (obj.displayText !== undefined) {
							atleastOne = 1;
							var text = "<div class=\"prog\">" +
								obj.displayText + 
								"</div>";
							elem.append(text);
						}
				}
				
				if (atleastOne == 1) {
					elem.append("<a href=\"#\" class=\"btn-add\" onclick=\"clearProgramsToRun()\">Clear List</a>");
				}
				
			}
		   
	   });

}

