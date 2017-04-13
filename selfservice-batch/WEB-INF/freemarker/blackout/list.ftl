<@layout.head title="${pageContext.page.label}s" />
<#import "/batch/_batch_macros.ftl" as batch>

<@layout.body>
<input type="hidden" id="pageGroup" value="batch"/>
<h1>Batch</h1>
<#--
	<h3 class="cleared"><@s.message 'uachieve.selfservice.course.list.header'/></h3>
	<p><@s.message 'uachieve.selfservice.course.list.text'/></p>
-->
	<@t.setSelectedTab tab='blackout/list' />
	<@t.printBatchTabs />
	<h2><@s.message 'uachieve.selfservice.batch.blackout.list.header' /></h2>
	<@p.masterView pageContext />

</@layout.body>

