
<#-- ========== AUDIT MENU ========== -->
<h2 class="sr-only">Audit Result Details</h2>
  	<div class="col-lg-7 col-md-12 col-sm-12">				
	<#if displayHtmlReport()>
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
					<a href="#" id="expandAll">Open All Sections</a> <span class="spacer">&nbsp;</span> 
					<a href="#" id="collapseAll">Close All Sections</a>
				</p>		
				
			</div> <!-- end auditMenu -->
	
			<#-- ========== AUDIT REPORT ========== -->
			<#--${report}-->
			<br/>
			<@readerDumper reader=reportReader />
			
			<#assign collapseReqs = auditConfig.autoCollapseStandardView />
			
			<script type="text/javascript">
				Event.observe(window, 'load', function() {
					selfservice.audit.initAudit('<@h.url href="/plannedcourse/preview.html" />', ${auditConfig.specialEffects?string}, '${seriesIdentifierClass}', ${collapseReqs?string});
				}); 
			</script>
		</div>
	</#if>

		<div class="row" style="padding-top:200px;">
			<@h.statusLegend />
		</div>
	</div>

<#function displayHtmlReport><#return reportType?string?upper_case == "HTM" /></#function>
<#function displayPdfReport> <#return reportType?string?upper_case == "PDF" /></#function>