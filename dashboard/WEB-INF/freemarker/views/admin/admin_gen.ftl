
<#include "admin_top.ftl">

	
	<h1 id="pagetitle" tabindex="0">General</h1>
	<br />
	<form name="updateGeneral" class="form-horizontal" role="form" action="admin_general.html" method="POST" >
		
		<@d.inputRowAdminCheck name="holdMessage" label="Hold Warning Message" max="100" value=holdMessage />
		<@d.textareaRowAdminCheck name="searchTip" label="Courses Not Found Message" max="500" value=searchTip />
		<@d.textareaRowAdminCheck name="scheduleHelp" label="Schedule Help Text" max="500" value=scheduleHelp />
		<@d.textareaRowAdminCheck name="noSession" label="No Session Text" max="500" value=noSession />
		<@d.inputRowAdminCheck name="instidq" label="instidq" max="2" value=instidq />
		<@d.inputRowAdminCheck name="instid" label="instid" max="8" value=instid />
		<@d.inputRowAdminCheck name="instcd" label="instcd" max="3" value=instcd />
		<@d.booleanRadioRowAdminCheck name="studentDisplayName" label="Display Student Name" value=studentDisplayName />
		<@d.booleanRadioRowAdminCheck name="studentDisplayNumber" label="Display Student Number" value=studentDisplayNumber />
		<@security.authorize ifAnyGranted=" SB_ADMIN_EDIT=u ">
			<@d.submitButtons />
		</@security.authorize>	</form>
	

<#include "admin_bot.ftl">