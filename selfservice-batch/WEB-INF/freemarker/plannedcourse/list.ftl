<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="courses"/>
<input type="hidden" id="mobilePageGroup" value="plannedCourses"/>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.plannedcourse.list.header' /></h1>
	<p><@s.message 'uachieve.selfservice.plannedcourse.list.text' /></p>

	<@p.masterView pageContext />
	
</@layout.body>