// Update the Udirect Markers inputs
function updateUdirectMarkers(markers) {
	// The data structure is as follows:
	// [{udirectMarker:
	//		{markerValue, replacementValue, type, catalogYear}
	//	}]
	
	var htmlBuffer = [];
	for (var i = 0; i < markers.length; i++) {
		htmlBuffer.push('<input type="hidden" name="markerValue' + i + '" value="' + markers[i].udirectMarker.markerValue + '" />');
		htmlBuffer.push('<input type="hidden" name="replacementValue' + i + '" value="' + markers[i].udirectMarker.replacementValue + '" />');
		htmlBuffer.push('<input type="hidden" name="type' + i + '" value="' + markers[i].udirectMarker.type + '" />');
		htmlBuffer.push('<input type="hidden" name="catalogYear' + i + '" value="' + markers[i].udirectMarker.catalogYear + '" />');
	}
	$j( '.markerButtonUL' ).append(htmlBuffer.join(''));
}

// Updates Add Markers buttons.
function updateAddMarkersButtons(data, auditDelimiter, pad)
{
	// The data structure is as follows:
	// {{markers:
	//		[{marker:
	//			{label, element, isFirstDprogType, isRequired, intSeqNo, actualChildren[...], possibleChildren[...]}
	//		}]
	// },
	// wetaIntSeqNo,
	// catalogYear,
	// wetaLabel,
	// wetaDisplayLabel,
	// wetaDisplayCatalogYear}
	var markersData = data.markers;
	var required = [];
	var nonRequired = [];
	var htmlBuffer = [];
	for (var i = 0; i < markersData.length; i++) {
		if (markersData[i].marker.isFirstDprogType == "true" && markersData[i].marker.possibleChildren.length > 0) {
			if (markersData[i].marker.isRequired == "true") {
				required[required.length] = i;
			} else {
				nonRequired[nonRequired.length] = i;
			}
		}
	}
	htmlBuffer.push('<li><span style="padding-left: ' + (pad + 25) + 'px;">');
	htmlBuffer.push('<input type="hidden" id="requiredMarker" name="requiredMarker" value="" />');
	if (required.length) {
		for (var i = 0; i < required.length; i++) {
			htmlBuffer.push('<input type="hidden" class="requiredMarker" name="" value="" />');
			if (i == 0) {
				htmlBuffer.push('<label style="color: red">Add Required:   </label>');
			}
			htmlBuffer.push('&nbsp;<input type="button" class="btn btn-default btn-xs cancel" value="' + markersData[required[i]].marker.label +
			'" id="addChild" name="addChild' + auditDelimiter + markersData[required[i]].marker.label + '" onclick="addMarker' +
			'(\'' + data.wetaIntSeqNo + '\', \'' + markersData[required[i]].marker.intSeqNo +	'\', \'' + data.catalogYear + '\')" />');
		}
	} else {
		for (var i = 0; i < nonRequired.length; i++) {
			if (i == 0) {
				htmlBuffer.push('<label>Add:   </label>');
			}
			htmlBuffer.push('&nbsp;<input type="button" class="btn btn-default btn-xs cancel" value="' + markersData[nonRequired[i]].marker.label +
			'" id="addChild" name="addChild' + auditDelimiter + markersData[nonRequired[i]].marker.label + '" onclick="addMarker' +
			'(\'' + data.wetaIntSeqNo + '\', \'' + markersData[nonRequired[i]].marker.intSeqNo + '\', \'' + data.catalogYear + '\')" />');
		}
	}
	htmlBuffer.push('</span></li>');

	$j( '.markerButtonUL' ).append(htmlBuffer.join(''));
}

// Updates remove child markers buttons
function updateRemoveChildMarkersButtons(data, auditDelimiter, pad)
{
	// The data structure is as follows:
	// {{markers:
	//		[{marker:
	//			{label, element, isFirstDprogType, isRequired, intSeqNo, actualChildren[...], possibleChildren[...]}
	//		}]
	// },
	// wetaIntSeqNo,
	// catalogYear,
	// wetaLabel,
	// wetaDisplayLabel,
	// wetaDisplayCatalogYear}
	
	if (data.wetaIntSeqNo != null) {
		
		var markersData = data.markers;
		var htmlBuffer = [];
		htmlBuffer.push('<li><br/>');	
		htmlBuffer.push('<span style="padding-left: ' + pad + 'px; display: inline-block">');
		htmlBuffer.push('<label>');
		if (data.wetaLabel != null) {
			htmlBuffer.push(data.wetaLabel);
		}
		htmlBuffer.push(':</label>');
		htmlBuffer.push('<span class="marker">' + data.wetaDisplayLabel + '</span>&nbsp;' + data.wetaDisplayCatalogYear + '&nbsp;');
		htmlBuffer.push('<button class="btn btn-danger btn-xs cancel" onclick="removeChildMarker(\'' + 
		data.wetaIntSeqNo + '\')" type="button" id="removeChild" name="removeChild' + auditDelimiter + 
		data.wetaIntSeqNo + '" ><i class="fa fa-trash-o"><span class="sr-only">Delete</span></i></button>');
		htmlBuffer.push('</span></li>');
		
		$j( '.markerButtonUL' ).append(htmlBuffer.join(''));
		
		// update buttons
		updateAddMarkersButtons(data, auditDelimiter, pad);
		
		// display children
		for (var i = 0; i < markersData.length; i++) {
			for (var j = 0; j < markersData[i].marker.actualChildren.length; j++) {
				updateRemoveChildMarkersButtons(markersData[i].marker.actualChildren[j], 
						auditDelimiter, pad + 50);
			}
		}
	
	}
	
	return true;
}

