<!DOCTYPE html>
<html lang="en-US">
<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"] />
<input type="hidden" id="pageGroup" value="security"/>
<head>
	<title>Security User Details</title>
	
	<script type="text/javascript">
	
	Event.onDOMReady(initUserPanels);
	Event.onDOMReady(initUserTables);
	Event.onDOMReady(initUserTabs);
	Event.onDOMReady(initSearchFields);
	
	function initUserTabs() {
		tabs = new YAHOO.widget.TabView("userTabs");
		tabs.set("activeTab", tabs.getTab(0));
		<#if tabView??>
			var selectedTab = "${tabView}";
		<#else>
			var selectedTab = "<#if RequestParameters.tabView??>${RequestParameters.tabView}</#if>";
		</#if>			
		 var tabsDisplayed = tabs.get('tabs'); 	
	        for (var i = 0; i < tabsDisplayed.length; i++) { 
	        	if(selectedTab == 'domains'){
	        		selectedTab = 'user domains';
	        	}
	            if (tabsDisplayed[i].get('labelEl').innerHTML.toLowerCase()  == selectedTab) { 
	            
	                tabs.set('activeIndex', i); 
	                break; 
	            } 
	        } 
		

		tabs.getTab(0).addListener("click", tabUserChangeHandler);
		tabs.getTab(1).addListener("click", tabUserChangeHandler);
		tabs.getTab(2).addListener("click", tabUserChangeHandler);	
		tabs.getTab(3).addListener("click", tabUserChangeHandler);
		
		<#if !user.username??>
		tabs.getTab(0).set("disabled", true);
		tabs.getTab(1).set("disabled", true);
		tabs.getTab(2).set("disabled", true);
		tabs.getTab(3).set("disabled", true);
		</#if>
	}
	
	function initUserTables() {
		var keys = [	
						<#list domainLabels as label>
						{key: "${label}" },
						</#list>
						{key: "dummy"}
					];
		keys.pop(keys[keys.length-1]);
		var columnDefs = [	
						<#list domainLabels as label>
						{key: "${label}", width:108 },
						</#list>
						{key: "dummy", width:108 }
					];;
		columnDefs.pop(columnDefs[columnDefs.length - 1]);
		
		var dataSource = new DataSource(Dom.get("groupDomainTable"));
		dataSource.responseType = DataSource.TYPE_HTMLTABLE;
		dataSource.responseSchema = { fields: keys };
		
		groupDomainTable = new DataTable("groupDomainContainer", columnDefs, dataSource,
					{ scrollable: true,
					  width: "${domainSize * 129}px" });	
		dataSource = new DataSource(Dom.get("userDomainTable"));
		dataSource.responseType = DataSource.TYPE_HTMLTABLE;
		dataSource.responseSchema = { fields: keys };
		
		userDomainTable = new DataTable("userDomainContainer", columnDefs, dataSource,
					{ scrollable: true,
					  width: "${domainSize * 129}px",
					  selectionMode: "single" });
		userDomainTable.subscribe("rowClickEvent", userDomainTable.onEventSelectRow);	
		userDomainTable.subscribe("rowClickEvent", userDomainSelected);
		
		keys = [  {key: "First Name" },
					    {key: "Last Name" },
					    {key: "Username" },
					    {key: "SIS ID" } ];
		
		columnDefs = [  { key: "First Name", width: 83},
									 { key: "Last Name", width: 79, sortable: true },
									 { key: "Username", width: 78, sortable: true },
									 { key: "SIS ID", width: 79, sortable: true } ];
		
		dataSource = new DataSource(Dom.get("adviseeSearchTable"));
		dataSource.responseType = DataSource.TYPE_HTMLTABLE;
		dataSource.responseSchema = { fields: keys };
		adviseeSearchTable = new DataTable("adviseeSearchContainer", columnDefs, dataSource,
					{ scrollable: true,
					   width: "416px",
					   height: "125px",
					   selectionMode: "single" });
		adviseeSearchTable.subscribe("rowClickEvent", adviseeSearchTable.onEventSelectRow);
		adviseeSearchTable.subscribe("rowClickEvent", adviseeSearchTableClick);
		
		
					// Group Property Table
			keys = [ { key: "mappingId" },
					 { key: "property" },
					 { key: "value" },
					 { key: "instidq" },
					 { key: "instid" },
					 { key: "instcd" },
					 { key: "description" }
				   ];
			columnDefs = [ 
							{ key: "property", width: 110, sortable: true},
							{ key: "value", width: 78, sortable: true },
							{ key: "instidq", width: 78, sortable: true },
							{ key: "instid", width: 79, sortable: true },
							{ key: "instcd", width: 79, sortable: true },
							{ key: "description", width: 200, sortable: true }
						 ];
			dataSource = new DataSource(Dom.get("userPropertyTable"));
			dataSource.responseType = DataSource.TYPE_HTMLTABLE;
			dataSource.responseSchema = { fields: keys };
			userPropertyTable = new DataTable("userPropertyContainer", columnDefs, dataSource,
					{ scrollable: true,
					   width: "750px",
					   height: "125px",
					   selectionMode: "single" });
			
			userPropertyTable.subscribe("rowClickEvent", userPropertyTable.onEventSelectRow);
			userPropertyTable.subscribe("rowClickEvent", userPropertyTableClick);
	}
	
	function userDomainSelected() {
		var data = userDomainTable.getRecord(userDomainTable.getSelectedRows()[0]).getData();
		var form = Dom.get("deleteDomainForm");
		<#list domainLabels as label>
		form.level_${label_index+1}.value = data.${label};
		</#list>
	}
		
	</script>
	
