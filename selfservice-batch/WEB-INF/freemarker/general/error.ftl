<@layout.head title="Error" />
<@layout.body>
	<div class="aligncenter">
		<h1>There has been an error processing your request.</h1>
		<div style="font-size: 1500%; color: #d9534f;" aria-hidden="true">
			<i class="fa fa-exclamation-circle" alt="Error" title="Error"></i>
		</div>
		<span class="sr-only">Error</span>
		<p>Please try again later.</p>
		<p><#if referer??><a href="${referer}" style="font-size: 123.1%; font-weight: bold;">Back</a> | </#if>
			<@sec.isLoggedIn>
				<@sec.isAdvisor>
					<a href="<@h.url href='/general/home.html' />" title="Home" alt="Home">Home</a>
				</@sec.isAdvisor>
				<@sec.isStudent>
					<@sec.isNotAdvisor>
						<a href="<@h.url href='/general/loginroute.html' />" title="Home" alt="Home">Home</a>
					</@sec.isNotAdvisor>
				</@sec.isStudent>
			</@sec.isLoggedIn>
		</p>
	</div>
</@layout.body>