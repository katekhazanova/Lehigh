<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>


<nav class="navbar navbar-default main-menu" role="navigation">
	<div class="navbar-header" id="navbar-default">
		<@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Domains=r,SEC_Users=r,SEC_Roles=r,SEC_Group_Members=r,SEC_Groups=r, UDIR_Advisor=r,UDIR_Publisher=r,DASH_Reports=r,UDIR_Admin=r, SB_ADMIN_EDIT=r,DASH_AUDIT_COMPARE=r">  
		<#if userCommand?? && userCommand.student??>
		 	<#assign student = userCommand.student />
		 	<@security.authorize ifAnyGranted="UDIR_Advisor=r, UDIR_Publisher=u, UDIR_Roadmaps=u,SS_ROLE_ADVISOR=r">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#studentMenu">
					<span class="sr-only">Toggle navigation</span> <span>Student Menu</span>
				</button>
			</@security.authorize>
		</#if>
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#mainmenu">
				<span class="sr-only">Toggle navigation</span> <span>Main Menu</span>
			</button>
		</@security.authorize> 
		<@security.authorize ifNoneGranted="SEC_Advisees=r,SEC_Domains=r,SEC_Users=r,SEC_Roles=r,SEC_Group_Members=r,SEC_Groups=r, UDIR_Advisor=r,UDIR_Publisher=r,DASH_Reports=r,UDIR_Admin=r, SB_ADMIN_EDIT=r,DASH_AUDIT_COMPARE=r">  
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#mainmenu">
				<span class="sr-only">Toggle navigation</span> <span>Menu</span>
			</button>
		</@security.authorize>
	</div>
	
