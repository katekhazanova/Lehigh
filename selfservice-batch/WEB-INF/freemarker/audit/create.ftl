<#assign form=JspTaglibs["/WEB-INF/tld/spring-form.tld"] />

<#macro refresher id>
	
	<#-- span that will hold a spinner image when refreshing -->
	<span id="${id}_spinner">&nbsp;</span>
</#macro>

<@layout.head title="Run Audit" />

<@layout.body autoScroll=true>
<input type="hidden" id="pageGroup" value="audits"/>
<input type="hidden" id="mobilePageGroup" value="requestAudit"/>

<#if createPlan != "true">
	<h1 class="cleared"><@s.message 'uachieve.selfservice.audit.request.header' /></h1>
<#else>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.plan.request.header' /></h1>
</#if>

<#if auditRunError>
	<p id="auditRunError" style="display:inline-block;" aria-hidden="false" class="alert alert-danger" role="alert" tabindex="0"><@s.message 'invalid.mustPickRequiredMarker'/></p>
<#else>
	<p id="auditRunError" style="display:none;" aria-hidden="true" class="alert alert-danger" role="alert" tabindex="-1"><@s.message 'invalid.mustPickRequiredMarker'/></p>
</#if>

<div class="row">

	<form name="auditRequest" id="auditRequest" method="post"<#if createPlan == "true"> action="${udirectRemoteLogin}/plan/manage/create-plan-lite.html?crossApp=${crossApp}"</#if>>
		<div class="col-md-12">
			<div>
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="false">
  				
				
				<#assign dpec = auditConfig.degreeProgramEntryConfig />	
				<#if auditConfig.allowDefaultDegreePrograms && createPlan != "true">
					<#include "_default_dprog.ftl" />
				</#if>
				<#if auditConfig.allowWhatIfDegreePrograms>
					<div class="panel panel-default">
					    <div class="panel-heading" role="tab" id="selectedProgramHeading">
					     
					        <a data-toggle="collapse" data-parent="#accordion" href="<#if auditRequest.useDefaultDegreePrograms>#selectedProgram</#if>" aria-expanded="<#if auditRequest.useDefaultDegreePrograms>false<#else>true</#if>" aria-controls="selectedProgram" onclick="removeAccordianHref('selectedProgram', 'Different Program', 'false', 'accordion');" keydown="removeAccordianHrefRadioKeyDown(event ,'selectedProgram', 'Different Program', 'false', 'accordion');">
					          <strong><i class="fa fa-caret-<#if auditRequest.useDefaultDegreePrograms>right<#else>down</#if>"></i> Select a Different Program:</strong>
					        </a>
					    </div>
				
				
				<div id="selectedProgram" class="panel-collapse collapse <#if !auditRequest.useDefaultDegreePrograms || !auditConfig.allowDefaultDegreePrograms>in</#if>" role="tabpanel" aria-labelledby="selectedProgramHeading">
      				<div class="panel-body">
					<div>		
						<p>
							<@s.message 'uachieve.selfservice.audit.runSelectedProgram.message' />
						</p>
						<div id="whatIfInputs">						
							<table class="markerDivider">
								<tr>
									<div id="addCatalogYearMessage" style="display: none;"><@s.message 'uachieve.selfservice.addCatalogYear' /></div>	
									<div id="collegeMessage" style="display: none;"><@s.message 'uachieve.selfservice.college' /></div>	
									<td class="left">
										<span><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> Loading</span>
									</td>
									<td class="right"></td>
								</tr>
							</table>
						</div>
					</div>
					</div> <!-- /panel-body selectedProgram -->
			    </div> <!-- /panel-collapse selectedProgram -->
			  </div> <!-- /panel selectedProgram -->
				</#if>
				</div> <!-- /panel-group -->			
			</div>
		</div> <#-- /col-md-12 -->
		<br>
		
		<#if createPlan != "true">
		<div class="col-md-12">
		<hr style="clear: both"/>
			<h4>Advanced Settings <span class="help"><a  data-toggle="collapse" href="#options" aria-expanded="false" aria-controls="options">
					Click to view available options.
				</a></span></h4>
			
		</div>
		
		<div class="col-md-4 collapse" id="options" aria-expanded="false">
			<div class="well">
				<@p.detailViewBeforeButtons>
					<#if comKeys??>
						<tr>
							<th><label for="comKey">COM</label></th>
							<td>
								<select class="form-control"  name="comKey" id="comKey">
									<#list comKeys?keys as key>
										<option value="${key}" <#if auditRequest.comKey?? && key == auditRequest.comKey>selected="true"</#if>>${key} - ${comKeys[key]}</option>
									</#list>
								</select>
							</td>
						</tr>
					</#if>
					<#if soprids??>
						<tr>
							<th><label for="soprid">SOPRID</label></th>
							<td>
								<select class="form-control"  name="soprid" id="soprid">
									<#list soprids as soprid>
										<option value="${soprid}" <#if auditRequest.soprid?? && soprid == auditRequest.soprid>selected="true"</#if>>${soprid}</option>
									</#list>
								</select>
							</td>
						</tr>
					</#if>
				</@p.detailViewBeforeButtons>
				<@p.detailView auditRequestOptionsPageContext false />
			</div>
			
		</div> <#-- /col-md-4 -->
		<#else>
		<input type="hidden" name="createPlan" value="true" />
		<div class="col-md-6" style="clear: both">
			<h4>Enter <@s.message 'udirect.plans.header'/> Information</h4>
		
		<div class="form-horizontal">
			<div class="form-group">
				<label for="planName" class="control-label col-md-4"><b><@s.message 'udirect.plans.header'/> Name:</b></label>
				<div class="col-md-8">
					<input type="text" id="planName" name="planName" class="udirect form-control" value="${planName!''}" class="form-control" minlength="1" maxlength="64">
				</div>													
				<#list planNames as planNameOther>
					<div class="planNames" style="display:none;" >${planNameOther}</div>
				</#list>
			</div>
			<div class="form-group">	
				<label for="termBegin" class="control-label col-md-4"><b><@s.message 'udirect.term.header'/>:</b></label>
					<div class="col-md-8">
						<select name="termBegin" id="termBegin" class="form-control"> 
							<#assign termKeys = terms?keys>
							<#list termKeys as term>
								<option value="${term}" <#if term == termBegin!''>selected</#if>>${terms[term]}</option>
							</#list>
						</select>
					</div>
					<div id="regCutOffs" style="display:none;">
						<#assign regCutOffKeys = regCutOffs?keys>
						<#list regCutOffKeys as regCutOff>
							<span id="${regCutOff}">${regCutOffs[regCutOff]}</span>
						</#list>
					</div>
			</div>
			<div class="form-group">	
				<label for="yearBegin" class="control-label col-md-4"><b><@s.message 'udirect.year.header'/>:</b></label>
				<div class="col-md-8">
				<input type="text" id="yearBegin" name="yearBegin" value="${yearBegin!currentYearTerm[0..3]}" maxlength="4" class="udirect form-control" onkeyup="this.value = validNum(this.value)" class="form-control" minlength="4">
				</div>
				<div id="currentYearTerm" style="display:none;">${currentYearTerm}</div>
			</div>
			<div class="form-group">
					<label for="numberOfYears" class="control-label col-md-4"><b><@s.message 'udirect.year.header'/>s To Graduation:</b></label>
					<div class="col-md-8">
						<select id="numberOfYears" name="numberOfYears" class="form-control">
								<option value="1" <#if defaultYears == 1>selected</#if>>1</option>
								<option value="2" <#if defaultYears == 2>selected</#if>>2</option>
								<option value="3" <#if defaultYears == 3>selected</#if>>3</option>
								<option value="4" <#if defaultYears == 4>selected</#if>>4</option>
								<option value="5" <#if defaultYears == 5>selected</#if>>5</option>
								<option value="6" <#if defaultYears == 6>selected</#if>>6</option>
								<option value="7" <#if defaultYears == 7>selected</#if>>7</option>
								<option value="8" <#if defaultYears == 8>selected</#if>>8</option>
								<option value="9" <#if defaultYears == 9>selected</#if>>9</option>
								<option value="10" <#if defaultYears == 10>selected</#if>>10</option>
						</select>
					
					</div>
				</div>
		</div>
		</div>
		</#if>
