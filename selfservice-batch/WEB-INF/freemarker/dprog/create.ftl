<@layout.head title="Create ${pageContext.page.label}" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="profile"/>
	<@p.detailView ctx=pageContext saveButton="Add"/>
	
</@layout.body>