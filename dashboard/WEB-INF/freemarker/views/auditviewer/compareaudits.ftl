

<META name="view" content="compareAudits">
<input type="hidden" id="pageGroup" value="tools"/>
		<title>Audit Comparison</title>

		<h1 id="pagetitle">Audit Comparison</h1>
	<form action="home.html">
		<a class="btn btn-sm btn-default" href="#" onclick="window.close();">Close Window</a>
	</form>
	
		<h3>Matched Percent: ${matchedPercent}%</b></h3>
		<table class="table table-striped table-bordered table-condensed">
			<tr>
				<td>
					<pre>${audit1Info}</pre>
				</td>
				<td>
					<pre>${audit2Info}</pre>
				</td>
			</tr>
			<tr>
				<td>
					<pre style="min-width:550px">${diff1}</pre>
				</td>
				<td>
					<pre style="min-width:550px">${diff2}</pre>
				</td>
			</tr>
		</table>
    