<@layout.head title='Loading Your Audit'>
	<meta http-equiv="refresh" content="${auditConfig.auditPollingRate};url=${refreshUrl}?id=${id}&refreshCount=${refreshCount}">
</@layout.head>

<@layout.body>
	<div class="aligncenter">
		<h1><@s.message 'uachieve.selfservice.audit.loading.header' /></h1>
		<p><i class="fa fa-spinner fa-spin" aria-hidden="true"></i><span class="sr-only">Your audit is loading</span></p>
		<p><@s.message 'uachieve.selfservice.audit.loading.text' /><span class="subtle">(<@h.link href="/audit/list.html?autoPoll=true" title="more..." />).</span></p>
	</div>
</@layout.body>