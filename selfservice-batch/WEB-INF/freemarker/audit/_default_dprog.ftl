			<#-- TODO if defaultDegreePrograms.isEmpty(), do not allow the option of running a default dprog like 3.5 does -->
	<div class="panel panel-default">
    <div class="panel-heading" role="tab" id="currentProgramHeading">
     
        <a tabIndex='0' data-toggle="collapse" data-parent="#accordion" aria-expanded="<#if auditRequest.useDefaultDegreePrograms || !auditConfig.allowWhatIfDegreePrograms>true<#else>false</#if>" aria-controls="currentProgram" <#if createPlan != "true">href="<#if !auditRequest.useDefaultDegreePrograms && auditConfig.allowDefaultDegreePrograms>#currentProgram</#if>" onclick="removeAccordianHref('currentProgram', 'Declared Programs', 'true', 'accordion');" keydown="removeAccordianHrefRadioKeyDown(event ,'currentProgram', 'Declared Programs', 'true', 'accordion');"</#if>>
        	<strong><i class="fa fa-caret-<#if !auditRequest.useDefaultDegreePrograms && auditConfig.allowDefaultDegreePrograms>right<#else>down</#if>"></i> Run Declared Programs:</strong>
        </a>
    </div>		
			
		<div id="currentProgram" class="panel-collapse collapse <#if auditRequest.useDefaultDegreePrograms || !auditConfig.allowWhatIfDegreePrograms>in</#if>" role="tabpanel" aria-labelledby="currentProgramHeading">
      		<div class="panel-body">
				<div id="defaultInputs">
					<@p.masterView defaultDegreeProgramsPageContext />
				</div>
		<#--		<hr style="clear: both"/> -->
			
			</div> <!-- /panel-body currentProgram -->
    </div> <!-- /panel-collapse currentProgram -->
  </div> <!-- /panel currentProgram -->