</div> <#-- /row -->










<div class="row">
		<div class="col-md-12">		
			<input name="useDefaultDegreePrograms" id="useDefaultDegreePrograms" value="<#if !auditRequest.useDefaultDegreePrograms || !auditConfig.allowDefaultDegreePrograms>false<#else>true</#if>" style="display: none;" />
			<#if createPlan != "true">
				<p>
					<#if auditRequest.useDefaultDegreePrograms || !auditConfig.allowWhatIfDegreePrograms>
						<button id="runAudit" class="btn btn-primary" onclick="runDeclaredPrograms()" title="Run Declared Programs" value="Run Declared Programs" accesskey="r" type="button">Run Declared Programs</button>
					<#else>
						<button id="runAudit" class="btn btn-primary" onclick="runDifferentProgram()" title="Run Different Program" value="Run Different Program" accesskey="r" type="button">Run Different Program</button>
					</#if>
					<a class="btn btn-default" role="button" alt="Cancel" title="Cancel" href="../audit/list.html"> Cancel </a>
						
				</p>
				
			<#else>		
				
	
				<p>
					<button id="createPlanButton" class="btn btn-primary" onclick="sendPlan()" title="Create <@s.message 'udirect.plans.header'/>" value="Create <@s.message 'udirect.plans.header'/>" type="button"> Next </button>
					<#if udirectRemoteLogin?? && udirectRemoteLogin !="">
						<a class="btn btn-default" role="button" alt="Cancel" title="Cancel" href="${udirectRemoteLogin}/plan/manage/display-plans.html?crossApp=${crossApp}"> Cancel </a>			
					</#if>
				</p>
			</#if>
			<#-- if set to true, this means the page is being refreshed, and that the 
					submit shouldn't be considered an audit request.  by default this value is false, and will 
					only be changed to true by some javascript, for example, in an 
					onchange event listener. -->
			<input type="hidden" name="pageRefresh" id="pageRefresh" value="false" />
		</div>
	</form>

	
</div> <#-- /row -->

<#-- following script refreshes the page when certain dropdowns change -->
<script>
	$j( document ).ready(function() {
		$j.ajaxSetup({ cache: false });	
		<#if auditConfig.allowWhatIfDegreePrograms>
			initializeWhatIfAudit();
		</#if>		
		<#if createPlan == "true">	
			initCreatePlan();
		</#if>
	});
</script>

</@layout.body>