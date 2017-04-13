<#assign security=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>
<ul class="skiplist dontprint">
    		<li class="skip"><a href="#main" id="skpnav" role="link">Skip navigation links.</a></li>
    	</ul>

<header role="banner" class="hidden-print">
	<div id="header" class="hidden-xs hidden-sm">
		<div id="headerLogo" class=" first">
			<#-- if logo starts with "http", it's an absolute url, otherwise it is relative so it will get prefixed with the servlet context -->
			<#if selfServiceConfig.applicationLogo?starts_with("http")>
				<#assign applicationLogoUrl = selfServiceConfig.applicationLogo />
			<#else>
				<#assign applicationLogoUrl><@h.url href=selfServiceConfig.applicationLogo /></#assign>
			</#if>

				<img src="${applicationLogoUrl}" alt="Logo" title="Logo" />

		</div>
		<div id="headerInfo" class="pull-right">
			<@sec.isLoggedIn>
				<#if currentUser??>
					<span class="pull-right">
						${currentUser.name}
					</span>
					<br/>
				</#if>
				<@sec.isAdvisor>
					<#if currentInstitution??>
						<span class="pull-right">
							${currentInstitution.instcd.name}
						</span>
						<br/>
					<#else>
						<br/>
					</#if>
				</@sec.isAdvisor>
				<@sec.isNotAdvisor>
					<br/>
				</@sec.isNotAdvisor>
				<!--span class="textonlylink">Turn off Styles & Javascript</span-->
				<br/>
				<span class="pull-right">
					<#include "themebuttons.ftl" />
				</span>
				
			</@sec.isLoggedIn>
		</div>
	</div>
<@sec.isNotLoggedIn>
	<nav class="navbar navbar-default main-menu" >
		&nbsp;
	</nav>
