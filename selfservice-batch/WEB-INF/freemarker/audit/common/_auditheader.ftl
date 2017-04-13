<#if showAudit>
		<h2 class="sr-only">Student and Audit Information</h2>
				<div class="auditTitle">
					<div class="floatright" style="height:60px;">
						<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_AUDIT perm="C">
							<#if !printerFriendly>
								<@h.buttonAsLink src="" href="/audit/create.html" title="Request Audit" />
							</#if>
						</@sec.hasAppFnPerm>
					</div>
					<!--div -->
						${audit.prefixName!''} ${audit.firstName!''} ${audit.middleName!''} ${audit.lastName!''} ${audit.suffixName!''} ${audit.stuName!''}
					<!-- /div -->
					<br/>
					<#--if audit.dptitle1??>${audit.dptitle1!''} <br /></#if>
					<#if audit.dptitle2??>${audit.dptitle2!''} <br /></#if>
					<#if audit.webtitle??>${audit.webtitle!''} <br/></#if-->
					<#assign titleFields = auditConfig.dpTitleConfig.getDisplayValues(audit) />
					<#list titleFields as titleField>
						<#if titleField??>
							${titleField!''}<br/>
						</#if>
					</#list>
				</div>
				<div class="auditMessage"><@s.message 'uachieve.selfservice.audit.report.text'/></div>
				<table class="verticalListing auditHeaderTable">
					<tr>
						<th>Prepared On</th><td>${audit.rundate?string("MM/dd/yyyy hh:mm a")}</td>
						<th>Program Code</th><td>${audit.dprog!''}</td>									
						<th>Catalog Year</th><td>${termService.getFriendlyNameFromCode(audit.catlyt)!audit.catlyt}</td>
					</tr>
					<tr>
						<th>Student ID</th><td>${audit.stuno!''}</td>
						<th>Graduation Date</th><td>${audit.gradDate!''}</td>
						<#--th>Class Standing</th><td></td-->
						<#if auditConfig.showJobId>
							<th>Job ID</th><td>${audit.jobid!''}</td>
						</#if>
					</tr>
				</table>
	<#-- don't show charts if either: a) they're disabled or b) this is the printer friendly view -->
	
<#else>
	<#-- no audit to show, display welcome message -->
	
		<h1>Welcome to ${selfServiceConfig.applicationName}</h1>
		<div class="well">
			<p><strong>To run an audit:</strong></p>
			<ol>
				<li>Fill out the courses in the 'Manage Student' area <span class="subtle">(optional)</span>.</li>
				<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_AUDIT perm="C">
					<li>Press <@h.buttonAsLink src="" href="/audit/create.html" title="Request Audit" /> when you complete the courses list.</li>
				</@sec.hasAppFnPerm>
			</ol>
		</div>
</#if>	
