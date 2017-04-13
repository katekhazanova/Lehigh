
<head>
	<meta charset="utf-8" />
	<title>Audit Comparison - Compare Previous Audits Results</title>
</head>
<body>
<input type="hidden" id="pageGroup" value="tools"/>
	<h1 id="pagetitle">Compare Previous Audits Results</h1>

	<form action="home.html">
		<a class="btn btn-sm btn-default" href="<@spring.url relativeUrl="/auditviewer/home.html#compare" />">Return to Search</a>
	</form>
	<br>

	<button class="btn btn-primary btnAlign btnTopMargin" onclick="compareAudits()">Compare</button>
	<h3> JobID's for ${stuno}</h3>

	<table id="previousAudits" class="table table-striped table-bordered table-hover">
	<tr>
			<th role="columnheader"> ID</th>
			<th role="columnheader"> Instcd</th>
			<th role="columnheader"> Program</th>
			<th role="columnheader"> Catalog Year</th>
			<th role="columnheader"> Created</th>
			<th role="columnheader"> Run By</th>
			<th role="columnheader"> Compare</th>
	</tr>
	<#list jobQueueRuns as job>
	<tr>
			<td>${job['jobid']!''}</td>
			<td>${job['instcd']!''}</td>
			<td>${job['dprog']!''}</td>
			<td>${job['catlyt']!''}</td>
			<td>${job['rundate']!''}</td>
			<td>${job['userid']!''}</td>
			<td><input type="checkbox" class="jobID" value="${job['jobid']}" /></td>
	</tr>
	</#list>
	</table>

</body>
