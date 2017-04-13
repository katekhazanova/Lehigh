<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="courses"/>
<input type="hidden" id="mobilePageGroup" value="homeCourses"/>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.course.list.header'/></h1>
	<p><@s.message 'uachieve.selfservice.course.list.text'/></p>

	<@p.masterView pageContext />

	<#-- @h.statusLegend /-->

</@layout.body>

