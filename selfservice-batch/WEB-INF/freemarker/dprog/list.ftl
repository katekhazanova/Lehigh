<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="profile"/>
	<#if flash.dprogsDeleted??>
		<#if flash.dprogsDeleted != 1>
			<h1>${flash.dprogsDeleted} degree programs were deleted</h1>
		<#else>
			<h1>${flash.dprogsDeleted} degree program was deleted</h1>
		</#if>
	</#if>

	<h1 class="cleared"><@s.message 'uachieve.selfservice.dprog.list.header'/></h1>
	<p><@s.message 'uachieve.selfservice.dprog.list.text'/></p>
	
	<@p.masterView pageContext />


</@layout.body>