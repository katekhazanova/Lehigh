<@layout.head title="Help Topics" />
<@layout.body>


	
	<#if RequestParameters['topic']?? >
		<#-- user has selected a specific topic-->
	
		
		<#include "topics/${topic}-help.ftl" />
		
		<hr />
		<#if RequestParameters['popup']?? >
			<p><a href="javascript:window.close()">Close Window</a></p>
		<#else>
			<a class="btn btn-default" role="button" href="<@h.url href='/general/help.html' />">Back to all Help topics</a>
		</#if>
	<#else>
		<#-- no topic selected, show all help topics-->
		<input type="hidden" id="pageGroup" value="settings"/>
		<h1>Help Topics</h1>
		<p>Choose one of the help topics from the list below.</p>

		<ul>
			<@helpitem topic='auditresults' text='Interpreting Audit Results' />
			<@sec.isAdvisor>
				<@helpitem topic='search' text='Searching for Students' />
				<li><@h.link href="/general/help.html?topic=comp_id.crsNum" title="Adding Courses" /></li>
			</@sec.isAdvisor>
			<@sec.hasAppFn AppFuncRole.SS_AREA_BATCHES > 
				<li><@h.link href="/general/help.html?topic=startDate" title="Adding a Date" /></li>
				<li><@h.link href="/general/help.html?topic=startTime" title="Adding a Time" /></li>
			</@sec.hasAppFn>
			<li><@h.link href="/general/help.html?topic=ipadScroll" title="iPad Scrolling" /></li>
		</ul>			
	</#if>

</@layout.body>

<#macro helpitem (topic, text)>
	<li>
		<@h.link href="/general/help.html?topic=${topic?html}" title="${text}" />
	</li>
</#macro>