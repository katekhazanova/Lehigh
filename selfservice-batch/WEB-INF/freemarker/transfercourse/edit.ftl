<@layout.head title="Edit ${pageContext.page.label}" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="courses"/>
<input type="hidden" id="mobilePageGroup" value="transferCourses"/>
	<@p.detailView ctx=pageContext saveButton="Save" />
	
</@layout.body>