// Updates/overwrites the left hand side of Markers page
function updateLeftMarkers(data)
{
	// The data structure is as follows:
	// {{markers:
	//		[{marker:
	//			{label, element, isFirstDprogType, isRequired, intSeqNo, actualChildren[...], possibleChildren[...]}
	//		}]
	// },
	// wetaIntSeqNo,
	// catalogYear,
	// wetaLabel,
	// wetaDisplayLabel,
	// wetaDisplayCatalogYear,
	// catalogYearTerm, //only on root
	// auditDelimiter, //only on root
	// {udirectMarkers: //only on root
	// 		[{udirectMarker: //only on root
	//			[markerValue, replacementValue, type, catalogYear] //only on root
	//		}] //only on root
	// }} //only on root
	
	var markersData = data.markers;
	var auditDelimiter = data.auditDelimiter;
	
	// clear the html
	$j( '.markerButtonUL' ).html( '<li><br/></li>' );
	
	// update udirect markers
	updateUdirectMarkers(data.udirectMarkers);
	
	// update buttons
	updateAddMarkersButtons(data, auditDelimiter, 0);
	
	var disableAudit = needsRequiredMarkers(data);
	$j('#disableAudit').each(function() {
		$j(this).val(disableAudit);
	});
	
	// display children
	for (var i = 0; i < markersData.length; i++) {
		for (var j = 0; j < markersData[i].marker.actualChildren.length; j++) {
			updateRemoveChildMarkersButtons(markersData[i].marker.actualChildren[j], 
					auditDelimiter, 50);
		}
	}	
	if ( $j( '#requiredMarker' ).length > 0) {
		$j( 'form[name="auditRequest"]' ).validate();
		$j( '#requiredMarker' ).valid();
	}
}

// Updates/overwrites the right hand side of Markers page
function updateRightMarkers(data)
{
	// The data structure is as follows:
	// {forcedCatalogYear,
	// pickedCatalogYear,
	// {addList:
	//		[{add:{
	//			dprog, columns:[]
	//		}}]
	// },
	// addLabel,
	// {newMarkers:
	//		{parentWetaId, wetaId}
	// },
	// auditDelimiter,
	// {catalogYearTerms:
	//		[{option:
	//			{name, label}
	//		}]
	// }}
	var htmlBuffer = [];
	htmlBuffer.push('<h3>Adding a ' + data.addLabel + ': </h3><table class="verticalListing" width="100%">');
	if (data.forcedCatalogYear != "true") {
		htmlBuffer.push('<tr><td width="100%"><label for="newMarker.catalogYear">' + $j( '#addCatalogYearMessage' ).html() + '</label>');
		htmlBuffer.push('<select class="form-control" name="newMarker.catalogYear" id="newMarker.catalogYear" onchange="addMarkerSelect');
		htmlBuffer.push('(\'' + data.newMarkers.parentWetaId + '\', \'' + data.newMarkers.wetaId + '\')">');
		
		for (var i = 0; i < data.catalogYearTerms.length; i++) {
			htmlBuffer.push('<option value="' + data.catalogYearTerms[i].option.name +
					data.auditDelimiter + data.catalogYearTerms[i].option.label + '" ');
			if (data.pickedCatalogYear == data.catalogYearTerms[i].option.name) {
				htmlBuffer.push('selected="selected"');
			}
			htmlBuffer.push('>' + data.catalogYearTerms[i].option.label + '</option>');		
		}
		htmlBuffer.push('</select><input type="hidden" name="lastCY" id = "lastCY" value="' + data.pickedCatalogYear + '" />');
		htmlBuffer.push('<span id="newMarker.catalogYear_spinner">&nbsp;</span></td></tr>');
	}
	htmlBuffer.push('<tr><td width="100%"><br/><label for="newMarker.replacementValue">' + data.addLabel + ': </label>');
	htmlBuffer.push('<select class="form-control"  name="newMarker.replacementValue" id="newMarker.replacementValue" onchange="addMarkerReplacementValue');
	if (data.forcedCatalogYear != "true") {
		htmlBuffer.push('()">');
	} else {
		htmlBuffer.push('ForceCY(\'' + $j( '#catalogYearTerm' ).val() + '\')">');
	}
	htmlBuffer.push('<option value="" selected="true">-      </option>');
	for (var i = 0; i < data.addList.length; i++) {
		htmlBuffer.push('<option value="' + data.addList[i].add.dprog + '">');
		for (var j = 0; j < data.addList[i].add.columns.length; j++) {
			if (j != 0) {				
				htmlBuffer.push(' - ');
			}
			htmlBuffer.push(data.addList[i].add.columns[j]);
		}
		htmlBuffer.push('</option>');
	}
	htmlBuffer.push('</select>');
	htmlBuffer.push('<span id="newMarker.replacementValue_spinner">&nbsp;</span></td>');
	htmlBuffer.push('<td><br/><input class="btn btn-warning btn-xs cancel" type="button" name="cancelAdd" value="Never mind" onclick="cancelAddMarker()" /></td></tr></table>');	

	$j( '.right' ).html(htmlBuffer.join(''));
}

