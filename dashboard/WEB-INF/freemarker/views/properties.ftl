<!DOCTYPE html>
<html lang="en-US">
 
<head>
	<title>Security Properties</title>
		
	<script type="text/javascript">
		
		function initPropertyTabs() {
			tabs = new YAHOO.widget.TabView("propertyTabs");
			<#if tabView??>
			var selectedTab = "global";
			<#else>
			var selectedTab = "<#if RequestParameters.tabView??>${RequestParameters.tabView}</#if>";
			</#if>
			
			if (selectedTab == "global")
				tabs.set("activeIndex", 0);
			else if (selectedTab == "application")
				tabs.set("activeIndex", 1);
				
			tabs.getTab(0).addListener("click", tabPropertyChangeHandler);
			tabs.getTab(1).addListener("click", tabPropertyChangeHandler);
		}
		
		Event.onDOMReady(initPropertyTables);
		Event.onDOMReady(initPropertyTabs);
		Event.onDOMReady(initSearchFields);
		Event.onDOMReady(initPropertyPanels);
	</script>
</head>
<input type="hidden" id="pageGroup" value="security"/>	
<body class="yui-skin-sam">

			<h1>Property Management</h1>
		<#if errorMessage??>
		<div style="font-weight:bold;color:red;width:100%;text-align:center;">
			${errorMessage}
		</div>
		</#if>
		
		<div id="propertyTabs" class="yui-navset" style="clear:both;">
			<ul class="yui-nav">
				<li class="selected"><a href="#tab1"><em>Global</em></a></li>
				<li><a href="#tab2"><em>Application</em></a></li>
			</ul>
			<div class="yui-content">
<!-- ############################################################################### -->
<!-- ####            GLOBAL PROPERTIES TAB								        #### -->
<!-- ############################################################################### -->	
				<div>
					<h3>
						Global Properties
						<a href="#" data-toggle="modal" data-target="#globalPropHelpModal" aria-haspopup="true" title = "Help for Global Properties" style="font-size: 65%;">
							<span class="sr-only">View Help Modal</span>	
							<i class="fa fa-question-circle fa-lg"></i>
						</a>
					</h3>
							
					<div id="globalPropertyContainer" style="font-size:9pt">
						<table id="globalPropertyTable" >
							<thead>
							<tr>
								<th>mappingid</th>
								<th>Property</th>
								<th>Value</th>
								<th>InstIDQ</th>
								<th>InstID</th>
								<th>InstCD</th>
								<th>Description</th>
							</tr>
							</thead>
							<tbody>
								<#if globalProperties??>
								<#list globalProperties as globalProperty>
								<tr>
									<td>${globalProperty.mappingId?string("0")!''}</td>
									<td>
										<#list availableProperties as ap>
											<#assign app="${ap.property!''}"/>
											<#assign gpp="${globalProperty.property!''}"/>
											<#if app == gpp> 
												${ap.description}
											</#if>
										</#list>
									</td>
									<td>${globalProperty.value!''}</td>
									<td>${globalProperty.instidq!''}</td>
									<td>${globalProperty.instid!''}</td>
									<td>${globalProperty.instcd!''}</td>
									<td>${globalProperty.description!''}</td>
								</tr>
								</#list>
								</#if>
							</tbody>
						</table>
					</div>
					
					<form name="deleteGlobalPropertyForm" method="post" action="manage-property.html">
						<input type="hidden" name="action" value="delete" />
						<input type="hidden" name="entity_type" value="GLOBAL"/>
						<input type="hidden" name="tabView" value="global"/>
						<input type="hidden" name="mappingid"/>
						<input name="submitButton" type="submit" value="Delete Property" style="margin:10px" disabled="true"/>
					</form>
					
					<div style="margin:10px">

						<form name="addGlobalPropertyForm" method="post" action="manage-property.html">
						<input type="hidden" name="mappingid"/>
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="entity_type" value="GLOBAL"/>
						<input type="hidden" name="tabView" value="global"/>
						<#if domainErrorMessage??>
							<span style="color:red;font-weight:bold">${domainErrorMessage}</span>
						</#if>
						<table width="650px" cellpadding="0" cellspacing="0" border="0">
						<thead>
							<tr>
								<th class="propertyHeader">Property</th>
								<th class="propertyHeader">Value</th>
								<th class="propertyHeader">InstIDQ</th>
								<th class="propertyHeader">InstID</th>
								<th class="propertyHeader">InstCD</th>
								<th class="propertyHeader">Description</th>										
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="float: left">
									<select name="property" style="display:inline;width:130px;font-size:9pt;margin-right:10px" onchange="onAddGlobalPropertyChange()">
									<#if availableProperties??>
										<option value=""></option>
										<#list availableProperties as ap>
											<option value="${ap.property}">${ap.description}</option>
										</#list>
									</#if>
									</select>
								</td>
								<td >
									<input name="value" maxlength="255" type="text" style="width:100px;font-size:9pt;margin-right:10px" onchange="onAddGlobalPropertyChange()"/>
								</td>
								<td >
									<input name="instidq" maxlength="2" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddGlobalPropertyChange()"/>
								</td>
								<td >
									<input name="instid" maxlength="8" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddGlobalPropertyChange()"/>
								</td>
								<td >
									<input name="instcd" maxlength="3" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddGlobalPropertyChange()"/>
								</td>
								<td >
									<input name="description" maxlength="100" type="text" style="width:100%;font-size:9pt;margin-right:10px" onchange="onAddGlobalPropertyChange()"/>
								</td>
							</tr>
						</tbody>
						</table>
						<br/>
						<input name="submitButton" type="submit" value="Add Property" onclick="return validateProperty(addGlobalPropertyForm);"/>
						<input name="cancelButton" type="button" value="Cancel" style="visibility: hidden" onclick="cancelGlobalUpdateProperty();"/>
						</form>
					</div>
					
				</div>
				
				
