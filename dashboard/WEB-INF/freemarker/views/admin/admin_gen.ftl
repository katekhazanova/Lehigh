
<#include "admin_top.ftl">

	
	<h1 id="pagetitle" tabindex="0">General</h1>
	<br />
	<form name="updateGeneral" class="form-horizontal" role="form" action="admin_general.html" method="POST" >
		
		<@d.inputRow name="holdMessage" label="Hold Warning Message" max="100" value=holdMessage />
		<@d.textareaRow name="searchTip" label="Courses Not Found Message" max="500" value=searchTip />
		<@d.textareaRow name="scheduleHelp" label="Schedule Help Text" max="500" value=scheduleHelp />
		<@d.textareaRow name="noSession" label="No Session Text" max="500" value=noSession />
		<@d.inputRow name="instidq" label="instidq" max="2" value=instidq />
		<@d.inputRow name="instid" label="instid" max="8" value=instid />
		<@d.inputRow name="instcd" label="instcd" max="3" value=instcd />
		<@d.booleanRadioRow name="studentDisplayName" label="Display Student Name" value=studentDisplayName />
		<@d.booleanRadioRow name="studentDisplayNumber" label="Display Student Number" value=studentDisplayNumber />
		<@d.submitButtons />
	</form>
	

<#include "admin_bot.ftl">