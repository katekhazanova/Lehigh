<@layout.head title="Create ${pageContext.page.label}" />
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
		<@p.detailViewBeforeForm>
		<@batch.batchTabs step=0/>
	</@p.detailViewBeforeForm>
	<@p.detailViewBeforeSaveButton>
		<input type="submit" class="btn btn-success" alt="Save & Continue" name="descriptionContinue" value="Save & Continue">
	</@p.detailViewBeforeSaveButton>
	<@p.detailView ctx=pageContext saveButton="Save & Finish" />
	
</@layout.body>