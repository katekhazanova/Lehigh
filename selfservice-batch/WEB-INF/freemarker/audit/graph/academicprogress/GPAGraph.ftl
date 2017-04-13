<#import "../_macros.ftl" as graph>

<#if graphData?size lt 4>	<#assign graphHeight = "Height='${graph.computeGraphHeight(graphData)}'" />
<#else>						<#assign graphHeight = "" />
</#if>
<Graph Name='GPAGraph' ${graphHeight}>
	<@graph.animateGraph />
	<@graph.gpaDataLabel />
</Graph>

<GraphData Name='GPAGraph' Method='Replace' SeriesIn='Columns'>


	<Categories>
		<Category Name='GPA'/>
	</Categories>


	<#list graphData as graphLine>
		<Series Name='${graphLine.seriesName}'>
			<Data Value='${graph.formattedGpa(graphLine)}'/>		
		</Series>
	</#list>
        

</GraphData>
<#--

	<cit:bar-graph name="GPAGraph">
		<cit:data-label>
			<cit:format-settings value-format="override-maximum-decimal-places:true;maximum-decimal-places:9;override-always-show-maximum-decimal-places:true;always-show-maximum-decimal-places:true"/>
		</cit:data-label>
	</cit:bar-graph>
	-->
	

