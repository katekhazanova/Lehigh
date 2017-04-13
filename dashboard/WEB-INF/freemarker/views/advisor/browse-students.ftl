<html>
<head>
	<META name="userName" content="${userFullName!''}">
		<title>Student Browser</title>    
</head>
<body class="yui-skin-sam">

<div style="margin-left:5%;margin-right:5%;">
	<#if error??>
		<div style="height:600px;width:100%;text-align:center;">
			<@h.img src="/images/stop.jpg" title="Access Denied" alt="Access Denied"/>
			<h2>Access is Denied to Username: ${message!''} ${planLabel}</h2>
			<p>You lack sufficient credentials to view this student's ${planLabel?lower_case}s.</p>
			<p>If you feel you are getting this message in error, contact your system administrator.</p>
			<p><@h.link title="Return to Student Browser" href="/advisor/browse-students.html" />
			<p><@h.link title="Log Out" href="/j_spring_security_logout" />
		</div>
	<#else>
	<div class="boxNC" style="width:750px margin-left: 50%; margin-right: 50%; ">
	<h1><span style="vertical-align:middle;margin-right:3px;"></span>Student Browser</h1>
	
	<div class="content">
	
		<div id="instructions">
			<p>This list of students you initially see are students that are assigned to you.
			You can do a search on a partial match (at least 1 character) to a student's last name, 
			an exact match to a username (their log in name), or an exact match to the
			student's Student ID.  All students matching these criteria will be returned.</p>
		</div>
		
			<div id="studentFilter" class="filterDiv">
			
			<table id="studentSearch" class="borderless-table" >
			
		  <tr>			
			<form id="studentFilterForm" method="get" action="">
				<td><input type="text" id="lastnameField" name="lastname" class="textInputDescriptor" value="Last Name" style="margin-left:2px;margin-right:2px;width:96px;" /></td>
				<td><input type="text" id="firstnameField" name="firstname" class="textInputDescriptor" value="First Name" style="margin-left:2px;margin-right:2px;width:96px;" /></td>
				<td><input type="text" id="usernameField" name="username" class="textInputDescriptor" value="Username" style="margin-left:2px;margin-right:2px;width:96px" /></td>
				<td><input type="text" id="sisidField"    name="sisID"    class="textInputDescriptor" value="Student ID" style="margin-left:2px;margin-right:2px;width:96px" /></td>
				<td><input type="text" id="emailField" name="email" class="textInputDescriptor" value="Email Address" style="margin-left:2px; margin-right:2px; width:96px;" /></td>
				<td><input type="submit" id="searchButton" value="Search" style="width:96px" /></td>
			</form>
		  </tr>
			  
			</table>
			</div>
		<div><h2><#if searchOn=="true">My Advisees:<#else>Search Results:</#if></h2></div>	
		<div id="studentSearchContainer" class="studentSearchTable" style="font-size:10pt">
			<table id="studentTable" class="tables" style="font-size: 100%;" >
				<thead>
					<tr>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Username</th>
						<th>Student ID</th>
						<th>Email</th>
						<th>${declaredLabel}</th>
						<th>View</th>				
					</tr>
				</thead>
				<tbody>
					<#if students??>
					<#list students as student>
						<tr>
							<td>${student.lastName!''}</td>
							<td>${student.firstName!''}</td>
							<td>${student.username!''}</td>
							<td>${student.sisId!''}</td>
							<td><#if student.email??><div style="font-size:8pt"><a href="mailto:${student.email!''}">${student.email!''}</#if></a></div></td>
							<td>
								<div style="font-size:8pt">
									<#if studentDeclaredPlanIdMap[student.sisId]??>
											<@h.link title="${studentDeclaredPlanNameMap[student.sisId]}" onclick="showLoadingBar();" href="/plan/edit-plan-with-roadmap.html?planId=${studentDeclaredPlanIdMap[student.sisId]}&roadmapId=-1&username=${student.username}&validate=true"/>
									</#if>
								</div>
							</td>												   
							<td><@h.imgLink src="/laf/themes/udirect/images/go.jpg" href="/plan/manage/display-plans.html?student=${student.username}" title="View ${planLabel}s" alt="View ${planLabel}s"/></td>
						</tr>
					</#list>
					</#if>
				</tbody>
			</table>
		</div>


		<div id="submitLookup" class="filterDiv">
		<form id="viewStudentForm" method="get" action="<@h.url href="/plan/manage/display-plans.html" />">
			<input type="hidden" id="student" name="student" />
			<input id="submitLookupButton" type="submit" value="View Selected Student" style="float:right; margin-bottom:10px; margin-top:10px; margin-right:5px" disabled="true" />
		</form>
		<form id="studentAdviseesFilterForm" method="get" action="">
			<#if searchOn=="true"><div class="hidden"></#if>
			<input type="submit" id=advisees" name="advisees" value="Return to list of my advisees" style="float:left; margin-bottom:10px; margin-top:10px;"/>
			<#if searchOn=="true"></div></#if>
		</form>
		</div>	

	</div>
	</#if>
	<input type="hidden" id="declaredLabel" name="declaredLabel" value="${declaredLabel}" />
		<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	</div>
	</div>



</body>
</html>