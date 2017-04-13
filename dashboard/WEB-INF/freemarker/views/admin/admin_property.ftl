
<#include "admin_top.ftl">

	
	<h1 id="pagetitle" tabindex="0">Property Configurations</h1>
	<br />
	<form name="updateProperty" class="form-horizontal" role="form" action="admin_property.html" method="POST" >
		

		<@d.booleanRadioRow name="notificationsVisible" label="Display Notification Page" value=notificationsVisible />
		<@d.submitButtons />
	</form>
	

<#include "admin_bot.ftl">