<#import "../_macros.ftl" as graph>


<Graph Name='ProgressGraph'>
	<@graph.animateGraph />
	<@graph.gpaDataLabel />
</Graph>
<GraphData Name='ProgressGraph' Method='Replace' SeriesIn='Columns'>


	<Categories>
		<#list ['GPA', 'Planned', 'In Progress', 'Complete'] as seriesName>
			<Category Name='${seriesName}'/>
		</#list>
	</Categories>


	<#list graphData as graphLine>
		<Series Name='${graphLine.seriesName}'>
            <#-- If GPA <= 0, we don't want to display it -->
			<#if graphLine.gpa lte 0>
				<Data Value=''/>
			<#else>
				<Data Value='${graph.formattedGpa(graphLine)}'/>
			</#if>

			<#-- String drillDown = getDrillDown(graphData); -->
			<#assign drillDown = graph.transcriptDrillDownUrl(auditViewRequest, graphLine) />
			<Data Value='${graphLine.plannedHours}' DrilldownURL='${drillDown}'/>
			<Data Value='${graphLine.inProgressHours}' DrilldownURL='${drillDown}'/>
			<Data Value='${graphLine.completeHours}' DrilldownURL='${drillDown}'/>
		</Series>
	</#list>


</GraphData>
