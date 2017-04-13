// imports
var Dom = YAHOO.util.Dom;
var Event = YAHOO.util.Event;
var DataSource = YAHOO.util.DataSource;
var DataTable = YAHOO.widget.DataTable;
var SimpleDialog = YAHOO.widget.SimpleDialog;
var Connect = YAHOO.util.Connect;

// Global Variables
var tabs;
var groupsTable;
var groupRolesTable;
var existingRolesTable;
var memberSearchTable;
var groupDomainTable;
var groupPropertyTable;
var confirmDeleteDialog;
		



function groupsTableRowSelected() {
	Dom.get("deleteGroupButton").disabled = false;
	document.applicationSelectionForm.app.disabled = false;
	var param = "";
	var tabView = Dom.get("tabView").value;
	if (tabView.length > 0)
		param = "&tabView=" + tabView;
	
	var data = groupsTable.getRecord(groupsTable.getSelectedRows()[0]);
	window.location = "groups.html?group=" + data.getData().Groups + param;
}

function tabGroupChangeHandler() {
	var selectedTab = tabs.get("activeTab");
	var label = selectedTab.get('labelEl').innerHTML;

		Dom.get("tabView").value = label;
}

function submitAddGroup() {
	var form = document.manageGroupsForm;
	form.action.value = "add";
	var index = tabs.get("activeIndex");
	switch (index) {
		case 0:  form.tabView.value = "roles"; break;
		case 1:  form.tabView.value = "users"; break;
		case 2:  form.tabView.value = "domains"; break;
		case 3:  form.tabView.value = "properties"; break;
	}
	
	document.manageGroupsForm.submit();
}

function submitDeleteGroup() {		
	if (!confirmDeleteDialog) {
		confirmDeleteDialog = new SimpleDialog("warning", {
				width: "250px",
				fixedcenter: true,
				modal: true,
				visible: true,
				icon:  SimpleDialog.ICON_HELP,
				draggable: true });
		var buttons = [ { text: "Delete Group",
						  handler:  confirmDeletion },
						{ text: "Cancel",
						  handler:  cancelDeletion,
						  isDefault: true } ];
		confirmDeleteDialog.cfg.queueProperty("buttons", buttons);
		confirmDeleteDialog.setHeader("WARNING!");
		confirmDeleteDialog.setBody("Are you sure you want to delete the group?<br /><br /> " +
		"Deleting the group will remove all roles and users associated with the group.");
		confirmDeleteDialog.render(document.body);
	}

	confirmDeleteDialog.show();
}

function confirmDeletion() {
	confirmDeleteDialog.hide();
	var form = document.manageGroupsForm;
	form.action.value = "delete";
	
	var data = groupsTable.getRecord(groupsTable.getSelectedRows()[0]);
	form.deleteGroup.value = data.getData().Groups;
	form.submit();
}

function cancelDeletion() {
	confirmDeleteDialog.hide();
}

function appChosenForGroup() {
	var data = groupsTable.getRecord(groupsTable.getSelectedRows()[0]);
	document.applicationSelectionForm.group.value = data.getData().Groups;
	document.applicationSelectionForm.submit();
}

function groupRolesSelection() {
	existingRolesTable.unselectAllRows();
	Dom.get("rolesRemoveButton").disabled = false;
	Dom.get("rolesAddButton").disabled = true;
}

function existingRolesSelection() {
	groupRolesTable.unselectAllRows();
	Dom.get("rolesRemoveButton").disabled = true;
	Dom.get("rolesAddButton").disabled = false;
}

function addRoleToGroup() {
	var row = existingRolesTable.getRecord(existingRolesTable.getSelectedRows()[0]);
	var existingRecordSet = existingRolesTable.getRecordSet();
	var recordIndex = existingRecordSet.getRecordIndex(row);
	var data = row.getData();
	var role = data["Existing Roles"];
	role = role;
	
	row = groupsTable.getRecord(groupsTable.getSelectedRows()[0]);
	data = row.getData();
	var group = data["Groups"];
	
	var newRow = new Object();
	newRow["Group Roles"] = role;
	groupRolesTable.addRow(newRow);
	existingRolesTable.deleteRow(recordIndex);
	
	Connect.asyncRequest("POST", 
						 "group-roles-manager.ajax",
						 addRoleCallback,
						 "action=add&role=" + role + "&group=" + group);
}

function removeRoleFromGroup() {
	var row = groupRolesTable.getRecord(groupRolesTable.getSelectedRows()[0]);
	var groupRecordSet = groupRolesTable.getRecordSet();
	var recordIndex = groupRecordSet.getRecordIndex(row);
	var data = row.getData();
	var role = data["Group Roles"];
	
	row = groupsTable.getRecord(groupsTable.getSelectedRows()[0]);
	data = row.getData();
	var group = data["Groups"];
	
	var newRow = new Object();
	newRow["Existing Roles"] = role;
	existingRolesTable.addRow(newRow);
	groupRolesTable.deleteRow(recordIndex);
	
	Connect.asyncRequest("POST", 
						 "group-roles-manager.ajax",
						 removeRoleCallback,
						 "action=remove&role=" + role + "&group=" + group);
}


var addRoleCallback = {
	success: function(response) {
		var message = eval("(" + response.responseText + ")");
		if (message.result == "success") {
			var role = message.role;
			var recordSet = groupRolesTable.getRecordSet();
			for (var index = 0; index < recordSet.getLength(); index++) {
				if (recordSet.getRecord(index).getData()["Group Roles"] == role) {
					var row = groupRolesTable.getRow(index);
					var color = (index % 2 == 1) ? "#EDF5FF" : "#FFFFFF";							
						
					var anim = new YAHOO.util.ColorAnim(row, 
						{ backgroundColor:  { from: "#3F6",
											  to: color }
					    }); 
					anim.duration = 3;
					anim.animate();
				}
			}
		}
	},
	failure: function(response) {
	}
}

var removeRoleCallback = {
	success: function(response) {
	},
	failure: function(response) {
	}
}

function memberSearchTableClick() {
	document.addMemberForm.sisIdMember.value = "";
	document.addMemberForm.usernameMember.value = "";
	var data = memberSearchTable.getRecord(memberSearchTable.getSelectedRows()[0]);
	document.addMemberForm.member.value = data.getData().Username;
}


function usernameChange() {
	document.addMemberForm.sisIdMember.value = "";
	memberSearchTable.unselectAllRows();
}

function sisIdChange() {
	document.addMemberForm.usernameMember.value = "";
	memberSearchTable.unselectAllRows();
}

function submitGroupMemberUpdate(action) {
	document.addMemberForm.action.value = action;
	var row = groupsTable.getRecord(groupsTable.getSelectedRows()[0]);
	document.addMemberForm.group.value = row.getData().Groups; 
	
	if (action == "remove") {
		var listValue = Dom.get("memberList").value;
		if (!listValue) {
			alert("You must select a user to remove from the 'Advisees' list.");
			return;
		}
		
		document.addMemberForm.member.value = Dom.get("memberList").value;
	}
	
	document.addMemberForm.submit();
}