// Updates the What if top inputs
function updateWhatIfTop(data, showBreadCrumb)
{
	// The data structure is as follows:
	// {institutionsData:
	// 		{instcd,	
	//		currentDisplay,	
	//		currentValue,		
	//		{institutions:
	//			[{instcd:
	//				{name, code}
	//			}]
	//		},
	//		showInstcd}
	// }
	
	var htmlBuffer = [];
	htmlBuffer.push('<tr>');
	if (data.institutions.length == 1) {
		htmlBuffer.push('<td><input type="hidden" name="instcd" value="' + data.institutions[0].instcd.code + '" /></td>');
	} else {
		htmlBuffer.push('<th><label for="instcd">School</label></th><td>');
		if (data.currentValue.length > 0) {
			htmlBuffer.push('<input type="hidden" name="previousInstcd" value="' + data.currentValue + '" />');
		}
		if (showBreadCrumb) {
			htmlBuffer.push('<span class="marker">' + data.currentValue + '<strong> -</strong>' + data.currentDisplay + '</span>');
			htmlBuffer.push('<input type="hidden" name="instcd" id="instcd" value="' + data.currentValue + '"/>');
		} else {
			htmlBuffer.push('<select class="form-control maxWidth"  name="instcd" id="instcd" onchange="setInstitution()" >');
			for (var i = 0; i < data.institutions.length; i++) {
				htmlBuffer.push('<option value="' + data.institutions[i].instcd.code + '" ');
				if (data.institutions[i].instcd.code == data.instcd) {
					htmlBuffer.push('selected=true"');
				}
				htmlBuffer.push('>');
				if (data.showInstcd) {
					htmlBuffer.push(data.institutions[i].instcd.code + ' - ' + data.institutions[i].instcd.name);
				} else {
					htmlBuffer.push(data.institutions[i].instcd.name);
				}
				htmlBuffer.push('</option>');
			}
			htmlBuffer.push('</select><span id="instcd_spinner">&nbsp;</span>');
		}
		htmlBuffer.push('</td>');
	}
	htmlBuffer.push('</tr>');
	return htmlBuffer.join('');
}

// Updates the Dropdown dprog entry
function updateDropdown(dprogData, showBreadCrumb)
{
	// The data structure is as follows:
	// {dprogData:
	// 		strategy:DROPDOWN,	
	//		auditRequestDegreeLabel,
	//		currentDisplay,	
	//		currentValue,		
	//		whatIfDegreeProgram,
	//		{dprogOptions:
	//			[{option:
	//				{name, label}
	//			}]
	//		}}
	// }
	var htmlBuffer = [];
	if (showBreadCrumb) {
		htmlBuffer.push('<input type="hidden" name="previousWhatIfDegreeProgram" value="' + dprogData.currentValue + '" />');
		htmlBuffer.push('<input type="hidden" id="whatIfDegreeProgram" name="whatIfDegreeProgram" value="' + dprogData.whatIfDegreeProgram + '" />');
		htmlBuffer.push('<input type="hidden" name="auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentDisplay" value="' +
				dprogData.currentDisplay + '" />');
		htmlBuffer.push('<span class="marker">' + dprogData.currentDisplay + '</span>')
	} else {
		if (dprogData.dprogOptions.length == 0) {
			htmlBuffer.push('<p class="notice">No degree programs found for this school.</p>');
		} else if (dprogData.dprogOptions.length == 1) {
			htmlBuffer.push('<input type="hidden" name="whatIfDegreeProgram" id="whatIfDegreeProgram" value="' +
					dprogData.whatIfDegreeProgram + '" />');
			htmlBuffer.push('<span class="marker">' + dprogData.currentDisplay + '</span>');
		} else {
			if ( dprogData.whatIfDegreeProgram != "" ) {
				htmlBuffer.push('<input type="hidden" name="previousWhatIfDegreeProgram" value="' + dprogData.whatIfDegreeProgram + '" />');
			}
			htmlBuffer.push('<select class="form-control maxWidth"  name="whatIfDegreeProgram" id="whatIfDegreeProgram" ' + 
					'onchange="setDegreeProgram()" >');
			htmlBuffer.push('<option value="">-</option>');
			for (var i = 0; i < dprogData.dprogOptions.length; i++) {
				htmlBuffer.push('<option value="' + dprogData.dprogOptions[i].option.name + '" ');
				if (dprogData.dprogOptions[i].option.name == dprogData.whatIfDegreeProgram) {
					htmlBuffer.push('selected="selected"');
				}
				htmlBuffer.push('>' + dprogData.dprogOptions[i].option.label + '</option>');
			}
			htmlBuffer.push('</select><span id="whatIfDegreeProgram">&nbsp;</span>');
		}
	}
	return htmlBuffer.join('');
}

// Updates the BreadCrumb for the cascade strategy
function updateBreadCrumb(data)
{	
	// The data structure is as follows:
	// {dprogData:
	// 		strategy:CASCADE,	
	//		college:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		major:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		degree:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		currentDisplay,	
	//		currentValue,		
	//		whatIfDegreeProgram,
	//		{dprogOptions:
	//			[{option:
	//				{name, label}
	//			}]
	//		}}
	// }
	var htmlBuffer = [];
	
	if (data.college.show=="true") {
		htmlBuffer.push('<input type="hidden" name="previousDegreeProgramCollege" value="' + data.college.currentValue + '" />');
		htmlBuffer.push('<input type="hidden" name="degreeProgramCollege" id="degreeProgramCollege" value="' + data.college.currentValue + '" />');
		htmlBuffer.push('<span class="marker">' + data.college.currentDisplay + '</span>');
	}
	if (data.major.show=="true") {
		htmlBuffer.push('<input type="hidden" name="previousDegreeProgramMajor" value="' + data.major.currentValue + '" />');
		htmlBuffer.push('<input type="hidden" name="degreeProgramMajor" id="degreeProgramMajor" value="' + data.major.currentValue + '" />');
		if (data.college.show=="true") {
			htmlBuffer.push('<strong> > </strong>');
		}
		htmlBuffer.push('<span class="marker">' + data.major.currentDisplay + '</span>');		
	}
	if (data.degree.show=="true") {
		htmlBuffer.push('<input type="hidden" name="previousDegreeProgramDegree" value="' + data.degree.currentValue + '" />');
		htmlBuffer.push('<input type="hidden" name="degreeProgramDegree" id="degreeProgramDegree" value="' + data.degree.currentValue + '" />');
		if (data.college.show=="true" || data.major.show=="true") {
			htmlBuffer.push('<strong> > </strong>');
		}
		htmlBuffer.push('<span class="marker">' + data.degree.currentDisplay + '</span>');	
	}
	htmlBuffer.push('<input type="hidden" name="previousWhatIfDegreeProgram" value="' + data.currentValue + '" />');
	htmlBuffer.push('<input type="hidden" name="whatIfDegreeProgram" value="' + data.whatIfDegreeProgram + '" />');
	htmlBuffer.push('<input type="hidden" name="auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentDisplay" value="' + data.currentDisplay + '" />');
	htmlBuffer.push('<span class="marker"> ' + data.currentDisplay + '</span>');
	return htmlBuffer.join('');
}

