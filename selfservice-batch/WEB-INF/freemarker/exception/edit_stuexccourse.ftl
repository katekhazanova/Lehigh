<@layout.head title="Edit ${pageContext.page.label}" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="exception"/>
	<@p.detailView ctx=pageContext saveButton="Save" cancelText="Return" />
	<@p.masterView ctx=stuExcCoursePageContext deleteButton="Remove" deleteHeader="Remove" />
		
</@layout.body>