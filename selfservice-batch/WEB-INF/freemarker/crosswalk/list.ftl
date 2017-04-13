<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="tools"/>
	<input type="hidden" id="mobilePageGroup" value="crosswalk"/>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.crosswalk.list.header'/></h1>
	<p><@s.message 'uachieve.selfservice.crosswalk.list.text'/></p>

	<@p.masterView pageContext />
	
</@layout.body>