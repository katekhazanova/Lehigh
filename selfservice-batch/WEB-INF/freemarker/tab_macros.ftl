<#-- prints the main tabs (audits/change program/add student/profile) for the manage pages -->
<#macro printAuditTabs queryParams>
	<@tabs>
		<#local linkText><@s.message 'uachieve.selfservice.audit.results.title' /></#local>
		<@tab "/audit/read.html${auditQueryParams}" linkText "audit/read" />
		<#if auditConfig.showCourseHistory>
			<#local linkText><@s.message 'uachieve.selfservice.audit.courseHistory.title' /></#local>
			<@tab "/audit/listcourses.html${auditQueryParams}" linkText "audit/listcourses" />
		</#if>
		<#if auditConfig.showExceptions>
			<#local linkText><@s.message 'uachieve.selfservice.audit.exceptions.title' /></#local>
			<@tab "/audit/listexceptions.html${auditQueryParams}" linkText "audit/listexceptions" />
		</#if>
		<#if auditConfig.showMarkers>
			<#local linkText><@s.message 'uachieve.selfservice.audit.markers.title' /></#local>
			<@tab "/audit/listmarkers.html${auditQueryParams}" linkText "audit/listmarkers" />
		</#if>
	</@tabs>
</#macro>

<#macro printBatchTabs>
	<@tabs>
		<@secureTab appFn=AppFuncRole.SS_AREA_BATCHES url="/batch/list.html" title="Batch Definitions" id="batch/list" />
		<@secureTab appFn=AppFuncRole.SS_AREA_RESULTS url="/scheduledjob/list.html" title="Scheduled Jobs" id="scheduledjob/list"    />
		<@secureTab appFn=AppFuncRole.SS_AREA_RESULTS url="/batchresult/results.html" title="Run Results" id="batchresult/results" />
		<@secureTab appFn=AppFuncRole.SS_AREA_BLACKOUTS url="/blackout/list.html" title="Blackouts" id="blackout/list" />
	</@tabs>
</#macro>

<#-- only prints tab if area is globally enabled -->
<#macro secureTab appFn url title id>
	<@sec.hasAppFn appFn>
		<@tab url=url title=title id=id />
	</@sec.hasAppFn>
</#macro>

<#macro setSelectedTab tab>
	<#assign selectedTab = tab>
</#macro>

<#macro tabs>	
	<ul class="nav nav-tabs" role="navigation">
		<li>
			<#nested />
		</li>
	</ul>
	
	
</#macro>

<#macro tab url title id><#if !isFirstTab??><#assign isFirstTab = false />
		<#if id == selectedTab>
			<li class="active"><a href="#">${title}<span class="sr-only">tab selected</span></a></li>
		<#else>
			<li><a href="<@s.url url />">${title}</a></li>
		</#if>
	<#else>
		<#if id == selectedTab>
			<li class="active"><a href="#">${title}<span class="sr-only">tab selected</span></a></li>
		<#else>
			<li><a href="<@s.url url />">${title}</a></li>
		</#if> 
	</#if>
	<#assign previousTab = id />
</#macro>


<#macro closetabs>
	<#--<#if tabtool.wasPreviousTabActive(selectedTab)>-->
	<#if previousTab?? && previousTab == selectedTab >
		<td class="tab_on_end">&nbsp;</td>
	<#else>
		<td class="tab_off_end">&nbsp;</td>
	</#if>
</#macro>