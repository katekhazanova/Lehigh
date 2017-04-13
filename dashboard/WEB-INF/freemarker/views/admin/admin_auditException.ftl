
<#include "admin_top.ftl">

	
	<h1 id="pagetitle" tabindex="0">Audit Exceptions</h1>

	<form name="updateAuditException" class="form-horizontal" role="form" action="admin_auditException.html" method="POST" >

		<@d.ctlcdConfigsRows action="R" ruflag="U/I" pseudo="blank" force="blank" delig="X" id="reqAdjust" label="Edit Requirement/Sub-Requirement" ctlcd=reqAdjustCtlcd note=reqAdjustNote memo=reqAdjustMemo/>
		<@d.ctlcdConfigsRows action="E" ruflag="blank" pseudo="C" force="F" delig="blank" id="forceComplete" label="Force Requirement/Sub-requirement Complete" ctlcd=forceCompleteCtlcd note=forceCompleteNote memo=forceCompleteMemo/>
		<@d.ctlcdConfigsRows action="C/S" ruflag="P" pseudo="blank" force="blank" delig="+" id="forceCourse" label="Force Course" ctlcd=forceCourseCtlcd note=forceCourseNote memo=forceCourseMemo/>
		<@d.ctlcdConfigsRows action="R" ruflag="U/I" pseudo="blank" force="blank" delig="blank" id="addCourse" label="Add Sub-Requirement Course" ctlcd=addCourseCtlcd note=addCourseNote memo=addCourseMemo/>
		<@d.ctlcdConfigsRows action="R" ruflag="D" pseudo="blank" force="blank" delig="blank" id="removeCourse" label="Delete Sub-Requirement Course" ctlcd=removeCourseCtlcd note=removeCourseNote memo=removeCourseMemo/>
		<@d.ctlcdConfigsRows action="R" ruflag="S" pseudo="blank" force="blank" delig="blank" id="swapCourse" label="Swap Sub-Requirement Courses" ctlcd=swapCourseCtlcd note=swapCourseNote memo=swapCourseMemo/>
		
		<@d.submitButtons />
	</form>

<#include "admin_bot.ftl">
