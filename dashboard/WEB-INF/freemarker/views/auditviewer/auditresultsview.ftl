

<input type="hidden" id="pageGroup" value="tools"/>

		<script>
			window.onload=function(){
				processAudit();
			}
		</script>
		
	<title>Audit Comparison - Audit Run Results</title>	
	<h1 id="pagetitle">Audit Run Results</h1>
	<form action="home.html">
		<a class="btn btn-sm btn-default" href="<@spring.url relativeUrl="/auditviewer/home.html#runAudits" />">Return to List</a>
	</form>
	

	
	
<br/>


<div id="results">
${displayAllAuditInfo}
</div>