// Updates the Cascade dprog entry
function updateCascade(data, showBreadCrumb, disableAudit)
{
	// The data structure is as follows:
	// {dprogData:
	// 		strategy:CASCADE,	
	//		college:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		major:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		degree:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		currentDisplay,	
	//		currentValue,		
	//		whatIfDegreeProgram,
	//		{dprogOptions:
	//			[{option:
	//				{name, label}
	//			}]
	//		}}
	// }
	var dprogLineBreak = false;
	var htmlBuffer = [];
	
	if (showBreadCrumb) {
		htmlBuffer.push(updateBreadCrumb(data));				
		htmlBuffer.push('<input type="hidden" name="disableAudit" id="disableAudit" value="' + disableAudit + '">');
	} else {
		if (data.college.show=="true") {
			if (data.major.show=="true"||data.degree.show=="true") {
				htmlBuffer.push('<tr style="border-bottom:0px">');
			} else {
				htmlBuffer.push('<tr>');
			}
			htmlBuffer.push('<td valign="top" ><label for="degreeProgramCollege">' + $j('#collegeMessage').html() + '</label></td>');
			htmlBuffer.push('<td><input type="hidden" name="previousDegreeProgramCollege" value="' + data.college.degreeProgram + '" />');
			htmlBuffer.push('<select class="form-control"  name="degreeProgramCollege" id="degreeProgramCollege" onchange="setCollege()">');
			htmlBuffer.push(	'<option value="">-</option>');
			for (var i = 0; i < data.college.list.length; i++) {
				htmlBuffer.push('<option value="' + data.college.list[i] + '"');
				if (data.college.degreeProgram == data.college.list[i]) {
					htmlBuffer.push(' selected="true"');
				}
				htmlBuffer.push('>' + data.college.list[i] + '</option>');
			}
			htmlBuffer.push('</select><span id="degreeProgramCollege_spinner">&nbsp;</span></td></tr>');
			dprogLineBreak = true;
		}
		if (data.major.show=="true") {
			if (dprogLineBreak) {
				htmlBuffer.push('<br />');
			}			
			if (data.degree.show=="true") {
				htmlBuffer.push('<tr style="border-bottom:0px">');
			} else {
				htmlBuffer.push('<tr>');
			}
			htmlBuffer.push('<td valign="top" ><label for="degreeProgramMajor">Major:</label></td>');
			htmlBuffer.push('<td><input type="hidden" name="previousDegreeProgramMajor" value="' + data.major.degreeProgram + '" />');
			htmlBuffer.push('<select class="form-control"  name="degreeProgramMajor" id="degreeProgramMajor" onchange="setMajor()">');
			htmlBuffer.push(	'<option value="">-</option>');
			for (var i = 0; i < data.major.list.length; i++) {
				htmlBuffer.push('<option value="' + data.major.list[i] + '"');
				if (data.major.degreeProgram == data.major.list[i]) {
					htmlBuffer.push(' selected="true"');
				}
				htmlBuffer.push('>' + data.major.list[i] + '</option>');
			}
			htmlBuffer.push('</select><span id="degreeProgramMajor_spinner">&nbsp;</span></td></tr>');
			dprogLineBreak = true;
		}
		if (data.degree.show=="true") {
			if (dprogLineBreak) {
				htmlBuffer.push('<br />');
			}
			htmlBuffer.push('<tr><td valign="top" ><label for="degreeProgramDegree">Degree:</label></td>');
			htmlBuffer.push('<td><input type="hidden" name="previousDegreeProgramDegree" value="' + data.degree.degreeProgram + '" />');
			htmlBuffer.push('<select class="form-control"  name="degreeProgramDegree" id="degreeProgramDegree" onchange="setDegree()">');
			htmlBuffer.push(	'<option value="">-</option>');
			for (var i = 0; i < data.degree.list.length; i++) {
				htmlBuffer.push('<option value="' + data.degree.list[i] + '"');
				if (data.degree.degreeProgram == data.degree.list[i]) {
					htmlBuffer.push(' selected="true"');
				}
				htmlBuffer.push('>' + data.degree.list[i] + '</option>');
			}
			htmlBuffer.push('</select><span id="degreeProgramDegree_spinner">&nbsp;</span></td></tr>');
		}
		htmlBuffer.push('<tr><td valign="top" ><br/><label for="whatIfDegreeProgram">Program: </label></td>');
		htmlBuffer.push('<td><br/><input type="hidden" name="previousWhatIfDegreeProgram" value="' + data.whatIfDegreeProgram + '" />')
		if (data.dprogOptions.length == 1 && data.whatIfDegreeProgram) {
			htmlBuffer.push('<input type="hidden" name="whatIfDegreeProgram" id="whatIfDegreeProgram" value="' + data.whatIfDegreeProgram + '" />');
			htmlBuffer.push('<span class="marker">' + data.currentDisplay + '</span>');
		} else {
			htmlBuffer.push('<select class="form-control"  name="whatIfDegreeProgram" id="whatIfDegreeProgram" ' + 
			'onchange="setDegreeProgram()" ><option value="">-</option>');
			if (data.dprogOptions.length) {
				for (var i = 0; i < data.dprogOptions.length; i++) {
					htmlBuffer.push('<option value="' + data.dprogOptions[i].option.name + '"');
					if (data.dprogOptions[i].option.name == data.whatIfDegreeProgram) {
						htmlBuffer.push(' selected="selected"');
					}
					htmlBuffer.push('>' + data.dprogOptions[i].option.label + '</option>');
				}					
			}
			htmlBuffer.push('</select><span id="whatIfDegreeProgram_spinner">&nbsp;</span>');
		}
		htmlBuffer.push('</td></tr>');
	}
	return htmlBuffer.join('');
}

