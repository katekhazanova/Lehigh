<!DOCTYPE html>
<html lang="en-US">
<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"] />
<head>
	<title>Security Groups</title>
	
	<script type="text/javascript"> if (top.frames.length!=0) top.location=self.document.location; </script>
		
	<script type="text/javascript">
	
		function initGroupTables() {
			var keys = [  { key: "Groups" } ];
			var columnDefs = [ { key: "Groups", width: 200, sortable: true } ];
			var dataSource = new DataSource(Dom.get("groupsTable"));
			dataSource.responseType = DataSource.TYPE_HTMLTABLE;
			dataSource.responseSchema = { fields: keys };
			groupsTable = new DataTable("groupsContainer", columnDefs, dataSource,
					{ scrollable: true,
					  width: "220px",
					  height: "150px",
					  selectionMode: "single" });
			
			groupsTable.subscribe("rowClickEvent", groupsTable.onEventSelectRow);
			groupsTable.subscribe("rowClickEvent", groupsTableRowSelected);
			
			<#if group??>
			Dom.get("deleteGroupButton").disabled = false;
			
			var recordSet = groupsTable.getRecordSet();
			for (var index = 0; index < recordSet.getLength(); index++) {
				var record = recordSet.getRecord(index);
				if (record.getData().Groups == "${group}") {
					groupsTable.selectRow(groupsTable.getRow(index));
					break;
				}
			}
			</#if>
			
			keys = [ { key: "Group Roles" } ];
			columnDefs = [ { key:  "Group Roles", width: 200, sortable: true } ];
			dataSource = new DataSource(Dom.get("groupRolesTable"));
			dataSource.responseType = DataSource.TYPE_HTMLTABLE;
			dataSource.responseSchema = { fields: keys };
			groupRolesTable = new DataTable("groupRolesContainer", columnDefs, dataSource,
					{ scrollable:  true,
					  width:  "185px",
					  height: "200px",
					  selectionMode: "single" });
			
			groupRolesTable.subscribe("rowClickEvent", groupRolesTable.onEventSelectRow);
			groupRolesTable.subscribe("rowClickEvent", groupRolesSelection);
			
			
			keys = [ { key: "Existing Roles" } ];
			columnDefs = [ { key:  "Existing Roles", width: 200, sortable: true } ];
			dataSource = new DataSource(Dom.get("existingRolesTable"));
			dataSource.responseType = DataSource.TYPE_HTMLTABLE;
			dataSource.responseSchema = { fields: keys };
			existingRolesTable = new DataTable("existingRolesContainer", columnDefs, dataSource,
					{ scrollable:  true,
					  width:  "185px",
					  height: "200px",
					  selectionMode: "single" });
			
			existingRolesTable.subscribe("rowClickEvent", existingRolesTable.onEventSelectRow);
			existingRolesTable.subscribe("rowClickEvent", existingRolesSelection);
			
			keys = [ { key: "First Name" },
					 { key: "Last Name" },
					 { key: "Username" },
					 { key: "SIS ID" } ];
			
			columnDefs = [  { key: "First Name", width: 83, sortable: true },
						    { key: "Last Name", width: 79, sortable: true },
							{ key: "Username", width: 78, sortable: true },
							{ key: "SIS ID", width: 79, sortable: true } ];
			
			dataSource = new DataSource(Dom.get("memberSearchTable"));
			dataSource.responseType = DataSource.TYPE_HTMLTABLE;
			dataSource.responseSchema = { fields: keys };
			memberSearchTable = new DataTable("memberSearchContainer", columnDefs, dataSource,
					{ scrollable: true,
					   width: "416px",
					   height: "125px",
					   selectionMode: "single" });
			
			memberSearchTable.subscribe("rowClickEvent", memberSearchTable.onEventSelectRow);
			memberSearchTable.subscribe("rowClickEvent", memberSearchTableClick);
			
			keys = [	
						<#list domainLabels as label>
						{key: "${label}" },
						</#list>
						{key: "dummy"}
					];
			keys.pop(keys[keys.length-1]);
			columnDefs = [	
						<#list domainLabels as label>
						{key: "${label}", width:108 },
						</#list>
						{key: "dummy", width:108 }
					];;
			columnDefs.pop(columnDefs[columnDefs.length - 1]);
		
			dataSource = new DataSource(Dom.get("groupDomainTable"));
			dataSource.responseType = DataSource.TYPE_HTMLTABLE;
			dataSource.responseSchema = { fields: keys };
				
			groupDomainTable = new DataTable("groupDomainContainer", columnDefs, dataSource,
					{ scrollable: true,
					  width: "${domainSize * 129}px",
					  selectionMode: "single" });
			
			groupDomainTable.subscribe("rowClickEvent", groupDomainTable.onEventSelectRow);
			groupDomainTable.subscribe("rowClickEvent", groupDomainSelected);
			
			
			
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
							{ key: "property", width: 110, sortable: true },
							{ key: "value", width: 78, sortable: true },
							{ key: "instidq", width: 78, sortable: true },
							{ key: "instid", width: 79, sortable: true },
							{ key: "instcd", width: 79, sortable: true },
							{ key: "description", width: 200, sortable: true }
						 ];
			dataSource = new DataSource(Dom.get("groupPropertyTable"));
			dataSource.responseType = DataSource.TYPE_HTMLTABLE;
			dataSource.responseSchema = { fields: keys };
			groupPropertyTable = new DataTable("groupPropertyContainer", columnDefs, dataSource,
					{ scrollable: true,
					   width: "750px",
					   height: "125px",
					   selectionMode: "single" });
			
			groupPropertyTable.subscribe("rowClickEvent", groupPropertyTable.onEventSelectRow);
			groupPropertyTable.subscribe("rowClickEvent", groupPropertyTableClick);
		}
		
		function initGroupTabs() {
			tabs = new YAHOO.widget.TabView("groupTabs");
			<#if tabView??>
			var selectedTab = "${tabView}";
			<#else>
			var selectedTab = "<#if RequestParameters.tabView??>${RequestParameters.tabView}</#if>";
			</#if>
			
		 var tabsDisplayed = tabs.get('tabs'); 	
	        for (var i = 0; i < tabsDisplayed.length; i++) { 
	        	if(selectedTab == 'users'){
	        		selectedTab = 'group members';
	        	}
	            if (tabsDisplayed[i].get('labelEl').innerHTML.toLowerCase()  == selectedTab) {
	                tabs.set('activeIndex', i); 
	                break; 
	            } 
	        } 
				
			tabs.getTab(0).addListener("click", tabGroupChangeHandler);
			tabs.getTab(1).addListener("click", tabGroupChangeHandler);
			tabs.getTab(2).addListener("click", tabGroupChangeHandler);
			tabs.getTab(3).addListener("click", tabGroupChangeHandler);
			
			<#if !group??>
				tabs.getTab(0).set("disabled", true);
				tabs.getTab(1).set("disabled", true);
				tabs.getTab(2).set("disabled", true);
				tabs.getTab(3).set("disabled", true);
			</#if>
		}
		
		function groupDomainSelected() {
			var data = groupDomainTable.getRecord(groupDomainTable.getSelectedRows()[0]).getData();
			var form = Dom.get("deleteDomainForm");
			<#list domainLabels as label>
			form.level_${label_index+1}.value = data.${label};
			</#list>
		}
		
		Event.onDOMReady(initGroupTables);
		Event.onDOMReady(initGroupTabs);
		Event.onDOMReady(initSearchFields);
	</script>
