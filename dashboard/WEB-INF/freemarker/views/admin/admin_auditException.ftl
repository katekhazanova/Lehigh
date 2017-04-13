
<#include "admin_top.ftl">

	
	<h1 id="pagetitle" tabindex="0">Audit Exceptions</h1>

	<form name="updateAuditException" class="form-horizontal" role="form" action="admin_auditException.html" method="POST" >

		<@d.ctlcdConfigsRowsAdminCheck action="R" ruflag="U/I" pseudo="blank" force="blank" delig="X" id="reqAdjust" label="Edit Requirement/Sub-Requirement" ctlcd=reqAdjustCtlcd note=reqAdjustNote memo=reqAdjustMemo/>
		<@d.ctlcdConfigsRowsAdminCheck action="E" ruflag="blank" pseudo="C" force="F" delig="blank" id="forceComplete" label="Force Requirement/Sub-requirement Complete" ctlcd=forceCompleteCtlcd note=forceCompleteNote memo=forceCompleteMemo/>
		<@d.ctlcdConfigsRowsAdminCheck action="C/S" ruflag="P" pseudo="blank" force="blank" delig="+" id="forceCourse" label="Force Course" ctlcd=forceCourseCtlcd note=forceCourseNote memo=forceCourseMemo/>
		<@d.ctlcdConfigsRowsAdminCheck action="R" ruflag="U/I" pseudo="blank" force="blank" delig="blank" id="addCourse" label="Add Sub-Requirement Course" ctlcd=addCourseCtlcd note=addCourseNote memo=addCourseMemo/>
		<@d.ctlcdConfigsRowsAdminCheck action="R" ruflag="D" pseudo="blank" force="blank" delig="blank" id="removeCourse" label="Delete Sub-Requirement Course" ctlcd=removeCourseCtlcd note=removeCourseNote memo=removeCourseMemo/>
		<@d.ctlcdConfigsRowsAdminCheck action="R" ruflag="S" pseudo="blank" force="blank" delig="blank" id="swapCourse" label="Swap Sub-Requirement Courses" ctlcd=swapCourseCtlcd note=swapCourseNote memo=swapCourseMemo/>
		
	<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u">
		<@d.submitButtons />
	</@security.authorize>
	</form>

<#include "admin_bot.ftl">
