<@layout.head title="Admin">
</@layout.head>
<@layout.body>
<#include "admin_top.ftl">
	
	<h1 id="pagetitle">ProgramMatcher</h1><br/>
	<h2 style="width: 100%; text-align: left;">Active Index: <font color="#00B836">${activeIndex}</font> </h2>
	<br />
	<table class="admin-table" width="50%">
		<thead><tr><th width="35%">&nbsp;</th><th>Index Built</th><th>Status</th></tr></thead>
		<tr><td><span class="admin-table-rowh">Index 1 Status:</span></td><td><@d.showIndexBuilt "${Index_1_s}" /></td><td><@d.showIndexStatus "${Index_1_c}" /> </td></tr>
		<tr><td><span class="admin-table-rowh">Index 2 Status:</span></td><td><@d.showIndexBuilt "${Index_2_s}" /></td><td><@d.showIndexStatus "${Index_2_c}" /> </td></tr>
	</table>
	
	<br /> <br />
	
	
	<#assign index_schedule_url>
		<@s.url relativeUrl="/admin/dprog_scheduleIndex.html"/>
	</#assign>
	
	
	<h2 style="width: 100%; text-align: left;">Schedule Indexing</h2>
	<br/>
	<form action='${index_schedule_url}'>
	<table width="50%" class="admin-table">
	<tr><td><span class="admin-table-rowh">Current re-index Schedule</span></td>
		<td>
			<input id="idx_time" name="idx_time" value="${DPROG_INDEX_RUN_TIME}"/>
			<#if index_error??>
				<br/>
				<span style="color: red">Invalid Chron value.</span>
			</#if><br />
			<button type="submit" class="btn btn-primary" style="margin-top: 10px">Save</button> <br />
		</td></tr></table>
		
	</form>
	<button class="btn btn-default btn-xs">Help</button>
<script>

$j("button").click(function () {
$j("#cronHelp").toggle("slow");
});
</script>
	<br />
	<br />
	<@d.cronTable />
	
	
	<#assign index_now_url>
		<@s.url relativeUrl="/admin/dprog_index_now.html"/>
	</#assign>
	
	<h2 style="width: 100%; text-align: left;">Re-Index Now</h2>
	<form action='${index_now_url}'>
		<button type="submit" name="submit_now" class="btn btn-primary">Go</button>
	</form>
	
	
<#include "admin_bot.ftl">
</@layout.body>