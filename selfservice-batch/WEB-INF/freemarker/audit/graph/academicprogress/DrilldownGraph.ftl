<#import "../_macros.ftl" as graph>
    
<#if graphData?size lt 4>	<#assign graphHeight = "Height='${graph.computeGraphHeight(graphData)}'" />
<#else>						<#assign graphHeight = "" />
</#if>
<Graph Name='DrilldownGraph' ${graphHeight}>
	<@graph.hourDataLabel />
</Graph>


<GraphData Name='DrilldownGraph' Method='Replace' SeriesIn='Columns'>


	<Categories>
		<Category Name='Drilldown'/>
	</Categories>


	<#list graphData as graphLine>
		<Series Name='${graphLine.label}'>
			<#if atLowestLevel>
				<Data Value='1'/>
			<#else>
				<Data Value='1' DrilldownURL='${graph.academicProgressDrillDownUrl(auditViewRequest, graphLine)}'/>
			</#if>
		</Series>
	</#list>



</GraphData>
<#--
<cit:bar-graph name="DrilldownGraph">
	<cit:value-scale>
		<cit:value-scale-labels display-labels="true"/>
	</cit:value-scale>
	<cit:category-scale display-scale-labels="true"/>
</cit:bar-graph>

	<cit:bar-graph name='DrilldownGraph'>
		<cit:value-scale>
			<cit:value-scale-labels display-labels='true'/>
		</cit:value-scale>
	</cit:bar-graph>

-->
