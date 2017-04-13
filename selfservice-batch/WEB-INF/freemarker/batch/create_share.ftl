<@layout.head title="${pageContext.page.label}s" />
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<@p.detailViewBeforeForm>
		<@batch.batchTabs step=4 />
	</@p.detailViewBeforeForm>
	<@p.detailView ctx=pageContext />

</@layout.body>
