<style>
	th {
		text-align: left;
	}
	.info-header {
		background-color: #E03A3E; 
	}
	.info-body {
		background-color: #FAFAFA;
	}
</style>


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
		<div class="alert alert-danger">
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


<#if infoDebug >
	<div class="info-header">
		General
	</div>
	<div class="info-body">
		<table>
			<tr>
				<td>Date</td>
				<td><@displayFieldOrException currentDate dateException /></td>
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
	</div>
	
	<br/>
	
	<div class="info-header">
		Runtime
	</div>
	<div class="info-body">
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
		<#if runException?? >
			<@displayException runException />
		</#if>
		
	</div>
	
	<br/>
	
	<div class="info-header">
		Parameters
	</div>
	<div class="info-body">
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
	</div>
	
	<br/>
	
	<div class="info-header">
		Attributes
	</div>
	<div class="info-body">
		<#if requestAttributes??>
			<table>
				<tr>
					<th>Name</th>
					<th>Value</th>
				</tr>
				<#list requestAttributes?keys as attName >
					<tr>
						<td><@displayField attName /></td>
						<td><@displayField requestAttributes[attName]?string /></td>
					</tr>
				</#list>
				</table>
		</#if>
		<#if reqAttException?? >
			<@displayError reqAttException />
		</#if>
	</div>
	
	<br/>
	
	<div class="info-header">
		Cookies
	</div>
	<div class="info-body">
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
	</div>
	
	<br/>
	
	<div class="info-header">
		Session
	</div>
	<div class="info-body">
		<#if sessionAttributes??>
			<table>
				<tr>
					<th>Name</th>
					<th>Value</th>
				</tr>
				<#list sessionAttributes?keys as attName >
					<tr>
						<td><@displayField attName /></td>
						<td><@displayField sessionAttributes[attName]?string /></td>
					</tr>
				</#list>
			</table>
		</#if>
		<#if sessAttException?? >
			<@displayException sessAttException />
		</#if>
	</div>
	
	<br/>
	
	<div class="info-header">
		Headers
	</div>
	<div class="info-body">
		<#if requestHeaders??>
			<table>
				<tr>
					<th>Name</th>
					<th>Value</th>
				</tr>
				<#list requestHeaders?keys as attName >
					<tr>
						<td><@displayField attName /></td>
						<td><@displayField requestHeaders[attName]?string /></td>
					</tr>
				</#list>
			</table>
		</#if>
		<#if reqHeaderException?? >
			<@displayException reqHeaderException />
		</#if>
	</div>
	
	<br/>
	
	<div class="info-header">
		Properties from security.properties
	</div>
	<div class="info-body">
		<#if overriddenProperties??>
			<table>
				<tr>
					<th>Property</th>
					<th>Value</th>
				</tr>
				<#list overriddenProperties?keys as propName>
					<tr>
						<td><@displayField propName /></td>
						<td><@displayField overriddenProperties[propName] /></td>
					</tr>
				</#list>
			</table>
		</#if>
		<#if overPropException?? >
			<@displayException overPropException />
		</#if>
	</div>
	
	<br/>
	
	<div class="info-header">
		System Properties
	</div>
	<div class="info-body">
		<#if systemProperties??>
			<table>
				<tr>
					<th>Property</th>
					<th>Value</th>
				</tr>
				<#list systemProperties?keys as propName>
					<tr>
						<td><@displayField propName /></td>
						<td><@displayField systemProperties[propName] /></td>
					</tr>
				</#list>
			</table>
		</#if>
		<#if sysPropException?? >
			<@displayException sysPropException />
		</#if>
	</div>
	<br/>
	
	<div class="info-header">
		Global Properties
	</div>
	<div class="info-body">
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
		<#if globPropException?? >
			<@displayException globPropException />
		</#if>
	</div>
	<br/>
	
	<div class="info-header">
		Application Properties
	</div>
	<div class="info-body">
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
		<#if appPropException?? >
			<@displayException appPropException />
		</#if>
	</div>
	<br/>
	
	<div class="info-header">
		User Properties
	</div>
	<div class="info-body">
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
	</div>
</#if>