</head>
<input type="hidden" id="pageGroup" value="security"/>	
<body class="yui-skin-sam">

			<h1>Group Management</h1>
		

<!-- ############################################################################### -->
<!-- ####            GROUPS MAIN EDITOR											#### -->
<!-- ############################################################################### -->
		<div id="groupEditor" style="text-align:center;height:200px">
			<div style="float:left;padding:0px 80px 0px 275px">
				<div id="groupsContainer">
					<table id="groupsTable">
						<thead>
							<tr><th>Groups</th></tr>
						</thead>
						<tbody>
							<#if groups??>
							<#list groups as group>
							<tr><td>${group}</td></tr>
							</#list>
							</#if>
						</tbody>
					</table>
				</div> <!-- End:  Group Table Container -->
			</div> <!--  End:  Group Picker Div -->
			<#assign isAddHidden="hidden"/>
			<#assign isDeleteHidden="hidden"/>
			<@security.authorize ifAllGranted="SEC_Groups=c">
				<#assign isAddHidden="button"/>
			</@security.authorize>
			<@security.authorize ifAllGranted="SEC_Groups=d">
				<#assign isDeleteHidden="button"/>
			</@security.authorize>
			<form name="manageGroupsForm" method="post" action="manage-groups.html">
				<input type="hidden" id="tabView" name="tabView" />
				<input type="hidden" name="action" />
				<input type="hidden" name="deleteGroup" />
			<div class="verticalForm" id="addRemoveButtonsContainer" style="margin-top:50px;float:left;width:160px;text-align:center">
				<input type="${isAddHidden}" value="&lt;&lt; Add" style="width:70px" onclick="submitAddGroup()" />
				<input type="${isDeleteHidden}" id="deleteGroupButton" value="Delete" style="width:70px" onclick="submitDeleteGroup()" disabled="true" />
			</div> <!--  End:  Buttons for adding and removing groups -->
			
			<div class="verticalForm" id="groupInputDiv" style="float:left;margin-top:45px">
			<@security.authorize ifAllGranted="SEC_Groups=c">
				<label for="groupNameField"> Group Name:	</label>
				<input type="text" name="groupNameField" />
			</@security.authorize>
			</div>  <!-- End:  Group input div -->
			
			</form>
		</div> <!--  End:  Group Editor Div -->
		
		<#if errorMessage??>
		<div style="font-weight:bold;color:red;width:100%;text-align:center;">
			${errorMessage}
		</div>
		</#if>
	
		<div id="selectedGroupDiv" style="float:center;text-align:left;padding:0px 0px 10px 275px">
			<label for="selectedGroupNameField">
				Selected Group Name:
			</label>
			<#if group??>
				<input id="selectedGroupNameField" type="text" name="selectedGroupName" value="${group}" disabled="disabled" style="width:200px;margin:3px"/><br>
			</#if>
		</div>
		
		<div id="groupTabs" class="yui-navset" style="clear:both;">
			<ul class="yui-nav">
				<li class="selected"><a href="#tab1"><em>Roles</em></a></li>
			<@security.authorize ifAnyGranted="SEC_Group_Members=r">
				<li><a href="#tab2"><em>Group Members</em></a></li>
			</@security.authorize>	
			<@security.authorize ifAnyGranted="SEC_Domains=r">
				<li><a href="#tab3"><em>Domains</em></a></li>
			</@security.authorize>
				<li><a href="#tab4"><em>Properties</em></a></li>
			</ul>
			<div class="yui-content" style="padding:0px 0px 0px 25px">
