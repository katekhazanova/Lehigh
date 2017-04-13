<@layout.head title="${pageContext.page.label} Details" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="exception"/>
	<@p.detailView pageContext />

	<#-- only show StuExcCourses if the action type (action) of the parent StuException == R -->
	<#if showStuExcCourses>	
		<hr />
		<@p.masterView stuExcCoursePageContext />
	</#if>
	
</@layout.body>