</@sec.isNotLoggedIn>
<@sec.isLoggedIn>
	<nav class="navbar navbar-default main-menu" role="navigation">
		<div class="navbar-header" id="navbar-default">
			<@sec.isAdvisor>
				<#if currentStudent??>
					  <button type="button" role="button" class="navbar-toggle" data-toggle="collapse" data-target="#studentMenu">
						   <span class="sr-only">Toggle navigation</span>
						   <span>Student Menu</span>
					  </button>
				</#if>
				  <button type="button" role="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainmenu">
					   <span class="sr-only">Toggle navigation</span>
					   <span>Main Menu</span>
				  </button>
			  </@sec.isAdvisor>
			  
			  <#if encoding??>
				<@security.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r, SS_ENCODING_TA_RULE=r">	
			  	<button type="button" role="button" class="navbar-toggle" data-toggle="collapse" data-target="#encodingMenu">
				   <span class="sr-only">Toggle navigation</span>
				   <span>Encoding Menu</span>
			  	</button>
			  	</@security.authorize>
			  </#if>
			  
			  
			  
			  <@sec.isNotAdvisor>
		  		  <button type="button" role="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainmenu">
					   <span class="sr-only">Toggle navigation</span>
					   <span>Menu</span>
				  </button>
			  </@sec.isNotAdvisor>
				  
		</div>
	<@sec.isAdvisor>
		<#if currentInstitution??>

				<div class="collapse navbar-collapse main-menu" id="mainmenu">
			    	<ul class="nav navbar-nav" style="height: auto;">
			    		<li class="hidden-xs" id="home">
			    			<a  href="<@h.url href='/general/home.html' />" role="menuitem" title="Home">
			    				
			    				<i class="fa fa-home fa-lg"><span class="sr-only">Home</span></i>
		    				</a>
	    				</li>
	    				<li class="visible-xs home">
			    			<a  href="<@h.url href='/general/home.html' />"  role="menuitem">
			    				
			    				<i class="fa fa-home fa-lg"></i> Home
		    				</a>
	    				</li>
			    		
	    		<#assign showNotifications = "${NOTIFICATIONS_VISIBLE}" />
			
				<#if showNotifications == "T" >
			    		<@security.authorize ifAnyGranted="UDIR_Advisor=r, UDIR_Publisher=u, UDIR_Roadmaps=u, UDIR_Notes=r">
							<#if udirectRemoteLogin?? && udirectRemoteLogin !="">
							<li role="presentation">
								<a  href="${udirectRemoteLogin}/secure/udirect/notifications/notifications.html?crossApp=${crossApp}"  role="menuitem">Notifications</a>
							</li>
							</#if>
						</@security.authorize>
				</#if>
					
						
						
			    	<@sec.hasAppFn appFn=AppFuncRole.SS_MISC_STUDENTSEARCH>
			    		<li id="students" class="dropdown hidden-xs"><a id="studentsMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown" >Students
				             <b class="caret"></b></a>
				            <ul class="dropdown-menu"  aria-labelledby="studentsMenu" >
								<li role="presentation"><a  href="<@h.url href='/student/search.html' />" tabindex="-1">Search</a></li>
								<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_STUDENT perm="C">
									<li role="presentation"><a  href="<@h.url href='/student/create.html' />" tabindex="-1">Add</a></li>
								</@sec.hasAppFnPerm>
							</ul>
						</li>
						<li class="visible-xs studentsearch"><@h.link href='/student/search.html' title='Student Search'  role="menuitem"/></li>
						<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_STUDENT perm="C">
							<li class="visible-xs addstudent"><@h.link href='/student/create.html' title='Add Student'  role="menuitem"/></li>
						</@sec.hasAppFnPerm>
							
				    </@sec.hasAppFn>
				    
				    <#if udirectRemoteLogin?? && udirectRemoteLogin !="">
					<@security.authorize ifAnyGranted="UDIR_Roadmaps=r, UDIR_Publisher=u">
				    	<li class="dropdown hidden-xs">
				            <a id="roadmapMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown" >Roadmaps <b class="caret"></b></a>
					            <ul class="dropdown-menu"  aria-labelledby="roadmapMenu">
						            <li role="presentation"><a  href="${udirectRemoteLogin}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}" tabindex="-1">Manage </a></li>
									<li role="presentation"><a  href="${udirectRemoteLogin}/roadmap/manageall/display-roadmaps.html?crossApp=${crossApp}" tabindex="-1">View All </a></li>
					            </ul>
				          
			            </li>
			            <li class="visible-xs"><a href="${udirectRemoteLogin}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}"  role="menuitem">Manage Roadmaps</a></li>
						<li class="visible-xs"><a href="${udirectRemoteLogin}/roadmap/manageall/display-roadmaps.html?crossApp=${crossApp}"  role="menuitem">View All Roadmaps</a></li>
					            
					</@security.authorize>
					</#if>    
					
					<@security.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r, SS_ENCODING_TA_RULE=r">
					<li id="encoding" class=""><a href="<@s.url "/encoding/transfer/transferhome.html" />" role="menuitem">Encoding</a></li>
					</@security.authorize>

					<@sec.hasAppFn AppFuncRole.SS_AREA_BATCHES >
			            <li id="batch" class=""><a  href="<@s.url "/batch/list.html" />" role="menuitem">Batch</a>
						</li>
					</@sec.hasAppFn>
					
					
					<@security.authorize ifAnyGranted="SS_AREA_CROSSWALK=R,DASH_AUDIT_COMPARE=r">
		            <li id="tools" class="dropdown hidden-xs"><a href="#" id="tools" class="dropdown-toggle" data-toggle="dropdown">Tools <b class="caret"></b></a>
		                <ul class="dropdown-menu"  aria-labelledby="toolsMenu">
		                  
		                  <#if dashboardURL?? && dashboardURL !="" >
		        					     <@security.authorize ifAnyGranted="DASH_AUDIT_COMPARE=r">
		        			            <li><a  href="${dashboardURL}/auditviewer/home.html?crossApp=${crossApp}"  id="Audit Comparison" role="menuitem">Audit Comparison</a></li>
		                         
		  			               </@security.authorize>
							</#if>
							
							<@sec.hasAppFn AppFuncRole.SS_AREA_CROSSWALK>
		                    <li class=""><a  href="<@s.url "/crosswalk/list.html" />" role="menuitem">Program Mappings</a>
		                    </li>
		                  </@sec.hasAppFn>
	                  </ul>
	                  </li>
	                  </@security.authorize>
					
					<#if dashboardURL?? && dashboardURL !="" >
					     <@security.authorize ifAnyGranted="DASH_AUDIT_COMPARE=r">
			           		<li class="hidden-sm hidden-md hidden-lg"><a  href="${dashboardURL}/auditviewer/home.html?crossApp=${crossApp}"  id="Audit Comparison" role="menuitem">Audit Comparison</a></li>
			             </@security.authorize>
					</#if>

			    <@sec.hasAppFn AppFuncRole.SS_AREA_CROSSWALK>
						<li id="crosswalk" class="hidden-sm hidden-md hidden-lg"><a  href="<@s.url "/crosswalk/list.html" />" role="menuitem">Program Mappings</a>
						</li>
					</@sec.hasAppFn>
			        
			        <#if dashboardURL?? && dashboardURL !="" >
					         <@security.authorize ifAnyGranted="DASH_Reports=R">
      			            <li class="hidden-sm"><a  href="${dashboardURL}/reports/reports-console.html?crossApp=${crossApp}"  id="Reports" role="menuitem">Reports</a></li>
      			        </@security.authorize>


      			    	<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r,SEC_Advisees=r,SEC_Roles=r">
      			            <li class="dropdown hidden-sm hidden-xs">
      				           <a id="securityMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown" >Security <b class="caret"></b></a>
      					            <ul class="dropdown-menu"  aria-labelledby="securityMenu">
      						            <li role="presentation">
      						            	<a  href="${dashboardURL}/security-console.html?crossApp=${crossApp}" tabindex="-1">Console</a>
      					            	</li>
      					      <@security.authorize ifAnyGranted="SEC_Roles=r">
      									<li role="presentation">
      										<a  href="${dashboardURL}/roles.html?crossApp=${crossApp}" tabindex="-1">Roles</a>
      									</li>
      								</@security.authorize>
      						    <@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Users=r,SEC_Domains=r">
      										<li role="presentation">
      											<a  href="${dashboardURL}/users.html?crossApp=${crossApp}" tabindex="-1">Users</a>
      										</li>
      								</@security.authorize>

      								<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
      									<li role="presentation">
      										<a  href="${dashboardURL}/groups.html?crossApp=${crossApp}" tabindex="-1" >Groups</a>
      									</li>
      								</@security.authorize>

      								<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
      									<li role="presentation">
      										<a  href="${dashboardURL}/properties.html?crossApp=${crossApp}" tabindex="-1">Properties</a>
      									</li>
      								</@security.authorize>
      							</ul>
      						</li>
                  <!-- this section displays in the xs menu -->
                      <@security.authorize ifAnyGranted="SEC_Roles=r">
                        <li class="visible-xs hidden-sm hidden-md hidden-lg">
                          <a  href="${dashboardURL}/roles.html?crossApp=${crossApp}" tabindex="-1">Security Roles</a>
                        </li>
                      </@security.authorize>
                      <@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Users=r,SEC_Domains=r">
                          <li class="visible-xs hidden-sm hidden-md hidden-lg">
                            <a  href="${dashboardURL}/users.html?crossApp=${crossApp}" tabindex="-1">Security Users</a>
                          </li>
                      </@security.authorize>

                      <@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
                        <li class="visible-xs hidden-sm hidden-md hidden-lg">
                          <a  href="${dashboardURL}/groups.html?crossApp=${crossApp}" tabindex="-1" >Security Groups</a>
                        </li>
                      </@security.authorize>

                      <@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
                        <li class="visible-xs hidden-sm hidden-md hidden-lg">
                          <a  href="${dashboardURL}/properties.html?crossApp=${crossApp}" tabindex="-1">Security Properties</a>
                        </li>
                      </@security.authorize>
      						</@security.authorize>

                  <@security.authorize ifAnyGranted="SS_AREA_ADMIN=r, SB_ADMIN_EDIT=r, UDIR_Admin=r">
                     <li class="visible-xs hidden-sm hidden-md hidden-lg"><a  href="${dashboardURL}/admin/admin_menu.html?crossApp=${crossApp}" tabindex="-1">Admin</a></li>
                  </@security.authorize>
						</#if>
            <#if currentUser?? && currentUser.institutions.size gt 1>
              <li class="visible-xs hidden-sm hidden-md hidden-lg"><a  href="<@h.url href='/general/selectinstitution.html' />" tabindex="-1">Select Institution</a></li>
            </#if>
            <!-- this section displays in the sm menu -->
            <@security.authorize ifAnyGranted="SS_AREA_CROSSWALK=R,DASH_Reports=R,SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r,SEC_Advisees=r,SEC_Roles=r">
            <li class="dropdown hidden-xs visible-sm hidden-md hidden-lg" id="overflow">
                <a id="overflowMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"  title="More">
                  More...
                  <b class="caret"></b>
                </a>
                <ul class="dropdown-menu"  aria-labelledby="overflowMenu">
                 
                  <#if dashboardURL?? && dashboardURL !="" >
        					     <@security.authorize ifAnyGranted="DASH_Reports=R">
        			            <li><a  href="${dashboardURL}/reports/reports-console.html?crossApp=${crossApp}"  id="Reports" role="menuitem">Reports</a></li>
                          <li role="separator" class="divider"></li>
  			               </@security.authorize>

            			    	<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r,SEC_Advisees=r,SEC_Roles=r">
    					              <@security.authorize ifAnyGranted="SEC_Roles=r">
            									<li role="presentation">
            										<a  href="${dashboardURL}/roles.html?crossApp=${crossApp}" tabindex="-1">Security Roles</a>
            									</li>
            								</@security.authorize>
            						            <@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Users=r,SEC_Domains=r">
            										<li role="presentation">
            											<a  href="${dashboardURL}/users.html?crossApp=${crossApp}" tabindex="-1">Security Users</a>
            										</li>
            								</@security.authorize>

            								<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
            									<li role="presentation">
            										<a  href="${dashboardURL}/groups.html?crossApp=${crossApp}" tabindex="-1" >Security Groups</a>
            									</li>
            								</@security.authorize>

            								<@security.authorize ifAnyGranted="SEC_Domains=r,SEC_Group_Members=r,SEC_Groups=r">
            									<li role="presentation">
            										<a  href="${dashboardURL}/properties.html?crossApp=${crossApp}" tabindex="-1">Security Properties</a>
            									</li>
            								</@security.authorize>
          						</@security.authorize>
        						</#if>
                </ul>
            </li>
            </@security.authorize>


						<li class="visible-xs">
			    			<a href="<@h.url href='/general/logout.html' />"  role="menuitem">
			    				<i class="fa fa-sign-out fa-lg"></i> Log Out
		    				</a>
	    				</li>
				    	
		    	</ul>
	
			    	<ul class="nav navbar-nav navbar-right settings hidden-xs">
			    		<#if udirectRemoteLogin?? && udirectRemoteLogin !="">
			    		
			    		<#else>
			    			<#if dashboardURL?? && dashboardURL !="" >	
			    			<@security.authorize ifAllGranted="SS_AREA_COMMENTS=r">
								<li class="dropdown" id="notifications">
				        			<a id="notificationsMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"  title="Notifications">
				        				<i class="fa fa-bell fa-lg"><span class="sr-only">Notifications</span></i> 
				        				<b class="caret"></b>
			        				</a>
					        		<ul class="dropdown-menu"  aria-labelledby="notificationsMenu">
					    				<li role="presentation">
					    					<a  href="${dashboardURL}/comments_notifications.html?crossApp=${crossApp}" tabindex="-1">
					    						<@s.message 'uachieve.selfservice.comment.label'/>s
				    						</a>
			    						</li>
				    				</ul>
			    				</li>
		    				</@security.authorize>
		    				</#if>
						</#if>
				     	<li class="dropdown" id="settings">
				        	<a id="settingsMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"  title="Settings"><i class="fa fa-cog fa-lg"><span class="sr-only">Settings</span></i> <b class="caret"></b></a>
					        <ul class="dropdown-menu"  aria-labelledby="settingsMenu" >
						       <@security.authorize ifAnyGranted="SS_AREA_ADMIN=r, SB_ADMIN_EDIT=r, UDIR_Admin=r">
								<#if dashboardURL?? && dashboardURL !="" >
									<li role="presentation"><a  href="${dashboardURL}/admin/admin_menu.html?crossApp=${crossApp}" tabindex="-1">Admin</a></li>
								</#if>
								</@security.authorize>
								<@sec.hasAppFn AppFuncRole.SS_MISC_PWCHANGE>
									<li role="presentation"><a  href="<@h.url href='/general/changepassword.html' />" tabindex="-1">Change Password</a></li>
								</@sec.hasAppFn>
								<#if currentUser?? && currentUser.institutions.size gt 1>
									<li role="presentation"><a  href="<@h.url href='/general/selectinstitution.html' />" tabindex="-1">Select Institution</a></li>
								</#if>
								<#if selfServiceConfig.advisorHelpUrl!=''>
					     			<li role="presentation"><a  href="${selfServiceConfig.advisorHelpUrl}" target='_blank' tabindex="-1">Help <span class="sr-only">Link opens in a new tab or window</span></a></li>
					   			<#else>
					   				<#assign helpUrl = "/general/helloworld.html#help" />
								 	<li role="presentation"><@h.link href='${helpUrl}' title='Help ' target='_blank' span="<span class=\"sr-only\">Link opens in a new tab or window</span>" /></li>
							   </#if>
						        <li class="divider"></li>
						        <li role="presentation"><a  href="<@h.url href='/general/logout.html' />" tabindex="-1">
					    				<i class="fa fa-sign-out fa-lg"></i> Log Out
				    				</a>
								</li>
					        </ul>
				    	</li>
				    </ul>
				</div>
				<#if encoding??>
				<div class="collapse navbar-collapse encodingMenu" id="encodingMenu">
			    		<ul class="nav navbar-nav" style="height: auto;">
			    		<li class="selectedStudent">
							<p class="navbar-text">
								<span class="schoolInfo">
									School: ${currentInstitution.instidq}/${currentInstitution.instid}/${currentInstitution.instcd.code}
									<br>
								</span>
							</p>
							</li>
							<@security.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r, SS_ENCODING_TA_RULE=r">	
							<li class="active"><a href="<@s.url "/encoding/transfer/transferhome.html" />" role="menuitem">Transfer Articulation</a></li>
							</@security.authorize>
						</ul>

				</div>
				</#if>
				
				<#if currentStudent??>
					
					<div class="collapse navbar-collapse studentMenu" id="studentMenu">
			    		<ul class="nav navbar-nav" style="height: auto;">
			    		<li class="selectedStudent">
							<p class="navbar-text">
								<span class="studentName">
							 		<@s.message 'uachieve.selfservice.student.display.studentIntro'/>
									<#if displayStudentName()>
										${currentStudent.name}
									</#if>
									<#if studentConfig.displayStudentNumber && currentStudent??>
										<#if displayStudentName()>/</#if>
										${currentStudent.stuMaster.stuno}
									</#if>
									<br/>
								</span>
							</p>
							</li>
							<@sec.hasAppFn AppFuncRole.SS_AREA_AUDIT>
								<li id="audits"  class="dropdown hidden-xs">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown">Audits <b class="caret"></b></a>
									<ul class="dropdown-menu"  id="auditsDD">
										<@sec.hasAppFnPerm AppFuncRole.SS_AREA_AUDIT 'C'>
											<li><@h.link href='/audit/create.html' title='Request New' /></li>
										</@sec.hasAppFnPerm>
										<@sec.hasAppFn AppFuncRole.SS_AREA_AUDIT>
											<li><@h.link href='/audit/list.html' title='Manage' /></li>
										</@sec.hasAppFn>
										<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
											<li><a href="<@s.url "/programmatcher/viewSearchResults.html" />" >Program Matcher</a>
											</li>
										</@security.authorize>
									</ul>
								</li>
								<@sec.hasAppFnPerm AppFuncRole.SS_AREA_AUDIT 'C'>
									<li class="visible-xs requestAudit"><@h.link href='/audit/create.html' title='Request New Audit'  role="menuitem"/></li>
								</@sec.hasAppFnPerm>
								<@sec.hasAppFn AppFuncRole.SS_AREA_AUDIT>
									<li class="visible-xs manageAudits"><@h.link href='/audit/list.html' title='Manage Audits'  role="menuitem"/></li>
								</@sec.hasAppFn>
								<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
									<li class="visible-xs programMatcher"><a href="<@s.url "/programmatcher/viewSearchResults.html" />" role="menuitem" >Program Matcher</a>
									</li>
								</@security.authorize>
							</@sec.hasAppFn>
							<@security.authorize ifAnyGranted="UDIR_Plans=r">
								<#if udirectRemoteLogin?? && udirectRemoteLogin !="">
									<li><a href="${udirectRemoteLogin}/plan/manage/display-plans.html?crossApp=${crossApp}" role="menuitem">
										<@s.message 'udirect.plans.header'/>s</a>
									</li>
								</#if>
							</@security.authorize>
							
							<#if scheduleURL?? && scheduleURL != "" && allowSchedule>
								<@security.authorize ifAnyGranted="SB_USER=r">
									<li class="dropdown hidden-xs">
										<a href="#" id="schedule" class="dropdown-toggle" data-toggle="dropdown">Schedules <b class="caret"></b></a>
										<ul class="dropdown-menu"  id="scheduleDD">
											<li><a href="${scheduleURL}/sec/home_id?crossApp=${crossApp}" >Schedule Home</a></li>
											<li><a href="${scheduleURL}/sec/sched_show?crossApp=${crossApp}" >My Current Schedule</a></li>
											<li><a href="${scheduleURL}/sec/search?crossApp=${crossApp}" >Find Courses</a></li>
											<@security.authorize ifAnyGranted="SB_AUTOGENERATESCHEDULE=r">
												<li><a href="${scheduleURL}/sec/preferences?crossApp=${crossApp}">Preferences</a></li>
											</@security.authorize> 
					
										</ul>
									</li>
									
											<li class="visible-xs"><a href="${scheduleURL}/sec/sched_show?crossApp=${crossApp}"  role="menuitem">My Current Schedule</a></li>
								</@security.authorize>
							</#if>
							
							<@security.authorize ifAnyGranted="SS_AREA_COURSE=r,SS_AREA_TRANSFERCOURSE=r,SS_AREA_PLANNEDCOURSE=r">
								<li id="courses" class="dropdown hidden-xs">
									<a href="#"  class="dropdown-toggle" data-toggle="dropdown">Courses <b class="caret"></b></a>
									<ul class="dropdown-menu" id="coursesDD">
										<@sec.hasAppFn AppFuncRole.SS_AREA_COURSE>
											<li><@h.link href='/course/list.html' title='Home' /></li>
										</@sec.hasAppFn>
										<@sec.hasAppFn AppFuncRole.SS_AREA_TRANSFERCOURSE>
											<li><@h.link href='/transfercourse/list.html' title='Transfer' /></li>
										</@sec.hasAppFn>
										<@sec.hasAppFn AppFuncRole.SS_AREA_PLANNEDCOURSE>
											<li><@h.link href='/plannedcourse/list.html' title='Planned' /></li>
										</@sec.hasAppFn>
									</ul>
								</li>
								<@sec.hasAppFn AppFuncRole.SS_AREA_COURSE>
									<li class="visible-xs homeCourses"><@h.link href='/course/list.html' title='Home Courses'  role="menuitem"/></li>
								</@sec.hasAppFn>
								<@sec.hasAppFn AppFuncRole.SS_AREA_TRANSFERCOURSE>
									<li class="visible-xs transferCourses"><@h.link href='/transfercourse/list.html' title='Transfer Courses'  role="menuitem"/></li>
								</@sec.hasAppFn>
								<@sec.hasAppFn AppFuncRole.SS_AREA_PLANNEDCOURSE>
									<li class="visible-xs plannedCourses"><@h.link href='/plannedcourse/list.html' title='Planned Courses'  role="menuitem"/></li>
								</@sec.hasAppFn>

							</@security.authorize>
							<@sec.hasAppFn AppFuncRole.SS_AREA_COMMENTS>
								<#assign commentLabel><@s.message 'uachieve.selfservice.comment.label'/>s</#assign>
								<li id="comments"><@h.link href='/comment/list.html' title="${commentLabel}"  role="menuitem"/></li>
							</@sec.hasAppFn>
							<@sec.hasAppFn AppFuncRole.SS_AREA_TRANSFEREVAL>
								<li id="transferEvals" class="hidden-sm hidden-xs"><@h.link href='/transfereval/list.html' title='Transfer Evaluations'  role="menuitem"/></li>
							</@sec.hasAppFn>
							<@sec.hasAppFn AppFuncRole.SS_AREA_EXCEPTION>
							
							<li id="exception" class="hidden-sm hidden-xs"><a href="<@s.url "/exception/list.html" />"  role="menuitem">Exceptions</a>
							</li>
							</@sec.hasAppFn>
							<@security.authorize ifAnyGranted="SS_AREA_DPROG=r,SS_AREA_STUDENT=r">
							<li id="profile" class="dropdown hidden-xs">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">Profile <b class="caret"></b></a>
								<ul class="dropdown-menu"  id="profileDD">
									<@sec.hasAppFn AppFuncRole.SS_AREA_DPROG>
										<li><@h.link href='/dprog/list.html' title='Programs' /><li>
									</@sec.hasAppFn>
									<@sec.hasAppFn AppFuncRole.SS_AREA_STUDENT>
										<li><@h.link href='/student/list.html' title='Demographic' /><li>
									</@sec.hasAppFn>
								</ul>
							</li>
							</@security.authorize>
							
						</ul>

					</div>
				</#if>
				<#else>
			    	<ul class="nav navbar-nav navbar-right ">
				     	<li class="dropdown hidden-xs" id="settings">
				        	<a href="#" id="settings" class="dropdown-toggle" data-toggle="dropdown" title="Settings"><span class="sr-only">Settings</span><i class="fa fa-cog fa-lg"></i> <b class="caret"></b></a>
					        <ul class="dropdown-menu" id="settingsDD" >
						        <@security.authorize ifAnyGranted="SB_ADMIN_EDIT=r, SS_AREA_ADMIN=r">
								<#if dashboardURL?? && dashboardURL !="" >
									<li><a href="${dashboardURL}/admin/admin_menu.html?crossApp=${crossApp}" >Admin</a></li>
								</#if>
								</@security.authorize>
								<@sec.hasAppFn AppFuncRole.SS_MISC_PWCHANGE>
									<li><@h.link href='/general/changepassword.html' title='Change Password' /><li>
								</@sec.hasAppFn>
								<#if currentUser?? && currentUser.institutions.size gt 1>
									<li><@h.link href='/general/selectinstitution.html' title='Select Institution' /><li>
								</#if>
								<#if selfServiceConfig.advisorHelpUrl!=''>
					     			<li><a href="${selfServiceConfig.advisorHelpUrl}"  target='_blank' >Help <span class="sr-only">Link opens in a new tab or window</span></a></li>
					   			<#else>
					   				<#assign helpUrl = "/general/helloworld.html#help" />
								 	<li><@h.link href='${helpUrl}' title='Help' target='_blank' span="<span class=\"sr-only\">Link opens in a new tab or window</span>" /></li>
							   </#if>
						        <li class="divider"></li>
						        <li>
									<a href="<@h.url href='/general/logout.html' />">
					    				<i class="fa fa-sign-out fa-lg"></i> Log Out
				    				</a>
								</li>
					        </ul>
				    	</li>
				    	
				    	<li class="visible-xs">
			    			<a href="<@h.url href='/general/logout.html' />" role="menuitem">
			    				<i class="fa fa-sign-out fa-lg"></i> Log Out
		    				</a>
	    				</li>
				    </ul>
				</#if>
				</nav>
				</@sec.isAdvisor>
				
				
				
				
				
				
				
				
				
				
				
				
				<@sec.isStudent>
					<@sec.isNotAdvisor>
						<div class="collapse navbar-collapse main-menu" id="mainmenu">
			    			<ul class="nav navbar-nav" style="height: auto;">
								<@sec.hasAppFn AppFuncRole.SS_AREA_AUDIT>
									<li id="audits" class="dropdown hidden-xs">
										<a href="#" class="dropdown-toggle" data-toggle="dropdown">Audits <b class="caret"></b></a>
										<ul class="dropdown-menu" id="auditsDD">
											<@sec.hasAppFnPerm AppFuncRole.SS_AREA_AUDIT 'C'>
												<li><@h.link href='/audit/create.html' title='Request New' /></li>
											</@sec.hasAppFnPerm>
											<@sec.hasAppFn AppFuncRole.SS_AREA_AUDIT>
												<li><@h.link href='/audit/list.html' title='Manage' /></li>
											</@sec.hasAppFn>
											<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
												<li id="programMatcher"><a href="<@s.url "/programmatcher/viewSearchResults.html" />" >Program Matcher</a>
												</li>
											</@security.authorize>
										</ul>
									</li>
									<@sec.hasAppFnPerm AppFuncRole.SS_AREA_AUDIT 'C'>
										<li class="visible-xs requestAudit"><@h.link href='/audit/create.html' title='Request New Audit'  role="menuitem"/></li>
									</@sec.hasAppFnPerm>
									<@sec.hasAppFn AppFuncRole.SS_AREA_AUDIT>
										<li class="visible-xs manageAudits"><@h.link href='/audit/list.html' title='Manage Audits'  role="menuitem"/></li>
									</@sec.hasAppFn>
									<@security.authorize ifAnyGranted="SS_AREA_PROGRAMMATCHER=c">
										<li class="visible-xs programMatcher" id="programMatcher"><a href="<@s.url "/programmatcher/viewSearchResults.html" />"  role="menuitem">Program Matcher</a>
										</li>
									</@security.authorize>
								</@sec.hasAppFn>
								
								<#if udirectRemoteLogin?? && udirectRemoteLogin !="">
									<@security.authorize ifAnyGranted="UDIR_Plans=r">
										<li><a href="${udirectRemoteLogin}/plan/manage/display-plans.html?crossApp=${crossApp}" role="menuitem">
											<@s.message 'udirect.plans.header'/>s</a>
										</li>
									</@security.authorize>
								</#if>
								
								<#if scheduleURL?? && scheduleURL != "">
								<@security.authorize ifAnyGranted="SB_USER=r">
									<li class="dropdown hidden-xs">
										<a href="#" id="schedule" class="dropdown-toggle" data-toggle="dropdown">Schedules <b class="caret"></b></a>
										<ul class="dropdown-menu"  id="scheduleDD">
											<li><a href="${scheduleURL}/sec/home_id?crossApp=${crossApp}" >Schedule Home</a></li>
											<li><a href="${scheduleURL}/sec/sched_show?crossApp=${crossApp}" >My Current Schedule</a></li>
											<li><a href="${scheduleURL}/sec/search?crossApp=${crossApp}" >Find Courses</a></li>
											<@security.authorize ifAnyGranted="SB_AUTOGENERATESCHEDULE=r">
												<li><a href="${scheduleURL}/sec/preferences?crossApp=${crossApp}">Preferences</a></li>
											</@security.authorize>
										</ul>
									</li>
									<li class="visible-xs"><a href="${scheduleURL}/sec/sched_show?crossApp=${crossApp}" role="menuitem">My Current Schedule</a></li>
								</@security.authorize>
								</#if>
									
									
								<#if udirectRemoteLogin?? && udirectRemoteLogin !="">
									<@security.authorize ifAnyGranted="UDIR_Roadmaps=r">
										<li class="dropdown hidden-xs">
											<a href="#" id="roadmaps" class="dropdown-toggle" data-toggle="dropdown">Roadmaps <b class="caret"></b></a>
											<ul class="dropdown-menu"  id="roadmapsDD">
												<li><a href="${udirectRemoteLogin}/roadmap/manage/display-roadmaps.html?crossApp=${crossApp}" >Manage </a></li>
												<li><a href="${udirectRemoteLogin}/roadmap/manageall/display-roadmaps.html?crossApp=${crossApp}" >View All </a></li>
											</ul>
										</li>
									</@security.authorize>
								</#if>
								<@security.authorize ifAnyGranted="SS_AREA_COURSE=r,SS_AREA_TRANSFERCOURSE=r,SS_AREA_PLANNEDCOURSE=r">
									<li id="courses" class="dropdown hidden-xs">
										<a class="dropdown-toggle" data-toggle="dropdown" href="#" >Courses <b class="caret"></b></a>
										<ul class="dropdown-menu" id="coursesDD">
											<@sec.hasAppFn AppFuncRole.SS_AREA_COURSE>
												<li><@h.link href='/course/list.html' title='Home' /><li>
											</@sec.hasAppFn>
											<@sec.hasAppFn AppFuncRole.SS_AREA_TRANSFERCOURSE>
												<li><@h.link href='/transfercourse/list.html' title='Transfer' /></li>
											</@sec.hasAppFn>
											<@sec.hasAppFn AppFuncRole.SS_AREA_PLANNEDCOURSE>
												<li><@h.link href='/plannedcourse/list.html' title='Planned' /></li>
											</@sec.hasAppFn>
										</ul>
									</li>
									<@sec.hasAppFn AppFuncRole.SS_AREA_COURSE>
										<li class="visible-xs homeCourses"><@h.link href='/course/list.html' title='Home Courses'  role="menuitem"/></li>
									</@sec.hasAppFn>
									<@sec.hasAppFn AppFuncRole.SS_AREA_TRANSFERCOURSE>
										<li class="visible-xs transferCourses"><@h.link href='/transfercourse/list.html' title='Transfer Courses'  role="menuitem"/></li>
									</@sec.hasAppFn>
									<@sec.hasAppFn AppFuncRole.SS_AREA_PLANNEDCOURSE>
										<li class="visible-xs plannedCourses"><@h.link href='/plannedcourse/list.html' title='Planned Courses'  role="menuitem"/></li>
									</@sec.hasAppFn>
								</@security.authorize>
								<@sec.hasAppFn AppFuncRole.SS_AREA_COMMENTS>
									<#assign commentLabel><@s.message 'uachieve.selfservice.comment.label'/>s</#assign>
									<li id="comments"><@h.link href='/comment/list.html' title="${commentLabel}"  role="menuitem"/></li>
								</@sec.hasAppFn>
								<@sec.hasAppFn AppFuncRole.SS_AREA_BATCHES >
								<li id="batch" class="hidden-sm hidden-xs"><a href="<@s.url "/batch/list.html" />" role="menuitem">Batch</a>
								</li>
								</@sec.hasAppFn>
								<@sec.hasAppFn AppFuncRole.SS_AREA_CROSSWALK>
								<li id="crosswalk" class="hidden-sm hidden-xs"><a href="<@s.url "/crosswalk/list.html" />" role="menuitem">Program Mappings</a>
								</li> 
								</@sec.hasAppFn>
								<@sec.hasAppFn AppFuncRole.SS_AREA_EXCEPTION>
									<li id="exception" class="hidden-xs hidden-sm"><@h.link href='/exception/list.html' title='Exceptions'  role="menuitem"/></li>
								</@sec.hasAppFn>
								<@sec.hasAppFn AppFuncRole.SS_AREA_TRANSFEREVAL>
									<li id="transferEvals" class="hidden-xs hidden-sm"><@h.link href='/transfereval/list.html' title='Transfer Evaluations'  role="menuitem"/></li>
								</@sec.hasAppFn>
								<@security.authorize ifAnyGranted="SS_AREA_DPROG=r,SS_AREA_STUDENT=r">
								
								
								<li id="profile" class="dropdown hidden-xs hidden-sm">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown">Profile <b class="caret"></b></a>
									<ul class="dropdown-menu"  id="profileDD">
										<@sec.hasAppFn AppFuncRole.SS_AREA_DPROG>
												<li><@h.link href='/dprog/list.html' title='Programs' /></li>
											</@sec.hasAppFn>
											<@sec.hasAppFn AppFuncRole.SS_AREA_STUDENT>
												<li><@h.link href='/student/list.html' title='Demographic' /></li>
											</@sec.hasAppFn>
									</ul>
								</li>
								</@security.authorize>
								
								<li class="visible-xs">
					    			<a href="<@h.url href='/general/logout.html' />" role="menuitem">
					    				<i class="fa fa-sign-out fa-lg"></i> Log Out
				    				</a>
			    				</li>
							</ul>
									
					    	<ul class="nav navbar-nav navbar-right settings hidden-xs">
						     	<li class="dropdown" id="settings">
						        	<a href="#" id="settings" class="dropdown-toggle" data-toggle="dropdown" title="Settings"><span class="sr-only">Settings</span><i class="fa fa-cog fa-lg"></i> <b class="caret"></b></a>
									<ul class="dropdown-menu"  id="settingsDD">
										<@sec.hasAppFn AppFuncRole.SS_MISC_PWCHANGE>
											<li><@h.link href='/general/changepassword.html' title='Change Password' /></li>
										</@sec.hasAppFn>
										<#if selfServiceConfig.studentHelpUrl!=''>
	                         				<li><a href="${selfServiceConfig.studentHelpUrl}" target="_blank" alt="Help">Help <span class="sr-only">Link opens in a new tab or window</span></a></li>
	                      				<#else>
	                      					<#assign helpUrl = "/general/helloworld.html#help" />
							 				<li><@h.link href='${helpUrl}' title='Help' target='_blank' span="<span class=\"sr-only\">Link opens in a new tab or window</span>" /></li>
	                       				</#if>
										<li>
											<a href="<@h.url href='/general/logout.html' />">
						    					<i class="fa fa-sign-out fa-lg"></i> Log Out
					    					</a>
				    					</li>
									</ul>
								</li>
							</ul>
							
						</div>
					</@sec.isNotAdvisor>
				</@sec.isStudent>
				
				
			
		</header>
</@sec.isLoggedIn>
	

<#-- returns true if the student's name should be displayed -->
<#function displayStudentName>
	<#return studentConfig.displayStudentName && currentStudent?? && currentStudent.name?? />
</#function>