//Updates the What if bottom inputs
function updateWhatIfBottom(catalogYearTermValues, showBreadCrumb)
{
	// The data structure is as follows:
	// {catalogYearTermValues:
	// 		{catalogYearTerm,
	//		currentDisplay,
	//		currentValue,
	//		multiCatalogYearTermsConfigured,
	//		{catalogYearTerms:
	//			[{catalogYearTerm:
	//				{label, name}
	//			}]
	//		},
	//		clearAll}
	// }
	var htmlBuffer = [];
	htmlBuffer.push('<tr><th>' + $j( '#addCatalogYearMessage' ).html() + '</th><td>');
	if (showBreadCrumb) {
		htmlBuffer.push('<span style="dispaly:block"><span class="marker">' + catalogYearTermValues.currentDisplay + '</span>');
		if (catalogYearTermValues.clearAll=="true") {
			htmlBuffer.push('<span style="float:right;margin-left: 15px;"><input class="btn btn-warning btn-xs cancel" ' + 
				'type="button" id="changeProgramButton" name="changeProgram" value="Clear Selections" onclick="setInstitution()"/></span></span>');
		} else { 
			htmlBuffer.push('<span style="float:right;margin-left: 15px;"><input class="btn btn-warning btn-xs cancel" ' + 
			'type="button" id="changeProgramButton" name="changeProgram" value="Clear Selections" onclick="setDegreeProgram()"/></span></span>');
		}
		htmlBuffer.push('<input type="hidden" name="catalogYearTerm" id="catalogYearTerm" value="' + catalogYearTermValues.currentValue + '" >');
		htmlBuffer.push('<input type="hidden" name="auditRequest.wifBreadcrumb.catalogYearTerm.currentDisplay" ' + 
				'id="auditRequest.wifBreadcrumb.catalogYearTerm.currentDisplay" value="' + catalogYearTermValues.currentDisplay + '" >');
	} else {
		if ( catalogYearTermValues.catalogYearTerms.length > 1 ) {
			htmlBuffer.push('<br/><select class="form-control" name="catalogYearTerm" id="catalogYearTerm" onchange="setCatalogYearTerm()" ><option value="">-</option>');
			for (var i = 0; i < catalogYearTermValues.catalogYearTerms.length; i++) {
				htmlBuffer.push('<option value="' + catalogYearTermValues.catalogYearTerms[i].catalogYearTerm.name + '" ');
				if (catalogYearTermValues.catalogYearTerm == catalogYearTermValues.catalogYearTerms[i].catalogYearTerm.name) {
					htmlBuffer.push('selected="selected"');
				}
				htmlBuffer.push('>' + catalogYearTermValues.catalogYearTerms[i].catalogYearTerm.label + '</option>');
			}
			htmlBuffer.push('</select>');
		} else {
			if (catalogYearTermValues.catalogYearTerms.length == 1) {
				htmlBuffer.push('<input type="hidden" name="catalogYearTerm" id="catalogYearTerm" value="' + 
						catalogYearTermValues.catalogYearTerms[0].catalogYearTerm.name + '" >');
				htmlBuffer.push('<span class="marker">' + catalogYearTermValues.catalogYearTerms[0].catalogYearTerm.label + '</span>');
			}
		}
		htmlBuffer.push('<span id="catalogYearTerm_spinner">&nbsp;</span>');
	}
	htmlBuffer.push('</td></tr>');
	return htmlBuffer.join('');
}

