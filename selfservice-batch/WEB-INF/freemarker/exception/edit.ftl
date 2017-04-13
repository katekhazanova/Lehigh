<@layout.head title="Edit ${pageContext.page.label}" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="exception"/>
	<#-- only show StuExcCourses if the action type (action) of the parent StuException == R -->
	<#if showStuExcCourses>	
		<@p.detailViewInsideForm>
			<input type="hidden" name="courseEdit" id="courseEdit" value="" />
			<input type="hidden" name="courseEditId" id="courseEditId" value="" />
		</@p.detailViewInsideForm>
		<@p.detailViewAfterForm>
			<@p.masterView ctx=stuExcCoursePageContext deleteButton="Remove" deleteHeader="Remove" />
			<br/>
		</@p.detailViewAfterForm>
	</#if>
	<@p.detailView ctx=pageContext saveButton="Save"/>
	
	<script type="text/javascript">
		Event.observe(window, 'load', function() {
			selfservice.exception.initExceptions();
		});
	</script>
</@layout.body>