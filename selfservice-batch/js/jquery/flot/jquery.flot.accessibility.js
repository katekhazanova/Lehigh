(function ($) {
    function init(plot) {
        var accessibilityLevel = 0;
        var plotPointer = plot;
        var currentSeriesIndex = 0;
        var currentIndex = 0;
        var leftOffset = 0;
        var topOffset = 0;
        
        function checkAccessibilityEnabled(plot, options) {
        	if (options.accessibility.level) {
        		accessibilityLevel = options.accessibility.level;
        		plot.hooks.draw.push(addScreenReaderDiv);
        		plot.hooks.draw.push(addTabindex);
        		plot.hooks.draw.push(addLabel);
	        	if (!options.series.pie.show) {
	            	plot.hooks.bindEvents.push(onFocus);
	            	plot.hooks.draw.push(setStartingIndexes);
	        	}
        	}
        }
        
        function addScreenReaderDiv() {
        	if (!plotPointer.getPlaceholder().find('.sr-only').length) {
        		plotPointer.getPlaceholder().append('<div class="sr-only" aria-live="assertive"></div>');
        	}
        }
        
        function addTabindex() {
        	plotPointer.getPlaceholder().attr('tabindex','0');
        	plotPointer.getPlaceholder().css('outline', '0');
        	plotPointer.getPlaceholder().attr('role', 'application');
        }
        
        function addLabel() {
            var dataExists = false;
            for (var i = 0; i < plotPointer.getData().length; i++) {
            	if (plotPointer.getData()[i].datapoints.points.length > 0) {
            		dataExists = true;
            	}
            }
            if (!dataExists) {
            	plotPointer.getOptions().accessibility.label += ' no data';	
            }     
            plotPointer.getPlaceholder().attr('aria-label', plotPointer.getOptions().accessibility.label);
        }       
        
        function setStartingIndexes() {
        	var minLeft = null; 
        	var minLeftIndex = null;
        	for (var i = 0; i < plotPointer.getData().length; i++) {
	        	if (currentSeriesIsHorizontal()) {
	        		if (plotPointer.getData()[i].datapoints.points.length > 0) {
	        			if (minLeft == null || plotPointer.getData()[i].datapoints.points[1] > minLeft) {
	        				minLeft = plotPointer.getData()[i].datapoints.points[1];
	        				minLeftIndex = i;
	        			}
	        		}
	        	} else {
	        		if (plotPointer.getData()[i].datapoints.points.length > 0) {
	        			if (minLeft == null || plotPointer.getData()[i].datapoints.points[0] < minLeft) {
	        				minLeft = plotPointer.getData()[i].datapoints.points[0];
	        				minLeftIndex = i;
	        			}
	        		}
	        	}
        	}
        	if (minLeftIndex != null) {
        		currentSeriesIndex = minLeftIndex;
        	}
        }

        function onFocus(plot, eventHolder) {
            eventHolder.mousedown(function (e) {
            	if (options.grid.clickable) {
	            	var tempItem = plotPointer.findNearbyItem(e.pageX - plotPointer.offset().left, e.pageY - plotPointer.offset().top, function (s) { return s["hoverable"] != false; });
	    			currentIndex = tempItem.dataIndex;
	    			currentSeriesIndex = tempItem.seriesIndex;
	            	if (plotPointer.getHighlights().length < 0 || ((plotPointer.getHighlights()[0].point[0] != currentIndex || plotPointer.getHighlights()[0].point[2] != currentSeriesIndex) && !currentSeriesIsHorizontal()) || 
	            			((plotPointer.getHighlights()[0].point[1] != currentIndex || plotPointer.getHighlights()[0].point[2] != currentSeriesIndex) && currentSeriesIsHorizontal())) {
	                	refresh();
	            	} else {
		        		if (plotPointer.getOptions().grid.clickable) {
			        		plotPointer.getPlaceholder().trigger("plothover", [ null, null ]);
		        			plotPointer.getPlaceholder().trigger("plotclick", [ null, getCurrentItem() ]); 
		            		plotPointer.getPlaceholder().find('.sr-only').html('');
		        		}
	            	}
	                e.stopImmediatePropagation();
            	}
            });
        	plotPointer.getPlaceholder().focus(function (e) {
            	plotPointer.unhighlight();
            	plotPointer.highlight(currentSeriesIndex, currentIndex, "plothover");
            	plotPointer.getOptions().accessibility.position = getCurrentPos();
        		plotPointer.getPlaceholder().trigger("plothover", [ null, getCurrentItem() ]);
        		plotPointer.getPlaceholder().find('.sr-only').html(getScreenReaderData() + ' Use the arrow keys to navigate.');  
        	});        	
        	plotPointer.getPlaceholder().blur(function (e) {
        		plotPointer.unhighlight();
        		plotPointer.getPlaceholder().trigger("plothover", [ null, null ]);
        		plotPointer.getPlaceholder().find('.sr-only').html('');
        	});
        	plotPointer.getPlaceholder().keydown(function (e) {
	        	switch(e.which) {
	        	case 13: // enter
	        		e.preventDefault();
	        		if (plotPointer.getOptions().grid.clickable) {
	        			plotPointer.getPlaceholder().trigger("plotclick", [ null, getCurrentItem() ]); 
	            		plotPointer.getPlaceholder().find('.sr-only').html('');
	        		}
	        		break;
	        		
	        	case 33: // page up
	        		e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
		        		goToFirstIndex();
		        	} else {
		        		goToFirstSeries();
		        	}
		           	break;
		               	
	        	case 34: // page down
		        	e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
			        	goToLastIndex();
		        	} else {
			        	goToLastSeries();
		        	}
		           	break;
		               	
	        	case 35: // end
		        	e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
			        	goToFirstSeries();
		        	} else {
			        	goToLastIndex();
		        	}
		           	break;
		              	
	        	case 36: // home
		        	e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
		        		goToLastSeries();
		        	} else {
			        	goToFirstIndex();
		        	}
		           	break;
		               	
		        case 37: // left
		        	e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
		        		goToPreviousSeriesForValue(1);
		        	} else {
		        		goToPreviousValueForSeries(0);
		        	}
		           	break;
			        	
		        case 38: // up
		        	e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
		        		goToPreviousValueForSeries(1);
		        	} else {
		        		goToNextSeriesForValue(0);
		        	}
		       	   	break;
			        	
			    case 39: // right
		        	e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
		        		goToNextSeriesForValue(1);
		        	} else {
		        		goToNextValueForSeries(0);
		        	}
		       	   	break;
			        	
			    case 40: // down
		        	e.preventDefault();
		        	if (currentSeriesIsHorizontal()) {
		        		goToNextValueForSeries(1);
		        	} else {
		        		goToPreviousSeriesForValue(0);
		        	}
		       		break;
		
			    default: 
		       	   	return; // exit this handler for other keys
        		}

        	});
        }
        
        function goToFirstSeries() {
        	for (var i = plotPointer.getData().length - 1; i > currentSeriesIndex; i--) {
        		if ((plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize) -1 >= currentIndex) {
					currentSeriesIndex = i;
				}
        	}
        	refresh();
        }
        
        function goToLastSeries() {
        	for (var i = 0; i < currentSeriesIndex; i++) {
        		if ((plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize) -1 >= currentIndex) {
					currentSeriesIndex = i;
				}
        	}
        	refresh();
        }
        
        function goToFirstIndex() {
        	currentIndex = 0;
        	refresh();
        }
        
        function goToLastIndex() {
        	currentIndex = (plotPointer.getData()[currentSeriesIndex].datapoints.points.length/plotPointer.getData()[currentSeriesIndex].datapoints.pointsize) - 1;
        	refresh();
        }
        
        function goToPreviousIndex() {
        	if (currentIndex > 0) {
        		currentIndex -= 1;
        	}
        	refresh();
        }
        
        function goToNextIndex() {
        	if (currentIndex < (plotPointer.getData()[currentSeriesIndex].datapoints.points.length/plotPointer.getData()[currentSeriesIndex].datapoints.pointsize) - 1) {
        		currentIndex += 1;
        	}
        	refresh();
        }
        
        function goToNextSeriesForValue(dataIndex) {
        	var value = getValue(currentSeriesIndex, currentIndex, dataIndex);
        	var set = false;
        	if (currentSeriesIndex < plotPointer.getData().length - 1) {
	        	for (var i = currentSeriesIndex + 1; i < plotPointer.getData().length; i++) {
	        		if (!set) {
	        			for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
	        				if (!set && getValue(i, j, dataIndex) == value) {
	        					currentSeriesIndex = i;
	        					currentIndex = j;
	        					set = true;
	        				}
	        			}        			
	        		}
	        	}
	        	if (!set) {
	        		var closestVal = null;
	        		var closestSeriesIndex = null;
	        		var closestIndex = null;
	            	for (var i = currentSeriesIndex + 1; i < plotPointer.getData().length; i++) {
	            		for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
	            			if ((!currentSeriesIsHorizontal() && getValue(i, j, dataIndex) < value && (closestVal == null || getValue(i, j, dataIndex) > closestVal)) ||
	            				(currentSeriesIsHorizontal() && getValue(i, j, dataIndex) > value && (closestVal == null || getValue(i, j, dataIndex) < closestVal))){
	            				closestVal = getValue(i, j, dataIndex);
	            				closestSeriesIndex = i;
	            				closestIndex = j;
	            			}
	            		}  
	            	}
	            	if (closestSeriesIndex != null && closestIndex != null) {
	            		currentSeriesIndex = closestSeriesIndex;
	            		currentIndex = closestIndex;
	            		set = true;
	            	}
	        	}
        	}
        	refresh();
        }
        
        function goToPreviousSeriesForValue(dataIndex) {
        	var value = getValue(currentSeriesIndex, currentIndex, dataIndex);
        	var set = false;
        	if (currentSeriesIndex > 0) {
	        	for (var i = currentSeriesIndex - 1; i >= 0; i--) {
	        		if (!set) {
	        			for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
	        				if (!set && getValue(i, j, dataIndex) == value) {
	        					currentSeriesIndex = i;
	        					currentIndex = j;
	        					set = true;
	        				}
	        			}        			
	        		}
	        	}
	        	if (!set) {
	        		var closestVal = null;
	        		var closestSeriesIndex = null;
	        		var closestIndex = null;
	            	for (var i = currentSeriesIndex - 1; i >= 0; i--) {
	            		for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
	            			if ((!currentSeriesIsHorizontal() && getValue(i, j, dataIndex) < value && (closestVal == null || getValue(i, j, dataIndex) > closestVal)) ||
	            				(currentSeriesIsHorizontal() && getValue(i, j, dataIndex) > value && (closestVal == null || getValue(i, j, dataIndex) < closestVal))){
	            				closestVal = getValue(i, j, dataIndex);
	            				closestSeriesIndex = i;
	            				closestIndex = j;
	            			}
	            		}  
	            	}
	            	if (closestSeriesIndex != null && closestIndex != null) {
	            		currentSeriesIndex = closestSeriesIndex;
	            		currentIndex = closestIndex;
	            		set = true;
	            	}
	        	}
        	}
        	refresh();
        }
        
        function goToNextValueForSeries(dataIndex) {
        	var value = getValue(currentSeriesIndex, currentIndex, dataIndex);
    		var closestVal = null;
        	for (var i = 0; i < plotPointer.getData().length; i++) { // get next value with any data
        		for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
        			if ((!currentSeriesIsHorizontal() && getValue(i, j, dataIndex) > value && (closestVal == null || getValue(i, j, dataIndex) < closestVal)) ||
        				(currentSeriesIsHorizontal() && getValue(i, j, dataIndex) < value && (closestVal == null || getValue(i, j, dataIndex) > closestVal))){
        				closestVal = getValue(i, j, dataIndex);
        			}
        		}  
        	}
        	gotoValueForSeries(dataIndex, closestVal);
        	refresh();
        }
        
        function goToPreviousValueForSeries(dataIndex) {
        	var value = getValue(currentSeriesIndex, currentIndex, dataIndex);
    		var closestVal = null;
        	for (var i = 0; i < plotPointer.getData().length; i++) { // get next value with any data
        		for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
        			if ((!currentSeriesIsHorizontal() && getValue(i, j, dataIndex) < value && (closestVal == null || getValue(i, j, dataIndex) > closestVal)) ||
        				(currentSeriesIsHorizontal() && getValue(i, j, dataIndex) > value && (closestVal == null || getValue(i, j, dataIndex) < closestVal))){
        				closestVal = getValue(i, j, dataIndex);
        			}
        		}  
        	}
        	gotoValueForSeries(dataIndex, closestVal);
        	refresh();
        }
        
        function gotoValueForSeries(dataIndex, closestVal) {
        	if (closestVal != null) {
	        	var set = false;
		        for (var j = 0; j < plotPointer.getData()[currentSeriesIndex].datapoints.points.length/plotPointer.getData()[currentSeriesIndex].datapoints.pointsize; j++) {
		        	if (!set && getValue(currentSeriesIndex, j, dataIndex) == closestVal) { // this series has next value
		        		currentIndex = j;
		        		set = true;
		        	}
		        }
		        if (!set) {
		        	for (var i = currentSeriesIndex - 1; i >= 0; i--) { // get closest next value down with any data
		        		for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
		        			if (!set && getValue(i, j, dataIndex) == closestVal){
	            				currentSeriesIndex = i;
	            				currentIndex = j;
	            				set = true;
		        			}
		        		}  
		        	}
		        }
		        if (!set) {
		        	for (var i = currentSeriesIndex + 1; i < plotPointer.getData().length; i++) { // get closest next value up with any data
		        		for (var j = 0; j < plotPointer.getData()[i].datapoints.points.length/plotPointer.getData()[i].datapoints.pointsize; j++) {
		        			if (!set && getValue(i, j, dataIndex) == closestVal){
	            				currentSeriesIndex = i;
	            				currentIndex = j;
	            				set = true;
		        			}
		        		}  
		        	}
		        }
        	}
        }
        
        function currentSeriesIsHorizontal() {
        	return plotPointer.getData()[currentSeriesIndex].bars.horizontal;
        }
        
        function getScreenReaderData() {
        	var retString = "";
        	if (currentSeriesIsHorizontal()) {
        		retString += "Horizontal Chart. ";
        	}
        	if (plotPointer.getData().length > 1) { // give series information
        		retString += "Series " + plotPointer.getData()[currentSeriesIndex].label + " is " + (currentSeriesIndex + 1) + " of " + plotPointer.getData().length + ". ";
        	}
        	if (currentSeriesIsHorizontal()) {
            	retString += "[" + getSRBefore() + srYReplace(yAxisTickMapper(plotPointer.getData()[currentSeriesIndex].datapoints.points[(plotPointer.getData()[currentSeriesIndex].datapoints.pointsize * currentIndex) + 1])) + ", ";
            	retString += srXReplace(xAxisTickMapper(getStackedValue(currentSeriesIndex, currentIndex, 0))) + getSRAfter() + "] ";
        	} else {
            	retString += "[" + getSRBefore() + srXReplace(xAxisTickMapper(plotPointer.getData()[currentSeriesIndex].datapoints.points[(plotPointer.getData()[currentSeriesIndex].datapoints.pointsize * currentIndex)])) + ", ";
            	retString += srYReplace(yAxisTickMapper(getStackedValue(currentSeriesIndex, currentIndex, 1))) + getSRAfter() + "] ";
        	}
        	retString += "is " + (currentIndex + 1) + " of " + (plotPointer.getData()[currentSeriesIndex].datapoints.points.length/plotPointer.getData()[currentSeriesIndex].datapoints.pointsize) + ". ";
        	if (currentSeriesIsHorizontal()) {
            	retString += getOtherValuesInStack(currentSeriesIndex, currentIndex, 1);
        	} else {
            	retString += getOtherValuesInStack(currentSeriesIndex, currentIndex, 0);
        	}
        	if (plotPointer.getOptions().grid.clickable) {
        		retString += "Can drill down";
        	}
        	return retString;
        }
        
        function xAxisTickMapper(value) {
        	if (plotPointer.getAxes().xaxis.ticks != null) {
	        	for (var i = 0; i < plotPointer.getAxes().xaxis.ticks.length; i++) {
	        		if (plotPointer.getAxes().xaxis.ticks[i].v == value) {
	        			return plotPointer.getAxes().xaxis.ticks[i].label
	        		}
	        	}
        	}
        	return value;
        }
        
        function yAxisTickMapper(value) {
        	if (plotPointer.getAxes().yaxis.ticks != null) {
	        	for (var i = 0; i < plotPointer.getAxes().yaxis.ticks.length; i++) {
	        		if (plotPointer.getAxes().yaxis.ticks[i].v == value) {
	        			return plotPointer.getAxes().yaxis.ticks[i].label
	        		}
	        	}
        	}
        	return value;
        }
        
        function getCurrentPos() {
        	return { x: 0, 
						y: 0, 
						pageX: parseInt(getCurrentItem().series.xaxis.p2c(getCurrentItem().datapoint[0]) + plotPointer.getPlaceholder().offset().left + plotPointer.getPlotOffset().left, leftOffset), 
						pageY: parseInt(getCurrentItem().series.yaxis.p2c(getCurrentItem().datapoint[1]) + plotPointer.getPlaceholder().offset().top + plotPointer.getPlotOffset().top, topOffset) }
        }
        
        function getCurrentItem() {
        	var ps = plotPointer.getData()[currentSeriesIndex].datapoints.pointsize;
        	return { datapoint: plotPointer.getData()[currentSeriesIndex].datapoints.points.slice(currentIndex * ps, (currentIndex + 1) * ps),
	        					dataIndex: currentIndex,
	        					series:  plotPointer.getData()[currentSeriesIndex],
	        					seriesIndex: currentSeriesIndex,
	        					pageX: parseInt(plotPointer.getData()[currentSeriesIndex].xaxis.p2c(plotPointer.getData()[currentSeriesIndex].datapoints.points[currentIndex * ps]) + plotPointer.getPlaceholder().offset().left + plotPointer.getPlotOffset().left, leftOffset),
	        					pageY: parseInt(plotPointer.getData()[currentSeriesIndex].yaxis.p2c(plotPointer.getData()[currentSeriesIndex].datapoints.points[currentIndex * ps + 1]) + plotPointer.getPlaceholder().offset().top + plotPointer.getPlotOffset().top, topOffset) };
        }
        
        function getOtherValuesInStack(seriesIndex, index, dataIndex) {
        	var retString = "";
        	var stack = plotPointer.getData()[seriesIndex].stack;
        	for (var i = 0; i < plotPointer.getData().length; i++) {
        		if (plotPointer.getData()[i].stack == stack && i != seriesIndex) {
        			// look for value
        			var value = value = getValueAtPoint(i, plotPointer.getData()[seriesIndex].datapoints.points[dataIndex], dataIndex);
        			if (value == null) {
        				value = 0;
        			}
        			if (retString.length > 0) {
        				retString += ", ";
        			}
        			retString += plotPointer.getData()[i].label + " = " + value;
        		}
        	}
        	if (retString.length > 0) {
        		return "Related series values are " + retString + ". ";
        	} else {
        		return "";
        	}
        }
        
        function getValueAtPoint(seriesIndex, point, dataIndex) {
        	var otherIndex = 1;
        	if (dataIndex) { 
        		otherIndex = 0;
        	}
        	for (var i = 0; i < plotPointer.getData()[seriesIndex].datapoints.points.length; i += plotPointer.getData()[seriesIndex].datapoints.pointsize) {
        		if (plotPointer.getData()[seriesIndex].datapoints.points[i + dataIndex] == point) {
        			return plotPointer.getData()[seriesIndex].datapoints.points[i + otherIndex] - plotPointer.getData()[seriesIndex].datapoints.points[i + 2];
        		}
        	} 
        	return null;
        }
        
        function getStackedValue(seriesIndex, index, dataIndex) {
        	if (plotPointer.getData()[seriesIndex].stack) {
        		return getValue(seriesIndex, index, dataIndex) - getValue(seriesIndex, index, 2);
        	} else {
        		return getValue(seriesIndex, index, dataIndex);
        	}
        }
        
        function getValue(seriesIndex, index, dataIndex) {
        	return plotPointer.getData()[seriesIndex].datapoints.points[plotPointer.getData()[seriesIndex].datapoints.pointsize * index + dataIndex];
        }
        
        function refresh() {
        	plotPointer.unhighlight();
        	plotPointer.highlight(currentSeriesIndex, currentIndex, "plothover");
        	plotPointer.getOptions().accessibility.position = getCurrentPos();
    		plotPointer.getPlaceholder().trigger("plothover", [ null, getCurrentItem() ]);
    		plotPointer.getPlaceholder().find('.sr-only').html(getScreenReaderData());        	
        }
        
        function getSRBefore() {
        	var retStr = getSR().before;
        	if (retStr != null && retStr.length > 0) {
        		return retStr + " ";
        	} else {
        		return "";
        	}
        }
        
        function getSRAfter() {
        	var retStr = getSR().after;
        	if (retStr != null && retStr.length > 0) {
        		return " " + retStr;
        	} else {
        		return "";
        	}
        }
        
        function srXReplace( str ) {
        	var retStr = getSR().xReplace;
        	if (retStr != null && retStr.length > 0) {
        		return retStr;
        	} else {
        		return str;
        	}
        }
        
        function srYReplace( str ) {
        	var retStr = getSR().yReplace;
        	if (retStr != null && retStr.length > 0) {
        		return retStr;
        	} else {
        		return str;
        	}
        }
        
        function getSR() {
        	var x;
        	var y;
        	var before = "";
        	var after = "";
        	var xReplace = "";
        	var yReplace = "";
        	// get current x and y value
        	if (currentSeriesIsHorizontal()) {
            	y = plotPointer.getData()[currentSeriesIndex].datapoints.points[(plotPointer.getData()[currentSeriesIndex].datapoints.pointsize * currentIndex) + 1];
            	x = currentSeriesIndex;
        	} else {
            	x = plotPointer.getData()[currentSeriesIndex].datapoints.points[(plotPointer.getData()[currentSeriesIndex].datapoints.pointsize * currentIndex)];
            	y = currentSeriesIndex;
        	}
        	
        	// find corresponding x values
        	for (var i = 0; i < plotPointer.getOptions().accessibility.srData.length; i++) {
        		var srData = plotPointer.getOptions().accessibility.srData[i];
        		if ( srData.x == null || $.inArray( x, srData.x ) != -1 ) {
        			
                	// find corresponding y values
        			if ( srData.y == null || $.inArray( y, srData.y ) != -1 ) {
        				if ( srData.before != null && srData.before.length > 0) {
        					if ( before.length > 0) {
        						before += " ";
        					}
        					before += srData.before;
        				}
        				
        				if ( srData.after != null && srData.after.length > 0) {
        					if ( after.length > 0) {
        						after += " ";
        					}
        					after += srData.after;
        				}
        				
        				if ( srData.xReplace != null && srData.xReplace.length > 0) {
        					if ( xReplace.length > 0) {
        						xReplace += " ";
        					}
        					xReplace += srData.xReplace;
        				}
        				
        				if ( srData.yReplace != null && srData.yReplace.length > 0) {
        					if ( yReplace.length > 0) {
        						yReplace += " ";
        					}
        					yReplace += srData.yReplace;
        				}
        			}        			
        		}
        	}
        	
        	return { 'before': before, 'after': after, 'xReplace': xReplace, 'yReplace': yReplace };
        }

        plot.hooks.processOptions.push(checkAccessibilityEnabled);
    }

    var options = { accessibility: { level: 0, label: 'Chart', srData: [] } };

    $.plot.plugins.push({
        init: init,
        options: options,
        name: "accessibility",
        version: "0.1"
    });
})(jQuery);