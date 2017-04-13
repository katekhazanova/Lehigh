<@layout.head title="${pageContext.page.label}s" />
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<h1><@s.message 'uachieve.selfservice.batch.share.list.header' /></h1>
	<@batch.batchTabs step=4 />
	<@p.masterView pageContext />
	
	<br/>
	<@h.buttonAsLink src=" " href="/batch/list.html" title="Save & Finish" />
	<a class="btn btn-default" href="<@h.url href='/batch/list.html' />" role="button">Cancel</a>
</@layout.body>