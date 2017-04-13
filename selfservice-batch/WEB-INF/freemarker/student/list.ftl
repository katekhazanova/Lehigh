<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="profile"/>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.student.manage.profile.header'/></h1>
	<p><@s.message 'uachieve.selfservice.student.manage.profile.text'/></p>
	<@sec.hasAppFn AppFuncRole.SS_AREA_COURSE>
		<a href="<@h.url "/course/list.html" />" class="brownboldlink">View Student Courses</a>
	</@sec.hasAppFn>
	<@p.masterView pageContext />
	
</@layout.body>