<@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Domains=r,SEC_Users=r,SEC_Roles=r,SEC_Group_Members=r,SEC_Groups=r, UDIR_Advisor=r,UDIR_Publisher=r,DASH_Reports=r,UDIR_Admin=r, SB_ADMIN_EDIT=r,SS_ROLE_ADVISOR=r,DASH_AUDIT_COMPARE=r">
	<div class="collapse navbar-collapse main-menu" id="mainmenu">
		<ul class="nav navbar-nav" style="height: auto;">
				<li id="home" class="hidden-xs">
					<a href="<@spring.url relativeUrl="/home.html"/>" role="menuitem"  title="Home"> 
						<i class="fa fa-home fa-lg"><span class="sr-only">Home</span></i>
					</a>
				</li>
				<li class="visible-xs home">
					<a href="<@spring.url relativeUrl="/home.html"/>" role="menuitem"> 
						<i class="fa fa-home fa-lg"></i> Home
					</a>
				</li> 
		
		<#assign showNotifications = "${NOTIFICATIONS_VISIBLE}" />
			
		<#if showNotifications == "T" >
			<#if udirectURL != "">
			<@security.authorize ifAnyGranted="UDIR_Advisor=r, UDIR_Publisher=u, UDIR_Roadmaps=u, UDIR_Notes=r">
				<li id="notifications">
					<a href="${udirectURL}/secure/udirect/notifications/notifications.html?crossApp=${crossApp}"  role="menuitem">Notifications</a>
				</li> 
			</@security.authorize>
			</#if>
		</#if>
		
			
			<#if selfserviceURL !="" >
					<@security.authorize ifAllGranted="SS_MISC_STUDENTSEARCH=r">
						<li class="dropdown hidden-xs"><a href="#" id="students" class="dropdown-toggle" data-toggle="dropdown">Students
			             	<b class="caret"></b></a>
			            	<ul class="dropdown-menu" id="SearchDD" >
								<li>
									<a href="${selfserviceURL}/student/search.html?crossApp=${crossApp}">Search</a>
								</li>
								<@security.authorize ifAllGranted="SS_AREA_STUDENT=C">
									<li>
										<a href="${selfserviceURL}/student/create.html?crossApp=${crossApp}">Add</a>
									</li>
								</@security.authorize>
							</ul>
						</li>
						<li class="visible-xs">
							<a href="${selfserviceURL}/student/search.html?crossApp=${crossApp}" role="menuitem">Search Students</a>
						</li>
						<@security.authorize ifAllGranted="SS_AREA_STUDENT=C">
						<li class="visible-xs">
							<a href="${selfserviceURL}/student/create.html?crossApp=${crossApp}" role="menuitem">Add Student</a>
						</li>
						</@security.authorize>
					</@security.authorize>
					
					<@security.authorize ifNoneGranted="SS_MISC_STUDENTSEARCH=r">
						<@security.authorize ifAllGranted="UDIR_Advisor=r">
						<li class="dropdown hidden-xs"><a href="#" id="students" class="dropdown-toggle" data-toggle="dropdown">Students
			             	<b class="caret"></b></a>
			            	<ul class="dropdown-menu" id="SearchDD" >
								<li>
									<a href="${udirectURL}/advisor/browse-students.html?on=false&crossApp=${crossApp}">Search</a>
								</li>
							</ul>
						</li>
						<li class="visible-xs">
							<a href="${udirectURL}/advisor/browse-students.html?on=false&crossApp=${crossApp}" role="menuitem">Search Students</a>
						</li>
						</@security.authorize>
					</@security.authorize>
				<#elseif udirectURL != "" >
					<li class="dropdown hidden-xs"><a href="#" id="students" class="dropdown-toggle" data-toggle="dropdown">Students
			             <b class="caret"></b></a>
			            <ul class="dropdown-menu" id="SearchDD" >
							<li>
								<a href="${udirectURL}/advisor/browse-students.html?on=false&crossApp=${crossApp}">Search</a>
							</li>
						</ul>
					</li>
					<li class="visible-xs">
							<a href="${udirectURL}/advisor/browse-students.html?on=false&crossApp=${crossApp}" role="menuitem">Search Students</a>
					</li>
				</#if>
		
			<#if udirectURL!= "">
			<@security.authorize ifAnyGranted="UDIR_Roadmaps=r, UDIR_Publisher=u">
				<li class="dropdown hidden-xs" id="roadmaps"><a href="#" class="dropdown-toggle" data-toggle="dropdown" class="ignoreURL">Roadmaps <b class="caret"></b></a>
					<ul class="dropdown-menu" id="roadmapsDD">
						<li>
							<a href="${udirectURL}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}">Manage</a>
						</li>
						<li>
							<a href="${udirectURL}/roadmap/manageall/display-roadmaps.html?crossApp=${crossApp}">View All </a>
						</li>
					</ul>
				</li>
				<li class="visible-xs">
					<a href="${udirectURL}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}" role="menuitem">Manage Roadmaps</a>
				</li>
				<li class="visible-xs">
					<a href="${udirectURL}/roadmap/manageall/display-roadmaps.html?crossApp=${crossApp}" role="menuitem">View All Roadmaps</a>
				</li> 
			</@security.authorize> 
			</#if>
			
				<#if selfserviceURL != "">
				<@security.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r, SS_ENCODING_TA_RULE=r">
					<li id="encoding"><a href="${selfserviceURL}/encoding/transfer/transferhome.html?crossApp=${crossApp}"  role="menuitem">Encoding</a></li> 
				</@security.authorize>    
			    </#if>  
			
			
			<@security.authorize ifAllGranted="SS_AREA_BATCHES=r"> 
			<#if selfserviceURL != "">
				<li>
					<a href="${selfserviceURL}/batch/list.html?crossApp=${crossApp}" role="menuitem">Batch</a>
				</li> 
			</#if> 
			</@security.authorize> 
			
			<@security.authorize ifAnyGranted="DASH_AUDIT_COMPARE=r,SS_AREA_CROSSWALK=R">
			<li id="tools" class="dropdown hidden-xs"><a href="#" id="tools" class="dropdown-toggle" data-toggle="dropdown">Tools <b class="caret"></b></a>
				<ul class="dropdown-menu" id="toolsDD">
					<@security.authorize ifAnyGranted="DASH_AUDIT_COMPARE=r">
					<li>
                      <a href="<@spring.url relativeUrl="/auditviewer/home.html" />">Audit Comparison</a>
                    </li>
                    </@security.authorize>
                    <@security.authorize ifAllGranted="SS_AREA_CROSSWALK=r">
					<#if selfserviceURL != "">
						<li>
							<a href="${selfserviceURL}/crosswalk/list.html?crossApp=${crossApp}" role="menuitem">Program Mappings</a>
						</li> 
					</#if> 
					</@security.authorize> 
				</ul>
			</li>
			</@security.authorize>
			
			<@security.authorize ifAnyGranted="DASH_AUDIT_COMPARE=r">
			<li class="hidden-sm hidden-md hidden-lg"><a href="<@spring.url relativeUrl="/auditviewer/home.html" />">Audit Comparison</a></li>
			</@security.authorize>
			
			<@security.authorize ifAllGranted="SS_AREA_CROSSWALK=r">
			<#if selfserviceURL != "">
				<li class="hidden-sm hidden-md hidden-lg">
					<a href="${selfserviceURL}/crosswalk/list.html?crossApp=${crossApp}" role="menuitem">Program Mappings</a>
				</li> 
			</#if> 
			</@security.authorize> 
			
			<@security.authorize ifAnyGranted="DASH_Reports=C">
				<li class="hidden-sm" id="reports">
					<a href="<@spring.url relativeUrl="/reports/reports-console.html" />" role="menuitem">Reports</a>
				</li> 
			</@security.authorize> 
			
			<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r,SEC_Advisees=r,SEC_Roles=r">
			<li id="security" class="dropdown hidden-sm hidden-xs"><a href="#" id="redauth" class="dropdown-toggle" data-toggle="dropdown">Security <b class="caret"></b></a>
				<ul class="dropdown-menu" id="redauthDD">
					<li>
						<a href="<@spring.url relativeUrl="/security-console.html" />">Console</a>
					</li> 
					<@security.authorize ifAnyGranted="SEC_Roles=r">
					<li>
						<a href="<@spring.url relativeUrl="/roles.html" />">Roles</a>
					</li> 
					</@security.authorize> 
					<@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Users=r,SEC_Domains=r">
						<li>
							<a href="<@spring.url relativeUrl="/users.html" />">Users</a>
						</li> 
					</@security.authorize> 
					<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
						<li>
							<a href="<@spring.url relativeUrl="/groups.html" />">Groups</a>
						</li> 
					</@security.authorize> 
					<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
						<li>
							<a href="<@spring.url relativeUrl="/properties.html" />">Properties</a>
						</li> 
					</@security.authorize>
				</ul>
			</li> 
			</@security.authorize> 
			
			
			
			<!-- this section displays in the xs menu -->
                      <@security.authorize ifAnyGranted="SEC_Roles=r">
                        <li class="visible-xs hidden-sm hidden-md hidden-lg">
                          <a href="<@spring.url relativeUrl="/roles.html" />">Security Roles</a>
                        </li>
                      </@security.authorize>
                      <@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Users=r,SEC_Domains=r">
                          <li class="visible-xs hidden-sm hidden-md hidden-lg">
                            <a href="<@spring.url relativeUrl="/users.html" />">Security Users</a>
                          </li>
                      </@security.authorize>
			
					  <@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
                        <li class="visible-xs hidden-sm hidden-md hidden-lg">
                          <a href="<@spring.url relativeUrl="/groups.html" />"> Security Groups</a>
                        </li>
                      </@security.authorize>
					  
					  <@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
                        <li class="visible-xs hidden-sm hidden-md hidden-lg">
                          <a href="<@spring.url relativeUrl="/properties.html" />">Security Properties</a>
                        </li>
                      </@security.authorize>
      			

                  <@security.authorize ifAnyGranted="SS_AREA_ADMIN=r, SB_ADMIN_EDIT=r, UDIR_Admin=r">
                     <li class="visible-xs hidden-sm hidden-md hidden-lg"><a  href="$<@spring.url relativeUrl="/admin/admin_home.html" />" tabindex="-1">Admin</a></li>
                  </@security.authorize>
					
			<li class="visible-xs">
				<a  href="<@spring.url relativeUrl="/j_spring_security_logout"/>"  role="menuitem">
					<i class="fa fa-sign-out fa-lg"></i> Log Out 
				</a>
			</li>
			
			
			
			  <!-- this section displays in the sm menu -->
            <@security.authorize ifAnyGranted="DASH_Reports=R,SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r,SEC_Advisees=r,SEC_Roles=r">
            <li class="dropdown hidden-xs visible-sm hidden-md hidden-lg" id="overflow">
                <a id="overflowMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"  title="More">
                  More...
                  <b class="caret"></b>
                </a>
                <ul class="dropdown-menu"  aria-labelledby="overflowMenu">
                	
                	
                	<@security.authorize ifAnyGranted="DASH_Reports=C">
						<li class="" id="reports">
							<a href="<@spring.url relativeUrl="/reports/reports-console.html" />" role="menuitem">Reports</a>
						</li> 
						<li role="separator" class="divider"></li>
					</@security.authorize> 
                 
                 	<@security.authorize ifAnyGranted="SEC_Roles=r">
                        <li>
                          <a href="<@spring.url relativeUrl="/roles.html" />">Security Roles</a>
                        </li>
                      </@security.authorize>
                      <@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Users=r,SEC_Domains=r">
                          <li>
                            <a href="<@spring.url relativeUrl="/users.html" />">Security Users</a>
                          </li>
                      </@security.authorize>
			
					  <@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
                        <li>
                          <a href="<@spring.url relativeUrl="/groups.html" />"> Security Groups</a>
                        </li>
                      </@security.authorize>
					  
					  <@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
                        <li>
                          <a href="<@spring.url relativeUrl="/properties.html" />">Security Properties</a>
                        </li>
                      </@security.authorize>
                  
                  
            			    	
        						
                </ul>
            </li>
            </@security.authorize>
			

		</ul>

		<ul class="nav navbar-nav navbar-right settings hidden-xs">
			<#if udirectURL != "">
			    		
	    		<#elseif selfserviceURL !="" >
	    			<@security.authorize ifAllGranted="SS_AREA_COMMENTS=r">
						<li class="dropdown" id="notifications">
		        			<a id="notificationsMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"  title="Notifications">
		        				<i class="fa fa-bell fa-lg"><span class="sr-only">Notifications</span></i> 
		        				<b class="caret"></b>
	        				</a>
			        		<ul class="dropdown-menu"  aria-labelledby="notificationsMenu"">
			    				<li role="presentation">
			    					<a  href="<@h.url href="/comments_notifications.html"/>" tabindex="-1">
			    						${commentLabel}s
		    						</a>
	    						</li>
		    				</ul>
	    				</li>
    				</@security.authorize>
    			<#else>
    			
				</#if>
		
		
			
		
			<li class="dropdown" id="settings">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" title="Settings"><span class="sr-only">Settings</span><i class="fa fa-cog fa-lg"></i> <b class="caret"></b></a>
				<ul class="dropdown-menu" id="settingsDD">
					<@security.authorize ifAnyGranted="UDIR_Admin=r, SB_ADMIN_EDIT=r, SS_AREA_ADMIN=r"> 
						<li>
							<a href="<@spring.url relativeUrl="/admin/admin_menu.html" />" id="admin">Admin</a>
						</li> 
					</@security.authorize>
						<#if selfserviceURL != "">
							<@security.authorize ifAnyGranted="SS_MISC_PWCHANGE=r">
								<li><a href="${selfserviceURL}/general/changepassword.html?crossApp=${crossApp}" title="Change Password" alt="Change Password">Change Password</a></li>
							</@security.authorize>
						<#elseif udirectURL != "">
							<@security.authorize ifAnyGranted="UDIR_PasswordChange=u">
								<li><a href="${udirectURL}/prefs/change-password.html?crossApp=${crossApp}" title="Change Password" alt="Change Password">Change Password</a></li>
							</@security.authorize>
						</#if>
						<#if helpURL!=''>
					     	<li><a  href="${helpURL}" target='_blank' tabindex="-1">Help</a></li>
					   	<#else>
					   		<#assign helpUrl = "/general/helloworld.html#help" />
							<li><@h.link href='${helpUrl}' title='Help' target='_blank' /></li>
						</#if>
					<li class="divider"></li>
					<li>
						<a  href="<@spring.url relativeUrl="/j_spring_security_logout"/>" > 
							<i class="fa fa-sign-out fa-lg"></i> Log Out 
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</div>


	<#if udirectURL != "" || selfserviceURL != "">
	<#if userCommand?? && userCommand.student??>
	<#assign student = userCommand.student />
	<@security.authorize ifAnyGranted="UDIR_Advisor=r, UDIR_Publisher=u, UDIR_Roadmaps=u,SS_ROLE_ADVISOR=r">

	<div class="collapse navbar-collapse studentMenu" id="studentMenu">
		<ul class="nav navbar-nav" style="height: auto;">
			<li class="selectedStudent">
				<p class="navbar-text">
					<span class="studentName">
				 		${studentLabel}
						<#if displayStudentName == "T">
							${student.firstName} ${student.lastName}
						</#if>
						<#if displayStudentNumber == "T">
							<#if displayStudentName == "T">/</#if>
							${student.sisId}
						</#if>
						<br/>
					</span>
				</p>
			</li> 
			
			<#if selfserviceURL != "">
			<@security.authorize ifAnyGranted="SS_AREA_AUDIT=r,SS_AREA_AUDIT=c">
				<li id="audits" class="dropdown hidden-xs"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Audits <b class="caret"></b></a>
					<ul class="dropdown-menu" id="auditsDD">
						<@security.authorize ifAllGranted="SS_AREA_AUDIT=c">
						<li>
							<a href="${selfserviceURL}/audit/create.html?crossApp=${crossApp}">Request New</a>
						</li> 
						</@security.authorize> 
						<@security.authorize ifAllGranted="SS_AREA_AUDIT=r">
							<li>
								<a href="${selfserviceURL}/audit/list.html?crossApp=${crossApp}">Manage</a>
							</li>
						</@security.authorize>
						<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
							<li>
								<a href="${selfserviceURL}/programmatcher/viewSearchResults.html?crossApp=${crossApp}">Program Matcher</a>
							</li> 
						</@security.authorize> 
					</ul>
				</li> 
				<@security.authorize ifAllGranted="SS_AREA_AUDIT=c">
					<li class="visible-xs">
						<a href="${selfserviceURL}/audit/create.html?crossApp=${crossApp}" role="menuitem">Request New Audit</a>
					</li> 
				</@security.authorize> 
				<@security.authorize ifAllGranted="SS_AREA_AUDIT=r">
					<li class="visible-xs">
					 <a href="${selfserviceURL}/audit/list.html?crossApp=${crossApp}" role="menuitem">Manage Audits</a>
					</li> 
				</@security.authorize> 
				<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
					<li class="visible-xs">
						<a href="${selfserviceURL}/programmatcher/viewSearchResults.html?crossApp=${crossApp}" role="menuitem">Program Matcher</a>
					</li> 
				</@security.authorize> 
			</@security.authorize> 
			</#if>


			<#if udirectURL != "">
			<@security.authorize ifAnyGranted="UDIR_Plans=r, UDIR_Plans=u">
				<li id="plans">
					<a href="${udirectURL}/plan/manage/display-plans.html?crossApp=${crossApp}"  role="menuitem"> ${planLabel}s </a>
				</li>
			</@security.authorize> 
			</#if>
			
			<#if scheduleBuilderURL??>
			<@security.authorize ifAnyGranted="SB_USER=crud">
				<li class="dropdown hidden-xs"><a href="#" id="schedules" class="dropdown-toggle" data-toggle="dropdown">Schedules <b class="caret"></b> </a>
					<ul class="dropdown-menu" id="scheduleDD">
						<li><a href="${scheduleBuilderURL}/sec/home_id?crossApp=${crossApp}">Schedule Home</a></li>
						<li><a href="${scheduleBuilderURL}/sec/sched_show?crossApp=${crossApp}">My Current Schedule</a></li>
						<li><a href="${scheduleBuilderURL}/sec/search?crossApp=${crossApp}">Find Courses</a></li>
						<@security.authorize ifAnyGranted="SB_AUTOGENERATESCHEDULE=crud">
							<li><a href="${scheduleBuilderURL}/sec/preferences?crossApp=${crossApp}">Preferences</a></li>
						</@security.authorize> 
					</ul>
				</li>
	
				<li class="visible-xs">
					<a href="${scheduleBuilderURL}/sec/sched_show?crossApp=${crossApp}" role="menuitem">My Current Schedule</a>
				</li> 
			</@security.authorize> 
			</#if>
			
			<#if selfserviceURL != "">
			<@security.authorize ifAnyGranted="SS_AREA_COURSE=r,SS_AREA_TRANSFERCOURSE=r,SS_AREA_PLANNEDCOURSE=r">
				<li class="dropdown hidden-xs"> <a id="courses" href="#" class="dropdown-toggle" data-toggle="dropdown">Courses <b class="caret"></b></a>
					<ul class="dropdown-menu" id="coursesDD">
						<@security.authorize ifAnyGranted="SS_AREA_COURSE=r">
							<li>
								<a href="${selfserviceURL}/course/list.html?crossApp=${crossApp}">Home</a>
							</li>
						</@security.authorize> 
						<@security.authorize ifAnyGranted="SS_AREA_TRANSFERCOURSE=r">
							<li>
								<a href="${selfserviceURL}/transfercourse/list.html?crossApp=${crossApp}">Transfer </a>
							</li> 
						</@security.authorize> 
						<@security.authorize ifAnyGranted="SS_AREA_PLANNEDCOURSE=r">
							<li>
								<a href="${selfserviceURL}/plannedcourse/list.html?crossApp=${crossApp}">Planned</a>
							</li> 
						</@security.authorize>
					</ul>
				</li> 
				
				<@security.authorize ifAnyGranted="SS_AREA_COURSE=r">
					<li class="visible-xs">
						<a href="${selfserviceURL}/course/list.html?crossApp=${crossApp}" role="menuitem">Home Courses</a>
					</li> 
				</@security.authorize> 
				<@security.authorize ifAnyGranted="SS_AREA_TRANSFERCOURSE=r">
					<li class="visible-xs">
						<a href="${selfserviceURL}/transfercourse/list.html?crossApp=${crossApp}" role="menuitem">Transfer Courses</a>
					</li> 
				</@security.authorize> 
				<@security.authorize ifAnyGranted="SS_AREA_PLANNEDCOURSE=r">
					<li class="visible-xs">
						<a href="${selfserviceURL}/plannedcourse/list.html?crossApp=${crossApp}" role="menuitem">Planned Courses</a>
					</li> 
				</@security.authorize> 
			</@security.authorize>
			</#if>
			
			<#if selfserviceURL != "">
				<@security.authorize ifAllGranted="SS_AREA_COMMENTS=r">
					<li>
						<a href="${selfserviceURL}/comment/list.html?crossApp=${crossApp}" role="menuitem">${commentLabel}s</a>
					</li> 
				</@security.authorize> 
					
				<@security.authorize ifAllGranted="SS_AREA_TRANSFEREVAL=r">
					<li class="hidden-sm hidden-xs">
						<a href="${selfserviceURL}/transfereval/list.html?crossApp=${crossApp}" role="menuitem">Transfer Evaluations</a>
					</li>
				</@security.authorize> 
				
				<@security.authorize ifAllGranted="SS_AREA_EXCEPTION=r">
					<li class="hidden-sm hidden-xs"> 
						<a href="${selfserviceURL}/exception/list.html?crossApp=${crossApp}" role="menuitem">Exceptions</a>
					</li> 
				</@security.authorize> 
				
				<@security.authorize ifAnyGranted="SS_AREA_DPROG=r,SS_AREA_STUDENT=r">
					<li class="dropdown hidden-xs"><a id="profile" href="#" class="dropdown-toggle" data-toggle="dropdown">Profile <b class="caret"></b></a>
						<ul class="dropdown-menu" id="profileDD">
							<@security.authorize ifAllGranted="SS_AREA_DPROG=r">
								<li>
									<a href="${selfserviceURL}/dprog/list.html?crossApp=${crossApp}">Programs</a>
								</li>
							</@security.authorize> 
							<@security.authorize ifAllGranted="SS_AREA_STUDENT=r">
								<li>
									<a href="${selfserviceURL}/student/list.html?crossApp=${crossApp}">Demographic</a>
								</li>
							</@security.authorize>
						</ul>
					</li> 
				</@security.authorize> 
			</#if>
			
		</ul>

	</div> 
	
