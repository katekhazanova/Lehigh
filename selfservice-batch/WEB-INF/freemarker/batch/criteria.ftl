<@layout.head title="${pageContext.page.label}" />
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<h1><@s.message 'uachieve.selfservice.batch.criteria.list.header' /></h1>
	<@batch.batchTabs step=2 />
	<@p.masterViewAfterAddButton>
		<@h.buttonAsLink src=" " 
			href="/batch/preview_criteria.html"
			title="Preview" />
	</@p.masterViewAfterAddButton>
	<@p.masterView pageContext "criteria" />
	<br/>
	<input type="button" class="btn btn-success" src=" " onclick="checkBatch()" title="Continue" value="Save & Continue"/>
	<a class="btn btn-primary" href="<@h.url href='/batch/list.html' />" role="button">Save & Finish</a>
	<a class="btn btn-default" href="<@h.url href='/batch/list.html' />" role="button">Cancel</a>
	
</@layout.body>
