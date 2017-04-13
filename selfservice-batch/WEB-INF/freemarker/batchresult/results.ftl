<@layout.head title="Batch Results" />

<@layout.body>
<input type="hidden" id="pageGroup" value="batch"/>
<h1>Batch</h1>
<#--
	<h3 class="cleared"><@s.message 'uachieve.selfservice.course.list.header'/></h3>
	<p><@s.message 'uachieve.selfservice.course.list.text'/></p>
-->
	<@t.setSelectedTab tab='batchresult/results' />
	<@t.printBatchTabs />
	<h2><@s.message 'uachieve.selfservice.batch.runResult.list.header' /></h2>
	<@p.masterView pageContext />

</@layout.body>