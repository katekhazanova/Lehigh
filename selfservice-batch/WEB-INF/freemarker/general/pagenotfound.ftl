<@layout.head title="Page Not Found" />
<@layout.body>

	
	<div class="aligncenter">
		<h1><@s.message 'uachieve.selfservice.general.pagenotfound.text'/></h1>
		<div style="font-size: 1500%; color: #d9534f;" aria-hidden="true">
			<i class="fa fa-exclamation-circle" alt="Error" title="Error"></i>
			<span class="sr-only">Error</span>
		</div>
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