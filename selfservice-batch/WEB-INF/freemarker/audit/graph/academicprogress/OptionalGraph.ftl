<#import "../_macros.ftl" as graph>

<#if graphData?size lt 4>	<#assign graphHeight = "Height='${graph.computeGraphHeight(graphData)}'" />
<#else>						<#assign graphHeight = "" />
</#if>
<Graph Name='OptionalGraph' ${graphHeight}>
	<@graph.hourDataLabel />
</Graph>


<GraphData Name='OptionalGraph' Method='Replace' SeriesIn='Columns'>


	<Categories>
		<Category Name='Optional'/>
	</Categories>


	<#list graphData as graphLine>
		<Series Name='${graphLine.seriesName}'>
			<Data Value='${graphLine.optional}'/>
		</Series>
	</#list>


</GraphData>