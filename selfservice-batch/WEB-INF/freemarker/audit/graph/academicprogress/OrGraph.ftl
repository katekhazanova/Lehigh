<#import "../_macros.ftl" as graph>

<#if graphData?size lt 4>	<#assign graphHeight = "Height='${graph.computeGraphHeight(graphData)}'" />
<#else>						<#assign graphHeight = "" />
</#if>
<Graph Name='OrGraph' ${graphHeight}>
	<@graph.hourDataLabel />
</Graph>


<GraphData Name='OrGraph' Method='Replace' SeriesIn='Columns'>


	<Categories>
		<Category Name='Or'/>
	</Categories>


	<#list graphData as graphLine>
		<Series Name='${graphLine.seriesName}'>
			<Data Value='${graphLine.or}'/>
		</Series>
	</#list>


</GraphData>