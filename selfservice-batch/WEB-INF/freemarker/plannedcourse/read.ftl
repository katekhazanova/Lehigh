<@layout.head title="${pageContext.page.label} Details" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="courses"/>
<input type="hidden" id="mobilePageGroup" value="plannedCourses"/>
	<@p.detailView pageContext />
	
</@layout.body>