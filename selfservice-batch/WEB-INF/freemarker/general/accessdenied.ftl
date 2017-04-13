<@layout.head title="Access Denied" />
<@layout.body>
	<div style="height:600px;width:100%;text-align:center;">
		<div aria-hidden="true" style="font-size: 1500%; color: #d9534f;">
			<i title="Error" alt="Error" class="fa fa-exclamation-circle"></i>
			<span class="sr-only">Error</span>
		</div>
		<h2>Access is Denied</h2>
		<p>You lack sufficient credentials to perform the action you are trying to perform.</p>
		<p>If you feel you are getting this message in error, contact your system administrator.</p>
		<p>
			<a href="<@h.url href='/general/logout.html' />" title="Log Out" alt="Log Out">
				<i class="fa fa-sign-out fa-lg"></i> Log Out
			</a>
		</p>
	</div>

</@layout.body>