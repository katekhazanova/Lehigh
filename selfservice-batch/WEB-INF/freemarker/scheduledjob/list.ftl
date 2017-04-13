<@layout.head title="${pageContext.page.label}s">
</@layout.head>
<#import "/batch/_batch_macros.ftl" as batch>

<@layout.body>
<input type="hidden" id="pageGroup" value="batch"/>
<h1>Batch</h1>
	<@t.setSelectedTab tab='scheduledjob/list' />
	<@t.printBatchTabs />
	<h2><@s.message 'uachieve.selfservice.batch.scheduledJob.list.header' /></h2>
	<@p.masterView ctx=pageContext deleteButton="Unschedule" deleteHeader="Unschedule"/>

</@layout.body>

