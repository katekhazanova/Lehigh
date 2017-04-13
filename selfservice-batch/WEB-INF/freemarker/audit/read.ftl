<@layout.head title="My Audit - Audit Results Tab" />
<@layout.body hideMenu=printerFriendly>
<div class="row">
<h1 class="sr-only">Audit Results</h1>
<input type="hidden" id="pageGroup" value="audits"/>
<input type="hidden" id="mobilePageGroup" value="manageAudits"/>
<input type="hidden" id="showCourseLinks" value="${showCourseCatalogLink}" />
<#if !useFile>
	<#-- ========== AUDIT HEADER, CHARTS, and TABS ========== -->
		
		<#include '/audit/common/_auditheader.ftl' />


<#-- ========== PLEASE REQUEST AUDIT ========== -->
<#if !showAudit>
	<p>
		<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_AUDIT perm="C">
			<@s.message 'uachieve.selfservice.audit.noaudit.text' /> <@h.buttonAsLink src="" href="/audit/create.html" title="Request Audit" />
		</@sec.hasAppFnPerm>

	</p>

<#-- ========== DISPLAY AUDIT ========== -->
<#else>

	<#-- ========== AUDIT NAVIGATION TABS ========== -->
	<#if !printerFriendly>
		<#if displayHtmlReport()>
			<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_EXCEPTION perm="C">
				<a class="btn btn-primary pull-right" href="<@s.url />/audit/exception_home.html">Enter Exception Mode</a>
			</@sec.hasAppFnPerm>
		</#if>
		
		<@t.setSelectedTab tab='audit/read' />
		<@t.printAuditTabs auditQueryParams />
		<#if auditConfig.showCharts && !printerFriendly>
		<@layout.plainTable id='auditSummary'>
		<h2 class="sr-only hidden-print">Progress Chart</h2>
			<div class="row graphs hidden-print">

				<#assign requirementLevel = auditViewRequest.requestLevel.ranking />

				<div class="col-md-4" >
					<span class="stronger">
						<#if requirementLevel == 0>		Audit
						<#elseif requirementLevel == 1>	Category:
						<#elseif requirementLevel == 2>	Summary:
						<#else>							Requirement:
						</#if>
						
						<#-- sometimes seriesIdentifier acutally equals the string "null", this if/else makes sure that doesn't get printed out -->
						<#if !auditViewRequest.seriesLabel?? || auditViewRequest.seriesLabel == 'null'><#else>${auditViewRequest.seriesLabel!''}</#if>
					</span>
					<br/>
					<p class="floatleft graphLegend">
						You are here: <i class="fa fa-home" title="Audit"></i>
						<#list breadCrumbs as bc>
							<#if bc_index gt 0> &gt; </#if>
							<#if bc_index + 1 == breadCrumbs?size>
								${bc.linkText}
							<#else>
								<a href="${bc.link}">${bc.linkText}</a>
							</#if>
						</#list>
					</p>
					<br/><hr/>
					<div id="gpaDetailGraphHtml" class="row" style="width: 297px; height: 183px;">
						<div class="col-xs-8">
							<div id="gpaDetailGraphHtmlPie" style="height: 146px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
							<div class="aligncenter" style="height: 17px;">
								<span id="gpaDetailGraphHtmlPieLabel" class="graphLabelLabel">&nbsp;${graphConfig.hoursLabel}&nbsp;</span>
							</div>
						</div>
						<div class="col-xs-4">
							<div id="gpaDetailGraphHtmlBar" style="height: 146px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
							<div class="aligncenter" style="height: 17px;">
								<span id="gpaDetailGraphHtmlBarLabel" class="graphLabelLabel">&nbsp;${graphConfig.gpaLabel}&nbsp;</span>
							</div>
						</div>
						<script type='text/javascript'>
						
							$j(document).ready(function() {
								$j.ajaxSetup({ cache: false });
								loadGpaDetailGraph(false, { complete: "<@s.message 'uachieve.selfservice.status.complete' />", inProgress: "<@s.message 'uachieve.selfservice.status.inprogress' />", unfulfilled: "<@s.message 'uachieve.selfservice.status.unfulfilled' />", planned: "<@s.message 'uachieve.selfservice.status.planned' />", hours: "${graphConfig.hoursLabel}", gpa: "${graphConfig.gpaLabel}" }, ${gpaDetailGraphHtml});			
							});
						</script>
					</div>
				</div>
				<div class="col-md-8" >
					<#-- p class="floatleft"><@h.img src="/images/vertical_divider_long.gif" title="" /></p -->
					<div>
						<span class="stronger">
							<#assign requirementLevel = auditViewRequest.requestLevel.ranking />
							<#if requirementLevel == 0>		Categories
							<#elseif requirementLevel == 1>	Requirements
							<#elseif requirementLevel == 2>	Requirements
							<#else>							Subrequirements
							</#if>
						</span>
						<br/>
						<p class="floatright graphLegend">
							<strong>Click on any area of the graph for further detail.</strong>
						</p>
						<br/><hr/>
						<div id="academicProgressGraphHtml" class="row">
							<div class="col-md-8 col-sm-12">
								<div id="academicProgressGraphHtmlHours" style="height: 146px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
								<div class="aligncenter" style="height: 17px;">
									<span id="academicProgressGraphHtmlHoursLabel" class="graphLabelLabel">&nbsp;${graphConfig.hoursLabel}&nbsp;</span>
								</div>
							</div>
							<div class="col-md-4 col-sm-12">
								<div id="academicProgressGraphHtmlGPA" style="height: 146px;"><i class="fa fa-spinner fa-spin" title="Still Loading"></i></div>
								<div class="aligncenter" style="height: 17px;">
									<span id="academicProgressGraphHtmlGPALabel" class="graphLabelLabel">&nbsp;${graphConfig.gpaLabel}&nbsp;</span>
								</div>
							</div>
							<script type='text/javascript'>
							
								$j(document).ready(function() {
									loadAcademicProgressGraph(false, { complete: "<@s.message 'uachieve.selfservice.status.complete' />", inProgress: "<@s.message 'uachieve.selfservice.status.inprogress' />", unfulfilled: "<@s.message 'uachieve.selfservice.status.unfulfilled' />", planned: "<@s.message 'uachieve.selfservice.status.planned' />", hours: "${graphConfig.hoursLabel}", gpa: "${graphConfig.gpaLabel}" }, ${academicProgressGraphHtml});			
								});
							</script>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-2 col-xs-0"></div>
						<div class="col-md-8 col-xs-12" style="padding: 0px 5px; border-style: solid; border-width: 1px;">
							<div class="row">
								<div class="col-md-3 col-xs-6 graphLegendLabel"><span class="graphBadge graphStatusOK">&nbsp;</span>&nbsp;<@s.message 'uachieve.selfservice.status.complete' /></div>
								<div class="col-md-3 col-xs-6 graphLegendLabel"><span class="graphBadge graphStatusIP">&nbsp;</span>&nbsp;<@s.message 'uachieve.selfservice.status.inprogress' /></div>
								<div class="col-md-3 col-xs-6 graphLegendLabel"><span class="graphBadge graphStatusNO">&nbsp;</span>&nbsp;<@s.message 'uachieve.selfservice.status.unfulfilled' /></div>
								<div class="col-md-3 col-xs-6 graphLegendLabel"><span class="graphBadge graphStatusPL">&nbsp;</span>&nbsp;<@s.message 'uachieve.selfservice.status.planned' /></div>
							</div>
						</div>	
						<div class="col-md-2 col-xs-0"></div>
					</div>
				</div>			
			</div>
		</@layout.plainTable>
	</#if>
 	</#if>
	
	
	<#-- ========== AUDIT MENU ========== -->
					
	<#if displayHtmlReport()>
		<h2 class="sr-only">Audit Result Details</h2>
		<div id="auditResults">
			<div id="auditMenu">
				<#--
					Adds the "Open All Sections" and "Close All Sections" links to the top of the audit.
					This toolbar is hidden initially (display:none;) and is only displayed to user agents that have javascript enabled.
					See selfservice.audit.initAudit() javascript for more info.
				-->
				<div class="aligncenter auditHeaderMessage">
					<@s.message 'audit.htmlHeaderMessage' />
				</div>
				
				<p id="expandCollapseAllLinks" style="display:none;">
					<a href="#" id="expandAll"><i class="fa fa-toggle-down"></i> Open All Sections</a> <span class="spacer">&nbsp;</span> 
					<a href="#" id="collapseAll"><i class="fa fa-toggle-right"></i> Close All Sections</a>
				</p>
				
				<#if !printerFriendly>
					<@help.tooltip topic="auditresults" />
					<p id="printerFriendlyP"><a target="_blank" href="?printerFriendly=true&id=${Compressor.compress(jobQueueRun)}" id="printerFriendly"><i class="fa fa-print"></i> Printer Friendly</a></p>
				</#if>
		

		
				<#--
				<p class="cleared">
					Open only: 
					<a href="#" id="expandComplete"><img src="<@h.url href="/images/titlebar_status_complete_extrasmall.gif" />" /> Complete</a>
					<a href="#" id="expandIncomplete"><img src="<@h.url href="/images/titlebar_status_unfulfilled_extrasmall.gif" />" /> Incomplete</a>
					<a href="#" id="expandInProgress"><img src="<@h.url href="/images/titlebar_status_in_progress_extrasmall.gif" />" /> In Progress</a>
					<a href="#" id="expandPlanned"><img src="<@h.url href="/images/titlebar_status_planned_extrasmall.gif" />" /> Planned</a>
				</p>
				-->
		
		
			</div> <!-- end auditMenu -->
	
			<#-- ========== AUDIT REPORT ========== -->
			<#--${report}-->
			<br/>
			<@readerDumper reader=reportReader />
			
			<#if !printerFriendly>
				<@h.statusLegend />
			</#if>	
			<#assign collapseReqs = auditConfig.autoCollapseStandardView />
			<#if printerFriendly>
				<#assign collapseReqs = auditConfig.autoCollapsePrinterView />
			</#if>
			
			<script type="text/javascript">
				Event.observe(window, 'load', function() {
					selfservice.audit.initAudit('<@h.url href="/plannedcourse/preview.html" />', ${auditConfig.specialEffects?string}, '${seriesIdentifierClass}', ${collapseReqs?string});
				}); 
			</script>
		</div>
	<#elseif displayPdfReport()>
		<div id="pdfAudit">
			<div class="aligncenter auditHeaderMessage">
				<@s.message 'audit.pdfHeaderMessage' />
			</div>
			<p class="pdfDownload">
				<a 
					href="<@h.url href="/audit/readpdf.html${auditQueryParams}&download=true" />"
					title="Download PDF Audit">Download PDF Audit
				</a>
			</p>
			<p class="getAcrobat">Make sure you've installed <a target="_blank" href="http://www.adobe.com/products/acrobat/readstep2.html" title="Download Adobe Reader">Adobe Reader</a> and are not using Browser or Chrome in Android before viewing this audit.</p>

			<p class="pdf"><embed src="<@h.url href="/audit/readpdf.pdf#navpanes=0${auditQueryParams}" />" width="800" height="400"></embed></p>
			
		</div>
	<#else>
		<p class="alert alert-warning">T			<p class="getAcrobat">
				<a class="tooltip" href="<@s.url />/general/help.html?topic=ipadScroll" onclick="javascript:selfservice.helpPopup('<@s.url />/general/help.html?topic=ipadScroll' ); return false;">
					Difficulty scrolling on the iPad?
				</a>
			</p>
audit report is in an unknown format (${reportType?string}) and can't be displayed.</p>  
	</#if>


</#if>
<#else>
	${auditFile}
</#if>
</div>
</@layout.body>

<#function displayHtmlReport><#return reportType?string?upper_case == "HTM" /></#function>
<#function displayPdfReport> <#return reportType?string?upper_case == "PDF" /></#function>