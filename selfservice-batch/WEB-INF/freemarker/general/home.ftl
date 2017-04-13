<#assign redauth=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<@layout.head "Home" />
<@layout.body>
	<input type="hidden" id="pageGroup" value="home"/>
	<input type="hidden" id="mobilePageGroup" value="home"/>
<div class="row">
		
	<div class="col-md-12">
		<h1>Home</h1>
		<p><@s.message 'uachieve.selfservice.message'/></p>
		
	<!--		<@redauth.authorize ifAnyGranted="UDIR_Advisor=R">
					<#if udirectRemoteLogin??>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="${udirectRemoteLogin}/secure/udirect/notifications.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Notifications">
								<div><i class="fa fa-notifications fa-5x"></i><br>
									Notifications</div>
							</a>
						</div>
					</#if>
			</@redauth.authorize> -->
		
		<@sec.hasAppFn appFn=AppFuncRole.SS_MISC_STUDENTSEARCH>
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@h.url href='/student/search.html' />"  class="dashboard-link" role="button" title="Students">
					<div><i class="fa fa-students fa-5x"></i><br>
						Students</div>
				</a>
			</div>
		</@sec.hasAppFn>
		
		<#if udirectRemoteLogin??>
			<@redauth.authorize ifAnyGranted="UDIR_Roadmaps=r, UDIR_Publisher=u">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${udirectRemoteLogin}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Roadmaps">
						<div><i class="fa fa-roadmaps fa-5x"></i><br>
							Roadmaps</div>
					</a>
				</div>
			</@redauth.authorize>
		</#if>	
		
		<@redauth.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r, SS_ENCODING_TA_RULE=r">
		<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@s.url "/encoding/transfer/transferhome.html" />" class="dashboard-link" role="button" title="Encoding">
					<div><i class="fa fa-encoding fa-5x"></i><br>
						Encoding</div>
				</a>
			</div>
		</@redauth.authorize>
		
		<@sec.hasAppFn AppFuncRole.SS_AREA_BATCHES >
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@s.url "/batch/list.html" />" class="dashboard-link" role="button" title="Batch">
					<div><i class="fa fa-batch fa-5x"></i><br>
						Batch</div>
				</a>
			</div>
		</@sec.hasAppFn>
		
		
		<@sec.hasAppFn AppFuncRole.SS_AREA_CROSSWALK>
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@s.url "/crosswalk/list.html" />" class="dashboard-link" role="button" title="Program Mappings">
					<div><i class="fa fa-programMappings fa-5x"></i><br>
						Program Mappings</div>
				</a>
			</div>
		</@sec.hasAppFn>
		
		
		<#if dashboardURL?? && dashboardURL != "">
			<@redauth.authorize ifAnyGranted="DASH_Reports=R">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${dashboardURL}/reports/reports-console.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Reports">
						<div><i class="fa fa-reports fa-5x"></i><br>
							Reports</div>
					</a>
				</div>
			</@redauth.authorize>
		</#if>
		
		<#if dashboardURL?? && dashboardURL != "">				
			<@redauth.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r,SEC_Advisees=r,SEC_Roles=r"> 
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${dashboardURL}/security-console.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Security">
						<div><i class="fa fa-security fa-5x"></i><br>
							Security</div>
					</a>
				</div>
			</@redauth.authorize>
		</#if>
			
		<#if dashboardURL?? && dashboardURL !="" >
			<@redauth.authorize ifAnyGranted="SB_ADMIN_EDIT=crud, SS_AREA_ADMIN=crud">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${dashboardURL}/admin/admin_menu.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Admin">
						<div><i class="fa fa-admin fa-5x"></i><br>
							Admin</div>
					</a>
				</div>
			</@redauth.authorize>
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