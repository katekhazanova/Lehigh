<head>
	<title>Audit Comparison - Student ID Search Results</title>
</head>
<body>
<input type="hidden" id="pageGroup" value="tools"/>
	<h1 id="pagetitle">Student ID Search Results</h1>

	<form action="home.html">
		<a class="btn btn-sm btn-default" href="<@spring.url relativeUrl="/auditviewer/home.html#runAudits" />">Return to Search</a>
	</form>
	<br>

	<button class="btn btn-primary btnAlign btnTopMargin" onclick="updateStunoList('add')">Add to List</button>
	<h3> Results Stunos for  ${partialStuno}</h3>

	<table id="studentList" class="table table-striped table-bordered table-hover">
	<tr>
			<th role="columnheader"> Name</th>
			<th role="columnheader"> Student Id</th>
			<th role="columnheader"> Add</th>
	</tr>
	<#list stumasters as stumaster>
	<tr>
			<td>${stumaster['stuname']!''}</td>
			<td>${stumaster['stuno']!''}</td>
			<td><input type="checkbox" class="stuno" value="${stumaster['stuno']}" /></td>
	</tr>
	</#list>
	</table>

</body>