</head>
	
<body class="yui-skin-sam">

	<#assign action="${RequestParameters.action!''}">

		<h1>User Management</h1>
	
	<#if error??>
		<div class="centeredBox error">
			<#if error == "1">
				Username is a Required Field.<br/>
			</#if>
			<#if error == "2">
				SIS ID is a Required Field.<br/>
			</#if>
			<#if error == "3">
				Username already exists.<br/>
			</#if>
			<#if error == "4">
				Password is a Required Field.<br/>
			</#if>
		</div>
	</#if>
		<form  id="userEditorForm" method="post" action="save-user-details.html">
			<input type="hidden" id="tabView" name="tabView" value="<#if RequestParameters.tabView??>${RequestParameters.tabView}<#else>groups</#if>" />
			
			<div class="row">
			<#assign isDisabled="disabled=yes"/>
			<@security.authorize ifAnyGranted="SEC_Users=u"> 
				<#assign isDisabled=""/>
			</@security.authorize>
			<div class="form-group col-md-3">
				<label for="usernameField">Username:</label>
					<#if action == 'clone'>
						<input name="action" class="form-control input-sm" type="hidden" value="clone"/>
						<input name="cloneUsernameField" class="form-control input-sm" value="${user.username!''}" type="hidden" id="cloneUsernameField" />
						<input name="usernameField" class="form-control input-sm" value="${user.username!''}" type="text" id="usernameField" size="20" onblur="textFieldBlur(this)" />
					<#else>
							<input name="usernameField" class="form-control input-sm" value="${user.username!''}" type="text" id="usernameField" size="20" onblur="textFieldBlur(this)"/>
						<#if action == 'new'>
							<input name="action" type="hidden" value="new"/>
						</#if>
					</#if>
				</div>
				<#assign isPasswordHidden="hidden"/>
				<#assign passwordLabel=" "/>
				<#assign isPasswordDisabled="disabled=yes"/>
				<@security.authorize ifAnyGranted="SEC_Change_Password=u">
					<#assign isPasswordHidden="password"/>
					<#assign passwordLabel="Password:"/>
					<#assign isPasswordDisabled=""/>
				</@security.authorize>
				<#if action == 'clone' || action == 'new'>
					<#assign isDisabled=""/>
					<#assign isPasswordHidden="password"/>
					<#assign passwordLabel="Password:"/>
					<#assign isPasswordDisabled=""/>
				</#if>
				<div class="form-group col-md-3">
					<label for="firstNameField">First Name:	</label>
					<input name="firstNameField" class="form-control input-sm" value="${user.firstName!''}" type="text" id="firstNameField" size="20" onblur="textFieldBlur(this)" ${isDisabled}/>
				</div>
				
				<div class="form-group col-md-3">	
					<label for="lastNameField">Last Name:</label>
					<input name="lastNameField" class="form-control input-sm" value="${user.lastName!''}" type="text" id="lastNameField" size="20" onblur="textFieldBlur(this)" ${isDisabled}/>
				</div>
				
			</div>
			<div class="row">	
				<div class="form-group col-md-3">
					<label for="emailField">Email:</label>
					<input name="emailField" class="form-control input-sm" value="${user.email!''}" type="text" id="emailField" size="20" onblur="textFieldBlur(this)" ${isDisabled}/>
				</div>
				
				<div class="form-group col-md-3">	
					<label for="sisIdField">SIS ID:</label>
					<input name="sisIdField" class="form-control input-sm" value="<#if action != 'clone'>${user.sisId!''}</#if>" type="text" id="sisIdField" size="20" onblur="textFieldBlur(this)" ${isDisabled}/>
				</div>
				
				<div class="form-group col-md-3">
					<label for="password">${passwordLabel}</label>
					<input name="password" class="form-control input-sm" value="" type="${isPasswordHidden}" id="password" size="20" onblur="textFieldBlur(this)" ${isPasswordDisabled}/>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-9">
					<label for="notesField">Notes:</label>
					<textarea name="notesField" class="form-control input-sm" id="notesField" rows="1" cols="80"/ ${isDisabled}>${user.notes!''}</textarea>
				</div>
			</div>
					
				<div class="row">
				<div class="form-group col-md-2">
					<#if action != 'clone'>
						<@security.authorize ifAnyGranted="SEC_Users=u"> 
							<input type="submit" class="btn btn-primary" name="saveButton" id="saveButton" value="Save" />
						</@security.authorize>
						<#if action == 'new'>
							<@security.authorize ifNoneGranted="SEC_Users=u"> 
								<input type="submit" class="btn btn-primary" name="saveButton" id="saveButton" value="Save" />
							</@security.authorize>
						</#if>
					<#else>
						<@security.authorize ifAnyGranted="SEC_Users=c"> 
							<input type="submit" class="btn btn-primary" name="saveButton" id="saveButton" value="Clone" />
						</@security.authorize>
					</#if>
				
				
					<input type="button" class="btn btn-default" name="cancelButton" id="cancelButton" value="Cancel" onclick="window.location='${request.contextPath}/users.html'" />
					
					</div>
				</div>
		</form>
	
	
	<#if action != 'clone'>
	
	<div id="userTabs" class="yui-navset">
		<ul class="yui-nav">
		<@security.authorize ifAnyGranted="SEC_Group_Members=r">
			<li><a href="#tab1"><em>Group Membership</em></a></li>
		</@security.authorize>
		<@security.authorize ifAnyGranted="SEC_Domains=r">
			<li><a href="#tab2"><em>User Domains</em></a></li>
		</@security.authorize>
		<@security.authorize ifAnyGranted="SEC_Advisees=r">
			<li><a href="#tab3"><em>Advisees</em></a></li>
		</@security.authorize>
			<li><a href="#tab4"><em>Properties</em></a></li>
		</ul>
		<div class="yui-content">
