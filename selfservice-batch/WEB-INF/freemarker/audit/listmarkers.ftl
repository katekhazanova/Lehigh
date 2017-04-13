<#import "_macros.ftl" as auditMacros>
<@layout.head title="My Audit - Markers Tab" />

<@layout.body>
<input type="hidden" id="pageGroup" value="audits"/>
	<#include '/audit/common/_auditheader.ftl' />
	
	<@t.setSelectedTab tab='audit/listmarkers' />
	<@t.printAuditTabs auditQueryParams />

	<#assign linkText><@s.message 'uachieve.selfservice.audit.courseHistory.title' /></#assign>

				<#if auditConfig.showMarkers>
					<h3>Markers</h3>
					<table class="table table-striped table-bordered">
						<tr>
							<th style="text-align: left;">Marker</th>
							<th style="text-align: left;">Value</th>
							<th>Type</th>
							<th style="text-align: left;">Catalog Year</th>
						</tr>
						<#list audit.jobQueueMarkers as marker>
							<tr>
								<td style="text-align: left;">${marker.rname}</td>
								<td style="text-align: left;">${marker.drval}</td>
								<td>${marker.drtype!''}</td>
								<td style="text-align: left;">${marker.catlyt!''}</td>
							</tr>
						</#list>
					</table>
				</#if>

</@layout.body>