// Updates the Dprog/CatalogYear Whatif section
function updateWhatIfDprogCatYear(data)
{
	// The data structure is as follows:
	// {{institutionsData:
	// 		{instcd,	
	//		currentDisplay,	
	//		currentValue,		
	//		{institutions:
	//			[{instcd:
	//				{name, code}
	//			}]
	//		},
	//		showInstcd}
	// },
	// {dprogData:{stratigy:MANUAL}
	// }, OR
	// {dprogData:
	// 		{strategy:DROPDOWN,	
	//		auditRequestDegreeLabel,
	//		currentDisplay,	
	//		currentValue,		
	//		whatIfDegreeProgram,
	//		{dprogOptions:
	//			[{option:
	//				{name, label}
	//			}]
	//		}}
	// }, OR
	// {dprogData:
	// 		strategy:CASCADE,	
	//		college:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		major:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		degree:
	//			{show,degreeProgram,currentDisplay,currentValue,list[]},
	//		currentDisplay,	
	//		currentValue,		
	//		whatIfDegreeProgram,
	//		{dprogOptions:
	//			[{option:
	//				{name, label}
	//			}]
	//		}}
	// },
	// {catalogYearTermValues:
	// 		{catalogYearTerm,
	//		currentDisplay,
	//		currentValue,
	//		multiCatalogYearTermsConfigured,
	//		{catalogYearTerms:
	//			[{catalogYearTerm:
	//				{label, name}
	//			}]
	//		},
	//		clearAll}
	// },
	// {markerTree:
	// 		{{markers:
	//			[{marker:
	//				{label, element, isFirstDprogType, isRequired, intSeqNo, actualChildren[...], possibleChildren[...]}
	//			}]
	// 		},
	// 		wetaValue,
	// 		wetaIntSeqNo,
	// 		wetaElement,
	// 		catalogYear,
	// 		wetaLabel,
	// 		wetaDisplayLabel,
	// 		wetaDisplayCatalogYear,
	// 		catalogYearTerm,
	// 		whatIfDegreeProgram, 
	// 		auditDelimiter,
	// 		{udirectMarkers: 
	// 			[{udirectMarker: 
	//				{markerValue, replacementValue, type, catalogYear} 
	//			}] 
	// 		}}
	// }}
	
	var htmlBuffer = [];
	var showBreadCrumb = false;
	var disableAudit = needsRequiredMarkers(data.markerTree);
	htmlBuffer.push('<table class="verticalListing">');
	if (data.catalogYearTermValues.catalogYearTerm.length > 0 && data.dprogData.whatIfDegreeProgram.length > 0) {
		showBreadCrumb = true;
	}
	if (data.dprogData.strategy == "MANUAL") {
		showBreadCrumb = false;
	}
	htmlBuffer.push(updateWhatIfTop(data.institutionsData, showBreadCrumb));
	htmlBuffer.push('<tr style="border-bottom:0px"><th><label for="whatIfDegreeProgram">');
	htmlBuffer.push(data.dprogData.auditRequestDegreeLabel);
	htmlBuffer.push('</label></th><td>');
	if (data.dprogData.strategy == "MANUAL") {
		htmlBuffer.push('<input type="text" class="form-control" name="whatIfDegreeProgram" id="whatIfDegreeProgram" ');
		if (data.dprogData.length > 0) {
			htmlBuffer.push('value="' + data.dprogData.whatIfDegreeProgram + '"');
		}
		htmlBuffer.push(' />');
		htmlBuffer.push('<input type="hidden" name="disableAudit" id="disableAudit" value="false">');
	} else if (data.dprogData.strategy == "DROPDOWN") {
		if (showBreadCrumb) {										
			htmlBuffer.push('<input type="hidden" name="disableAudit" id="disableAudit" value="' + disableAudit + '">');
		}
		htmlBuffer.push(updateDropdown(data.dprogData, showBreadCrumb));	
	} else {
		htmlBuffer.push(updateCascade(data.dprogData, showBreadCrumb));				
	}
	htmlBuffer.push('</td></tr>' + updateWhatIfBottom(data.catalogYearTermValues, showBreadCrumb, disableAudit) +	'</table>');
	htmlBuffer.push('<ul class="markerButtonUL"></ul>');
	$j( 'td.left' ).html(htmlBuffer.join(''));
}

// Returns true if required markers still need to be set
function needsRequiredMarkers(markerTree) {
	// {markerTree:
	// 		{{markers:
	//			[{marker:
	//				{label, element, isFirstDprogType, isRequired, intSeqNo, actualChildren[...], possibleChildren[...]}
	//			}]
	// 		},
	// 		wetaValue,
	// 		wetaIntSeqNo,
	// 		wetaElement,
	// 		catalogYear,
	// 		wetaLabel,
	// 		wetaDisplayLabel,
	// 		wetaDisplayCatalogYear,
	// 		catalogYearTerm,
	// 		whatIfDegreeProgram, 
	// 		auditDelimiter,
	// 		{udirectMarkers: 
	// 			[{udirectMarker: 
	//				{markerValue, replacementValue, type, catalogYear} 
	//			}] 
	// 		}}
	// }}
	if (markerTree.markers.length) {
		for (var i = 0; i < markerTree.markers.length; i++) {
			if (markerTree.markers[i].marker.isFirstDprogType == "true" && 
					markerTree.markers[i].marker.possibleChildren.length > 0 &&
					markerTree.markers[i].marker.isRequired == "true") {
				return true;
			}
			for (var j = 0; j < markerTree.markers[i].marker.actualChildren.length; j++) {
				if (needsRequiredMarkers(markerTree.markers[i].marker.actualChildren[j])) {
					return true;
				}
			}
		}
	}
	return false;
}

// Sends a ajax request to remove selected child marker and receives a json object of the updated markers.
function removeChildMarker(intSeqNo)
{
	$j( '.right' ).html( '' );
	var json = {};
	json.intSeqNo = intSeqNo;
	$j.getJSON('removeChildMarker.html', json,
		function (data) {
			updateLeftMarkers(data);
			if ($j( '#removeChild' ).length > 0) {
				$j( '#removeChild' ).focus();
			} else {
				$j( '#addChild' ).focus();
			}
	});
}

// Removes the right hand side of the webpage without updating
function cancelAddMarker()
{
	$j( '.right' ).html( '' );
	$j( '#addChild' ).focus();
}

