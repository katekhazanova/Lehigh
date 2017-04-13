<@layout.head title="${pageContext.page.label}s" />
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<h1><@s.message 'uachieve.selfservice.batch.criteria.list.header' /></h1>
	<@batch.batchTabs step=2 />
	<@h.buttonAsLink src="/images/bt_Back2List.png" href="/batch/criteria.html" title="Back to Criteria List" />
	<h3>Total: ${previewSize} students</h3>
	<@p.masterView pageContext />
</@layout.body>
