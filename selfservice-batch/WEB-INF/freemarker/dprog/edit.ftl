<@layout.head title="Edit ${pageContext.page.label}" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="profile"/>
	<@p.detailView ctx=pageContext saveButton="Save"/>
	
</@layout.body>