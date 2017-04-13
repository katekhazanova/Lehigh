<@layout.head title='There was a Problem with Your Audit' />

<@layout.body>
	<div class="aligncenter">
		<h1>There was a Problem with Your Audit</h1>
		<p class="alert alert-warning">
			Your audit is taking a very long time to complete, which typically means that there was a problem with your audit.
		</p>
		<p>
			You can <a href="${refreshUrl}?id=${id}">continue to wait for your audit to complete</a>, or you can <@h.link href="/audit/create.html" title="request a new audit" />.
		</p>
	</div>
</@layout.body>