<!-- ############################################################################### -->
<!-- ####            APPLICATION PROPERTIES TAB								    #### -->
<!-- ############################################################################### -->								
				<div>
					<h3>
						Application Properties 
						<a href="#" data-toggle="modal" data-target="#appPropHelpModal" aria-haspopup="true" title = "Help for Application Properties" style="font-size: 65%;">
							<span class="sr-only">View Help Modal</span>	
							<i class="fa fa-question-circle fa-lg"></i>
						</a>
					</h3>
					
					<form class="verticalForm" name="applicationSelectionForm" method="get">
						<div id="applicationSelection">
							<fieldset style="width:95%;text-align:center">
								<input type="hidden" name="tabView" value="application" />
								<br/>
								<label for="app" style="text-align:center">
									Application:
									<select name="app" style="display:inline;width:200px" onchange="appChosenForProperty()">
									<#assign app="${RequestParameters.app!''}">
									<#if apps??>
										<option value=""></option>
										<#list apps as application>
											<option value="${application}" <#if app == application>selected</#if>>${application}</option>
										</#list>
									</#if>
									</select> 
								</label>
							</fieldset>
						</div>
					</form>
							
					<div id="applicationPropertyContainer" style="font-size:9pt">
						<table id="applicationPropertyTable" >
							<thead>
							<tr>
								<th>mappingid</th>
								<th>Property</th>
								<th>Value</th>
								<th>InstIDQ</th>
								<th>InstID</th>
								<th>InstCD</th>
								<th>Description</th>
							</tr>
							</thead>
							<tbody>
								<#if applicationProperties??>
								<#list applicationProperties as applicationProperty>
								<tr>
									<td>${applicationProperty.mappingId?string("0")!''}</td>
									<td>
										<#list availableProperties as ap>
											<#assign app="${ap.property!''}"/>
											<#assign gpp="${applicationProperty.property!''}"/>
											<#if app == gpp> 
												${ap.description}
											</#if>
										</#list>
									</td>
									<td>${applicationProperty.value!''}</td>
									<td>${applicationProperty.instidq!''}</td>
									<td>${applicationProperty.instid!''}</td>
									<td>${applicationProperty.instcd!''}</td>
									<td>${applicationProperty.description!''}</td>
								</tr>
								</#list>
								</#if>
							</tbody>
						</table>
					</div>
					
					<form name="deleteApplicationPropertyForm" method="post" action="manage-property.html">
						<input type="hidden" name="action" value="delete" />
						<input type="hidden" name="entity_type" value="APPLICATION"/>
						<input type="hidden" name="tabView" value="application"/>
						<input type="hidden" name="app" value="${RequestParameters.app!''}"/>
						<input type="hidden" name="mappingid"/>
						<input name="submitButton" type="submit" value="Delete Property" style="margin:10px" disabled="true"/>
					</form>
					
					<div style="margin:10px">
						
						<form name="addApplicationPropertyForm" method="post" action="manage-property.html">
						<input type="hidden" name="mappingid"/>
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="entity_type" value="APPLICATION"/>
						<input type="hidden" name="tabView" value="application"/>
						<input type="hidden" name="app" value="${RequestParameters.app!''}"/>
						<#if domainErrorMessage??>
							<span style="color:red;font-weight:bold">${domainErrorMessage}</span>
						</#if>
						<table width="650px" cellpadding="0" cellspacing="0" border="0">
						<thead>
							<tr>
								<th class="propertyHeader">Property</th>
								<th class="propertyHeader">Value</th>
								<th class="propertyHeader">InstIDQ</th>
								<th class="propertyHeader">InstID</th>
								<th class="propertyHeader">InstCD</th>
								<th class="propertyHeader">Description</th>		
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<select name="property" style="display:inline;width:130px;font-size:9pt;margin-right:10px" onchange="onAddApplicationPropertyChange()">
									<#if availableProperties??>
										<option value=""></option>
										<#list availableProperties as ap>
											<option value="${ap.property}">${ap.description}</option>
										</#list>
									</#if>
									</select>
								</td>
								<td>
									<input name="value" maxlength="255" type="text" style="width:100px;font-size:9pt;margin-right:10px" onchange="onAddApplicationPropertyChange()"/>
								</td>
								<td>
									<input name="instidq" maxlength="2" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddApplicationPropertyChange()"/>
								</td>
								<td>
									<input name="instid" maxlength="8" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddApplicationPropertyChange()"/>
								</td>
								<td>
									<input name="instcd" maxlength="3" type="text" style="width:50px;font-size:9pt;margin-right:10px" onchange="onAddApplicationPropertyChange()"/>
								</td>
								<td>
									<input name="description" maxlength="100" type="text" style="width:100%;font-size:9pt;margin-right:10px" onchange="onAddApplicationPropertyChange()"/>
								</td>
							</tr>
						</tbody>
						</table>
						<br/>
						<input name="submitButton" type="submit" value="Add Property" onclick="return validateProperty(addApplicationPropertyForm);"/>
						<input name="cancelButton" type="button" value="Cancel" style="visibility: hidden" onclick="cancelApplicationUpdateProperty();"/>
						</form>
					</div>
					
				</div>
		
		
			</div> <!--  End:  YUI Tab Content -->
		</div>  <!-- End:  YUI Tabs Div -->
		
		
<!-- HELP MODALS -->

		<div class="modal fade" id="globalPropHelpModal" tabindex="-1" role="dialog" aria-labelledby="globalPropHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Global Properties</h1>
		        <p>
		        	Limit the properties all application can have access to. A user may have properties directly applied to their user 
					account or inherited globally.
				</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="appPropHelpModal" tabindex="-1" role="dialog" aria-labelledby="appPropHelpModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-body">
		      <h1>Application Properties</h1>
		        <p>
		        	Limit the properties an application can have access to. A user may have properties directly applied to their user 
					account or inherited from the application.
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