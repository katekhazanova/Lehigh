<#assign security=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<@layout.head "Home" />
<@layout.body>
	<input type="hidden" id="pageGroup" value="home"/>
	<input type="hidden" id="mobilePageGroup" value="home"/>
<div class="row">
		
	<div class="col-md-12">
		<h1>Home</h1>
		<p><@s.message 'uachieve.selfservice.message'/></p>
		
		<@sec.hasAppFn appFn=AppFuncRole.SS_MISC_STUDENTSEARCH>
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@h.url href='/student/search.html' />"  class="dashboard-link" role="button" title="Students">
					<div><i class="fa fa-students fa-5x"></i><br>
						Students</div>
				</a>
			</div>
		</@sec.hasAppFn>
		
		<#if udirectRemoteLogin??>
			<@security.authorize ifAnyGranted="UDIR_Roadmaps=r, UDIR_Publisher=u">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${udirectRemoteLogin}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Roadmaps">
						<div><i class="fa fa-roadmaps fa-5x"></i><br>
							Roadmaps</div>
					</a>
				</div>
			</@security.authorize>
		</#if>	
		
		<@security.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r, SS_ENCODING_TA_RULE=r">
		<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@s.url "/encoding/transfer/transferhome.html" />" class="dashboard-link" role="button" title="Encoding">
					<div><i class="fa fa-encoding fa-5x"></i><br>
						Encoding</div>
				</a>
			</div>
		</@security.authorize>
		
		<@sec.hasAppFn AppFuncRole.SS_AREA_BATCHES >
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@s.url "/batch/list.html" />" class="dashboard-link" role="button" title="Batch">
					<div><i class="fa fa-batch fa-5x"></i><br>
						Batch</div>
				</a>
			</div>
		</@sec.hasAppFn>
		
		<#if dashboardURL?? && dashboardURL != "">		
			<@security.authorize ifAnyGranted="DASH_AUDIT_COMPARE=r">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${dashboardURL}/auditviewer/home.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Audit Comparison">
						<div><i class="fa fa-file-text-o fa-5x"></i> <i class="fa fa-file-text-o fa-5x"></i><br>
							Audit Comparison</div>
					</a>
				</div>
            </@security.authorize>
		</#if>
		
		
		<@sec.hasAppFn AppFuncRole.SS_AREA_CROSSWALK>
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@s.url "/crosswalk/list.html" />" class="dashboard-link" role="button" title="Program Mappings">
					<div><i class="fa fa-programMappings fa-5x"></i><br>
						Program Mappings</div>
				</a>
			</div>
		</@sec.hasAppFn>
		
		
		<#if dashboardURL?? && dashboardURL != "">
			<@security.authorize ifAnyGranted="DASH_Reports=R">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${dashboardURL}/reports/reports-console.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Reports">
						<div><i class="fa fa-reports fa-5x"></i><br>
							Reports</div>
					</a>
				</div>
			</@security.authorize>
		</#if>
			
		<#if dashboardURL?? && dashboardURL !="" >
			<@security.authorize ifAnyGranted="SB_ADMIN_EDIT=r, SS_AREA_ADMIN=r">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${dashboardURL}/admin/admin_menu.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Admin">
						<div><i class="fa fa-admin fa-5x"></i><br>
							Admin</div>
					</a>
				</div>
			</@security.authorize>
		</#if>
	</div> <#-- /col-md-8 -->
</div> <#-- /row -->	

<@sec.isStudent>	
<div class="row">	
	<div class="col-md-11">
		<br />
		<div class="well col-md-4" style="padding: 0px; ">
			<div class="col-md-5" style="color: #333;" aria-hidden="true">
				<span class="fa-stack fa-4x">
				  <i class="fa fa-square-o fa-stack-2x"></i>
				  <i class="fa fa-user fa-stack-1x"></i>
				</span>
			</div>
			<div class="col-md-7" >
				<h2>Student Access</h2>
				<a href="<@h.url "/student/setSelfAsCurrentStudent.html"/>">View your profile</a>
			</div>
			
		</div>
	</div> <#-- /col-md-11 -->
</div> <#-- /row -->
</@sec.isStudent>


</@layout.body>