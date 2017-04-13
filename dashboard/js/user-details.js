// imports
var Dom = YAHOO.util.Dom;
var Event = YAHOO.util.Event;
var DataSource = YAHOO.util.DataSource;
var DataTable = YAHOO.widget.DataTable;

var groupHelpPanel;
var domainsHelpPanel;
var propertyHelpPanel;
var adviseesHelpPanel;

var userDomainTable;
var groupDomainTable;
var adviseeSearchTable;
var userPropertyTable;
var tabs; 

function initUserPanels() {
	groupHelpPanel = new YAHOO.widget.Panel("groupHelp", {
		width: "400px",
		fixedcenter: true,
		contraintoviewport: true,
		underlay: "shadow",
		close: true,
		visible: false,
		draggable: true} );
	groupHelpPanel.setHeader("Help - Groups");
	groupHelpPanel.setBody("Groups are assigned by your institution.  Users are assigned to " +
						   "groups and groups are then mapped to internal \"roles\".  This section " +
						   "may not be available if your institution hasn't implemented a way to " +
						   "update groups through DCP.");
	groupHelpPanel.render("container");
	
	domainHelpPanel = new YAHOO.widget.Panel("domainHelp", {
		width: "400px",
		fixedcenter: true,
		contraintoviewport: true,
		underlay: "shadow",
		close: true,
		visible: false,
		draggable: true} );
	domainHelpPanel.setHeader("Help - Domain");
	domainHelpPanel.setBody("Domains limit the permission scope to a certain level of your " + 
							"institution's hierarchical structure.  Use asterisks (*) to indicate " + 
							"that the user has permissions for any of the values for that level.  " +
							"A user may have domain permissions directly applied to their user " +
							"account or inherited from groups they belong to.");
	domainHelpPanel.render("container");
	
	propertyHelpPanel = new YAHOO.widget.Panel("propertyHelp", {
		width: "400px",
		fixedcenter: true,
		contraintoviewport: true,
		underlay: "shadow",
		close: true,
		visible: false,
		draggable: true} );
	propertyHelpPanel.setHeader("Help - Property");
	propertyHelpPanel.setBody("Limit the properties a user can have access.");
	propertyHelpPanel.render("container");
	
	adviseesHelpPanel = new YAHOO.widget.Panel("adviseesHelp", {
		width: "400px",
		fixedcenter: true,
		contraintoviewport: true,
		underlay: "shadow",
		close: true,
		visible: false,
		draggable: true} );
	adviseesHelpPanel.setHeader("Help - Advisees");
	adviseesHelpPanel.setBody("Assign advisees to an advisor user.");
	adviseesHelpPanel.render("container");
}

function tabUserChangeHandler(event) {

	var selectedTab = tabs.get("activeTab");
	var label = selectedTab.get('labelEl').innerHTML;

		Dom.get("tabView").value = label;
}


function adviseeSearchTableClick() {
	document.addAdviseeForm.sisIdAdvisee.value = "";
	document.addAdviseeForm.usernameAdvisee.value = "";
	var data = adviseeSearchTable.getRecord(adviseeSearchTable.getSelectedRows()[0]);
	document.addAdviseeForm.advisee.value = data.getData().Username;
}

function usernameAdviseeChange() {
	document.addAdviseeForm.sisIdAdvisee.value = "";
	adviseeSearchTable.unselectAllRows();
}

function sisIdAdviseeChange() {
	document.addAdviseeForm.usernameAdvisee.value = "";
	adviseeSearchTable.unselectAllRows();
}

function submitAddRemove(action) {
	document.addAdviseeForm.action.value = action;
	
	if (action == "remove") {
		var listValue = Dom.get("adviseeList").value;
		if (!listValue) {
			alert("You must select a user to remove from the 'Advisees' list.");
			return;
		}
		
		document.addAdviseeForm.advisee.value = Dom.get("adviseeList").value;
	}
	
	document.addAdviseeForm.submit();
}

function addUserToGroup() {
	document.userGroupForm.action.value = "add";
	document.userGroupForm.submit();
}

function removeUserFromGroup() {
	document.userGroupForm.action.value = "remove";
	document.userGroupForm.deleteGroup.value = Dom.get("memberGroups").value;
	document.userGroupForm.submit();
}

