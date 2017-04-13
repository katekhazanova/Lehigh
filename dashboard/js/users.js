
var deleteDialog;
var userTable;

$(document).ready(function() {
	userTable = $('#userTable').dataTable( {
		"sDom": 'rt<"bottom"flip<"clear">',
		"bLengthChange":false,
		"aaSorting": [[ 6, "asc" ]],
		"aoColumns": [null,null,null,null,null]
	} );
	
	
	$("#userTable tbody").delegate("tr", "click", function() {
		
		$("#userTable tbody tr").removeClass('active');  
		$(this).addClass('active');
		
		var iPos = userTable.fnGetPosition( this );
		if(iPos!=null){
			
			 var aData = userTable.fnGetData( iPos )
			$('#usernameField').val(aData[2]);
			$('#editUserButton').removeAttr("disabled");
			$('#deleteUserButton').removeAttr("disabled");
			$('#cloneUserButton').removeAttr("disabled");
		}
	});
	
	deleteDialog = new YAHOO.widget.SimpleDialog("deleteDialog",
			{	width: "325px",
				fixedcenter: true,
				visible: false,
				draggable: true,
				close: true,
				text: "Are you sure you want to delete this user?",
				icon: YAHOO.widget.SimpleDialog.ICON_HELP,
				constrainttoviewport: true,
				buttons: [ { text: "Yes", 	 handler: deleteUser },
						   { text: "Cancel", handler: cancelDeletion, isDefault: true } ]
			});
	
	deleteDialog.setHeader("Delete User Confirmation");
	deleteDialog.render(document.body);
} );

function searchSubmit() {
	
	//clear the select user
	$('#usernameField').val(''); 
	
	$.ajax({
		type: "POST",
		url: "userlist.ajax",
		data: {
			'first' : $('#firstNameFilter').val(),
			'last' : $('#lastNameFilter').val(),
			'username' : $('#usernameFilter').val(),
			'sisid' : $('#sisidFilter').val(),
			'group' : $('#groupFilter').val(),
			'email' : $('#emailFilter').val()
		},
		dataType: "json",
		success: function(data){
			/* Example call to load a new file */
			userTable.fnClearTable();
			userTable.fnAddData(data.aaData); //the data part of your json message
			userTable.fnDraw();
		}
		});
}

function addButtonClicked() {
	Dom.get("usernameField").value = "";
	document.editUserForm.action.value = "new";
	document.editUserForm.submit();
}

function deleteButtonClicked() {
	if ($('#usernameField').val() != "") {
		deleteDialog.show();
	}
}

function deleteUser() {		
	deleteDialog.hide();
	document.editUserForm.action.value = "delete";
	document.editUserForm.submit();
}

function cancelDeletion() {
	deleteDialog.hide();
}

function cloneButtonClicked() {
	if ($('#usernameField').val() != "") {
		document.editUserForm.action.value = "clone";
		document.editUserForm.submit();
	}
}

function checkEnter(e){ 				// e is event object passed from function invocation
	var characterCode = e.keyCode;
	if(characterCode == 13){ 			// if character code is equal to ascii 13 (if enter key)
		searchSubmit();
		return false;
	}
	else {
		return true; 					// return true to the event handler
	}
}