function addMarkerReplacementValueForceCY(catalogYear)
{
	$j( '#newMarker\\.replacementValue_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.catalogYear = catalogYear;
	json.replacementValue = $j( '#newMarker\\.replacementValue' ).val();
	$j.getJSON('addMarkerToSessionAjax.html', json,
		function (data) {
			updateLeftMarkers(data);
			$j( '.right' ).html( '' );
			if ($j( '#addChild' ).length > 0) {
				$j( '#addChild' ).focus();
			} else {
				$j( '#removeChild' ).focus();
			}
	});
}

// Add the replacement value of the marker and therefore the whole marker
function addMarkerReplacementValue()
{
	$j( '#newMarker\\.replacementValue_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.catalogYear = $j( '#newMarker\\.catalogYear' ).val();
	json.replacementValue = $j( '#newMarker\\.replacementValue' ).val();
	$j.getJSON('addMarkerToSessionAjax.html', json,
		function (data) {
			updateLeftMarkers(data);
			$j( '.right' ).html( '' );
			if ($j( '#addChild' ).length > 0) {
				$j( '#addChild' ).focus();
			} else {
				$j( '#removeChild' ).focus();
			}
	});
}

// Add a marker, request marker data (Gets the catalog year from the <select>
function addMarkerSelect(parentWetaId, wetaId)
{
	addMarker(parentWetaId, wetaId, $j( '#newMarker\\.catalogYear' ).val());
}

// Add a marker, request marker data
function addMarker(parentWetaId, wetaId, catalogYear)
{
	$j( '#newMarker\\.catalogYear_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.catalogKeyString = catalogYear;
	json.lastCY = $j( '#lastCY' ).val();
	json.parentWetaId = parentWetaId;
	json.wetaId = wetaId;
	$j.getJSON('addMarkerAjax.html', json,
		function (data) {
			$j( '#newMarker\\.catalogYear' ).blur();
			updateRightMarkers(data);
			if ($j( '#newMarker\\.catalogYear' ).length > 0) {
				$j( '#newMarker\\.catalogYear' ).focus();
			} else {
				$j( '#newMarker\\.replacementValue' ).focus();
			}
	});
}

// Set up What if Audit Data
function initializeWhatIfAudit()
{
	var json = {};
	$j.getJSON('initializeWhatIfAudit.html', json,
		function (data) {
			updateWhatIfDprogCatYear(data);
			updateLeftMarkers(data.markerTree);
	});
}

// Select Institution
function setInstitution()
{
	$j( '#instcd_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.instcd = $j( '#instcd' ).val();
	$j.getJSON('setInstitutionAjax.html', json,
		function (data) {
			$j( '#instcd' ).blur();
			updateWhatIfDprogCatYear(data);
			updateLeftMarkers(data.markerTree);
			$j( '#instcd' ).focus();
	});
}

//Select College
function setCollege()
{
	$j( '#degreeProgramCollege_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.college = $j( '#degreeProgramCollege' ).val();
	$j.getJSON('setCollegeAjax.html', json,
		function (data) {
			$j( '#degreeProgramCollege' ).blur();
			updateWhatIfDprogCatYear(data);
			updateLeftMarkers(data.markerTree);
			$j( '#degreeProgramCollege' ).focus();
	});
}

//Select Major
function setMajor()
{
	$j( '#degreeProgramMajor_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.major = $j( '#degreeProgramMajor' ).val();
	$j.getJSON('setMajorAjax.html', json,
		function (data) {
			$j( '#degreeProgramMajor' ).blur();
			updateWhatIfDprogCatYear(data);
			updateLeftMarkers(data.markerTree);
			$j( '#degreeProgramMajor' ).focus();
	});
}

//Select Degree
function setDegree()
{
	$j( '#degreeProgramDegree_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.degree = $j( '#degreeProgramDegree' ).val();
	$j.getJSON('setDegreeAjax.html', json,
		function (data) {
			$j( '#degreeProgramDegree' ).blur();
			updateWhatIfDprogCatYear(data);
			updateLeftMarkers(data.markerTree);
			$j( '#degreeProgramDegree' ).focus();
	});
}

// Select Degree Program
function setDegreeProgram()
{
	$j( '#whatIfDegreeProgram_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.whatIfDegreeProgram = $j( '#whatIfDegreeProgram' ).val();
	$j.getJSON('setDegreeProgramAjax.html', json,
		function (data) {
			$j( '#whatIfDegreeProgram' ).blur();
			updateWhatIfDprogCatYear(data);
			updateLeftMarkers(data.markerTree);
			$j( '#whatIfDegreeProgram' ).focus();
	});
}

// Select Catalog Year Term for Dprog
function setCatalogYearTerm()
{
	$j( '#catalogYearTerm_spinner' ).html( '<i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Refreshing' );
	var json = {};
	json.catalogYearTerm = $j( '#catalogYearTerm' ).val();
	$j.getJSON('setCatalogYearTermAjax.html', json,
		function (data) {
			$j( '#catalogYearTerm' ).blur();
			updateWhatIfDprogCatYear(data);
			updateLeftMarkers(data.markerTree);
			$j( '#changeProgramButton' ).focus();
	});
}

//Submits the Declared Programs
function runDeclaredPrograms() 
{
	// submit audit request
	$j( 'form[name="auditRequest"]' ).submit();
}

// Validates and submits the What if Audit
function runDifferentProgram() 
{
	// if audit is not disabled
	if ($j( '#disableAudit' ).length > 0 && $j( '#disableAudit' ).val() == "false") {
		// hide the error box
		$j( '#auditRunError' ).attr( 'tabindex', '-1' );
		$j( '#auditRunError' ).attr( 'aria-hidden', 'true' );
		$j( '#auditRunError' ).css( 'display', 'none' );
		
		// submit audit request
		$j( 'form[name="auditRequest"]' ).submit();
	} else {
		// show the error box
		$j( '#auditRunError' ).attr( 'tabindex', '0' );
		$j( '#auditRunError' ).attr( 'aria-hidden', 'false' );
		$j( '#auditRunError' ).css( 'display', 'inline-block' );
	}
}

function sendPlan() 
{
	applyValidation();

	$j( '#createPlanButton' ).attr( 'type', 'submit' );
	$j( '#createPlanButton' ).attr( 'onclick', '' );
	validateFields($j( '#requiredMarker' ).valid());
	if ($j( '#requiredMarker' ).valid()) {
		$j( '#createPlanButton' ).click();
		$j( 'form[name="auditRequest"]' ).submit();
	}
	$j( '#createPlanButton' ).attr( 'type', 'button' );
	$j( '#createPlanButton' ).attr( 'onclick', 'sendPlan()' );
}

function removeAccordianHrefKeyDown(event, selected, name, val, accordion) 
{
	switch(event.which) {
	case 32: // space
		e.preventDefault();
		removeAccordianHref(selected, name, accordion);
		break;
	
    default: 
   	   	return; // exit this handler for other keys
	}
}
	
function removeAccordianHref(selected, name, val, accordion) 
{
	$j( '#' + accordion ).find( '.panel-heading' ).find( 'a' ).each( function () {
			
		if ( $j( this ).attr( 'aria-controls' ) == selected ) {
			$j( '#useDefaultDegreePrograms' ).attr( 'value', val );
			$j( '#runAudit' ).attr( 'title', 'Run ' + name );
			$j( '#runAudit' ).attr( 'value', 'Run ' + name );
			$j( '#runAudit' ).html( 'Run ' + name );
			$j( '#runAudit' ).attr( 'onclick', 'run' + name.replace(' ','') + '()');
			$j( this ).find( 'i' ).removeClass( 'fa-caret-right' );
			$j( this ).find( 'i' ).addClass( 'fa-caret-down' );
			if ( $j( '#' + $j( this ).attr( 'aria-controls' ) ).hasClass( 'in' ) ) {
				$j( this ).attr( 'href', '' );				
			} 
			else 
			{
				$j( this ).attr( 'href', '#' + $j( this ).attr( 'aria-controls' ) );				
			}
		} else {				
			$j( this ).find( 'i' ).removeClass( 'fa-caret-down' );
			$j( this ).find( 'i' ).addClass( 'fa-caret-right' );
		}
	});
}
	
//Validate input is numeric only
function validNum(myField) {
	var notInt = /\D/g;
	return myField.replace(notInt, "");
};
	
function validateFields() {
	applyValidation();
	$j( '#planName' ).valid();
	$j( '#termBegin' ).valid();
	$j( '#yearBegin' ).valid();
	if ( $j( '#whatIfDegreeProgram' ).length > 0) {
		$j( '#whatIfDegreeProgram' ).valid();
	}
	if ( $j( '#catalogYearTerm' ).length > 0) {
		$j( '#catalogYearTerm' ).valid();
	}
	$j( '#requiredMarker' ).valid();
}
	
function applyValidation() {
	$j( 'form[name="auditRequest"]' ).validate();
	if ( $j( '#whatIfDegreeProgram' ).length > 0 ) {
		$j('#whatIfDegreeProgram').rules("add", {required: true});
		$j('#catalogYearTerm').rules("add", {required: true});
	}
	$j('#planName').rules("add", {required: true});
	$j('#planName').rules("add", {duplicate: true});
	$j('#planName').rules("add", {noSpecialChars: true});
	$j('#termBegin').rules("add", {pastYearTerm: true});
	$j('#yearBegin').rules("add", {required: true});
	$j('#yearBegin').rules("add", {pastYearTerm: true});
	$j('#requiredMarker').rules("add", {noneRequired: true});
}

function initCreatePlan() {
	
	$j.validator.addMethod("duplicate", function(value, element) {
		var valid = true;
		$j('.planNames').each(function(i){
			if($j(this).text() == value){
				valid = false;
			}
		});
		return valid;
	}, "name already exists.");
	
	$j.validator.addMethod("noneRequired", function(value, element) {
		var valid = true;
		$j('.requiredMarker').each(function(i){
			if($j(this).val() != "false"){
				valid = false;
			}
		});
		return valid;
		console.log("maker(s) are required.")
	}, "marker(s) are required.");
		
	$j.validator.addMethod("pastYearTerm", function(value, element) {
		var currentYearTerm = $j( '#currentYearTerm' ).text();
		var selectedYearTerm = $j( '#yearBegin' ).val() + "" + $j( '#termBegin option:selected' ).attr( 'value' );
		if ( $j( '#' + $j( '#termBegin option:selected' ).attr( 'value' ) ).html() > 0 ) {
			var regCutOff = $j( '#' + $j( '#termBegin option:selected' ).attr( 'value' ) ).html();
			if (regCutOff.length < 2) {
				regCutOff = "0" + regCutOff;
			}
			selectedYearTerm = $j( '#yearBegin' ).val() + "" + regCutOff;
			var d = new Date();
			var month = d.getMonth() + 1;
			if (month < 10) {
				month = "0" + month;
			}
			currentYearTerm = currentYearTerm.substring(0, 4) + month;
		}
		if(currentYearTerm < selectedYearTerm){
			return true;
		}
		return false;
	}, "must select a future year term");
	
	$j.validator.addMethod("noSpecialChars", function(value, element) {
		
		var planName = $j( '#planName' ).val();
		
		if(planName.indexOf('"') + planName.indexOf('&') + planName.indexOf('<') + planName.indexOf('>') + 4 > 0){
				return false;
		}
		
		return true;
	}, 'input must not contain \",&,<,or>.');
		
	$j( '#yearBegin' ).change(function() {
		applyValidation();
		$j( '#termBegin' ).valid();
	});
	
	$j( '#planName' ).keyup(function() {
		$j( '#planName' ).valid();
	});
	
	$j( '#yearBegin' ).keyup(function() {
		applyValidation();
		$j( '#termBegin' ).valid();
	});
	
	$j( '#termBegin' ).change(function() {
		applyValidation();
		$j( '#yearBegin' ).valid();
	});
	
}