<!-- ############################################################################### -->
<!-- ####            GROUPS  TAB												#### -->
<!-- ############################################################################### -->
		<@security.authorize ifAnyGranted="SEC_Group_Members=r">
			<div>
				<h3>Groups 
					<a href="#" data-toggle="modal" data-target="#userGroupHelpModal" aria-haspopup="true" title = "Help for Group Membership" style="font-size: 65%;">
						<span class="sr-only">View Help Modal</span>	
						<i class="fa fa-question-circle fa-lg"></i>
					</a>
				</h3>
				
				<div style="float:left;">
					Group Membership:<br />
					<select id="memberGroups" name="memberGroups" size="8" style="width:150px" <#if !user.username??>disabled</#if>>
						<#if groups??>
							<#list groups as group>
								<option value="${group}">${group}</option>
							</#list>
						</#if>
						
					</select>
				</div>
			<#assign isGroupMemberAddHidden="hidden"/>
			<#assign isGroupMemberDeleteHidden="hidden"/>
			<@security.authorize ifAllGranted="SEC_Users=u,SEC_Group_Members=u">
				<#assign isGroupMemberAddHidden="button"/>
			</@security.authorize>
			<@security.authorize ifAllGranted="SEC_Users=u,SEC_Group_Members=d">
				<#assign isGroupMemberDeleteHidden="button"/>
			</@security.authorize>
			
				<div class="verticalForm" style="float:left;width:75px;margin-top:40px;padding-left:15px;text-align:center">
					<input type="${isGroupMemberAddHidden}" value="&lt;&lt; Add" onclick="addUserToGroup()" style="width:60px" <#if !user.username??>disabled</#if> onclick="" />
					<input type="${isGroupMemberDeleteHidden}" value="X" onclick="removeUserFromGroup()" style="width:60px" <#if !user.username??>disabled</#if> />
				</div>
				
				<div class="verticalForm" style="float:left;margin-top:30px;padding-left:15px">
					<form class="verticalForm" name="userGroupForm" method="post" action="user-groups.html">
						<input type="hidden" name="action" />
						<input type="hidden" name="username" value="${user.username!''}" />
						<input type="hidden" name="deleteGroup" />
						<@security.authorize ifAllGranted="SEC_Users=u,SEC_Group_Members=u">
						<label for="groupField">Group Name:	</label>
						<input type="text" name="group" id="groupField" <#if !user.username??>disabled</#if>/>
						</@security.authorize>
					</form>
				</div>
				
				<div style="padding-top:20px;clear:both">
					<strong>Group Domains</strong><br />
					
					<div id="groupDomainContainer" style="font-size:9pt">
						<table id="groupDomainTable" width="100%" cellpadding="0" cellspacing="0" border="0">
							<thead>
							<tr>
								<#list domainLabels as label>
								<th>${label}</th>
								</#list>
							</tr>
							</thead>
							<tbody>
							<#list groupDomains as groupDomain>
							<tr>
								<#if groupDomain.levelOne != "">
									<td>${groupDomain.levelOne}</td>
								</#if>
								<#if groupDomain.levelTwo != "">
									<td>${groupDomain.levelTwo}</td>
								</#if>
								<#if groupDomain.levelThree != "">
									<td>${groupDomain.levelThree}</td>
								</#if>
								<#if groupDomain.levelFour != "">
									<td>${groupDomain.levelFour}</td>
								</#if>
								<#if groupDomain.levelFive != "">
									<td>${groupDomain.levelFive}</td>
								</#if>
								<#if groupDomain.levelSix != "">
									<td>${groupDomain.levelSix}</td>
								</#if>
							</tr>
							</#list>
							</tbody>
						</table>
					</div>
				</div>
			</div>
	</@security.authorize>