</@security.authorize>
</#if>
</#if>
</@security.authorize>
 






<@security.authorize ifNoneGranted="SEC_Advisees=r,SEC_Domains=r,SEC_Users=r,SEC_Roles=r,SEC_Group_Members=r,SEC_Groups=r, UDIR_Advisor=r,UDIR_Publisher=r,DASH_Reports=r,UDIR_Admin=r, SB_ADMIN_EDIT=r,SS_ROLE_ADVISOR=r,DASH_AUDIT_COMPARE=r">
	<div class="collapse navbar-collapse main-menu" id="mainmenu">
		<ul class="nav navbar-nav" style="height: auto;">
			<#if selfserviceURL !="" >
			<@security.authorize ifAnyGranted="SS_AREA_AUDIT=r,SS_AREA_AUDIT=c">
				<li class="dropdown hidden-xs"><a id="audits" href="#" class="dropdown-toggle" data-toggle="dropdown">Audits <b class="caret"></b></a>
					<ul class="dropdown-menu" id="auditsDD">
						<@security.authorize ifAllGranted="SS_AREA_AUDIT=c">
							<li>
								<a href="${selfserviceURL}/audit/create.html?crossApp=${crossApp}">Request New</a>
							</li>
						</@security.authorize> 
						<@security.authorize ifAllGranted="SS_AREA_AUDIT=r">
							<li>
								<a href="${selfserviceURL}/audit/list.html?crossApp=${crossApp}">Manage</a>
							</li>
						</@security.authorize>
						<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
							<li>
								<a href="${selfserviceURL}/programmatcher/viewSearchResults.html?crossApp=${crossApp}" />Program Matcher</a>
							</li> 
						</@security.authorize> 
					</ul>
				</li> 
					
				<@security.authorize ifAllGranted="SS_AREA_AUDIT=c">
					<li class="visible-xs">
						<a href="${selfserviceURL}/audit/create.html?crossApp=${crossApp}" role="menuitem">Request New Audit</a>
					</li>
				</@security.authorize> 
				<@security.authorize ifAllGranted="SS_AREA_AUDIT=r">
					<li class="visible-xs">
						<a href="${selfserviceURL}/audit/list.html?crossApp=${crossApp}" role="menuitem">Manage Audits</a>
					</li> 
				</@security.authorize> 
				<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
					<li class="visible-xs">
						<a href="${selfserviceURL}/programmatcher/viewSearchResults.html?crossApp=${crossApp}"  role="menuitem">Program Matcher</a>
					</li> 
				</@security.authorize> 
			</@security.authorize> 
			</#if>
			
			
			<#if udirectURL!= "">
			<@security.authorize ifAnyGranted="UDIR_Plans=r, UDIR_Plans=u">
				<li id="plans">
					<a href="${udirectURL}/plan/manage/display-plans.html?crossApp=${crossApp}" role="menuitem">${planLabel}s</a>
				</li> 
			</@security.authorize>
			</#if>
			
			<#if scheduleBuilderURL??>
			<@security.authorize ifAnyGranted="SB_USER=crud">
				<li class="dropdown hidden-xs"><a href="#" id="schedules" class="dropdown-toggle" data-toggle="dropdown">Schedules <b class="caret"></b></a>
					<ul class="dropdown-menu" id="scheduleDD">
						<li><a href="${scheduleBuilderURL}/sec/home_id?crossApp=${crossApp}">Schedule Home</a></li>
						<li><a href="${scheduleBuilderURL}/sec/sched_show?crossApp=${crossApp}">My Current Schedule</a></li>
						<li><a href="${scheduleBuilderURL}/sec/search?crossApp=${crossApp}">Find Courses</a></li>
						<@security.authorize ifAnyGranted="SB_AUTOGENERATESCHEDULE=crud">
							<li><a href="${scheduleBuilderURL}/sec/preferences?crossApp=${crossApp}">Preferences</a></li>
						</@security.authorize>
					</ul>
				</li>
				<li class="visible-xs">
					<a href="${scheduleBuilderURL}/sec/sched_show?crossApp=${crossApp}" role="menuitem">My Current Schedule</a>
				</li> 
			</@security.authorize> 
			</#if>
	
			<#if udirectURL!= "">
			<@security.authorize ifAllGranted="UDIR_Roadmaps=r">
				<li class="dropdown hidden-xs" id="roadmaps"><a href="#" id="roadmaps" class="dropdown-toggle" data-toggle="dropdown">Roadmaps <b class="caret"></b></a>
					<ul class="dropdown-menu" id="roadmapsDD">
						<li>
							<a href="${udirectURL}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}">Manage </a>
						</li>
						<li>
							<a href="${udirectURL}/roadmap/manageall/display-roadmaps.html?crossApp=${crossApp}">View All </a>
						</li>
					</ul>
				</li> 
			</@security.authorize>
			</#if>
			
			<#if selfserviceURL != "">
			<@security.authorize ifAnyGranted="SS_AREA_COURSE=r,SS_AREA_TRANSFERCOURSE=r,SS_AREA_PLANNEDCOURSE=r">
				<li class="dropdown hidden-xs"><a id="courses" class="dropdown-toggle" data-toggle="dropdown" href="#">Courses <b class="caret"></b></a>
					<ul class="dropdown-menu" id="coursesDD">
						<@security.authorize ifAllGranted="SS_AREA_COURSE=r">
							<li>
								<a href="${selfserviceURL}/course/list.html?crossApp=${crossApp}">Home</a>
							</li>
						</@security.authorize> 
						<@security.authorize ifAllGranted="SS_AREA_TRANSFERCOURSE=r">
							<li>
								<a href="${selfserviceURL}/transfercourse/list.html?crossApp=${crossApp}">Transfer</a>
							</li> 
						</@security.authorize> 
						<@security.authorize ifAllGranted="SS_AREA_PLANNEDCOURSE=r">
							<li>
								<a href="${selfserviceURL}/plannedcourse/list.html?crossApp=${crossApp}">Planned</a>
							</li>
						</@security.authorize>
						
					</ul>
				</li> 
				
				<@security.authorize ifAllGranted="SS_AREA_COURSE=r">
					<li class="visible-xs"><a href="${selfserviceURL}/course/list.html?crossApp=${crossApp}" role="menuitem">Home Courses</a></li> 
				</@security.authorize> 
				<@security.authorize ifAllGranted="SS_AREA_TRANSFERCOURSE=r">
					<li class="visible-xs"><a href="${selfserviceURL}/transfercourse/list.html?crossApp=${crossApp}" role="menuitem">Transfer Courses</a></li> 
				</@security.authorize> 
				<@security.authorize ifAllGranted="SS_AREA_PLANNEDCOURSE=r">
					<li class="visible-xs"><a href="${selfserviceURL}/plannedcourse/list.html?crossApp=${crossApp}" role="menuitem">Planned Courses</a></li> 
				</@security.authorize> 
			</@security.authorize>
			</#if>
			
			
			<@security.authorize ifAllGranted="SS_AREA_COMMENTS=r">
			<#if selfserviceURL != "">
				<li><a href="${selfserviceURL}/comment/list.html?crossApp=${crossApp}" role="menuitem">${commentLabel}s</a></li>
			</#if>
			</@security.authorize>
			
			<@security.authorize ifAllGranted="SS_AREA_BATCHES=r">
			<#if selfserviceURL != "">
				<li class="hidden-sm hidden-xs">
					<a href="${selfserviceURL}/batch/list.html?crossApp=${crossApp}" role="menuitem"> Batch </a>
				</li>
			</#if> 
			</@security.authorize> 
			
			
			<@security.authorize ifAllGranted="SS_AREA_CROSSWALK=r">
			<#if selfserviceURL != "">
				<li class="hidden-sm hidden-xs">
					<a href="${selfserviceURL}/crosswalk/list.html?crossApp=${crossApp}" role="menuitem">Program Mappings </a>
				</li> 
			</#if>
			</@security.authorize> 
			
			<#if selfserviceURL != "">
				<@security.authorize ifAllGranted="SS_AREA_EXCEPTION=r">
					<li class="hidden-xs hidden-sm">
						<a href="${selfserviceURL}/exception/list.html?crossApp=${crossApp}" role="menuitem">Exceptions</a>
					</li> 
				</@security.authorize>
				
				<@security.authorize ifAllGranted="SS_AREA_TRANSFEREVAL=r">
					<li class="hidden-xs hidden-sm">
						<a href="${selfserviceURL}/transfereval/list.html?crossApp=${crossApp}" role="menuitem">Transfer Evaluations</a>
					</li>
				</@security.authorize> 
				
				
				<@security.authorize ifAnyGranted="SS_AREA_DPROG=r,SS_AREA_STUDENT=r">
					<li class="dropdown hidden-xs hidden-sm"><a id="profile" href="#" class="dropdown-toggle" data-toggle="dropdown">Profile<b class="caret"></b></a>
						<ul class="dropdown-menu" id="profileDD">
							<@security.authorize ifAllGranted="SS_AREA_DPROG=r">
								<li>
									<a href="${selfserviceURL}/dprog/list.html?crossApp=${crossApp}">Programs</a>
								</li>
							</@security.authorize> 
							<@security.authorize ifAllGranted="SS_AREA_STUDENT=r">
								<li>
									<a href="${selfserviceURL}/student/list.html?crossApp=${crossApp}">Demographic</a>
								</li>
							</@security.authorize>
						</ul>
					</li> 
				</@security.authorize> 
			</#if>
			
			
			<li class="visible-xs"><a  href="<@spring.url relativeUrl="/j_spring_security_logout"/>"  role="menuitem"> <i class="fa fa-sign-out fa-lg"></i> Log Out </a></li>
		</ul>
	
		<ul class="nav navbar-nav navbar-right settings hidden-xs">
			<li class="dropdown" id="settings"><a href="#" id="settings" class="dropdown-toggle" data-toggle="dropdown" title="Settings"><span class="sr-only">Settings</span><i class="fa fa-cog fa-lg"></i> <b class="caret"></b></a>
				<ul class="dropdown-menu" id="settingsDD">
					<#if selfserviceURL != "">
							<@security.authorize ifAnyGranted="SS_MISC_PWCHANGE=r">
								<li><a href="${selfserviceURL}/general/changepassword.html?crossApp=${crossApp}" title="Change Password" alt="Change Password">Change Password</a></li>
							</@security.authorize>
						<#elseif udirectURL != "">
							<@security.authorize ifAnyGranted="UDIR_PasswordChange=u">
								<li><a href="${udirectURL}/prefs/change-password.html?crossApp=${crossApp}" title="Change Password" alt="Change Password">Change Password</a></li>
							</@security.authorize>
						</#if>
						<#if helpURL!=''>
					     	<li><a  href="${helpURL}" target='_blank' tabindex="-1">Help</a></li>
					   	<#else>
					   		<#assign helpUrl = "/general/helloworld.html#help" />
							<li><@h.link href='${helpUrl}' title='Help' target='_blank' /></li>
						</#if>	

					<li><a  href="<@spring.url relativeUrl="/j_spring_security_logout"/>"> <i class="fa fa-sign-out fa-lg"></i> Log Out </a></li>
				</ul>
			</li>
		</ul>
	
	</div>
</@security.authorize>

</nav>


