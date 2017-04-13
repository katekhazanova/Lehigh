<#assign nullDisplay = "<i>null</i>" />
<#assign emptyString = "" />
<#macro displayField field=nullDisplay>
	<#if field?string == nullDisplay>
		${nullDisplay}
	<#else>
		"${field}"
	</#if>
</#macro>

<#macro displayException exception=emptyString>
	<#if exception?is_sequence>
		<div class="alert alert-danger" role="alert" tabindex="0">
			<#list exception as eLine>
				${eLine}
			</#list>
		</div>
	</#if>
</#macro>

<#macro displayFieldOrException field=nullDisplay exception=emptyString>
	<#if exception != emptyString>
		<@displayException exception />
	</#if>
	<#if field?string != nullDisplay >
		<@displayField field />
	</#if>
</#macro>

<#macro displayPropertiesFile fileName propertyList=emptyString propertiesException=emptyString>
<strong>Properties from ${fileName}:</strong><br/>
	<#if propertyList?is_hash>
		<table>
			<tr>
				<th>Property</th>
				<th>Value</th>
			</tr>
			<#list propertyList?keys as propName>
				<tr>
					<td><@displayField propName /></td>
					<td><@displayField propertyList[propName] /></td>
				</tr>
			</#list>
		</table>
	</#if>
	<#if propertiesException?is_sequence >
		<@displayException propertiesException />
	</#if>
	<br/>
</#macro>

<#macro displayPropertyHash hashTitle propertyHash=emptyString hashException=emptyString>
<strong>${hashTitle}</strong><br/>
<#if propertyHash?is_hash>
	<table>
		<tr>
			<th>Name</th>
			<th>Value</th>
		</tr>
		<#list propertyHash?keys as currentKey >
			<tr>
				<td><@displayField currentKey /></td>
				<td><@displayField propertyHash[currentKey]?string /></td>
			</tr>
		</#list>
		</table>
</#if>
<#if hashException?is_sequence >
	<@displayError hash_exception />
</#if>
<br/>
</#macro>

<@layout.head title="Self-Service Diagnostics" />

<@layout.body>
<#if selfServiceConfig.debug >

<h2>General Properties</h2>
<strong>General</strong><br/>
<table>
		<tr>
			<th>Name</th>
			<th>Value</th>
		</tr>
		<tr>
			<td>Date</td>
			<td><@displayFieldOrException currentDate currentDateException /></td>
		</tr>
		<tr>
			<td>Buffer size</td>
			<td><@displayFieldOrException response.bufferSize responseException /></td>
		</tr>
		<tr>
			<td>Servlet path</td>
			<td><@displayFieldOrException request.servletPath requestException /></td>
		</tr>
		<tr>
			<td>Context path</td>
			<td><@displayFieldOrException request.contextPath requestException /></td>
		</tr>
		<tr>
			<td>Server Name</td>
			<td><@displayFieldOrException request.serverName requestException /></td>
		</tr>
		<tr>
			<td>Server Port</td>
			<td><@displayFieldOrException request.serverPort requestException /></td>
		</tr>
		<tr>
			<td>Remote address</td>
			<td><@displayFieldOrException request.remoteAddr requestException /></td>
		</tr>
		<tr>
			<td>Remote host</td>
			<td><@displayFieldOrException request.remoteHost requestException /></td>
		</tr>
	</table>

<strong>Runtime</strong><br/>
<#assign meg = 1024 * 1024 />
<#if runtime?? >
	<table>
		<tr>
			<th>Name</th>
			<th>Value</th>
		</tr>
		<tr>
			<td>Processors</td>
			<td><@displayField runtime.availableProcessors() /></td>
		</tr>
		<tr>
			<td>Used memory</td>
			<td><@displayField ((runtime.totalMemory() - runtime.freeMemory())/meg)?string /></td>
		</tr>
		<tr>
			<td>Free memory</td>
			<td><@displayField (runtime.freeMemory()/meg)?string /></td>
		</tr>
		<tr>
			<td>Total memory</td>
			<td><@displayField (runtime.totalMemory()/meg)?string /></td>
		</tr>
		<tr>
			<td>Max memory</td>
			<td><@displayField (runtime.maxMemory()/meg)?string /></td>
		</tr>
	</table>
</#if>
<#if runtimeException?? >
	<@displayException runtimeException />
</#if>

<@displayPropertyHash 'System Properties' systemProperties systemPropertiesException />
<hr/>

<h2>Web Properties</h2>
<#-- strong>Parameters</strong><br/>
<#if request.parameterNames??>
	<table>
		<tr>
			<th>Name</th>
			<th>Value</th>
		</tr>
		<#list request.parameterNames as paramName >
			<tr>
				<td><@displayField paramName /></td>
				<td><@displayField request.getParameter(paramName) /></td>
			</tr>
		</#list>
	</table>
</#if>
<#if requestException?? >
	<@display requestException />
