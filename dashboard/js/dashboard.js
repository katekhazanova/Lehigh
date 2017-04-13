function mouseOverImage(imgSrc) {
	var image = imgSrc.src;
	image = image.substring(0, image.lastIndexOf("-"));
	imgSrc.src = image + "-mouseover.gif";
}

function mouseOutImage(imgSrc) {
	var image = imgSrc.src;
	image = image.substring(0, image.lastIndexOf("-"));
	imgSrc.src = image + "-normal.gif";
}

function initSearchFields() {
	var form = document.userSearchForm;
	var search = form.lastNameFilter;
	if (search.value == "Last Name")
		search.className = "emptySearch"
	else
		search.className = "";
	
	search = form.usernameFilter;
	if (search.value == "Username")
		search.className = "emptySearch";
	else
		search.className = "";
		
	search = form.sisFilter;
	if (search.value == "SIS ID")
		search.className = "emptySearch";
	else
		search.className = "";
}

function initIntroTabs() {
	var tabs = new YAHOO.widget.TabView("directionsTab");
}

function onAddPropertyChange() {
	var property = document.addPropertyForm.property;
	var value = document.addPropertyForm.value;
	var instidq = document.addPropertyForm.instidq;
	var instid = document.addPropertyForm.instid;
	var instcd = document.addPropertyForm.instcd;
	var description = document.addPropertyForm.description;
	var submitButton = document.addPropertyForm.submitButton;

	if (property.value == 'SECURE_IMPORT' || property.value == 'SECURE_LOGIN') {
		value.disabled = true;
		description.disabled = true;
		instidq.disabled = false;
		instid.disabled = false;
		instcd.disabled = false;
	}
	else if (property.value == 'SECURE_SOPRID' || property.value == 'SECURE_UPDATEPIN') {
		value.disabled = false;
		description.disabled = true;
		instidq.disabled = false;
		instid.disabled = false;
		instcd.disabled = false;
	}
	else if (property.value == 'INSTITUTION' || property.value == 'INSTITUTION CODE') {
		value.disabled = true;
		instidq.disabled = false;
		instid.disabled = false;
		instcd.disabled = false;
	}
	else if (property.value == 'EXCEPTION') {
		value.disabled = false;
		instidq.disabled = false;
		instid.disabled = false;
		instcd.disabled = false;
	}  
	else if (property.value != '') {
		value.disabled = false;
		instidq.disabled = true;
		instid.disabled = true;
		instcd.disabled = true;
	}
	 
}

function userPropertyTableClick() {
	var data = userPropertyTable.getRecord(userPropertyTable.getSelectedRows()[0]);
	propertyTableClick(data);
}

function groupPropertyTableClick() {
	var data = groupPropertyTable.getRecord(groupPropertyTable.getSelectedRows()[0]);
	propertyTableClick(data);
}

function propertyTableClick(data){
	document.deletePropertyForm.mappingid.value = data.getData().mappingId;
	document.deletePropertyForm.submitButton.disabled = false;
	
	// Set the data from the selection to the form
	document.addPropertyForm.mappingid.value = data.getData().mappingId;
	document.addPropertyForm.property.selectedIndex = getIndex(document.addPropertyForm.property.options, data.getData().property);
	document.addPropertyForm.value.value = data.getData().value;
	document.addPropertyForm.instidq.value = data.getData().instidq;
	document.addPropertyForm.instid.value = data.getData().instid;
	document.addPropertyForm.instcd.value = data.getData().instcd;
	document.addPropertyForm.description.value = data.getData().description;	
	
	// Enable/disable buttons
	document.addPropertyForm.action.value = 'update';
	document.addPropertyForm.submitButton.value = 'Save';
	document.addPropertyForm.cancelButton.style.visibility = 'visible';
	
	onAddPropertyChange();
}

