<@layout.head title="${pageContext.page.label}">
	<#if autoPoll>
		<meta http-equiv="refresh" content="${batchConfig.batchPollingRate}">
	</#if>
</@layout.head>
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<h1>Batch</h1>
	<@t.setSelectedTab tab='batch/list' />
	<@t.printBatchTabs />
	<h2><@s.message 'uachieve.selfservice.batch.definition.list.header' /></h2>
	
	<p class="alert alert-danger" role="alert" tabindex="0"${isHidden}>${alertMessage}</p>
	
	<@p.masterView ctx=pageContext addButton="Add Batch"/>

	<input type="hidden" id="contextPath" value="${springMacroRequestContext.getContextPath()}" />

</@layout.body>

