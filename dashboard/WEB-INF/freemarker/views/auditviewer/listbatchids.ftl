<#include "../admin/admin_top.ftl">


		<h1 id="pagetitle" tabindex="0">
			<form action="home.html">
				<button type="submit" class="btn btn-primary"><b>AuditViewer</b></button>
				Batch Results
			</form> 
		</h1>
	<head>
		<meta charset="utf-8" />
		<title>auditviewer</title>
		<script>
			function redirectToCompare(j){
				var count = 0;
				var batchids = new Array();
				for(var i = 1; i <= j; i++){
					if(document.getElementById("batchID" + i).checked){
						batchids[count] = document.getElementById("batchID" + i).value;
						count++;
					}
				}
				if(count == 1){

					if (confirm('You have selected a Batch. To submit the Batch please select "OK." To cancel select "Cancel." ')==true){
						window.location.replace( $('#contextPath').val() +  "/auditviewer/submitAudits.html?batchid=" + batchids[0]);
					}
				}
				else if(count == 0){
					alert("Select a BatchId");
				}
				else{
					alert("Select no more than 1 Jobid");
				}
			}
			function redirectToViewStudents(j){
				var count = 0;
				var batchids = new Array();
				for(var i = 1; i <= j; i++){
					if(document.getElementById("batchID" + i).checked){
						batchids[count] = document.getElementById("batchID" + i).value;
						count++;
					}
				}
				if(count == 1){
					window.location.replace($('#contextPath').val() + "/auditviewer/listBatchStudents.html?batchid=" + batchids[0]);
				}
				else if(count == 0){
					alert("Select a BatchId");
				}
				else{
					alert("Select no more than 1 Jobid");
				}
			}
			function uniqueRadio(k){
				for(var i = 1; i <= ${buttonCount}; i++){
					if(document.getElementById("batchID" + i) != document.getElementById("batchID" + k)){
						document.getElementById("batchID" + i).checked = false;
					}
				}
			}
		</script>
	</head>
	<body>

Please select 1 Batch Id to run compare on students in each, or to view the students in a Batch
${jobids}
<button class="btn btn-primary btnAlign btnTopMargin" onclick="redirectToCompare(${buttonCount})">Compare Students in Batch</button>   
<button class="btn btn-primary btnAlign btnTopMargin" onclick="redirectToViewStudents(${buttonCount})" style="margin-left:10px">View Students in Batch</button></pre>
    
<#include "../admin/admin_bot.ftl">