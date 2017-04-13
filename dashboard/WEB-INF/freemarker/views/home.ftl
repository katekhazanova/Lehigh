<html>
<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
<head>
	<title>Home</title>	
	<META name="userName" content="${userFullName!''}">	
</head>

<div class="row">
		<input type="hidden" id="pageGroup" value="home"/>
	<input type="hidden" id="mobilePageGroup" value="home"/>
	<div class="col-md-12"> 

	<h1>Home</h1>
	<p>${welcomeText}</p>
	

			
			
			<#if selfserviceURL != "">
				<@security.authorize ifAllGranted="SS_MISC_STUDENTSEARCH=R,SS_ROLE_ADVISOR=crud">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${selfserviceURL}/student/search.html?crossApp=${crossApp}"
							class="dashboard-link" role="button" title="Students">
						<div><i class="fa fa-students fa-5x"></i><br>
							Students</div>
					</a>
				</div>
				</@security.authorize>
			<#elseif  udirectURL != "">	
				<@security.authorize ifAllGranted="UDIR_Advisor=r">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${udirectURL}/advisor/browse-students.html?on=false" class="dashboard-link" role="button" title="Students">
						<div><i class="fa fa-students fa-5x"></i><br>
							Students</div>
					</a>
				</div>
				</@security.authorize>
			</#if>

			<#if udirectURL != "">
				<@security.authorize ifAnyGranted="UDIR_Roadmaps=r, UDIR_Publisher=u">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${udirectURL}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}" 
					class="dashboard-link" role="button" title="Roadmaps">
						<div><i class="fa fa-roadmaps fa-5x"></i><br>
							Roadmaps</div>
					</a>
				</div>
				</@security.authorize>
			</#if>
			
			<#if selfserviceURL != "">
				<@security.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r, SS_ENCODING_TA_RULE=r">
					<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
						<a href="${selfserviceURL}/encoding/transfer/transferhome.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Encoding">
							<div><i class="fa fa-encoding fa-5x"></i><br>
								Encoding</div>
						</a>
					</div>
				</@security.authorize>
			</#if>
			
			
			<#if selfserviceURL != "">
				<@security.authorize ifAnyGranted="SS_AREA_BATCHES=R">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${selfserviceURL}/batch/list.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Batch">
						<div><i class="fa fa-batch fa-5x"></i><br>
							Batch</div>
					</a>
				</div>
				</@security.authorize>
			</#if>
			
			<#if selfserviceURL != "">
				<@security.authorize ifAnyGranted="SS_AREA_CROSSWALK=R">
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="${selfserviceURL}/crosswalk/list.html?crossApp=${crossApp}" class="dashboard-link" role="button" title="Program Mappings">
						<div><i class="fa fa-programMappings fa-5x"></i><br>
							Program Mappings</div>
					</a>
				</div>
				</@security.authorize>
			</#if>
			
			
			<@security.authorize ifAnyGranted="DASH_Reports=R">
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@spring.url relativeUrl="/reports/reports-console.html" />" class="dashboard-link" role="button" title="Reports">
					<div><i class="fa fa-reports fa-5x"></i><br>
						Reports</div>
				</a>
			</div>
			</@security.authorize>
			
			<@security.authorize ifAnyGranted="SEC_Users=r,SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r,SEC_Advisees=r,SEC_Roles=r"> 
			<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
				<a href="<@spring.url relativeUrl="/security-console.html" />" class="dashboard-link" role="button" title="Security">
					<div><i class="fa fa-security fa-5x"></i><br>
						Security</div>
				</a>
			</div>
			</@security.authorize>
			
			<@security.authorize ifAnyGranted="SB_ADMIN_EDIT=crud, SS_AREA_ADMIN=crud, UDIR_Admin=crud"> 
				<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
					<a href="<@spring.url relativeUrl="/admin/admin_menu.html" />" class="dashboard-link" role="button" title="Admin">
						<div><i class="fa fa-admin fa-5x"></i><br>
							Admin</div>
					</a>
				</div>
			</@security.authorize>
			
			
				</div> <#-- /col-md-11 -->
</div> <#-- /row -->

	<#if studentLandingPageUrl != "">	
		<#if selfserviceURL != "">
			<@security.authorize ifAnyGranted="SS_ROLE_STUDENT=r">	
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
							<a href="${studentLandingPageUrl}?student=crossApp=${crossApp}">View your profile</a>
							</div>
						</div>
					</div>
				</div>
			</@security.authorize>
		<#else>	
			<@security.authorize ifAnyGranted="UDIR_Plans=r, UDIR_Plans=u,SB_USER=r">	
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
							<a href="${studentLandingPageUrl}?student=crossApp=${crossApp}">View your profile</a>
							</div>
						</div>
					</div>
				</div>
			</@security.authorize>
		</#if>
	</#if>

</html>