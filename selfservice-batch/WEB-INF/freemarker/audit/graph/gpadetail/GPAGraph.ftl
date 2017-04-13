<#import "../_macros.ftl" as graph>


<#-- Represents the bar chart on the right hand side of GpaDetailGraph.itxml. -->

<Graph Name='GPAGraph'>
	<@graph.animateGraph />
	<@graph.gpaDataLabel />
</Graph>

<Datalabel Name='GPAGraph' Method='Replace'><Text>Label</Text></Datalabel>

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
