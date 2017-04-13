
<#if selectedReqId??>
	<input type="hidden" id="selectedReqId" value="${selectedReqId}">
</#if>

<#if popPseudo??>
	<input type="hidden" id="popPseudo" value="${popPseudo}">
</#if>

<#-- ========== DISPLAY AUDIT ========== -->  	
  	<div class="row">
  	
  		<h1 class="sr-only">Exception Mode</h1>
		<h2 class="sr-only">Student and Audit Information</h2>
  	
		<div class="col-md-2" style="font-size:14px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
			${audit.prefixName!''} ${audit.firstName!''} ${audit.middleName!''} ${audit.lastName!''} ${audit.suffixName!''} ${audit.stuName!''}
		</div>
		<div class="col-md-3" style="font-size:14px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
				<#if audit.dptitle1??>${audit.dptitle1!''} <br /></#if>
					<#if audit.dptitle2??>${audit.dptitle2!''} <br /></#if>
					<#if audit.webtitle??>${audit.webtitle!''} <br/></#if>
		</div>
		<div class="col-md-2" style="font-size:14px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
			${audit.dprog!''}
		</div>
		<div class="col-md-2" style="font-size:14px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
			${termService.getFriendlyNameFromCode(audit.catlyt)!audit.catlyt}
		</div>
		<div class="col-md-3">
			<a class="btn btn-default pull-right" href="<@s.url />/audit/read.html">Exit Exception Mode</a>
		</div>
	</div>
	
	<hr style="margin-top: 0px;">
	
	<div class="row">
		<div id="ExceptionAdded" class="col-md-offset-3 col-md-6 alert alert-success" style="display:none;">
			<center><strong>Success!</strong> One or more Exceptions have been recently added please run the audit for them to apply.</center>
		</div>
		<div id="loadingAudit" class="col-md-offset-3 col-md-6 alert alert-info" style="display:none;">
			<#assign updateMsg = "updating every ${auditConfig.auditPollingRate} seconds" />
			<center><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> <strong>Loading...</strong> The audit you requested is running, ${updateMsg}</center>
		</div>
	</div>