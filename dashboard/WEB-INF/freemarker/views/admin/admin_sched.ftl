
<#include "admin_top.ftl">

	<h1 id="pagetitle" tabindex="0">Schedule</h1>
	<br />
	<form name="updateConfigs" class="form-horizontal" role="form" action="admin_schedule.html" method="POST" >
	
		<@d.booleanRadioRow name="SCHED_FULL" label="Schedule Full Sessions" value=SCHED_FULL />
		<@d.booleanRadioRow name="ENABLE_BUSYTIME" label="Enable Busy Times" value=ENABLE_BUSYTIME />
		<@d.booleanRadioRow name="ENABLE_ADD_TO_CART" label="Enable Pre-Enroll" value=ENABLE_ADD_TO_CART />
		<@d.numericalInputRow name="MIN_SCHEDULES_TO_GENERATE" label="Minimum Number of Schedules to Generate" min="1" max="the \"Maximum Number of Schedules to Generate\"" value=MIN_SCHEDULES_TO_GENERATE />
		<@d.numericalInputRow name="MAX_SCHEDULES_TO_GENERATE" label="Maximum Number of Schedules to Generate" min="the \"Minimum Number of Schedules to Generate\"" max="100" value=MAX_SCHEDULES_TO_GENERATE />
		<@d.numericalInputRow name="THUMBNAIL_START_HOUR" label="Thumbnail Start Hour" min="0" max="the \"Thumbnail End Hour\"" value=THUMBNAIL_START_HOUR />
		<@d.numericalInputRow name="THUMBNAIL_END_HOUR" label="Thumbnail End Hour" min="the \"Thumbnail Start Hour\"" max="24" value=THUMBNAIL_END_HOUR />
		<@d.numericalInputRow name="MAX_SCHEDULES_TO_SAVE" label="Maximum Number of Schedules a Student can Save" min="0" max="20" value=MAX_SCHEDULES_TO_SAVE />
		<@d.submitButtons />
	</form>

<#include "admin_bot.ftl">