<!-- ############################################################################### -->
<!-- ####            ROLES TAB    												#### -->
<!-- ############################################################################### -->

				<div>
					<h3>
						Roles
						<a href="#" data-toggle="modal" data-target="#groupRoleHelpModal" aria-haspopup="true" title = "Help for Group Roles" style="font-size: 65%;">
							<span class="sr-only">View Help Modal</span>	
							<i class="fa fa-question-circle fa-lg"></i>
						</a>
					</h3>
					
					<form class="verticalForm" name="applicationSelectionForm" method="get">
						<div id="applicationSelection">
							<fieldset style="width:95%;text-align:center">
								<input type="hidden" name="group" />
								<input type="hidden" name="tabView" value="roles" />
								<label for="app" style="text-align:center">
									Application:
									<select name="app" style="display:inline;width:200px" <#if !group??>disabled="disabled"</#if> onchange="appChosenForGroup()">
										<#if apps??>
										<option value=""></option>
										<#list apps as application>
										<option value="${application}" <#if app?? && app == application>selected</#if>>${application}</option>
										</#list>
										</#if>
									</select> 
								</label>
							</fieldset>
						</div>
					</form>
					
					<div id="groupRoles" style="float:left;padding:0px 80px 25px 250px">
						<div id="groupRolesContainer">
							<table id="groupRolesTable">
								<thead>
									<tr><th>Group Roles</th></tr>
								</thead>
								<tbody>
									<#if groupRoles??>
									<#list groupRoles as groupRole>
									<tr><td>${groupRole}</td></tr>
									</#list>
									</#if>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="verticalForm" id="groupRolesButtons" style="float:left;padding:90px 80px 25px 25px">
					<@security.authorize ifAllGranted="SEC_Groups=u">
						<input type="button" id="rolesAddButton" value="&lt;&lt; Add" style="width:85px" disabled="true" onclick="addRoleToGroup()" />
						<input type="button" id="rolesRemoveButton" value="Remove &gt;&gt;" style="width:85px" disabled="true" onclick="removeRoleFromGroup()" />
					</@security.authorize>
					</div>
					
					<div id="existingRoles" style="float:left;padding:0px 0px 25px 25px">
						<div id="existingRolesContainer">
							<table id="existingRolesTable">
								<thead>
									<tr><th>Existing Roles</th></tr>
								</thead>
								<tbody>
									<#if existingRoles??>
									<#list existingRoles as existingRole>
									<tr><td>${existingRole}</td></tr>
									</#list>
									</#if>
								</tbody>
							</table>
						</div>
					</div>
					<div style="clear:both"></div>
				</div>

