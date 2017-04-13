<#-- GENERIC MACROS:TEST TO REPRODUCE BLANK LINES: UTF-8 ENCODING -->

<#assign width = 65>
<#assign wideWidth = 131>
<#macro centered centerText>
    <#local padding = centerText?length + ((width - centerText?length)/2) - 1 />
	${centerText?left_pad(padding)}
</#macro>

<#macro printHorizRule char='=' ruleWidth=width>
<#local displayString = "" />
<#list 1..ruleWidth as i><#local displayString = displayString + char /></#list>
${displayString}
</#macro>

<#macro printHorizWideRule char='=' ruleWidth=wideWidth>
<#local displayString = "" />
<#list 1..ruleWidth as i><#local displayString = displayString + char /></#list>
${displayString}
</#macro>

<#macro printBlankString length><#list 1..length as space> </#list></#macro>

<#macro displayField fieldValue hidden padding padLeft=false>
<#if hidden>
${""?right_pad(padding)}
<#else>
<#if padLeft>
${fieldValue?left_pad(padding)}
<#else>
${fieldValue?right_pad(padding)}
</#if>
</#if>
</#macro>

<#macro displayFieldAndText field text hidden padding padRight=false>
<#if hidden>
${""?right_pad(padding)}
<#else>
<#if padRight>
${(field + ' ' + text)?right_pad(padding)}
<#else>
${(field + ' ' + text)?left_pad(padding)}
</#if>
</#if>
</#macro>

<#macro displaySequenceIndent fieldValue padding lineSeparator lineLength=width>
<#--if ! hidden -->
	<#local firstLine = true />
	<#if fieldValue?size gt 0>
		<#list fieldValue as val>
			<#local currentLines><@splitLongLine text=val indent=0 lineLength=lineLength lineSeparator=lineSeparator /></#local>
			${""?right_pad(padding)}${currentLines}<#if val_has_next></#if>
			<#local firstLine = false />
		</#list>
	</#if>
<#--/#if-->
</#macro>

<#macro splitLongLine text indent lineLength lineSeparator splitAt=' '>
	<#local searchBegin = 0 />
	<#list 0..100 as loopIndex>
	   	<#if (text?length - searchBegin > 1) >
			<#local searchEnd = searchBegin + lineLength />
			<#if (searchEnd gte text?length) >
				<#local searchEnd = (text?length) />
			</#if>
			<#local searchString = text?substring(searchBegin, searchEnd) />
			<#local currentLine = searchString />
			<#local lineEnd = searchString?length />
			<#if searchString?length == lineLength >
				<#local lineEnd = searchString?index_of(lineSeparator) />
				<#if lineEnd lt 0>
					<#local lineEnd = searchString?last_index_of(splitAt) /> 
				</#if>
				<#if lineEnd lt 0>
					<#local lineEnd = searchString?length - 1 /> 
				</#if>
			    <#local currentLine = searchString?substring(0, lineEnd) />
			</#if>
			<#if loopIndex == 0>
				${currentLine}
			<#else>

				${currentLine?trim?left_pad(currentLine?length + indent)}${lineSeparator}
			</#if>
			<#local searchBegin = searchBegin + lineEnd + 1/>
			<#if searchBegin gte (text?length - 1)>
				<#break>
			</#if>
		</#if>
	</#list>
</#macro>

<#macro displayCourse course singleSpace=false>
	<#if course.displayCourse>
		<#local displayString = "" />
		<#local dept = "" />
		<#local dept = course.suppressedDepartment />
		<#local displayString = course.matchCtl + dept + course.courseNumber + course.dateRange 
			+ course.postModifier + course.title />
		<#if course.hasRefCourses>
			<#local displayString = displayString + course.refCourses />
		</#if>
		${displayString}
	</#if>
</#macro>	

<#macro createCourseLink course>
	<#local fullLink = course.com.urls />
	<#local linkText = course.jobQueueAccept.dept?right_pad(course.com.deptlng - course.com.deptbgn) + course.courseNumber />
	<#local linkText = linkText?right_pad(course.com.cmprend - course.com.cmprbgn) />
	<#local fullLink = fullLink + linkText />
	<#local fullLink = fullLink + course.com.urlsep />
	<#local displayText><@displayCourse course=course singleSpace=true /></#local>
	<#local fullLink = fullLink + displayText />
	<#local fullLink = fullLink + course.com.urle />
	${fullLink}
</#macro>

<#function showSubreqGotSummary subreq>
	<#return (subreq.showGotSummary && (subreq.showGotHours || subreq.showGotCount || subreq.showGotGpa))>
</#function>

<#function showSubreqNeedsSummary subreq>
	<#return (((subreq.needsText?length gt 0) || subreq.showNeedsHours || subreq.showNeedsCount || subreq.showNeedsGpa)) >
</#function>			