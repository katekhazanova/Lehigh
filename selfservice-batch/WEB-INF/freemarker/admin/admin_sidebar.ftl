<#assign redauth=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>
<#assign adminBaseUrl>
	<@s.url relativeUrl="/admin/"/>
</#assign>




<div class="col-md-3">
	<div class="well">
	<h2 style="margin-top: 0px;">Administration</h2>
		<ul id="admin-sidebar" class="nav nav-pills nav-stacked">
		
			<@redauth.authorize ifAnyGranted="SB_ADMIN_EDIT=crud">
			<#if (scheduleBuilderURL?? && scheduleBuilderURL !="" ) || dashboardURL?? && dashboardURL !="">
				<li style="font-weight: bold;">Schedule Builder </li>
			</#if>
			<#if dashboardURL?? && dashboardURL !="" >
				<li><a href="${dashboardURL}/admin/admin_general.html?crossApp=${crossApp}">General</a></li>
				<li><a href="${dashboardURL}/admin/admin_remote.html?crossApp=${crossApp}">Remote</a></li>
				<li><a href="${dashboardURL}/admin/admin_schedule.html?crossApp=${crossApp}">Schedule</a></li>
				<li><a href="${dashboardURL}/admin/admin_Home.html?crossApp=${crossApp}">Home Page</a></li>
			</#if>
			<#if scheduleURL?? && scheduleURL !="">
				<li><a href="${scheduleURL}/admin/admin_YearTerm?crossApp=${crossApp}">YearTerm Setup</a></li>
				<li><a href="${scheduleURL}/admin/index_home?crossApp=${crossApp}">Course Indexing</a></li>
				<li><a href="${scheduleURL}/admin/logging_viewall?crossApp=${crossApp}">Logging & Support</a></li>
			</#if>
			</@redauth.authorize>
			
			<@redauth.authorize ifAnyGranted="SS_AREA_ADMIN=crud">
			<li style="font-weight: bold;">Self-Service </li>
			<li><a href="<@h.url href='/admin/dprog_index_home.html' />">ProgramMatcher</a></li>
			<#if dashboardURL?? && dashboardURL !="" >
				<li><a href="${dashboardURL}/admin/admin_auditException.html">Audit Exceptions</a></li>
			</#if>
			</@redauth.authorize>
			
			<@redauth.authorize ifAnyGranted="UDIR_Admin=crud">
			<#if dashboardURL?? && dashboardURL !="" >
				<li style="font-weight: bold;">u.direct</li>
				<li><a href="${dashboardURL}/admin/admin_courseGrades.html">Catalog Course Grades</a></li>
				<li><a href="${dashboardURL}admin_planNotes.html">Plan Messages</a></li>
			</#if>
			</@redauth.authorize>
			<#if dashboardURL?? && dashboardURL !="" >
				<li style="font-weight: bold;">Global</li>
				<li><a href="${adminBaseUrl}admin_property.html">Property Configurations</a></li>
			</#if>

			</ul>
	</div>
</div>