<!-- ############################################################################### -->
<!-- ####            GROUP MEMBERS TAB											#### -->
<!-- ############################################################################### -->
	<@security.authorize ifAnyGranted="SEC_Group_Members=r">
				<div>
					<h3>
						Group Members
						<a href="#" data-toggle="modal" data-target="#groupMembersHelpModal" aria-haspopup="true" title = "Help for Group Members" style="font-size: 65%;">
							<span class="sr-only">View Help Modal</span>	
							<i class="fa fa-question-circle fa-lg"></i>
						</a>
					</h3>
					<div style="float:left;">
						<strong>Members:</strong><br />
						<select id="memberList" name="members" size="22" style="width:275px">
							<#if members??>
							<#list members as member>
								<option name="${member.username}">${member.username}</option>
							</#list>
							</#if>
						</select>
					</div>
			<#assign isGroupMemberAddHidden="hidden"/>
			<#assign isGroupMemberDeleteHidden="hidden"/>
			<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Group_Members=u">
				<#assign isGroupMemberAddHidden="button"/>
			</@security.authorize>
			<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Group_Members=d">
				<#assign isGroupMemberDeleteHidden="button"/>
			</@security.authorize>
					<div class="verticalForm" style="float:left;margin-top:180px;margin-left:15px ">
						<input type="${isGroupMemberAddHidden}" value="&lt;&lt; Add" style="width: 80px" onclick="submitGroupMemberUpdate('add')" /><br />
						<input type="${isGroupMemberDeleteHidden}" value="Remove" style="width:80px" onclick="submitGroupMemberUpdate('remove')" />
					</div>
					
					<div style="float:left; margin-left:15px">
					<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Group_Members=u">
						<strong>Search</strong> <br />
					</@security.authorize>	
						<div id="searchArea" style="padding-bottom:5px;margin-top:10px;">
							<form method="get" name="userSearchForm" action="group-member-search.html">
							<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Group_Members=u">
								<input name="tabView" type="hidden" value="users" />
								<input name="group" type="hidden" value="<#if group??>${group}</#if>" />
								<input name="lastNameFilter" type="text" style="width:128px" value="<#if adviseeLastName??>${adviseeLastName}<#else>Last Name</#if>"   onFocus="searchFocused(this, 'Last Name')" onBlur="searchLostFocus(this, 'Last Name')"/>
								<input name="usernameFilter" type="text" size="12" value="<#if username??>${username}<#else>Username</#if>"  onFocus="searchFocused(this, 'Username')" onBlur="searchLostFocus(this, 'Username')"/>
								<input name="sisFilter" type="text" size="12" value="<#if sisId??>${sisId}<#else>SIS ID</#if>" onFocus="searchFocused(this, 'SIS ID')" onBlur="searchLostFocus(this, 'SIS ID')" />
								<input type="submit" name="searchButton"  value="Search" /> <br />
							</@security.authorize>	
							</form>
						</div>
						<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Group_Members=u">
						<div id="memberSearchContainer" style="font-size:10pt;">
							<table id="memberSearchTable" cellpadding="2" cellspacing="0" border="1">
								<thead>
									<tr>
										<th>First Name</th>
										<th>Last Name</th>
										<th>Username</th>
										<th>SIS ID</th>
									</tr>
								</thead>
								<tbody>
									<#if userSearch??>
									<#list userSearch as user>
									<#if user??>
									<tr>
										<td>${user.firstName}</td>
										<td>${user.lastName}</td>
										<td>${user.username}</td>
										<td>${user.sisId}</td>
									</tr>
									</#if>
									</#list>
									</#if>
								</tbody>
							</table>
						</div>  <!-- closing the search results div  -->
						</@security.authorize>
						<br />
						<div class="verticalForm">
							<form name="addMemberForm" method="post" action="manage-group-members.html">
								<input type="hidden" name="group" />
								<input type="hidden" name="member" />
								<input type="hidden" name="tabView" value="users" />
								<input type="hidden" name="action" />
								<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Group_Members=u">
								<em>OR</em>
								<label for="usernameMember" style="margin-bottom: 0px;">Username: </label>
								<input name="usernameMember" type="text" onchange="usernameChange()" />
								<div style="padding-top: 10px;"><em>OR</em></div>
								<label for="sisIdMember" style="margin-bottom: 0px;"> SIS ID: </label>
								<input name="sisIdMember" type="text" onchange="sisIdChange()"/>
								</@security.authorize>
							</form>
						</div>
					
					</div> <!-- closing the search area  -->
					<div style="clear:both"></div>
				</div> <!-- closing the group members tab -->
	</@security.authorize>
