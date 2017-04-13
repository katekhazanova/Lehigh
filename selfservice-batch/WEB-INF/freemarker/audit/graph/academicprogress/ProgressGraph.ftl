<#import "../_macros.ftl" as graph>

<#if graphData?size lt 4>	<#assign graphHeight = "Height='${graph.computeGraphHeight(graphData)}'" />
<#else>						<#assign graphHeight = "" />
</#if>
<Graph Name='ProgressGraph' ${graphHeight}>
	<@graph.animateGraph />
	<@graph.hourDataLabel />
</Graph>


<GraphData Name='ProgressGraph' Method='Replace' SeriesIn='Columns'>


	<Categories>
		<#list ['Unfulfilled', 'Planned', 'In Progress', 'Complete' ] as seriesName>
			<Category Name='${seriesName}'/>
		</#list>
	</Categories>


	<#list graphData as graphLine>
		<Series Name='${graphLine.label}'>
			<#list [graphLine.unfulfilledHours, graphLine.plannedHours, graphLine.inProgressHours, graphLine.completeHours] as hours>
				<#if atLowestLevel>
					<Data Value='${hours}' Description='${graphLine.seriesName}'/>
				<#else>
					<Data Value='${hours}' DrilldownURL='${graph.academicProgressDrillDownUrl(auditViewRequest, graphLine)}'/>
				</#if>
			</#list>
		</Series>
	</#list>


</GraphData>