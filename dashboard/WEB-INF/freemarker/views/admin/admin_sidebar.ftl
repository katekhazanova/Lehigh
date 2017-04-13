<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
<#assign adminBaseUrl>
	<@spring.url relativeUrl="/admin/"/>
</#assign>



<div class="col-md-3">
	<div class="well">
	<h2 style="margin-top: 0px;">Administration</h2>
		<ul id="admin-sidebar"class="nav nav-pills nav-stacked">
		
			<@security.authorize ifAnyGranted="SB_ADMIN_EDIT=r">
			<li style="font-weight: bold;">Schedule Builder</li>
			<li><a href="${adminBaseUrl}admin_general.html">General</a></li>
			<li><a href="${adminBaseUrl}admin_remote.html">Remote</a></li>
			<li><a href="${adminBaseUrl}admin_schedule.html">Schedule</a></li>
			<li><a href="${adminBaseUrl}admin_Home.html">Home Page</a></li>
			<#if scheduleBuilderURL != "">
				<li><a href="${scheduleBuilderURL}/admin/admin_YearTerm?crossApp=${crossApp}">YearTerm Setup</a></li>
				<li><a href="${scheduleBuilderURL}/admin/index_home?crossApp=${crossApp}">Course Indexing</a></li>
				<li><a href="${scheduleBuilderURL}/admin/logging_viewall?crossApp=${crossApp}">Logging & Support</a></li>
			</#if>
			</@security.authorize>
			
			<@security.authorize ifAnyGranted="SS_AREA_ADMIN=r">
				<li style="font-weight: bold;">Self-Service </li>
				<#if selfserviceURL !="" >
					<li><a href="${selfserviceURL}/admin/dprog_index_home.html?crossApp=${crossApp}">ProgramMatcher </a></li>
				</#if>
				<li><a href="${adminBaseUrl}admin_auditException.html">Audit Exceptions</a></li>
			</@security.authorize>
			
	<!--		<@security.authorize ifAnyGranted="SS_AREA_ADMIN=crud">
				<li style="font-weight: bold;">AuditViewer</li>
				<li><a href="<@spring.url relativeUrl="/auditviewer/home.html" />">Compare Audits</a></li>
			</@security.authorize>
	-->
			
			<@security.authorize ifAnyGranted="UDIR_Admin=r">
				<li style="font-weight: bold;">u.direct</li>
				<li><a href="${adminBaseUrl}admin_courseGrades.html">Catalog Course Grades</a></li>
				<li><a href="${adminBaseUrl}admin_planNotes.html">Plan Messages</a></li>
			</@security.authorize>
			<@security.authorize ifAnyGranted="SS_AREA_ADMIN=r, SB_ADMIN_EDIT=r, UDIR_Admin=r">
				<li style="font-weight: bold;">Global</li>
				<li><a href="${adminBaseUrl}admin_property.html">Property Configurations</a></li>
			</@security.authorize>

		</ul>
	</div>
</div>