<!-- ############################################################################### -->
<!-- ####            DOMAINS TAB												#### -->
<!-- ############################################################################### -->	
	<@security.authorize ifAnyGranted="SEC_Domains=r">							
				<div>
					<h3>
						Group Domains 
						<a href="#" data-toggle="modal" data-target="#groupDomainsHelpModal" aria-haspopup="true" title = "Help for Group Domains" style="font-size: 65%;">
							<span class="sr-only">View Help Modal</span>	
							<i class="fa fa-question-circle fa-lg"></i>
						</a>
					</h3>
					
					<div id="groupDomainContainer" style="font-size:9pt">
						<table id="groupDomainTable" >
							<thead>
							<tr>
								<#list domainLabels as label>
									<th>${label}</th>
								</#list>
							</tr>
							</thead>
							<tbody>
							<#if groupDomains??>
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
								</#if>
							</tbody>
						</table>
					</div>
					<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Domains=d">
					<form id="deleteDomainForm" method="post" action="manage-group-domain.html">
						<input type="hidden" name="action" value="delete" />
						<input type="hidden" name="group" value="${group!''}" />
						<input type="hidden" name="level_1" />
						<input type="hidden" name="level_2" />
						<input type="hidden" name="level_3" />
						<input type="hidden" name="level_4" />
						<input type="hidden" name="level_5" />
						<input type="hidden" name="level_6" />
						<input type="submit" value="Delete Domain" style="margin:10px" />
					</form>
					</@security.authorize>
					<@security.authorize ifAllGranted="SEC_Groups=u,SEC_Domains=u">
					<div style="margin:10px">
						<strong>Add Domain</strong><br />
						<form method="post" action="manage-group-domain.html">
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
						<input type="hidden" name="group" value="${group!''}" />
						<input type="submit" value="Add Domain" style="margin:10px"/>
						</form>
					</div>	
					</@security.authorize>
				</div>
				
	</@security.authorize>