function validateProperty(form) {
	
	if (form.property.value == 'INSTITUTION' || form.property.value == 'INSTITUTION CODE') {
	
		if (form.instid.value == '' && form.description.value != '') {
			alert('Missing required INSTID code.');
			return false;
		} 
		else if (form.instid.value != '' && form.description.value == '') {
			alert('Missing required description.');
			return false;
		}
		else if (form.instid.value == '' && form.description.value == '') {
			alert('Missing required INSTID code and description.');
			return false;
		}
		else {
			return true;
		}
		
	} 
	else if (form.property.value == 'SECURE_LOGIN' || form.property.value == 'SECURE_IMPORT') {
	
		if (form.instidq.value == '') {
			alert('Missing required INSTIDQ code.');
			return false;
		}
		else if (form.instid.value == '') {
			alert('Missing required INSTID code.');
			return false;
		}
		else {
			return true;
		}
	
	}
	else if (form.property.value == 'SECURE_SOPRID') {
	
		if (form.value.value == '') {
			alert('Missing required value.');
			return false;
		}
		else if (form.instidq.value == '') {
			alert('Missing required INSTIDQ code.');
			return false;
		}
		else if (form.instid.value == '') {
			alert('Missing required INSTID code.');
			return false;
		}
		else {
			return true;
		}
	
	}
	else if (form.property.value == 'SECURE_UPDATEPIN') {
	
	    var v = form.value.value.toUpperCase();
	    form.value.value = v; 
		if (v != 'Y' && v != 'N') {
			alert('Update pin value must be Y or N.');
			return false;
		}
		else if (form.instidq.value == '') {
			alert('Missing required INSTIDQ code.');
			return false;
		}
		else if (form.instid.value == '') {
			alert('Missing required INSTID code.');
			return false;
		}
		else {
			return true;
		}
		
	}
	else if (form.property.value != '') {
	
		if (form.value.value == '' && form.description.value != '') {
			alert('Missing required value.');
			return false;
		}
		else if (form.value.value != '' && form.description.value == '') {
			alert('Missing required description.');
			return false;
		}
		else if (form.value.value == '' && form.description.value == '') {
			alert('Missing required value and description.');
			return false;
		}
		else {
			return true;
		}
		
	}
	
}

function cancelUpdateProperty() {
	
	document.addPropertyForm.mappingid.value = "0";
	document.addPropertyForm.property.selectedIndex = 0;
	document.addPropertyForm.value.value = "";
	document.addPropertyForm.instidq.value = "";
	document.addPropertyForm.instid.value = "";
	document.addPropertyForm.instcd.value = "";
	document.addPropertyForm.description.value = "";
	
	document.addPropertyForm.action.value = 'add';
	document.addPropertyForm.submitButton.value = 'Add Property';
	document.addPropertyForm.cancelButton.style.visibility = 'hidden';
	
}

function getIndex(list, val) {

	for (var i=0; i<list.length; i++) {
		var v = list[i].text.trim();
		if (v == val.trim()) {
			return i;
		}
	}
	
	return -1;
}


var loadingBarDialog;

function createLoadingBar(){
	if (!loadingBarDialog) {
		
		loadingBarDialog = new YAHOO.widget.Dialog('loadingBarDiv', {
			visible: false,
		    fixedcenter :true,
		    constraintoviewport :true,
		    modal :true
		});
		loadingBarDialog.render();
	}
}

function showLoadingBar() {
	loadingBarDialog.show();
}

function hideLoadingBar() {
	if (loadingBarDialog) {
		loadingBarDialog.hide();
	}
}

function searchFocused(searchField, searchType) {
	if (searchField.className == "emptySearch") {
		searchField.value = "";
		searchField.className = "";
	}
}

function searchLostFocus(searchField, searchType) {
	if (searchField.value == "") {
		searchField.className = "emptySearch";
		searchField.value = searchType;
	}
}

function loadTables(){
	$('#comment-table').dataTable({
		"aaSorting": [[ 3, "desc" ]],
		"aoColumns": [
			null,
			null,
			null,
			null
		],
		"sDom": 'rt<"bottom"flip<"clear">',
		bLengthChange:false
	} );
}