<!-- ################################################################################ -->
<!-- ####            DOMAINS  TAB				    							 #### -->
<!-- ################################################################################ -->
	<@security.authorize ifAnyGranted="SEC_Domains=r">
			<div>
				<h3>
					User Domains 
					<a href="#" data-toggle="modal" data-target="#userDomainsHelpModal" aria-haspopup="true" title = "Help for User Domains" style="font-size: 65%;">
						<span class="sr-only">View Help Modal</span>	
						<i class="fa fa-question-circle fa-lg"></i>
					</a>
				</h3>
				
				<div id="userDomainContainer" style="font-size:9pt">
					<table id="userDomainTable" >
						<thead>
						<tr>
							<#list domainLabels as label>
								<th>${label}</th>
							</#list>
						</tr>
						</thead>
						<tbody>
						<#list userDomains as userDomain>
							<tr>
								<#if userDomain.levelOne != "">
									<td>${userDomain.levelOne}</td>
								</#if>
								<#if userDomain.levelTwo != "">
									<td>${userDomain.levelTwo}</td>
								</#if>
								<#if userDomain.levelThree != "">
									<td>${userDomain.levelThree}</td>
								</#if>
								<#if userDomain.levelFour != "">
									<td>${userDomain.levelFour}</td>
								</#if>
								<#if userDomain.levelFive != "">
									<td>${userDomain.levelFive}</td>
								</#if>
								<#if userDomain.levelSix != "">
									<td>${userDomain.levelSix}</td>
								</#if>
							</tr>
							</#list>
						</tbody>
					</table>
				</div>
				<@security.authorize ifAllGranted="SEC_Users=u,SEC_Domains=d">
				<form id="deleteDomainForm" method="post" action="manage-user-domain.html">
					<input type="hidden" name="action" value="delete" />
					<input type="hidden" name="level_1" />
					<input type="hidden" name="level_2" />
					<input type="hidden" name="level_3" />
					<input type="hidden" name="level_4" />
					<input type="hidden" name="level_5" />
					<input type="hidden" name="level_6" />
					<input type="hidden" name="username" value="${user.username!''}" />
					<input type="submit" value="Delete Domain" style="margin:10px" />
				</form>
				</@security.authorize>
				<@security.authorize ifAllGranted="SEC_Users=u,SEC_Domains=u">
				<div style="margin:10px">
					<strong>Add Domain</strong><br />
					<form method="post" action="manage-user-domain.html">
					<input type="hidden" name="username" value="${user.username!''}" />
					<#if domainErrorMessage??>
						<span style="color:red;font-weight:bold">${domainErrorMessage}</span>
					</#if>
					<table width="${domainSize * 129}px" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<#list domainLabels as domainLabel>
							<td><input name="level_${domainLabel_index+1}" type="text" style="width:108px;font-size:9pt" /></td>
							</#list>
						</tr>
					</table>
					<input type="hidden" name="action" value="add" />
					<input type="submit" value="Add Domain" style="margin:10px"/>
					</form>
				</div>	
				</@security.authorize>
			</div>
	</@security.authorize>