<!-- ############################################################################### -->
<!-- ####            PROPERTIES TAB												#### -->
<!-- ############################################################################### -->								
				<div>
					<h3>
						Properties 
						<a href="#" data-toggle="modal" data-target="#groupPropertiesHelpModal" aria-haspopup="true" title = "Help for Group Properties" style="font-size: 65%;">
							<span class="sr-only">View Help Modal</span>	
							<i class="fa fa-question-circle fa-lg"></i>
						</a>
					</h3>
							
					<div id="groupPropertyContainer" style="font-size:9pt">
						<table id="groupPropertyTable" >
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
								<#if groupProperties??>
								<#list groupProperties as groupProperty>
								<tr>
									<td>${groupProperty.mappingId?string("0")!''}</td>
									<td>
										<#list availableProperties as ap>
											<#assign app="${ap.property!''}"/>
											<#assign gpp="${groupProperty.property!''}"/>
											<#if app == gpp> 
												${ap.description}
											</#if>
										</#list>
									</td>
									<td>${groupProperty.value!''}</td>
									<td>${groupProperty.instidq!''}</td>
									<td>${groupProperty.instid!''}</td>
									<td>${groupProperty.instcd!''}</td>
									<td>${groupProperty.description!''}</td>
								</tr>
								</#list>
								</#if>
							</tbody>
						</table>
					</div>
					<@security.authorize ifAnyGranted="SEC_Groups=u">
					<form name="deletePropertyForm" method="post" action="manage-group-property.html">
						<input type="hidden" name="action" value="delete" />
						<input type="hidden" name="mappingid"/>
						<input type="hidden" name="group" value="${group!''}"/>
						<input name="submitButton" type="submit" value="Delete Property" style="margin:10px" disabled="true"/>
					</form>
					
					<div style="margin:10px">
						<strong>Add Property</strong><br/><br/>
						<form name="addPropertyForm" method="post" action="manage-group-property.html">
						<input type="hidden" name="mappingid"/>
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="group" value="${group!''}" />
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
		
		
			</div> <!--  End:  YUI Tab Content -->
		</div>  <!-- End:  YUI Tabs Div -->


<!-- HELP MODALS -->
		<div class="modal fade" id="groupRoleHelpModal" tabindex="-1" role="dialog" aria-labelledby="groupRoleHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Group Roles</h1>
		        <p>
		        	This section allows for you to map application roles to your institution's groups.  First, select the application.  You will 
		        	then see a list of roles associated with it.  You can then make the associations by selecting the roles and clicking on the
		        	appropriate button.
		        </p>
				<p>
					Changes take effect immediately after pressing the Add/Remove buttons.
				</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="groupMembersHelpModal" tabindex="-1" role="dialog" aria-labelledby="groupMembersHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Group Members</h1>
		        <p>
		        	If this capability is enabled at your institution, you may be able to add users to groups.  You can search 
		        	for them by using all or part of their last name, all of their username, or all of their student ID.
				</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="groupDomainsHelpModal" tabindex="-1" role="dialog" aria-labelledby="groupDomainsHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Group Domains</h1>
		        <p>
		        	Domains limit the permission scope to a certain level of your 
					institution's hierarchical structure.  Use asterisks (*) to indicate 
					that the group has permissions for any of the values for that level. 
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
		
		<div class="modal fade" id="groupPropertiesHelpModal" tabindex="-1" role="dialog" aria-labelledby="groupPropertiesHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Group Properties</h1>
		        <p>
		        	Limit the properties a group can have access. A user may have properties directly applied to their user 
					account or inherited from groups they belong to.
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