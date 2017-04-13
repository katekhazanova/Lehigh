<@layout.head title="${runningAuditsPageContext.page.label}s and ${completedAuditsPageContext.page.label}s">
	<#if autoPoll>
		<meta http-equiv="refresh" content="${auditConfig.auditPollingRate}">
	</#if>
</@layout.head>

<@layout.body>
	<input type="hidden" id="pageGroup" value="audits"/>
<input type="hidden" id="mobilePageGroup" value="manageAudits"/>
	<div class="row">
		<div class="col-md-12">
			<#-- <p>The list may also contain Evaluated Courses.</p> -->
		
			<#if autoPoll>
				<div class="floatleft onethird aligncenter">
					<p>
						Last updated at ${lastUpdated?time?string.medium}
						<br />
						<#assign updateMsg = "updating every ${auditConfig.auditPollingRate} seconds" />
						<i class="fa fa-spinner fa-spin" aria-hidden="true"></i><span class="sr-only">Your audit is loading</span> ${updateMsg} (<@h.link href="/audit/list.html" title="stop" />)</span>
					</p>
				</div>
				<div class="floatright onethird alignright">
					<p>
				<a href="<@h.url href="/audit/list.html?autoPoll=true" />" class="btn btn-primary">Update</a>
			</p>
				</div>
			</#if>
		
			<#if runningAuditsCount gt 0>
				<h1 class="cleared" style="float: left"><@s.message 'uachieve.selfservice.audit.running.header' /></h1>
				<p style="float: right"><@h.link href="/audit/cancelrunning.html" title="Cancel Running Audits" /></p>
				<@p.masterView runningAuditsPageContext />
			</#if>
			
			<h1 class="cleared"><@s.message 'uachieve.selfservice.audit.completed.header' /></h1>	
			<p><@s.message 'uachieve.selfservice.audit.completed.text' /></p>
			
			<@p.masterView ctx=completedAuditsPageContext addButton="Run Audit"/>
		</div> <#-- /col-md-12 -->
	</div> <#-- /row -->
</@layout.body>