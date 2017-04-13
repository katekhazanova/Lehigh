<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
<head>

	<style type="text/css">
		#more, #more a { font-size: 123.1%; }
		#more a { text-decoration: underline; }
		.section { margin-left: 4em; margin-right: 4em; margin-bottom: 4em; }	
	</style>
	
	<title>Installation Verification</title>
	<META name="view" content="installVerification">
</head>
<body>
	
		<h1 id="top">Dashboard Installation Verification</h1>
		<div class="alert alert-warning">
		<p>This page is a tool to help verify your Dashboard installation.</p>
		<p >More documentation is available from the <a href="http://clients.collegesource.com/home" target="_blank">CollegeSource Support Center</a>.</p>
		</div>
	
	<div class="row">
	
	<div class="col-md-3 col-lg-3 hidden-xs hidden-sm">
	
		<div class="well affix" id="sidenav">
		<h2>Options</h2>
			<ul id="admin-sidebar" class="nav nav-pills nav-stacked">
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#config" />">Configuration Verification</a></li>
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#dbconnect" />">Database Connection</a></li>
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#security" />">Security</a></li>
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#URLs" />">Application URLs</a></li>
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#version" />">Version Information</a></li>
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#help" />">Help Configuration</a></li>
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#styles" />">Styles</a></li>

	
				
				<br>
				<li><a href="<@spring.url relativeUrl="/general/helloworld.html#top" />"> <i class="fa fa-caret-up"></i> Back to top</a></li>
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
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${instidq}</td>
					<td>${instid}</td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
	
	<hr />
	<h2 id="dbconnect">Database Connection</h2>
	<div class="section">
		<p>A database query was run to check for database connectivity.</p>
		<p>Query: <strong>${query}</strong></p>
		<p>Result: <strong>${queryResult}</strong></p>
		<p>Java Version: <strong>${javaVersion}</strong></p>
	</div>
	
	<hr />
	<h2 id="security">Security</h2>
	<div class="section">
		<p>The following security permissions are those held by the current user (you).</p>
		<table class="verticalListing">
			<tbody>

				<tr>
					<th colspan="2" style="background-color: #fff; color: #000; padding-top: 30px;">
						<h3>Application Functions</h3>
					</th>
				</tr>
				<tr>
					<th>
					</th>
					<th>
						Create
					</th>
					<th>
						Read
					</th>
					<th>
						Update
					</th>
					<th>
						Delete
					</th>
				</tr>
				
				<#list AppFunRoleValues.values() as ss>
					<#assign v = ss?string>
					<tr>
						<th>${v}</th>
						<td>
							<@security.authorize ifAllGranted=v+"=c">
								<i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this application function</span></i>
							</@security.authorize>
							<@security.authorize ifNoneGranted=v+"=c">
								<i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this application function</span></i>
							</@security.authorize>
						</td>
						<td>
							<@security.authorize ifAllGranted=v+"=r">
								<i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this application function</span></i>
							</@security.authorize>
							<@security.authorize ifNoneGranted=v+"=r">
								<i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this application function</span></i>
							</@security.authorize>
						</td>
						<td>
							<@security.authorize ifAllGranted=v+"=u">
								<i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this application function</span></i>
							</@security.authorize>
							<@security.authorize ifNoneGranted=v+"=u">
								<i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this application function</span></i>
							</@security.authorize>
						</td>
						<td>
							<@security.authorize ifAllGranted=v+"=d">
								<i class="fa fa-check" style="color: green;font-size: 16px;" title="True"><span class="sr-only">You have this application function</span></i>
							</@security.authorize>
							<@security.authorize ifNoneGranted=v+"=d">
								<i class="fa fa-times" style="color: red;font-size: 16px;" title="False"><span class="sr-only">You do not have this application function</span></i>
							</@security.authorize>
						</td>
					</tr>
				</#list>
			</tbody>
		</table>
	</div>
	
	<hr />
					
	<h2 id="general">Application URLs</h4>
		 
			  <table  id="URLs" class="table table-striped table-bordered">
		   	  		<thead>
						<tr>
						<#if selfserviceURL??>
						<th> Selfservice URL </th>
						<td>${selfserviceURL}  </td>
						</#if>
						</tr>
						<tr>
						<#if udirectURL??>
						<th> Udirect URL </th>
						<td> ${udirectURL}  </td>
						</tr>
						</#if>
						<tr>
						<#if regLink??>
						<th> Schedule Builder Url </th> 
						<td> ${regLink} </td>
						</tr>
						</#if>
					</thead>
			  </table>

			  <h4 id="version">Version Information</h4>
			  		<#include "/layout/build.ftl" />
	<h2 id="help">Help Configuration</h2>
	<div class="section">
		<p>Configure the help URL for students and advisors within Dashboard at the following location.</p>
		<div class="table-responsive">
		<table class="table table-striped table-bordered">
			<tbody>
				<tr>
					<th> Property </th>
					<th> File </th>
				</tr>
				<tr>
					<td> <code>help.baseUrl= </code> </td>
					<td> dashboard.properties </td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
	
	<hr />
	<h2 id="styles">Styles</h2>
				<span>
					<#include "/includes/themebuttons.ftl" />
				</span>
		<div class="section">
			<h3 class="hidden-sm hidden-xs">Menus</h3>
			<p class="hidden-sm hidden-xs"><br><span class="alert alert-danger">The menu section will be hidden on small/extra small screens</span><br><br></p>
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
	
</body>