<@layout.head title="${pageContext.page.label}s" />
<#import "/batch/_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<@t.setSelectedTab tab='batchresult/results' />
	<@t.printBatchTabs />
	<h1><@s.message 'uachieve.selfservice.batch.runResult.list.header' /></h1>

	<@p.masterViewBeforeAddButton>
		<@h.buttonAsLink src="/images/bt_Back2List.png" href="/batchresult/results.html" title="Back to Result List" />
	</@p.masterViewBeforeAddButton>
	<@p.masterViewAfterDeleteButton>
		<#if numAudits gt 0>
			<#if hasPdfResults>
				<@h.buttonAsLink src="/images/bt_open_all_pdf.gif" 
					href="/batchresult/openAllPDF.html?batchid=${batchid}" 
					title="Open All in PDF" />
			</#if>
			<#if hasTxtResults>
				<@h.buttonAsLink src="/images/bt_open_all_txt.png" 
				href="/batchresult/openAllTxt.html?batchid=${batchid}" 
				title="Open All Txt as Pdf" />
			</#if>
		</#if>
	</@p.masterViewAfterDeleteButton>
	<@p.masterView pageContext />

</@layout.body>

