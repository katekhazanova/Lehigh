<@layout.head title="Edit ${pageContext.page.label}" />
<#import "_batch_macros.ftl" as batch>
<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<@p.detailViewBeforeHeader>
		<@batch.batchTabs step=4/>
	</@p.detailViewBeforeHeader>
	<@p.detailView pageContext />
	
</@layout.body>