<!-- ################################################################################ -->
<!-- ####            ADVISEES  TAB												 #### -->
<!-- ################################################################################ -->
	<@security.authorize ifAnyGranted="SEC_Advisees=r">
			<div>
				<h3>
					Advisees
					<a href="#" data-toggle="modal" data-target="#adviseesHelpModal" aria-haspopup="true" title = "Help for Advisees" style="font-size: 65%;">
						<span class="sr-only">View Help Modal</span>	
						<i class="fa fa-question-circle fa-lg"></i>
					</a>
				</h3>
				<div style="float:left">
					<strong>Advisees:</strong><br />
					<select id="adviseeList" name="advisees" size="22" style="width:200px">
						<#list advisees as advisee>
							<option name="${advisee}">${advisee}</option>
						</#list>
					</select>
				</div>
			<#assign isAdviseesAddHidden="hidden"/>
			<#assign isAdviseesDeleteHidden="hidden"/>
			<@security.authorize ifAllGranted="SEC_Users=u,SEC_Advisees=u">
				<#assign isAdviseesAddHidden="button"/>
			</@security.authorize>
			<@security.authorize ifAllGranted="SEC_Users=u,SEC_Advisees=d">	
				<#assign isAdviseesDeleteHidden="button"/>
			</@security.authorize>
				<div class="verticalForm" style="float:left;margin-top:180px;margin-left:15px ">
					<input type="${isAdviseesAddHidden}" value="&lt;&lt; Add" style="width: 80px" onclick="submitAddRemove('add')" /><br />
					<input type="${isAdviseesDeleteHidden}" value="Remove" style="width:80px" onclick="submitAddRemove('remove')" />
				</div>
	
				<div style="float:left; margin-left:15px">
				<@security.authorize ifAllGranted="SEC_Users=u,SEC_Advisees=u">
					<strong>Search</strong> <br />
				</@security.authorize>
					<div id="searchArea" style="padding-bottom:5px;margin-top:10px;">
						<form method="get" name="userSearchForm" action="advisee-search.html">
						<@security.authorize ifAllGranted="SEC_Users=u,SEC_Advisees=u">
							<input name="username" type="hidden" value="${user.username!''}" />
							<input name="tabView" type="hidden" value="advisees" />
							<input name="lastNameFilter" type="text" style="width:128px" value="<#if adviseeLastName??>${adviseeLastName}<#else>Last Name</#if>"   onFocus="searchFocused(this, 'Last Name')" onBlur="searchLostFocus(this, 'Last Name')"/>
							<input name="usernameFilter" type="text" size="12" value="<#if adviseeUsername??>${adviseeUsername}<#else>Username</#if>"  onFocus="searchFocused(this, 'Username')" onBlur="searchLostFocus(this, 'Username')"/>
							<input name="sisFilter" type="text" size="12" value="<#if adviseeSisid??>${adviseeSisid}<#else>SIS ID</#if>" onFocus="searchFocused(this, 'SIS ID')" onBlur="searchLostFocus(this, 'SIS ID')" />
							<input type="submit" name="searchButton"  value="Search" /> <br />
						</@security.authorize>
						</form>
					</div>
					<@security.authorize ifAllGranted="SEC_Users=u,SEC_Advisees=u">
					<div id="adviseeSearchContainer" style="font-size:10pt;">
						<table id="adviseeSearchTable" cellpadding="2" cellspacing="0" border="1">
							<thead>
								<tr>
									<th>First Name</th>
									<th>Last Name</th>
									<th>Username</th>
									<th>SIS ID</th>
								</tr>
							</thead>
							<tbody>
								<#if users??>
								<#list users as usr>
								<tr>
									<td>${usr.firstName}</td>
									<td>${usr.lastName}</td>
									<td>${usr.username}</td>
									<td>${usr.sisId}</td>
								</tr>
								</#list>
								</#if>
							</tbody>
						</table>		
					</div>  <!-- closing the search results div  -->
					</@security.authorize>
					<br />
					<div class="verticalForm">
						<form name="addAdviseeForm" method="post" action="manage-advisee.html">
							<input type="hidden" name="advisee" />
							<input type="hidden" name="username" value="${user.username!''}" />
							<input type="hidden" name="tabView" value="advisee" />
							<input type="hidden" name="action" />
							<@security.authorize ifAllGranted="SEC_Users=u,SEC_Advisees=u">
							<em>OR</em>
							<label for="usernameAdvisee" style="margin-bottom: 0px;">Username: 	</label>
							<input name="usernameAdvisee" type="text" onchange="usernameAdviseeChange()" />
							<div style="padding-top: 10px;"><em>OR</em></div>
							<label for="sisIdAdvisee" style="margin-bottom: 0px;"> SIS ID:	</label>
							 <input name="sisIdAdvisee" type="text" onchange="sisIdAdviseeChange()"/>
							</@security.authorize>
						</form>
					</div>
				</div> <!-- closing the search area  -->
				
				<div style="clear:both"></div>
			</div> <!-- closing the advisee tab -->
	</@security.authorize>		
