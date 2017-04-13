<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE html>
<html lang="en-US">
 
<head>
	<title>Security Users</title>	
</head>

<input type="hidden" id="pageGroup" value="security"/>	
<body >

	<#if userServiceCapability == "NONE">
		<#assign formDisabled="disabled=disabled" />
	<#else>
		<#assign formDisabled="" />
	</#if>

	<h1>User Management</h1>
	
	<div class="row" >
		<form method="get" name="userSearchForm" class="form-inline" role="form">
		
		  <div class="form-group col-md-2" style="padding-left: 0px; padding-right: 3px;">
		    <label for="firstNameFilter">First Name</label>
		    <input name="firstNameFilter" type="text"  class="form-control" id="firstNameFilter" value="<#if RequestParameters.firstNameFilter??>${RequestParameters.firstNameFilter}</#if>" ${formDisabled}   onKeyPress="checkEnter(event)"/>
		  </div>
	  	  <div class="form-group col-md-2" style="padding-left: 0px; padding-right: 3px;">
		    <label for="lastNameFilter">Last Name</label>
		    <input name="lastNameFilter" type="text" class="form-control" id="lastNameFilter" value="<#if RequestParameters.lastNameFilter??>${RequestParameters.lastNameFilter}</#if>" ${formDisabled}    onKeyPress="checkEnter(event)"/>
		  </div>
		  <div class="form-group col-md-2" style="padding-left: 0px; padding-right: 3px;">
		    <label for="usernameFilter">Username</label>
		    <input name="usernameFilter" type="text" class="form-control"  id="usernameFilter" value="<#if RequestParameters.usernameFilter??>${RequestParameters.usernameFilter}</#if>" ${formDisabled} onKeyPress="checkEnter(event)"/>
		  </div>
		  <div class="form-group col-md-2" style="padding-left: 0px; padding-right: 3px;">
		    <label for="sisidFilter">SIS ID</label>
		    <input name="sisidFilter" type="text" class="form-control" id="sisidFilter" value="<#if RequestParameters.sisidFilter??>${RequestParameters.sisidFilter}</#if>" ${formDisabled}  onKeyPress="checkEnter(event)"/>
		  </div>
		  <div class="form-group col-md-2" style="padding-left: 0px; padding-right: 3px;">
		    <label for="exampleInputEmail2">Email</label>
		    <input name="emailFilter" type="text" class="form-control" id="emailFilter"  value="<#if RequestParameters.emailFilter??>${RequestParameters.emailFilter}</#if>" ${formDisabled}  onKeyPress="checkEnter(event)"/>
		  </div>
		   <div class="form-group col-md-2" style="padding-left: 0px; padding-right: 0px;">
		   	   <input type="button" name="searchButton" class="btn btn-primary" id="searchButton" value="Search" ${formDisabled}  onclick="searchSubmit()" style="margin-top: 22px;"/> <br />
		   </div>	
		   <div class="row" style="padding:10px 0px 10px 0px;">
		   <div class="col-md-6">
		   		 <label for="groupFilter" class="col-md-3 control-label">Filter by Group: </label>
	 			<select id="groupFilter" class="form-control col-md-9" name="groupFilter" onchange="searchSubmit()">
				<option value="">Show All</option>
				<#list groups as group>
				<option value="${group}">${group}</option>
				</#list>
			</select>
		   </div>
		   </div>
		</form>
	</div>	
	<div class="row" >
		<table id="userTable" class="table table-striped table-bordered table-hover" >
			<thead>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Username</th>
					<th>SIS ID</th>
					<th>Email</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
	<div class="row">	
		<form name="editUserForm" method="get" action="user-details.html" class="form-inline" role="form">
			<input type="hidden" name="action" /">
			<input type="hidden" id="usernameField" name="username" /">
			<input type="hidden" name="firstNameFilter" />
			<input type="hidden" name="lastNameFilter" />
			<input type="hidden" name="usernameFilter" />
			<input type="hidden" name="groupFilter" />
			<input type="hidden" name="sisidFilter" />
			<input type="hidden" name="emailFilter" />
	
		<@security.authorize ifAnyGranted="SEC_Users=c"> 
		<div class="form-group">
			<input type="button" name="newButton" class="btn btn-default" id="newButton" value="New" ${formDisabled} onclick="addButtonClicked()" />
		</div>	
		</@security.authorize>
		<@security.authorize ifAnyGranted="SEC_Users=r"> 
		<div class="form-group">
			<input type="submit" name="editUserButton" class="btn btn-default" id="editUserButton" value="View" disabled="false" />
		</div>	
		</@security.authorize>
		<@security.authorize ifAnyGranted="SEC_Users=d"> 
		<div class="form-group">
			<input type="button" id="deleteUserButton" name="deleteButton"  class="btn btn-default" id="deleteButton" value="Delete" disabled onclick="deleteButtonClicked()" />
		</div>	
		</@security.authorize>
		<@security.authorize ifAnyGranted="SEC_Users=c"> 
		<div class="form-group">
			<input type="button" id="cloneUserButton" name="cloneButton" class="btn btn-default" id="cloneButton" value="Clone" disabled onclick="cloneButtonClicked()" />
		</div>	
		</@security.authorize>
		</form>
	</div>

</body>
</html>