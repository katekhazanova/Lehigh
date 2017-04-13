
<#--
 * Computes the height that a graph should be, based on the number of series
 * that the graph will display.
 * 
 * @param c collection containing the series that the graph will display
 * @return value representing the height of the graph
 -->
<#function computeGraphHeight graphData>
	<#if graphData?size gt 0>c
		<#return (40 / 2) + (graphData?size * 40)>
	<#else>
		<#return 60 />
	</#if>
</#function>

<#-- Should the graph be animated when displayed?  Only works for Flash-based graphs. -->
<#macro animateGraph>
	<#--<#if cordaConfig.animate>
		<Properties AnimateStyle='Default'/>
	</#if>-->
</#macro>

<#-- Generates the drildown url for the AcademicProgress graph. -->
<#function academicProgressDrillDownUrl auditViewRequest graphLine>
	<#return "${auditViewRequest.servletPath}?id=${Compressor.compress(AuditViewRequest.getDrillDownAuditViewRequest(auditViewRequest, graphLine.summary, graphLine.rtabx, graphLine.originalSeriesName, graphLine.originalLabel))}" />
</#function>

<#-- Generates the drildown url for the Transcript graph. -->
<#function transcriptDrillDownUrl auditViewRequest graphLine>
<#--
    private String getDrillDown(TranscriptGraphData tgd) {
    	// looks like stabx actually gets used!  see CourseHistoryServlet
    	
//    	do something about this?  or put this on hold since we're not even showing this graph yet? 
//    	return getAuditViewRequest().getServletPath() + "?id=" + CompressorUtils.compress(getDrillDownAuditViewRequest(summaryGroup, rtabx, seriesName));
        
    	return "./courseHistory?" 
            + "jobQSeqNo=" 
            + getJobQSeqNo()
            + "&grouping=" 
            + tgd.getStabx() 
            + ","
            + tgd.getRtabx();
    }
-->
<#return "${auditViewRequest.servletPath}?id=${Compressor.compress(AuditViewRequest.getDrillDownTranscriptRequest(auditViewRequest))}&filter.stabx=${graphLine.stabx}"/> <!--, graphLine.stabx))}" /-->
</#function>

<#macro gpaDataLabel>
	<DataLabels AlwaysShowDecimalPlaces='${graphConfig.showAllGPADecimals?string}' DecimalPlaces='${graphConfig.gpaGraphDecimalPlaces?string}'/>
</#macro>

<#macro hourDataLabel>
	<DataLabels AlwaysShowDecimalPlaces='${graphConfig.showAllHourDecimals?string}' DecimalPlaces='${graphConfig.hourGraphDecimalPlaces?string}'/>
</#macro>

<#function formattedGpa graphData>
	<#return graphData.getFormattedGpa(graphConfig.truncateGPA, graphConfig.gpaGraphDecimalPlaces) />
</#function>

<#function cordaSafeLabel label>
	<#return label?replace("'","`")>
</#function>