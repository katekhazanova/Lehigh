<#import "../_macros.ftl" as graph>

<#-- Represents the pie chart on the left hand side of GpaDetailGraph.itxml. -->
 
 
<#--
        sb.append(formatter.getCustomPropertiesXML());
--> 
	<#-- the following commented out java code dynamically sizes the pie chart based on the number of
	total hours accumulated 
        StringBuffer sb = new StringBuffer();
        JString jString = null;
        int totalHours = 0;
        int factor = 0;

        // initial values assume max (default) size of pie chart
        int top = -15;
        int topIncrement = 6;
        int left = 10;
        int leftIncrement = 7;
        int width = 150;
        int widthIncrement = 15;
        int height = 120;
        int heightIncrement = 12;

        // get total hours included in current pie graph
        for (Iterator iter = getGraphData().iterator(); iter.hasNext();) {
            GraphData graphLine = (GraphData) iter.next();

            totalHours = (int) graphLine.getTotalHours();
        }

        // determine appropriate size of pie graph based on total hours
        if (totalHours > 72) {
            factor = 0;
        } else if (totalHours > 36) {
            factor = 1;
        } else if (totalHours > 18) {
            factor = 2;
        } else if (totalHours > 9) {
            factor = 3;
        } else if (totalHours > 3) {
            factor = 4;
        } else {
            factor = 5;
        }

        top = top + (factor * topIncrement);
        left = left + (factor * leftIncrement);
        width = width - (factor * widthIncrement);
        height = height - (factor * heightIncrement);

        // <Graph Name='?' Top='?' Left='?' Width='?' Height='?' Type='Pie'
        // SubType='Basic'></Graph>
        jString = new JString("<Graph Name='?' Top='?' Left='?' Width='?' Height='?' Type='Pie' SubType='Basic'></Graph>");

        // Name='?'
        jString.setValue("ProgressGraph");

        // Top='?'
        jString.setValue(top);

        // Left='?'
        jString.setValue(left);

        // Width='?'
        jString.setValue(width);

        // Heigth='?'
        jString.setValue(height);

        sb.append(jString.toString());

        // Put the total hours inside the text box label
        jString = new JString("<Textbox Name='?'><Text>?</Text></Textbox>");

        // Name='?'
        jString.setValue("HoursLabel");

        // <Text>?</Text>
        jString.setValue(totalHours + " " + "Hours");

        sb.append(jString.toString());

        return sb.toString();
	-->


<Graph Name='ProgressGraph'>
	<@graph.animateGraph />
	<@graph.hourDataLabel />
</Graph>


<#-- calculate total hours -->
<#assign totalHours = 0 />
<#list graphData as graphLine>
	<#assign totalHours = totalHours + graphLine.totalHours />
</#list>
<Textbox Name='HoursLabel'><Text>${totalHours} Hours</Text></Textbox>


<GraphData Name='ProgressGraph' Method='Replace' SeriesIn='Columns'>


	<Categories>
		<#list ['Unfulfilled', 'Planned', 'In Progress', 'Complete' ] as seriesName>
			<Category Name='${seriesName}'/>
		</#list>
	</Categories>
	
	
	<#list graphData as graphLine>
		<Series Name='${graphLine.seriesName}'>
			<Data Value='${graphLine.unfulfilledHours}'/>
			<Data Value='${graphLine.plannedHours}'/>
			<Data Value='${graphLine.inProgressHours}'/>
			<Data Value='${graphLine.completeHours}'/>
		</Series>
	</#list>


</GraphData>
