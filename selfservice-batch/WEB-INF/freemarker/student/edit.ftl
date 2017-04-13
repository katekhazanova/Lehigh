<@layout.head title="Edit ${pageContext.page.label}" />

<@layout.body>
<input type="hidden" id="pageGroup" value="profile"/>
		<@p.detailView ctx=pageContext saveButton="Save"/>
	
<#if uppercaseStuno>
	<input type="hidden" id="uppercaseStuno" value="true"/>
<#else>
	<input type="hidden" id="uppercaseStuno" value="false"/>
</#if>	
</@layout.body>