</#if>
<br/-->
<@displayPropertyHash 'Request Parameters' requestParameters requestParametersException />

<@displayPropertyHash 'Attributes' requestAttributes requestAttributesException />

<@displayPropertyHash 'Session' sessionAttributes sessionAttributesException />

<@displayPropertyHash 'Headers' requestHeaders requestHeadersException />

<strong>Cookies</strong><br/>
<#if request.cookies??>
	<table>
		<tr>
			<th>Name</th>
			<th>Value</th>
			<th>Comment</th>
			<th>Domain</th>
			<th>Max Age</th>
			<th>Path</th>
			<th>Version</th>
		</tr>
		<#list request.cookies as cookie>
			<tr>
				<td><@displayField cookie.name /></td>
				<td><@displayField cookie.value /></td>
				<td><@displayField cookie.comment /></td>
				<td><@displayField cookie.domain /></td>
				<td><@displayField cookie.maxAge /></td>
				<td><@displayField cookie.path /></td>
				<td><@displayField cookie.version /></td>
			</tr>
		</#list>
	</table>
</#if>
<#if requestException?? >
	<@displayError requestException />
</#if>
<br/>
<hr/>

<h2>Security Properties</h2>
<strong>Global Properties:</strong><br/>
<#if globalProperties??>
<table>
	<tr>
		<th>Entity ID</th>
		<th>Entity Type</th>
		<th>Property</th>
		<th>Value</th>
		<th>Instidq</th>
		<th>Instid</th>
		<th>Instcd</th>
		<th>Description</th>
	</tr>
	<#list globalProperties as globProperty>
		<tr>
			<td><@displayField globProperty.entityId /></td>
			<td><@displayField globProperty.property /></td>
			<td><@displayField globProperty.value /></td>
			<td><@displayField globProperty.instidq /></td>
			<td><@displayField globProperty.instid /></td>
			<td><@displayField globProperty.instcd /></td>
			<td><@displayField globProperty.description /></td>
		</tr>
	</#list>
</table>
</#if>
<#if globalPropertiesException?? >
	<@displayException globalPropertiesException />
</#if>

<strong>Application Properties:</strong><br/>
<#if applicationProperties??>
<table>
	<tr>
		<th>Entity ID</th>
		<th>Entity Type</th>
		<th>Property</th>
		<th>Value</th>
		<th>Instidq</th>
		<th>Instid</th>
		<th>Instcd</th>
		<th>Description</th>
	</tr>
	<#list applicationProperties as appProperty>
		<tr>
			<td><@displayField appProperty.entityId /></td>
			<td><@displayField appProperty.property /></td>
			<td><@displayField appProperty.value /></td>
			<td><@displayField appProperty.instidq /></td>
			<td><@displayField appProperty.instid /></td>
			<td><@displayField appProperty.instcd /></td>
			<td><@displayField appProperty.description /></td>
		</tr>
	</#list>
</table>
</#if>
<#if applicationPropertiesException?? >
	<@displayException applicationPropertiesException />
</#if>
<br/>

<strong>User Properties:</strong><br/>
<#if userProperties??>
<table>
	<tr>
		<th>Entity ID</th>
		<th>Entity Type</th>
		<th>Property</th>
		<th>Value</th>
		<th>Instidq</th>
		<th>Instid</th>
		<th>Instcd</th>
		<th>Description</th>
	</tr>
	<#list userProperties as userProperty>
		<tr>
			<td><@displayField userProperty.entityId /></td>
			<td><@displayField userProperty.property /></td>
			<td><@displayField userProperty.value /></td>
			<td><@displayField userProperty.instidq /></td>
			<td><@displayField userProperty.instid /></td>
			<td><@displayField userProperty.instcd /></td>
			<td><@displayField userProperty.description /></td>
		</tr>
	</#list>
</table>
</#if>
<#if userPropException?? >
	<@displayException userPropException />
</#if>
<br/>
<hr/>

<h2>Default Properties</h2>
<@displayPropertiesFile 'default-selfservice.properties' defaultProperties defaultPropertiesException />
<hr/>

<h2>Overridden Properties:</h2>
<@displayPropertiesFile 'selfservice-audit.properties' auditProperties auditPropertiesException />
<@displayPropertiesFile 'selfservice-database.properties' databaseProperties databasePropertiesException />
<@displayPropertiesFile 'selfservice-debug.properties' debugProperties debugPropertiesException />
<@displayPropertiesFile 'selfservice-general.properties' generalProperties generalPropertiesException />
<@displayPropertiesFile 'selfservice-graph.properties' graphProperties graphPropertiesException />
<@displayPropertiesFile 'selfservice-misc.properties' miscProperties miscPropertiesException />
<@displayPropertiesFile 'selfservice-securities.properties' securityProperties securityPropertiesException />
<@displayPropertiesFile 'selfservice-student.properties' studentProperties studentPropertiesException />
<hr/>

</#if>
</@layout.body>