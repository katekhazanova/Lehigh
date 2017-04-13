<@layout.head title="Edit Blackout" >
<#assign jawr=JspTaglibs["/WEB-INF/tld/jawr.tld"]>

</@layout.head>

<@layout.body>
<input type="hidden" id="pageGroup" value="batch"/>
<h1>Batch</h1>
	<@t.setSelectedTab tab='blackout/list' />
	<@t.printBatchTabs />
	<h2>Edit Blackout</h2>
	<#include "_blackout_form.ftl"/>
</@layout.body>