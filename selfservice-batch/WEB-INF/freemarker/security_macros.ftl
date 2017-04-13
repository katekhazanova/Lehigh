<#assign security=JspTaglibs["/WEB-INF/tld/security.tld"]>
<#assign redauth=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<#-- spring's security.* tag library is a bit wordy - these macros replicate it (in fact use it),
	but just tighten things up a bit. -->

<#-- =================== spring related macros =================== -->
<#-- displays the user's name -->
<#macro username>
	<@security.authentication operation="username" />
</#macro>

<#-- displays the nested content only if the user is NOT logged in (has no SS_ROLE_USER) -->
<#macro isNotLoggedIn>
	<@security.authorize ifNotGranted=AppFuncRole.SS_ROLE_USER?string><#nested /></@security.authorize>
</#macro>	

<#-- displays the nested content only if the user is logged in (has SS_ROLE_USER) -->	
<#macro isLoggedIn>
	<@security.authorize ifAllGranted=AppFuncRole.SS_ROLE_USER?string><#nested /></@security.authorize>
</#macro>

<#-- displays the nested content only if the current user is a student (has SS_ROLE_STUDENT) -->	
<#macro isStudent>
	<@security.authorize ifAllGranted=AppFuncRole.SS_ROLE_STUDENT?string><#nested /></@security.authorize>
</#macro>

<#-- displays the nested content only if the current user is NOT a student (does NOT have SS_ROLE_STUDENT) -->	
<#macro isNotStudent>
	<@security.authorize ifNotGranted=AppFuncRole.SS_ROLE_STUDENT?string><#nested /></@security.authorize>
</#macro>

<#-- displays the nested content only if the current user is an advisor (has SS_ROLE_ADVISOR) -->	
<#macro isAdvisor>
	<@security.authorize ifAllGranted=AppFuncRole.SS_ROLE_ADVISOR?string><#nested /></@security.authorize>
</#macro>

<#-- displays the nested content only if the current user is NOT an advisor (does NOT have SS_ROLE_ADVISOR) -->	
<#macro isNotAdvisor>
	<@security.authorize ifNotGranted=AppFuncRole.SS_ROLE_ADVISOR?string><#nested /></@security.authorize>
</#macro>


<#-- =================== app function related macros ============ -->


<#-- displays the nested content only if the user has the required app function -->
<#macro hasAppFn appFn>
	<@redauth.authorize ifAnyGranted="${appFn}=R">
		<#nested />
	</@redauth.authorize>
</#macro>

<#-- same as hasAppFn, but works on a list of provided app functions - if any of the passed in appFns is granted, the contents will be printed -->
<#macro hasAppFns appFns>
	<#assign grants = "" />
	
	<#-- build up a string of appFns like "SS_AREA_COURSE=R,SS_AREA_PLANNEDCOURSE=R" -->
	<#list appFns as appFn>
		<#assign grants = "${grants}${appFn}=R" />
		<#if appFn_has_next>
			<#assign grants = "${grants}," />
		</#if>
	</#list>
	
	<@redauth.authorize ifAnyGranted=grants>
		<#nested />
	</@redauth.authorize>
</#macro>

<#macro hasAppFnPerm appFn perm>
	<@redauth.authorize ifAllGranted="${appFn}=${perm}">
		<#nested />
	</@redauth.authorize>
</#macro>