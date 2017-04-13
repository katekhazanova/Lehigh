	
<#include "admin_top.ftl">
	
	<h1 id="pagetitle" tabindex="0">Home Page</h1>
	<br />
	<form name="updateHome" class="form-horizontal" role="form" action="admin_Home.html" method="POST" >
	
		<@d.textareaRowAdminCheck name="welcomeText" label="Welcome text" max="750" value=welcomeText />
		<@security.authorize ifAnyGranted="SB_ADMIN_EDIT=u">
			<@d.submitButtons />
		</@security.authorize>	</form>
	

<#include "admin_bot.ftl">