<#macro cancelButton>
	<#assign cancel11_img_url>
	<@spring.url relativeUrl="/images/cancel.png"/>
	</#assign>
	<#assign admin_cancel_url><@spring.url relativeUrl="/admin/admin_menu.html"/></#assign>
	<a href="${admin_cancel_url}"><img src="${cancel11_img_url}"/></a>
</#macro>


<#macro showCalendar>
<div class="hero2-unit">
		<div class="calendar_header">
			
			<table class="wc-header"><tbody><tr>
			<td class="wc-time-column-header"></td>
			<td class="wc-day-column-header wc-day-1 wc-today">Mon</td>
			<td class="wc-day-column-header wc-day-2">Tue</td>
			<td class="wc-day-column-header wc-day-3">Wed</td>
			<td class="wc-day-column-header wc-day-4">Thu</td>
			<td class="wc-day-column-header wc-day-5">Fri</td>
			<td class="wc-day-column-header wc-day-6">Sat</td>
			<td class="wc-day-column-header wc-day-7">Sun</td>
			<td class="wc-scrollbar-shim"></td>
			</tr></tbody></table>
		</div>
		<div id="top_cl" class="top_cl_cl"></div>
		<div class="calendar_body">
			<div id='calendar'></div>
		</div>
</div>

</#macro>

<#macro displayErrorsAsList errorList headerText="" container="td" properties="">
	<#if errorList?? && errorList?size gt 0>
		<${container} ${properties} class="ui-state-error ui-corner-all">
			<#if headerText?length gt 0>
				<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<b>${headerText}</b>
				<br/>
			</#if>
			<ul style="margin-left:30px;">
				<#list errorList as error>
					<li>${error}</li>
				</#list>
			</ul>
		</${container}>
	</#if>
</#macro>

<#macro cronTable>
<div id="cronHelp" style="display:none;">
Values should be used in order separated by a space. <br />
Either Day of month or Day of week MUST be '?'<span class="sr-only">question mark</span>. 
Click <a href="https://clients.collegesource.com/home/display/SB/Course+Search">CollegeSource's documentation</a> for more help.
<br /><br />
<table class="admin-table cronHelp">
<thead>
<tr>
<th width="100px"> Name </th>
<th width="100px" > Mandatory </th>
<th > Allowed values </th>
<th > Special Chars </th>
</tr>
</thead>
<tbody>
<tr>
<td> Seconds </td>
<td> YES </td>
<td> 0-59 </td>
<td> , - * / </td>
</tr>
<tr>
<td> Minutes </td>
<td> YES </td>
<td> 0-59 </td>
<td> , - * / </td>
</tr>
<tr>
<td> Hours </td>
<td> YES </td>
<td> 0-23 </td>
<td> , - * / </td>
</tr>
<tr>
<td> Day of month </td>
<td> YES </td>
<td> 1-31 </td>
<td> , - * ? / L W </td>
</tr>
<tr>
<td> Month </td>
<td> YES </td>
<td> 1-12 or JAN-DEC </td>
<td> , - * / </td>
</tr>
<tr>
<td> Day of week </td>
<td> YES </td>
<td> 1-7 or SUN-SAT </td>
<td> , - * ? / L # </td>
</tr>
<tr>
<td> Year </td>
<td> NO </td>
<td> empty, 1970-2099 </td>
<td> , - * / </td>
</tr>
</tbody></table>
</div>

</#macro>

<#macro showIndexBuilt status>

	<#if status="true">
		<font color="00B836">Yes</font>
	<#else>
		No
	</#if>

</#macro>

<#macro showIndexStatus status>

	<#if status="Building...">
		<font color="D4A145">${status}</font>
	<#elseif status="Failed">
		<font color="9F1313">${status}</font>
	<#else>
		${status}
	</#if>

</#macro>