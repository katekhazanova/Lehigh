<@layout.head "Select a ${pageContext.page.label}" />

<@layout.body>

		<input type="hidden" id="pageGroup" value="settings"/>
	<h1>Select a ${pageContext.page.label}</h1>

	<#if currentInstcd??>
		<p><@s.message 'uachieve.selfservice.general.currentschool.text'/> ${currentInstcd.code} - ${currentInstcd.name}</p>
	</#if>

	<@p.detailView ctx=pageContext saveButton="Continue" />
	
</@layout.body>