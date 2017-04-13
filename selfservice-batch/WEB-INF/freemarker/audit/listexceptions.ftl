<#import "_macros.ftl" as auditMacros>
<@layout.head title="My Audit - Applied Exceptions Tab" />

<@layout.body>
<input type="hidden" id="pageGroup" value="audits"/>
	<#include '/audit/common/_auditheader.ftl' />
	
	<@t.setSelectedTab tab='audit/listexceptions' />
	<@t.printAuditTabs auditQueryParams />
<#if showExceptions>
	<br />
	<@s.message 'uachieve.selfservice.appliedExceptions.text' />
	<br />
	<@p.masterView pageContext />
</#if>
</@layout.body>