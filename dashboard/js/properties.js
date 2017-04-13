// imports
var Dom = YAHOO.util.Dom;
var Event = YAHOO.util.Event;
var DataSource = YAHOO.util.DataSource;
var DataTable = YAHOO.widget.DataTable;
var SimpleDialog = YAHOO.widget.SimpleDialog;
var Connect = YAHOO.util.Connect;

// Global Variables
var tabs;
var applicationPropertyTable;
var globalPropertyTable;
var applicationPropertyTable;
var confirmDeleteDialog;
		

function tabPropertyChangeHandler() {
	var index = tabs.get("activeIndex");
	if (index == 0)
		Dom.get("tabView").value = "global";
	else if (index == 1)
		Dom.get("tabView").value = "application";
}

function appChosenForProperty() {
	document.applicationSelectionForm.submit();
}

function globalPropertyTableClick() {
	var data = globalPropertyTable.getRecord(globalPropertyTable.getSelectedRows()[0]);
	document.deleteGlobalPropertyForm.mappingid.value = data.getData().mappingId;
	document.deleteGlobalPropertyForm.submitButton.disabled = false;
	
	// Set the data from the selection to the form
	document.addGlobalPropertyForm.mappingid.value = data.getData().mappingId;
	document.addGlobalPropertyForm.property.selectedIndex = getIndex(document.addGlobalPropertyForm.property.options, data.getData().property);
	document.addGlobalPropertyForm.value.value = data.getData().value;
	document.addGlobalPropertyForm.instidq.value = data.getData().instidq;
	document.addGlobalPropertyForm.instid.value = data.getData().instid;
	document.addGlobalPropertyForm.instcd.value = data.getData().instcd;
	document.addGlobalPropertyForm.description.value = data.getData().description;
	
	// Enable/disable buttons
	document.addGlobalPropertyForm.action.value = 'update';
	document.addGlobalPropertyForm.submitButton.value = 'Save';
	document.addGlobalPropertyForm.cancelButton.style.visibility = 'visible';
	
	onAddGlobalPropertyChange();
}

function applicationPropertyTableClick() {
	var data = applicationPropertyTable.getRecord(applicationPropertyTable.getSelectedRows()[0]);
	document.deleteApplicationPropertyForm.mappingid.value = data.getData().mappingId;
	document.deleteApplicationPropertyForm.submitButton.disabled = false;
	
	// Set the data from the selection to the form
	document.addApplicationPropertyForm.mappingid.value = data.getData().mappingId;
	document.addApplicationPropertyForm.property.selectedIndex = getIndex(document.addGlobalPropertyForm.property.options, data.getData().property);
	document.addApplicationPropertyForm.value.value = data.getData().value;
	document.addApplicationPropertyForm.instidq.value = data.getData().instidq;
	document.addApplicationPropertyForm.instid.value = data.getData().instid;
	document.addApplicationPropertyForm.instcd.value = data.getData().instcd;
	document.addApplicationPropertyForm.description.value = data.getData().description;
	
	// Enable/disable buttons
	document.addApplicationPropertyForm.action.value = 'update';
	document.addApplicationPropertyForm.submitButton.value = 'Save';
	document.addApplicationPropertyForm.cancelButton.style.visibility = 'visible';
	
	onAddApplicationPropertyChange();
}

function cancelGlobalUpdateProperty() {
	
	document.addGlobalPropertyForm.mappingid.value = "0";
	document.addGlobalPropertyForm.property.selectedIndex = 0;
	document.addGlobalPropertyForm.value.value = "";
	document.addGlobalPropertyForm.instidq.value = "";
	document.addGlobalPropertyForm.instid.value = "";
	document.addGlobalPropertyForm.instcd.value = "";
	document.addGlobalPropertyForm.description.value = "";
	
	document.addGlobalPropertyForm.action.value = 'add';
	document.addGlobalPropertyForm.submitButton.value = 'Add Property';
	document.addGlobalPropertyForm.cancelButton.style.visibility = 'hidden';
}

function cancelApplicationUpdateProperty() {
	
	document.addApplicationPropertyForm.mappingid.value = "0";
	document.addApplicationPropertyForm.property.selectedIndex = 0;
	document.addApplicationPropertyForm.value.value = "";
	document.addApplicationPropertyForm.instidq.value = "";
	document.addApplicationPropertyForm.instid.value = "";
	document.addApplicationPropertyForm.instcd.value = "";
	document.addApplicationPropertyForm.description.value = "";
	
	document.addApplicationPropertyForm.action.value = 'add';
	document.addApplicationPropertyForm.submitButton.value = 'Add Property';
	document.addApplicationPropertyForm.cancelButton.style.visibility = 'hidden';
}

function initPropertyTables() {
	
	// Group Property Table
	var keys = [ 
			 { key: "mappingId"},
			 { key: "PROPERTY" },
			 { key: "VALUE" },
			 { key: "INSTIDQ" },
			 { key: "INSTID" },
			 { key: "INSTCD" },
			 { key: "DESCRIPTION" }
		   ];
	var columnDefs = [ 
					{ key: "PROPERTY", width: 110, sortable: true },
					{ key: "VALUE", width: 78, sortable: true },
					{ key: "INSTIDQ", width: 78, sortable: true },
					{ key: "INSTID", width: 79, sortable: true },
					{ key: "INSTCD", width: 79, sortable: true },
					{ key: "DESCRIPTION", width: 200, sortable: true }
				 ];
	var dataSource = new DataSource(Dom.get("applicationPropertyTable"));
	dataSource.responseType = DataSource.TYPE_HTMLTABLE;
	dataSource.responseSchema = { fields: keys };
	applicationPropertyTable = new DataTable("applicationPropertyContainer", columnDefs, dataSource,
			{ scrollable: true,
			   width: "750px",
			   height: "125px",
			   selectionMode: "single" });
	applicationPropertyTable.subscribe("rowClickEvent", applicationPropertyTable.onEventSelectRow);
	applicationPropertyTable.subscribe("rowClickEvent", applicationPropertyTableClick);
	
	
	
	dataSource = new DataSource(Dom.get("globalPropertyTable"));
	dataSource.responseType = DataSource.TYPE_HTMLTABLE;
	dataSource.responseSchema = { fields: keys };
	globalPropertyTable = new DataTable("globalPropertyContainer", columnDefs, dataSource,
			{ scrollable: true,
			   width: "750px",
			   height: "125px",
			   selectionMode: "single" });
	globalPropertyTable.subscribe("rowClickEvent", globalPropertyTable.onEventSelectRow);
	globalPropertyTable.subscribe("rowClickEvent", globalPropertyTableClick);
}

function onAddGlobalPropertyChange() {
	var property = document.addGlobalPropertyForm.property;
	var value = document.addGlobalPropertyForm.value;
	var instidq = document.addGlobalPropertyForm.instidq;
	var instid = document.addGlobalPropertyForm.instid;
	var instcd = document.addGlobalPropertyForm.instcd;
	var description = document.addGlobalPropertyForm.description;
	var submitButton = document.addGlobalPropertyForm.submitButton;
	
	value.disabled = false;
	description.disabled = false;
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

function onAddApplicationPropertyChange() {
	var property = document.addApplicationPropertyForm.property;
	var value = document.addApplicationPropertyForm.value;
	var instidq = document.addApplicationPropertyForm.instidq;
	var instid = document.addApplicationPropertyForm.instid;
	var instcd = document.addApplicationPropertyForm.instcd;
	var description = document.addApplicationPropertyForm.description;
	var submitButton = document.addApplicationPropertyForm.submitButton;
	
	value.disabled = false;
	description.disabled = false;
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