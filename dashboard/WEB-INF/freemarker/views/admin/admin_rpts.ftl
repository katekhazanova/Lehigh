<head>
</head>

	
<#include "admin_top.ftl">
	
		<h1 id="pagetitle" tabindex="0">Reports</h1>
		<br />
		<#assign crse_demand_url>
			<@spring.url relativeUrl="/admin/admin_course_demand"/></#assign>
			<ul>
			<li>
			<a href="${crse_demand_url}">Course Demand</a></li>
			</ul>
			
			<div id="filler_bot">
	
	</div>
	

<#include "admin_bot.ftl">