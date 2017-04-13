<@layout.head title="Create Blackout">
<#assign jawr=JspTaglibs["/WEB-INF/tld/jawr.tld"]>

</@layout.head>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<@t.setSelectedTab tab='blackout/list' />
	<@t.printBatchTabs />
	<h1>Add Blackout</h1>
	<#include "_blackout_form.ftl"/>
</@layout.body>