<#if dpec.showCollege>
	<#assign previousDegreeProgramCollege = "" />
	<#if auditRequest.wifBreadcrumb.degreeProgramCollege.currentValue?? >
		<#assign previousDegreeProgramCollege = auditRequest.wifBreadcrumb.degreeProgramCollege.currentValue />
	</#if>
	<input type="hidden" name="previousDegreeProgramCollege" value="${previousDegreeProgramCollege}" />
	<input type="hidden" name="degreeProgramCollege" id="degreeProgramCollege" value="${auditRequest.wifBreadcrumb.degreeProgramCollege.currentValue}" />
	<span class="marker">${auditRequest.wifBreadcrumb.degreeProgramCollege.currentDisplay!""}</span>
</#if>

<#if dpec.showMajor>
	<#assign previousDegreeProgramMajor = "" />
	<#if auditRequest.wifBreadcrumb.degreeProgramMajor.currentValue?? >
		<#assign previousDegreeProgramMajor = auditRequest.wifBreadcrumb.degreeProgramMajor.currentValue />
	</#if>
	<input type="hidden" name="previousDegreeProgramMajor" value="${previousDegreeProgramMajor}" />
	<input type="hidden" name="degreeProgramMajor" id="degreeProgramMajor" value="${auditRequest.wifBreadcrumb.degreeProgramMajor.currentValue}" />
	<#if dpec.showCollege><strong> > </strong></#if><span class="marker"> ${auditRequest.wifBreadcrumb.degreeProgramMajor.currentDisplay!""}</span>
</#if>
	
<#if dpec.showDegree>
	<#assign previousDegreeProgramDegree = "" />
	<#if auditRequest.wifBreadcrumb.degreeProgramDegree.currentValue?? >
		<#assign previousDegreeProgramDegree = auditRequest.wifBreadcrumb.degreeProgramDegree.currentValue />
	</#if>
	<input type="hidden" name="previousDegreeProgramDegree" value="${previousDegreeProgramDegree}" />
	<input type="hidden" name="degreeProgramDegree" id="degreeProgramDegree" value="${auditRequest.wifBreadcrumb.degreeProgramDegree.currentValue!""}" />
	<#if dpec.showCollege || dpec.showMajor><strong> > </strong></#if><span class="marker">${auditRequest.wifBreadcrumb.degreeProgramDegree.currentDisplay!""}</span>
</#if>
	
<#assign previousWhatIfDegreeProgram = "" />
<#if auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentValue?? >
	<#assign previousWhatIfDegreeProgram = auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentValue />
</#if>
<input type="hidden" name="previousWhatIfDegreeProgram" value="${previousWhatIfDegreeProgram}" />
<input type="hidden" name="whatIfDegreeProgram" value="${auditRequest.whatIfDegreeProgram}" />
<input type="hidden" name="auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentDisplay" value="${auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentDisplay!""}" />
<span class="marker"> ${auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentDisplay!""}</span>