<!-- ############################################################################### -->
<!-- ####            PROPERTIES TAB												#### -->
<!-- ############################################################################### -->								
			<div>
				<h3>
					Properties 
					<a href="#" data-toggle="modal" data-target="#userPropHelpModal" aria-haspopup="true" title = "Help for User Properties" style="font-size: 65%;">
						<span class="sr-only">View Help Modal</span>	
						<i class="fa fa-question-circle fa-lg"></i>
					</a>
				</h3>
						
				<div id="userPropertyContainer" style="font-size:9pt">
					<table id="userPropertyTable" >
						<thead>
						<tr>
							<th>mappingid</th>
							<th>property</th>
							<th>value</th>
							<th>instidq</th>
							<th>instid</th>
							<th>instcd</th>
							<th>description</th>
						</tr>
						</thead>
						<tbody>
							<#if userProperties??>
							<#list userProperties as userProperty>
							<tr>
								<td>${userProperty.mappingId?string("0")!''}</td>
								<td>
									<#list availableProperties as ap>
										<#assign app="${ap.property!''}"/>
										<#assign gpp="${userProperty.property!''}"/>
										<#if app == gpp> 
											${ap.description}
										</#if>
									</#list>
								</td>
								<td>${userProperty.value!''}</td>
								<td>${userProperty.instidq!''}</td>
								<td>${userProperty.instid!''}</td>
								<td>${userProperty.instcd!''}</td>
								<td>${userProperty.description!''}</td>
							</tr>
							</#list>
							</#if>
						</tbody>
					</table>
				</div>
				<@security.authorize ifAnyGranted="SEC_Users=u">
				<form name="deletePropertyForm" method="post" action="manage-user-property.html">
					<input type="hidden" name="action" value="delete" />
					<input type="hidden" name="mappingid"/>
					<input type="hidden" name="user" value="${user.username!''}"/>
					<input name="submitButton" type="submit" value="Delete Property" style="margin:10px" disabled="true"/>
				</form>

				<div style="margin:10px">
					<strong>Add Property</strong><br/><br/>
					<form name="addPropertyForm" method="post" action="manage-user-property.html">
					<input type="hidden" name="mappingid"/>
					<input type="hidden" name="action" value="add" />
					<input type="hidden" name="user" value="${user.username!''}" />
					<#if domainErrorMessage??>
						<span style="color:red;font-weight:bold">${domainErrorMessage}</span>
					</#if>
					<table cellpadding="0" cellspacing="0" border="0">
					<thead>
						<tr>
							<th>Property</th>
							<th>Value</th>
							<th>InstIDQ</th>
							<th>InstID</th>
							<th>InstCD</th>
							<th>Description</th>	
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<select name="property" style="display:inline;width:130px;font-size:9pt;margin-right:10px" onchange="onAddPropertyChange()">
								<#if availableProperties??>
									<option value=""></option>
									<#list availableProperties as ap>
										<option value="${ap.property}">${ap.description}</option>
									</#list>
								</#if>
								</select>
							</td>
							<td>
								<input name="value" maxlength="255" type="text" style="width:100px;font-size:9pt;margin-right:10px" onchange="onAddPropertyChange()"/>
							</td>
							<td>
								<input name="instidq" maxlength="2" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddPropertyChange()"/>
							</td>
							<td>
								<input name="instid" maxlength="8" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddPropertyChange()"/>
							</td>
							<td>
								<input name="instcd" maxlength="3" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddPropertyChange()"/>
							</td>
							<td>
								<input name="description" maxlength="100" type="text" style="width:100%;font-size:9pt;margin-right:10px" onchange="onAddPropertyChange()"/>
							</td>
						</tr>
					</tbody>
					</table>
					<br/>
					<input name="submitButton" type="submit" value="Add Property" onclick="return validateProperty(addPropertyForm);"/>
					<input name="cancelButton" type="button" value="Cancel" style="visibility: hidden" onclick="cancelUpdateProperty();"/>
					</form>
				</div>
				</@security.authorize>
			</div>
			
			
		</div> <!-- closing the tab contents div  -->
	</div> <!-- closing the tabs div -->
	
	</#if>

	<#if action != 'clone'>				
	<input type="button" value="&lt;&lt; Return to User Search" style="margin:20px 0px 18px 23px" onclick="window.location='${request.contextPath}/users.html'" />
	</#if>
	
<!-- HELP MODALS -->

	<div class="modal fade" id="userGroupHelpModal" tabindex="-1" role="dialog" aria-labelledby="userGroupHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Group Membership</h1>
		        <p>
		        	Groups are assigned by your institution.  Users are assigned to 
					groups and groups are then mapped to internal "roles".  This section 
					may not be available if your institution hasn't implemented a way to 
					update groups through u.direct.
				</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="userDomainsHelpModal" tabindex="-1" role="dialog" aria-labelledby="userDomainsHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>User Domains</h1>
		        <p>
		        	Domains limit the permission scope to a certain level of your 
					institution's hierarchical structure.  Use asterisks (*) to indicate 
					that the user has permissions for any of the values for that level.  
					A user may have domain permissions directly applied to their user 
					account or inherited from groups they belong to.
				</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="adviseesHelpModal" tabindex="-1" role="dialog" aria-labelledby="adviseesHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Advisees</h1>
		        <p>
		        	Assign advisees to an advisor user.
				</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="userPropHelpModal" tabindex="-1" role="dialog" aria-labelledby="userPropHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Properties</h1>
		        <p>
		        	Limit the properties a user can have access to.
				</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
	
	

</body>
</html>