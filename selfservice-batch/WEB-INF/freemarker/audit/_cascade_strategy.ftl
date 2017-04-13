
<#if dpec.showCollege>
	<label for="degreeProgramCollege"><@s.message 'uachieve.selfservice.college'/></label>
	<#assign previousDegreeProgramCollege = "" />
	<#if auditRequest.degreeProgramCollege??>
		<#assign previousDegreeProgramCollege = auditRequest.degreeProgramCollege />
	</#if>
	<input type="hidden" name="previousDegreeProgramCollege" value="${previousDegreeProgramCollege}" />
	<select class="form-control"  name="degreeProgramCollege" id="degreeProgramCollege">
		<option value="">-</option>
		<#list degreeProgramColleges?sort_by("college") as dprog>
			<option value="${dprog.college!""}" 
				<#if auditRequest.degreeProgramCollege?? && dprog.college?? && dprog.college == auditRequest.degreeProgramCollege>
					selected="true"
				</#if>
				>${dprog.college!""}
			</option>
		</#list>
	</select>
	<@refresher "degreeProgramCollege" />
	<#assign dprogLineBreak = true />
</#if>

<#if dpec.showMajor>
	<#if dprogLineBreak??><br /></#if>
	<label for="degreeProgramMajor">Major:</label>
	<#assign previousDegreeProgramMajor = "" />
	<#if auditRequest.degreeProgramMajor?? >
		<#assign previousDegreeProgramMajor = auditRequest.degreeProgramMajor />
	</#if>
	<input type="hidden" name="previousDegreeProgramMajor" value="${previousDegreeProgramMajor}" />
	<select class="form-control"  name="degreeProgramMajor" id="degreeProgramMajor">
		<option value="">-</option>
		<#list degreeProgramMajors?sort_by("major") as dprog>
				<option value="${dprog.major!""}" 
					<#if auditRequest.degreeProgramMajor?? && dprog.major?? && dprog.major == auditRequest.degreeProgramMajor>
						selected="true"
					</#if>
					>${dprog.major!""}
				</option>
		</#list>
	</select>
	<@refresher "degreeProgramMajor" />
	<#assign dprogLineBreak = true />
</#if>

<#if dpec.showDegree>
	<#if dprogLineBreak??><br /></#if>
	<label for="degreeProgramDegree">Degree:</label>
	<#assign previousDegreeProgramDegree = "" />
	<#if auditRequest.degreeProgramDegree?? >
		<#assign previousDegreeProgramDegree = auditRequest.degreeProgramDegree />
	</#if>
	<input type="hidden" name="previousDegreeProgramDegree" value="${previousDegreeProgramDegree}" />
	<select class="form-control"  name="degreeProgramDegree" id="degreeProgramDegree">
		<option value="">-</option>
		<#list degreeProgramDegrees?sort_by("degree") as dprog>
			<option value="${dprog.degree!""}" 
				<#if auditRequest.degreeProgramDegree?? && dprog.degree?? && dprog.degree == auditRequest.degreeProgramDegree>
					selected="true"
				</#if>
				>${dprog.degree!""}
			</option>
		</#list>
	</select>
	<@refresher "degreeProgramDegree" />
</#if>

<tr>
	<td valign="top" >
	<br/>
		<!-- only needed for wif + cascase audits -->
		<label for="whatIfDegreeProgram">Program: </label>
	</td>
	<td>
	<br/>
		<#assign previousWhatIfDegreeProgram = "" />
		<#if auditRequest.whatIfDegreeProgram?? >
			<#assign previousWhatIfDegreeProgram = auditRequest.whatIfDegreeProgram />
		</#if>
		<input type="hidden" name="previousWhatIfDegreeProgram" value="${previousWhatIfDegreeProgram}" />
		<#if dprogOptions?size == 1 && auditRequest.whatIfDegreeProgram??>
			<input type="hidden" name="whatIfDegreeProgram" id="whatIfDegreeProgram" value="${auditRequest.whatIfDegreeProgram}" />
			<span class="marker">${auditRequest.wifBreadcrumb.whatIfDegreeProgram.currentDisplay}</span>
		<#else>
			<select class="form-control"  name="whatIfDegreeProgram" id="whatIfDegreeProgram">
				<option value="">-</option>
				<#if dprogOptions??>
					<#list dprogOptions as dprogOption>
						<#assign selected = auditRequest.whatIfDegreeProgram?? && dprogOption.name?trim == auditRequest.whatIfDegreeProgram?trim />
						<option value="${dprogOption.name}" <#if selected>selected="selected"</#if>>${dprogOption.label}</option>
					</#list>
				</#if>
			</select>
			<@refresher "whatIfDegreeProgram" />
		</#if>
	</td>