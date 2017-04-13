<#assign security=JspTaglibs["/WEB-INF/tld/security.tld"]>
<@layout.head "Installation Verification">

	<style type="text/css">
		#more, #more a { font-size: 123.1%; }
		#more a { text-decoration: underline; }
		.section { margin-left: 4em; margin-right: 4em; margin-bottom: 4em; }	
	</style>
	
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
	</div>
	
</header>
	
</@layout.head>

<@layout.body hideMenu=true>
	
		<h1 id="top">u.achieve Self-Service Installation Verification</h1>
		<div class="alert alert-warning">
		<p>This page is a tool to help verify your u.achieve Self-Service installation.</p>
		<p >More documentation is available from the <a href="http://clients.collegesource.com/home" target="_blank">CollegeSource Support Center</a>.</p>
		</div>
	
	<div class="row">
	
	<div class="col-md-3 col-lg-3 hidden-xs hidden-sm">
	
		<div class="well affix" id="sidenav">
		<h2>Options</h2>
			<ul id="admin-sidebar" class="nav nav-pills nav-stacked">
				<li><a href="<@s.url relativeUrl="/general/helloworld.html#config" />">Configuration Verification</a></li>
				<li><a href="<@s.url relativeUrl="/general/helloworld.html#dbconnect" />">Database Connection</a></li>
				<li><a href="<@s.url relativeUrl="/general/helloworld.html#security" />">Security</a></li>
				<li><a href="<@s.url relativeUrl="/general/helloworld.html#help" />">Help Configuration</a></li>
				<li><a href="<@s.url relativeUrl="/general/helloworld.html#corda" />">Corda Chart Configuration</a></li>
				<li><a href="<@s.url relativeUrl="/general/helloworld.html#styles" />">Styles</a></li>
				<br>
				<li><a href="<@s.url relativeUrl="/general/helloworld.html#top" />"> <i class="fa fa-caret-up"></i> Back to top</a></li>
			</ul>		
		</div> <!-- /well -->
	
	</div> <!-- /col-md-3 -->
	
	<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
	
	
	<h2 id="config">Configuration Verification</h2>
	<div class="section">
		<p>The following properties were read from your configuration file and are displayed here for verification.</p>
		<div class="cleared tableContainer">
		<table class="table table-striped table-bordered table-hover cleared">
			<thead>
				<tr>
					<th>instidq</th>
					<th>instid</th>
					<th>application name</th>
					<th>show charts</th>
					<th>debug on</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${selfServiceConfig.instidq}</td>
					<td>${selfServiceConfig.instid}</td>
					<td>${selfServiceConfig.applicationName}</td>
					<td>${auditConfig.showCharts?string}</td>
					<td <#if selfServiceConfig.debug> style="background-color:#f2dede;color:#b94a48;" </#if>>${selfServiceConfig.debug?string}</td>
				</tr>
			</tbody>
		</table>
		</div>
		<#if selfServiceConfig.debug>
			<p class="alert alert-danger" role="alert" tabindex="0">
				Leaving debug on in production may negatively affect performance - turn debugging on only in a development or testing environment.
			</p>
		</#if>
	</div>
	
	<hr />
	<h2 id="dbconnect">Database Connection</h2>
	<div class="section">
		<p>A database query was run to check for database connectivity.</p>
		<p>Query: <strong>${query}</strong></p>
		<p>Result: <strong>${queryResult}</strong></p>
	</div>
	
	<hr />
	<h2 id="security">Security</h2>
	<div class="section">
		<p>The following security permissions are those held by the current user (you).</p>
		<table class="verticalListing">
			<tbody>
				<tr>
					<th>User Object</th>
					<td><#if user??>${user.name!'No username defined'}<#else>No current user defined</#if></td>
				</tr>
				<tr>
					<th>Logged In</th>
					<td>
						<@sec.isLoggedIn><i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this security permission</span></i></@sec.isLoggedIn>
						<@sec.isNotLoggedIn><i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this security permission</span></i></@sec.isNotLoggedIn>
					</td>
				</tr>
				<tr>
					<th>Is Advisor</th>
					<td>
						<@sec.isAdvisor><i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this security permission</span></i></@sec.isAdvisor>
						<@sec.isNotAdvisor><i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this security permission</span></i></i></@sec.isNotAdvisor>
					</td>
				</tr>
				
				<tr>
					<th>Is Student</th>
					<td>
						<@sec.isStudent><i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this security permission</span></i></@sec.isStudent>
						<@sec.isNotStudent><i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this security permission</span></i></i></@sec.isNotStudent>
					</td>
				</tr>

				<tr>
					<th colspan="2" style="background-color: #fff; color: #000; padding-top: 30px;">
						<h3>Application Functions</h3>
					</th>
				</tr>
				
				<#list AppFunRoleValues.values() as ss>
					<#assign v = ss?string>
					<tr>
						<th>${v}</th>
						<td>
							<@security.authorize ifAllGranted=v>
								<i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this application function</span></i>
							</@security.authorize>
							<@security.authorize ifNotGranted=v>
								<i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this application function</span></i></i>
							</@security.authorize>
							
						</td>
					</tr>
				</#list>
			</tbody>
		</table>
	</div>
	
	<hr />
	<h2 id="help">Help Configuration</h2>
	<div class="section">
		<p>Configure the help URL for students and advisors within Self-Service at the following locations.</p>
		<div class="table-responsive">
		<table class="table table-striped table-bordered">
			<tbody>
				<tr>
					<th> Type </th>
					<th> Property </th>
					<th> File </th>
				</tr>
				<tr>
					<td> Student Help </td>
					<td> <code>uachieve.selfservice.studentHelpUrl= </code> </td>
					<td> selfservice-general.properties </td>
				</tr>
				<tr>
					<td> Advisor Help </td>
					<td> <code>uachieve.selfservice.advisorHelpUrl= </code> </td>
					<td> selfservice-general.properties </td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
		
	<hr />
	<h2 id="corda">Chart Configuration</h2>
	<div class="section">
		<p>These are what the charts will look like on the audit.</p>
		<h3>Chart 1</h3>
		<div id="academicProgressGraphHtml" style="width: 480-px; height: 183px; margin: 10px 5px 10px 5px;">
			<div class="row">
				<div id="academicProgressGraphHtmlHours" class="col-md-6" style="height: 146px; margin: 20px 0px 0px 27px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
				<div id="academicProgressGraphHtmlGPA" class="col-md-4" style="height: 146px; margin: 20px 0px 0px 0px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-5 aligncenter" style="height: 17px; margin: 0px 0px 0px 27px;">
					<span id="academicProgressGraphHtmlHoursLabel" class="graphLabelLabel">&nbsp;${graphConfig.hoursLabel}&nbsp;</span>
				</div>
				<div class="col-md-5 aligncenter" style="height: 17px; margin: 0px 0px 0px 0px;">
					<span id="academicProgressGraphHtmlGPALabel" class="graphLabelLabel">&nbsp;${graphConfig.gpaLabel}&nbsp;</span>
				</div>
			</div>
			<script type='text/javascript'>
			
				$j(document).ready(function() {
					loadAcademicProgressGraph(true, { complete: "<@s.message 'uachieve.selfservice.status.complete' />", inProgress: "<@s.message 'uachieve.selfservice.status.inprogress' />", unfulfilled: "<@s.message 'uachieve.selfservice.status.unfulfilled' />", planned: "<@s.message 'uachieve.selfservice.status.planned' />", hours: "${graphConfig.hoursLabel}", gpa: "${graphConfig.gpaLabel}" });			
				});
			</script>
		</div>
	
		<h3>Chart 2</h3>
		<div id="gpaDetailGraphHtml" style="width: 297px; height: 183px; margin: 10px 5px 10px 5px;">
			<div class="row">
				<div class="col-md-1"></div>
				<div id="gpaDetailGraphHtmlPie" class="col-md-6" style="height: 146px; margin: 20px 0px 0px 27px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
				<div id="gpaDetailGraphHtmlBar" class="col-md-2" style="height: 146px; margin: 20px 0px 0px 0px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
			</div>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-6 aligncenter" style="height: 17px; margin: 0px 0px 0px 27px;">
					<span id="gpaDetailGraphHtmlPieLabel" class="graphLabelLabel">&nbsp;${graphConfig.hoursLabel}&nbsp;</span>
				</div>
				<div class="col-md-2 aligncenter" style="height: 17px; margin: 0px 0px 0px 0px;">
					<span id="gpaDetailGraphHtmlBarLabel" class="graphLabelLabel">&nbsp;${graphConfig.gpaLabel}&nbsp;</span>
				</div>
			</div>
			<script type='text/javascript'>
			
				$j(document).ready(function() {
					loadGpaDetailGraph(true, { complete: "<@s.message 'uachieve.selfservice.status.complete' />", inProgress: "<@s.message 'uachieve.selfservice.status.inprogress' />", unfulfilled: "<@s.message 'uachieve.selfservice.status.unfulfilled' />", planned: "<@s.message 'uachieve.selfservice.status.planned' />", hours: "${graphConfig.hoursLabel}", gpa: "${graphConfig.gpaLabel}" });			
				});
			</script>
		</div>
	    
		<h3>Chart 3</h3>
		<div style="width: 480px;">
			<div id="transcriptGraphHtml" style="height: 150px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
		</div>
		<script type='text/javascript'>
		
			$j(document).ready(function() {
				loadTranscriptGraph("", { complete: "<@s.message 'uachieve.selfservice.status.complete' />", inProgress: "<@s.message 'uachieve.selfservice.status.inprogress' />", unfulfilled: "<@s.message 'uachieve.selfservice.status.unfulfilled' />", planned: "<@s.message 'uachieve.selfservice.status.planned' />", hours: "${graphConfig.hoursLabel}", gpa: "${graphConfig.gpaLabel}" });
			});
		</script>
	</div>
	
	<hr />
	<h2 id="styles">Styles</h2>
				<#include "/layout/themebuttons.ftl" />
		<div class="section">
			<h3 class="hidden-sm hidden-xs">Menus</h3>
			<p class="hidden-sm hidden-xs"><br><span class="alert alert-danger" role="alert" tabindex="0">The menu section will be hidden on small/extra small screens</span><br><br></p>
			<div class="hidden-sm hidden-xs">
				<nav class="navbar navbar-default main-menu" role="navigation">
				<div class="navbar-header" id="navbar-default">
							  <button type="button" role="button" class="navbar-toggle" data-toggle="collapse" data-target="#studentMenu">
								   <span class="sr-only">Toggle navigation</span>
								   <span>Student Menu</span>
							  </button>
						  <button type="button" role="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainmenu">
							   <span class="sr-only">Toggle navigation</span>
							   <span>Main Menu</span>
						  </button>
						  
				</div>

				<div class="collapse navbar-collapse main-menu" id="mainmenu">
			    	<ul class="nav navbar-nav" style="height: auto;">
			    		<li class="hidden-xs" id="home">
			    			<a href="#" role="menuitem" title="Home">
			    				<i class="fa fa-home fa-lg"></i>
		    				</a>
	    				</li>
			    		
							<li role="presentation">
								<a href="#" role="menuitem">Link</a>
							</li>
			    		<li id="dropdown" class="dropdown hidden-xs"><a id="dd1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown
				             <b class="caret"></b></a>
				            <ul class="dropdown-menu" aria-labelledby="dd1" role="menu">
								<li role="presentation"><a href="#" tabindex="-1" role="menuitem">Submenu Item 1</a></li>
								<li role="presentation"><a href="#" tabindex="-1" role="menuitem">Submenu Item 2</a></li>
							</ul>
						</li>
						
				    	
		    	</ul>
	
			    	<ul class="nav navbar-nav navbar-right settings hidden-xs">
				     	<li class="dropdown" id="settings">
				        	<a id="settingsMenu" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown" title="Settings" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog fa-lg"><span class="sr-only">Settings</span></i> <b class="caret"></b></a>
					        <ul class="dropdown-menu" aria-labelledby="settingsMenu" role="menu">
									<li role="presentation"><a href="#" tabindex="-1" role="menuitem">Submenu Item 1</a></li>
								<li role="presentation"><a href="#" tabindex="-1" role="menuitem">Submenu Item 2</a></li>
						        <li class="divider" role="presentation"></li>
						        <li role="presentation"><a href="#" tabindex="-1" role="menuitem">
					    				<i class="fa fa-sign-out fa-lg"></i> Log Out
				    				</a>
								</li>
					        </ul>
				    	</li>
				    </ul>
				</div>
				
					<div class="collapse navbar-collapse studentMenu" id="studentMenu">
			    		<ul class="nav navbar-nav" style="height: auto;">
			    		<li class="selectedStudent">
							<p class="navbar-text">
								<span class="studentName">
								Student:		Sally Student
										/
										123456789
									<br>
								</span>
							</p>
							</li>
								<li role="presentation">
								<a href="#" role="menuitem">Link</a>
							</li>
			    		<li id="dropdown" class="dropdown hidden-xs"><a id="dd1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown
				             <b class="caret"></b></a>
				            <ul class="dropdown-menu" aria-labelledby="dd1" role="menu">
								<li role="presentation"><a href="#" tabindex="-1" role="menuitem">Submenu Item 1</a></li>
								<li role="presentation"><a href="#" tabindex="-1" role="menuitem">Submenu Item 2</a></li>
							</ul>
						</li>
						</ul>
					</div>
				</nav>
				<div>
					
						<span style="font-weight: bold;">Main Menu class:</span> .main-menu <br>
						<span style="font-weight: bold;">Selected Student Menu class:</span> .studentMenu
				</div>
				
			</div>
			
			<h3>Buttons</h3>
			<p class="alert alert-info"> <i class="fa fa-info-circle"></i> Tip: Don't forget to check :hover styles</p>
						  
			  <h4>Default Button - .btn-default</h4>
			  <div class="bs-example">
			   	<button type="button" class="btn btn-default">Normal</button>
			   	<button type="button" class="btn btn-default active">Active</button>
			   	<button type="button" class="btn btn-default" disabled="disabled">Disabled</button>
		   	  </div>
		   	  
		   	  <h4>Primary Button - .btn-primary</h4>
			  <div class="bs-example">
			   	<button type="button" class="btn btn-primary">Normal</button>
			   	<button type="button" class="btn btn-primary active">Active</button>
			   	<button type="button" class="btn btn-primary" disabled="disabled">Disabled</button>
		   	  </div>
		   	  
		   	  <h4>Success Button - .btn-success</h4>
			  <div class="bs-example">
			   	<button type="button" class="btn btn-success">Normal</button>
			   	<button type="button" class="btn btn-success active">Active</button>
			   	<button type="button" class="btn btn-success" disabled="disabled">Disabled</button>
		   	  </div>
		   	  
		   	  <h4>Info Button - .btn-info</h4>
			  <div class="bs-example">
			   	<button type="button" class="btn btn-info">Normal</button>
			   	<button type="button" class="btn btn-info active">Active</button>
			   	<button type="button" class="btn btn-info" disabled="disabled">Disabled</button>
		   	  </div>
		   	  
		   	  <h4>Warning Button - .btn-warning</h4>
			  <div class="bs-example">
			   	<button type="button" class="btn btn-warning">Normal</button>
			   	<button type="button" class="btn btn-warning active">Active</button>
			   	<button type="button" class="btn btn-warning" disabled="disabled">Disabled</button>
		   	  </div>
		   	  
		   	  <h4>Danger Button - .btn-danger</h4>
			  <div class="bs-example">
			   	<button type="button" class="btn btn-danger">Normal</button>
			   	<button type="button" class="btn btn-danger active">Active</button>
			   	<button type="button" class="btn btn-danger" disabled="disabled">Disabled</button>
		   	  </div>
		   	  
		   	  
		   	  <h3>Icons</h3>
		   	  
		   	  <h4>Audit Icons</h4>
		   	  <p class="alert alert-info"> 
		   	  	<i class="fa fa-info-circle"></i> Tip: Icons are the same at the requirement and sub-requirement level by default, 
		   	 	but they have different classes so that they can be different if you so choose.
		   	  </p>
		   	  <table class="table table-striped table-bordered">
		   	  	<thead>
		   	  		<tr>
		   	  			<td> Icon </td>
		   	  			<td> Icon Name </td>
		   	  			<td> Background Class </td>
		   	  			<td> Symbol Class </td>
		   	  		</tr>
		   	  	</thead>
		   	  	<tbody>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="statusOK legend_status" style="float: left;">
								<i class="fa fa-statusOK"><span class="sr-only">Requirement Complete Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Requirement Complete </td>
		   	  			<td> .statusOK </td>
		   	  			<td> .fa-statusOK </td>
		   	  		</tr>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="Status_OK1 legend_status" style="float: left;">
								<i class="fa fa-Status_OK"><span class="sr-only">Sub-Requirement Complete Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Sub-Requirement Complete </td>
		   	  			<td> .Status_OK </td>
		   	  			<td> .fa-Status_OK </td>
		   	  		</tr>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="statusPL legend_status" style="float: left;">
								<i class="fa fa-statusPL"><span class="sr-only">Requirement Complete with Planned Courses Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Requirement Complete with Planned Courses </td>
		   	  			<td> .statusPL </td>
		   	  			<td> .fa-statusPL </td>
		   	  		</tr>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="Status_PL1 legend_status" style="float: left;">
								<i class="fa fa-Status_PL"><span class="sr-only">Sub-Requirement Complete with Planned Courses Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Sub-Requirement Complete with Planned Courses </td>
		   	  			<td> .Status_PL </td>
		   	  			<td> .fa-Status_PL </td>
		   	  		</tr>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="statusIP legend_status" style="float: left;">
								<i class="fa fa-statusIP"><span class="sr-only">Requirement Complete with In Progress Courses Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Requirement Complete with In Progress Courses </td>
		   	  			<td> .statusIP </td>
		   	  			<td> .fa-statusIP </td>
		   	  		</tr>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="Status_IP1 legend_status" style="float: left;">
								<i class="fa fa-Status_IP"><span class="sr-only">Sub-Requirement Complete with In Progress Courses Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Sub-Requirement Complete with In Progress Courses </td>
		   	  			<td> .Status_IP </td>
		   	  			<td> .fa-Status_IP </td>
		   	  		</tr>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="statusNO legend_status" style="float: left;">
								<i class="fa fa-statusNO"><span class="sr-only">Requirement Unfulfilled Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Requirement Unfulfilled </td>
		   	  			<td> .statusNO </td>
		   	  			<td> .fa-statusNO </td>
		   	  		</tr>
		   	  		<tr>
		   	  			<td> 
			   	  			<span class="Status_NO1 legend_status" style="float: left;">
								<i class="fa fa-Status_NO"><span class="sr-only">Sub-Requirement Unfulfilled Icon</span></i> 
							</span>  
						</td>
		   	  			<td> Sub-Requirement Unfulfilled </td>
		   	  			<td> .Status_NO </td>
		   	  			<td> .fa-Status_NO </td>
		   	  		</tr>
		   	  	</tbody>		   	  
		   	  </table>
	
		   	  <h4>Staff Home Page Images</h4>
		   	  <p class="alert alert-info"> <i class="fa fa-info-circle"></i> 
		   	  	Tip: Don't forget to check :hover styles. <br>
		   	 	 Hover style for the staff home page is set by the class .dashboard-link:hover
	   	 	 </p>
		   	  
				<div class="row">
					<div class="col-md-12">
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Notifications">
								<div><i class="fa fa-notifications fa-5x"></i><br>
									Notifications <br> .fa-notifications</div>
							</a>
						</div>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Students">
								<div><i class="fa fa-students fa-5x"></i><br>
									Students <br> .fa-students</div>
							</a>
						</div>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Roadmaps">
								<div><i class="fa fa-roadmaps fa-5x"></i><br>
									Roadmaps <br> .fa-roadmaps</div>
							</a>
						</div>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Batch">
								<div><i class="fa fa-batch fa-5x"></i><br>
									Batch <br> .fa-batch</div>
							</a>
						</div>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Program Mappings">
								<div><i class="fa fa-programMappings fa-5x"></i><br>
									Program Mappings <br> .fa-programMappings</div>
							</a>
						</div>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Reports">
								<div><i class="fa fa-reports fa-5x"></i><br>
									Reports <br> .fa-reports</div>
							</a>
						</div>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Security">
								<div><i class="fa fa-security fa-5x"></i><br>
									Security <br> .fa-security</div>
							</a>
						</div>
						<div class="col-md-3 col-sm-6 col-xs-6 dashboard">
							<a href="#" class="dashboard-link" role="button" title="Admin">
								<div><i class="fa fa-admin fa-5x"></i><br>
									Admin <br> .fa-admin</div>
							</a>
						</div>
					</div> 
				</div>
	   	  		
		  </div> <!-- /Styles -->
  
  </div> <!-- /col-md-9 -->
  </div> <!-- /row -->
	
</@layout.body>