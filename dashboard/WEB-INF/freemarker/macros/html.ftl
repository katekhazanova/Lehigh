<#macro url href><@spring.url href /></#macro>
<#macro css href><link rel="stylesheet" type="text/css" href="<@spring.url href />" /></#macro>
<#macro script href><script type="text/javascript" src="<@spring.url href />"></script></#macro>
<#macro link href title class=""onclick="" target="_self"><a href="<@spring.url href />" title="${title}" class="${class}" onclick=${onclick} target="${target}">${title}</a></#macro>
<#macro img src title="" class="" alt="" onclick=""><img src="<@spring.url src />" alt="${alt}" class="${class}" title="${title}" onclick="${onclick}"/></#macro>
<#macro imgLink src href title="" class="" onclick="" alt=""><a href="<@spring.url href />" title="${title}" alt="${alt}"onclick=${onclick}><@img src=src title=title class=class alt=alt/></a></#macro>
<#macro imgAndTextLink src href title="" class="" alt=""><a href="<@spring.url href />" title="${title}"><@img src=src title=title class=class alt=alt/></a> <a href="<@spring.url href />">${title}</a></#macro>
<#macro imgNonLink src title="" class="" alt=""><@imgHelp src=src title=title class=class alt=alt/></#macro>
<#macro imgHelp src title="" class="" alt=""><img src="<@spring.url src />" alt="${alt}" class="${class}" title="${title}" /></#macro>
<#macro imgIdLink src href title="" class="" alt="" hrefId="" imgId=""><a href="<@spring.url href />" id="${hrefId}"><img src="<@spring.url src />" alt="${alt}" class="${class}" title="${title}" id="${imgId}"/></a></#macro>
<#macro imgLinkNewWindow src href title="" class="" alt=""><a TARGET="_blank" href="<@spring.url href />" title="${title}" alt="${alt}"><@img src=src title=title class=class alt=alt/></a></#macro>

<#macro printStatus node>
	<#if node.isCourseList()>
		<@h.img class="courselist" src="/images/courselist.gif" title="Course List" alt="Course List"/>
	</#if>
	
	<#if node.isCourse()>
		<#if node.isCourseWithPreCoReq()>
			<@h.img class="course-icon" src="/laf/themes/udirect/images/course_precoreqs.png" title="${node.courseFlagDisplayString}" alt="${node.courseFlagDisplayString}"/>
		</#if>
	</#if>  
	
	<#if node.isRejectCourse()>
		<@h.img class="rejectcourse" src="/laf/themes/udirect/images/rejectcourse.gif" title="Course Not Allowed" alt="Course Not Allowed"/>
	</#if>
	
	  <#list node.statuses as status>
	    <#if status.toolTipText?? >
	    	<@h.img src="/images/${status.name?lower_case?replace(' ', '')}.png" title="${status.toolTipText}" alt="${status.toolTipText}"/>
	    <#else>
	   		<@h.img src="/images/${status.name?lower_case?replace(' ', '')}.png" title="${status.name}" alt="${status.name}"/>
	    </#if>
	   </#list>
	
	<#if node.statuses?size == 0>
		<#if node.isCourse()>
			<#if !node.isCourseList() && !node.isCourseWithPreCoReq()>
			  <#if !prefs.isAccessibleView()><#--Do not show course book icon next to courses in text only view-->
			       <@h.img class="course-icon" src="/laf/themes/udirect/images/course.gif" title="Course" alt="Course"/>
			  </#if>
			</#if>
		</#if>
	</#if>
	
	<#if node.isYearTerm()>
		<#if node.isTermFlagged()>
			<@h.img src="/images/plannedcourseflag.gif" title="One or more courses flagged in this term." alt="One or more courses flagged in this term."/>
		</#if>
	</#if>

	
</#macro>

<#macro formatDate date=' '>
	<#if date != ' '>
		${date?date}
	</#if>
</#macro>

<#macro formatDateTime dateTime=' '>
	<#if dateTime != ' '>
		${dateTime?datetime?string.long_short}
	</#if>
</#macro>