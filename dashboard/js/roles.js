var SimpleDialog = YAHOO.widget.SimpleDialog;

var confirmRoleDeleteDialog;

function submitRole() {
	document.roleSelectionForm.application.value = document.appSelectionForm.application.value;
	document.roleSelectionForm.submit();
}

function submitAlterRoleForm() {
	
	confirmRoleDeleteDialog = new SimpleDialog("warning", 
		{	
			width: 			"250px",
			fixedcenter: 	true,
			modal: 			true,
			visible: 		true,
			icon:  			SimpleDialog.ICON_HELP,
			draggable: 		true 
		}
	);
	
	var buttons = [ 
						{ 	
							text: 		"Delete Role",
				  			handler:  	deleteRole 
				  		},
						{ 
							text: 		"Cancel",
				  			handler:  	cancelDeletion,
				  			isDefault: 	true 
				  		} 
				  ];
				  
	confirmRoleDeleteDialog.cfg.queueProperty("buttons", buttons);
	confirmRoleDeleteDialog.setHeader("WARNING!");
	confirmRoleDeleteDialog.setBody("Are you sure you want to delete the role?<br /><br /> ");
	confirmRoleDeleteDialog.render(document.body);

	confirmRoleDeleteDialog.show();
}

function deleteRole() {
	confirmRoleDeleteDialog.hide();
	document.alterRoleForm.role.value = document.roleSelectionForm.role.value;
	document.alterRoleForm.application.value = document.appSelectionForm.application.value;
	document.alterRoleForm.submit();
}

function cancelDeletion() {
	confirmRoleDeleteDialog.hide();
}

function submitCloneRoleForm() {
	
	confirmRoleCloneDialog = new SimpleDialog("warning", 
		{	
			width: 			"250px",
			fixedcenter: 	true,
			modal: 			true,
			visible: 		true,
			icon:  			SimpleDialog.ICON_HELP,
			draggable: 		true 
		}
	);
	
	var buttons = [ 
						{ 	
							text: 		"Clone Role",
				  			handler:  	cloneRole 
				  		},
						{ 
							text: 		"Cancel",
				  			handler:  	cancelClone,
				  			isDefault: 	true 
				  		} 
				  ];
				  
	confirmRoleCloneDialog.cfg.queueProperty("buttons", buttons);
	confirmRoleCloneDialog.setHeader("WARNING!");
	confirmRoleCloneDialog.setBody("Are you sure you want to clone the role?<br /><br /> ");
	confirmRoleCloneDialog.render(document.body);

	confirmRoleCloneDialog.show();
}

function cancelClone() {
	confirmRoleCloneDialog.hide();
}

function cloneRole() {
	confirmRoleCloneDialog.hide();
	var src = document.alterRoleForm.roleNameField;
	var role = document.roleSelectionForm.role;
	if (src!=null && src.value != '' && role!=null && role.value!= '') {
		var dest = document.roleSelectionForm.role.options;
		dest[dest.length] = new Option(src.value, src.value);
		dest.selectedIndex =dest.length - 1; 
		src.value = "";
	
		var elements = document.permissionForm.elements;
		for (var i=0; i < elements.length; i++) {
			if (elements[i].options) {
				elements[i].selectedIndex = elements[i].selectedIndex;
				elements[i].disabled = false;
			}
		}
		savePermissions();
	}
}

function addRole() {
	var src = document.alterRoleForm.roleNameField;
	if (src!=null && src.value != '') {
		var dest = document.roleSelectionForm.role.options;
		dest[dest.length] = new Option(src.value, src.value);
		dest.selectedIndex =dest.length - 1; 
		src.value = "";
		
		var elements = document.permissionForm.elements;
		for (var i=0; i < elements.length; i++) {
			if (elements[i].options) {
				elements[i].selectedIndex = 0;
				elements[i].disabled = false;
			}
		}
	
		//var groups = document.groupsForm.groupsList;
		//for (i = groups.options.length-1; i >= 0; i--) {
		//	groups.options[i] = null;
		//}
	}
}

function savePermissions() {
	var roleList = document.roleSelectionForm.role;
	document.permissionForm.role.value = roleList[roleList.selectedIndex].value;
	document.permissionForm.submit();
}