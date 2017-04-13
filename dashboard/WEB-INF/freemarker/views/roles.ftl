<!DOCTYPE html>
<html lang="en-US">
<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"] />
<head>
	<title>Security Roles</title>
	
</head>
<input type="hidden" id="pageGroup" value="security"/>	
<body class="yui-skin-sam">

		<h1>Role Management</h1>
	

	
	<div style="width:100%" align="center">
		<form name="appSelectionForm" method="GET">
			<label for="appCombo" style="margin:25px">Application: 
				<select name="application" style="width:200px;margin:3px" onchange="submit()">
					<option value=""></option>
					<#list apps as app>
					<option value="${app}" <#if selectedApp?? && app == selectedApp>selected</#if>>${app}</option>
					</#list>
				</select>
			</label>
		</form>
	</div>
	
	<hr />

	<div id="roleListDiv" style="float:left;width:40%;text-align:center;height:180px">
	<form name="roleSelectionForm" method="GET">
		<input type="hidden" name="application" />
		Roles<br />
		<select name="role" size="8" style="width:200px" onchange="submitRole()">
			<#if roles??>
				<#list roles?sort as role>
					<option value="${role}" <#if selectedRole?? && role == selectedRole>selected</#if>>${role}</option>
				</#list>
			</#if>
		</select>
		</form>
	</div>
			<#assign isAddHidden="hidden"/>
			<#assign isDeleteHidden="hidden"/>
			<@security.authorize ifAllGranted="SEC_Roles=c">
				<#assign isAddHidden="button"/>
			</@security.authorize>
			<@security.authorize ifAllGranted="SEC_Roles=d">
				<#assign isDeleteHidden="button"/>
			</@security.authorize>
<form name="alterRoleForm" action="delete-role.html" method="POST">
	<input type="hidden" name="application" />
	<input type="hidden" name="role"/>
	<div id="roleButtons" style="float:left;width:10%;height:120px;padding-top:30px">
		<input type="${isAddHidden}" value="&lt;&lt; Add" style="width:75px;margin:3px" onclick="addRole(this)"/><br />
		<input type="${isAddHidden}" value="&lt; Clone &gt;" style="width:75px;margin:3px" onclick="submitCloneRoleForm()"/><br />
		<input type="${isDeleteHidden}" value="X  Delete" style="width:75px;margin:3px" onclick="submitAlterRoleForm()" /><br />
	</div>
	
	<div id="roleDetails" style="float:left;width:50%;text-align:left;height:105px;padding-top:45px;">
	<@security.authorize ifAllGranted="SEC_Roles=c">
		<label for="roleNameField" style="margin:25px">Role Name:</label>
		
			<input id="roleNameField" type="text" name="roleName" style="width:200px;margin:3px"/><br>
	</@security.authorize>
	</div>
	
	<div id="selectedRoleDiv" style="float:left;width:50%;text-align:left">
		<label for="selectedRoleNameField" style="margin:5px">Selected Role Name:</label>
		<#if selectedRole??>
				<input id="selectedRoleNameField" type="text" name="selectedRoleName" value="${selectedRole}" disabled="disabled" style="width:200px;margin:3px"/><br>
		</#if>
	</div>
	
</form>
	
	<hr style="clear:both" />
			<#assign isDisabled="disabled"/>
			<@security.authorize ifAnyGranted="SEC_Roles=u"> 
				<#assign isDisabled=""/>
			</@security.authorize>
			<#if !selectedRole??>
				<#assign isDisabled="disabled"/>
			</#if>
	<div id="permissions" style="width:100%;clear:both;padding-top:20px;text-align:center" >
		<form name="permissionForm" method="POST" action="save-permissions.html">
		<table cellpadding="0" cellspacing="0" border="1" width="80%" align="center">
			<tr>
				<th style="background-color:#EEE" align="left">App Function</th>
				<th style="background-color:#EEE" align="center">Read</th>
				<th style="background-color:#EEE" align="center">Update</th>
				<th style="background-color:#EEE" align="center">Create</th>
				<th style="background-color:#EEE" align="center">Delete</th>
			</tr>
			<#if permissions??>
			<#list permissions as permission>
			<tr>
				<td align="left" style="background-color:#EEE">
					${permission.appFunction}
					<input type="hidden" name="appFn" value="${permission.appFunction}" />
				</td>
				<td align="center">
						<select name="read" ${isDisabled}>
							<option value="NONE" <#if permission.canRead == "NONE">selected</#if>>NONE</option>
							<option value="RESTRICTED" <#if permission.canRead == "RESTRICTED">selected</#if>>RESTRICTED</option>
							<option value="FULL" <#if permission.canRead == "FULL">selected</#if>>FULL</option>
						</select>
				</td>
				<td align="center">
					<select name="update" ${isDisabled}>
						<option value="NONE" <#if permission.canUpdate == "NONE">selected</#if>>NONE</option>
						<option value="RESTRICTED" <#if permission.canUpdate == "RESTRICTED">selected</#if>>RESTRICTED</option>
						<option value="FULL" <#if permission.canUpdate == "FULL">selected</#if>>FULL</option>
					</select>
				</td>
				<td align="center">
					<select name="create" ${isDisabled}>
						<option value="NONE" <#if permission.canCreate == "NONE">selected</#if>>NONE</option>
						<option value="RESTRICTED" <#if permission.canCreate == "RESTRICTED">selected</#if>>RESTRICTED</option>
						<option value="FULL" <#if permission.canCreate == "FULL">selected</#if>>FULL</option>
					</select>
				</td>
				<td align="center">
					<select name="delete" ${isDisabled}>
						<option value="NONE" <#if permission.canDelete == "NONE">selected</#if>>NONE</option>
						<option value="RESTRICTED" <#if permission.canDelete == "RESTRICTED">selected</#if>>RESTRICTED</option>
						<option value="FULL" <#if permission.canDelete == "FULL">selected</#if>>FULL</option>
					</select>
				</td>
			</tr>
			</#list>
			</#if>
		</table>
			<input type="hidden" name="role" />
			<input type="hidden" name="app" value="${selectedApp!""}" />
			<@security.authorize ifAllGranted="SEC_Roles=u">
				<input type="button" value="Save" style="margin:3px" onclick="savePermissions()"/>
			</@security.authorize>
		</form>
	</div>	
	
	<hr />
	
	<div id="groupListDiv" style="float:left;width:100%;text-align:center;height:200px;">
		<strong>Groups that Contain this Role:</strong><br />
		<select name="groupsList" size="8" style="width:200px;color:black" disabled>
			<#if selectedRole??>
				<#list groups as group>
						<option name="${group}">${group}</option>
				</#list>
			</#if>
		</select>
		<br />
		<em>(If you want to add roles to groups, go to the Group's section.)</em>
	</div>


</body>
</html>