
<#include "admin_top.ftl">

	
	<h1 id="pagetitle" tabindex="0">Property Configurations</h1>
	<br />
	<form name="updateProperty" class="form-horizontal" role="form" action="admin_property.html" method="POST" >
		
		<@d.booleanRadioRowAdminCheck name="notificationsVisible" label="Display Notification Page" value=notificationsVisible />

	<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<@d.submitButtons />
	</@security.authorize>

	</form>
	

<#include "admin_bot.ftl">