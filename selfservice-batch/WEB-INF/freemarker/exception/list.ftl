<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="exception"/>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.exception.list.header'/></h1>
	<p><@s.message 'uachieve.selfservice.exception.list.text'/></p>
	
	<@p.masterView pageContext />

	<div align="center">
		<i class="fa fa-exclamation-triangle" title="Unconfigured Exception Type" style="color:#f5d852; ">
			<span class="sr-only">unconfigured exception type icon</span>
		</i>  denotes an unconfigured exception type. <br/>
		<i class="fa fa-lock fa-lg" title="Unauthorized Exception Type" style="color:#808080; ">
			<span class="sr-only">unauthorized exception type icon</span>
		</i> user is not authorized to edit exception.
	</div>
</@layout.body>