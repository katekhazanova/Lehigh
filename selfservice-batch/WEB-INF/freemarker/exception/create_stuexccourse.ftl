<@layout.head title="Create ${pageContext.page.label}" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="exception"/>
	<#-- need to pass in save button image as saveButton param  cancelButton="/images/bt_Back2List.png" -->

	<@p.detailView ctx=pageContext saveButton="Add To List" cancelText="Return" />
	<@p.masterView ctx=stuExcCoursePageContext deleteButton="Remove" deleteHeader="Remove" />
	
</@layout.body>