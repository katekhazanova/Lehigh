function loadGpaDetailGraph(test, labels, json) {
	var unfulfilledData = [];
	var plannedData = [];
	var inProgressData = [];
	var completeData = [];
	var gpaData = [];
	var options = {};
	var data = {};
	if (!test) {
		options = json.options;
		data = json.data;
		for (i = 0; i < data.length; i++) {
			if (data[i].unfulfilledHours.length != 0) {
				unfulfilledData[unfulfilledData.length] = [i, cleanNumber(data[i].unfulfilledHours, options.hour.decimalPlaces, false)];
			}
			if (data[i].completedHours != 0) {
				completeData[completeData.length] = [i, cleanNumber(data[i].completedHours, options.hour.decimalPlaces, false)];
			}
			if (data[i].inProgressHours != 0) {
				inProgressData[inProgressData.length] = [i, cleanNumber(data[i].inProgressHours, options.hour.decimalPlaces, false)];
			}
			if (data[i].plannedHours != 0) {
				plannedData[plannedData.length] = [i, cleanNumber(data[i].plannedHours, options.hour.decimalPlaces, false)];
			}
			if (data[i].gpa != 0) {
				gpaData[gpaData.length] = [i, cleanNumber(data[i].gpa, options.gpa.decimalPlaces, options.gpa.truncate)];
			}
		}
		printGpaDetailGraph(gpaData, unfulfilledData, plannedData, inProgressData, completeData, labels, options);
	} else {
		options = {
				gpa: {
					decimalPlaces: 3,
					showAllDecimals: true,
					truncate: true
				},
				hour: {
					decimalPlaces: 3,
					showAllDecimals: true
				}
		};
		unfulfilledData = [[0, 6.00]];
		plannedData = [[1, 80.00]];
		inProgressData = [[2, 9.00]];
		completeData = [[3, 33.00]];
		gpaData = [[0, 2.370]];
		printGpaDetailGraph(gpaData, unfulfilledData, plannedData, inProgressData, completeData, labels, options)
	}
}

function printGpaDetailGraph(gpaData, unfulfilledData, plannedData, inProgressData, completeData, labels, options) {
	var graphColors = getGraphColors();
	var gpaDetailPieGraphOptions = {
			legend: {
				show: false
			},
			series: {
				pie: {	
					border: {
						colors: [graphColors.NOborderColor, graphColors.PLborderColor, graphColors.IPborderColor, graphColors.OKborderColor],
						lineWidth: 2
					},
					highlight: {
						colorMap: {
							'Unfulfilled': graphColors.NOborderColor, 
							'Planned': graphColors.PLborderColor, 
							'In Progress': graphColors.IPborderColor, 
							'Complete': graphColors.OKborderColor
						}
					},
					show: true,
					radius: 72,
					offset: {top: 1},
					tilt: 1,
					label: {
						show: false
					}
				}
			},
			grid: {
				hoverable: true
			},
			colors: [graphColors.NOcolor, graphColors.PLcolor, graphColors.IPcolor, graphColors.OKcolor],
			tooltip: true,
			tooltipOpts: {
				content: '%y.' + options.hour.decimalPlaces +' %s'
			},
			accessibility: { level: 1, label: 'Hours Pie Graph', srData: [ { after: labels.hours } ] }
	};
	if (!options.hour.showAllDecimals) {
		gpaDetailPieGraphOptions.tooltipOpts.content = '%y %s';
	}
	var gpaDetailBarGraphOptions = {
			legend: {
				show: false
			},
			series: {
				bars: { show: true, barWidth: 0.4 , align: 'center', fillColor: graphColors.GPAcolor, lineWidth: 2},
				grow: {
					active: true,
					steps: 100
				}
			},
			xaxis: {
				show: false
			},
			yaxis: {
				ticks: [0.0, 2.0, 4.0],
				color: '#000000'
			},
			xaxes: [ {min: -0.5, max: 0.5} ],
			yaxes: [ { position: "right", min: 0, max: 4, tickDecimals: 1 } ],
			grid: {
				borderWidth: 0,
				markings: function (axes) {
					var markings = [];
					for (var x = -0.5; x <= 0.5; x+=0.2) {
						for (var y = 1; y <= 3; y+=2) {
							markings.push({ xaxis: { from: x, to: x + 0.04}, yaxis: { from: y, to: y}, color: '#000000', lineWidth: 1});
						}
					}
					return markings;
				},
				color: '#000000',
				hoverable: true
			},
			colors: [graphColors.GPAborderColor],
			tooltip: true,
			tooltipOpts: {
				content: '%y.' + options.gpa.decimalPlaces +' %s'
			},
			accessibility: { level: 1, label: 'Gpa Bar Graph', srData: [ { xReplace: labels.gpa } ] }
	};
	if (!options.gpa.showAllDecimals) {
		gpaDetailBarGraphOptions.tooltipOpts.content = '%y %s';
	}
	var unfulfilledSeries = {
			highlightColor: graphColors.NOborderColor,
			label: labels.unfulfilled,
			data: unfulfilledData
	}
	var plannedSeries = {
			label: labels.planned,
			highlightColor: graphColors.PLborderColor,
			data: plannedData
	}
	var inProgressSeries = {
			label: labels.inProgress,
			highlightColor: graphColors.IPborderColor,
			data: inProgressData
	}
	var completeSeries = {
			label: labels.complete,
			highlightColor: graphColors.OKborderColor,
			data: completeData
	}
	var gpaSeries = {
			highlightColor: graphColors.GPAborderColor,
			label: labels.gpa,
			data: gpaData
	}
	$j.plot('#gpaDetailGraphHtmlPie', [unfulfilledSeries, plannedSeries, inProgressSeries, completeSeries], gpaDetailPieGraphOptions);
	$j.plot('#gpaDetailGraphHtmlBar', [gpaSeries], gpaDetailBarGraphOptions);
}

function loadAcademicProgressGraph(test, labels, json) {
	var ticksData = [];
	var unfulfilledData = [];
	var plannedData = [];
	var inProgressData = [];
	var completeData = [];
	var gpaData= [];
	var urls = [];
	var ors = [];
	var optionals = [];
	var yMin = 0;
	var gpaPrecision = 0;
	var options = {};
	var data = {};
	if (!test) {
		options = json.options;
		data = json.data;
		for (i = 0; i < data.length; i++) {
			if (data[i].label.length > 0) {
				ticksData[ticksData.length] = [0 - i, data[i].label];
			}
			if (data[i].unfulfilledHours != 0) {
				unfulfilledData[unfulfilledData.length] = [cleanNumber(data[i].unfulfilledHours, options.hour.decimalPlaces, false), 0 - i];
			}
			if (data[i].completedHours != 0) {
				completeData[completeData.length] = [cleanNumber(data[i].completedHours, options.hour.decimalPlaces, false), 0 - i];
			}
			if (data[i].inProgressHours != 0) {
				inProgressData[inProgressData.length] = [cleanNumber(data[i].inProgressHours, options.hour.decimalPlaces, false), 0 - i];
			}
			if (data[i].plannedHours != 0) {
				plannedData[plannedData.length] = [cleanNumber(data[i].plannedHours, options.hour.decimalPlaces, false), 0 - i];
			}
			if (data[i].gpa.value != 0) {
				gpaData[gpaData.length] = [padDecimals(cleanNumber(data[i].gpa, options.gpa.decimalPlaces, options.gpa.truncate), options.gpa.decimalPlaces), 0 - i];
			}
			if (data[i].rtabx.length > 0) {
				urls[i] = data[i].rtabx;
			}
			ors[i] = data[i].or;
			optionals[i] = data[i].optional;
		}
		yMin = -1 * (data.length - 0.5);
		printAcademicProgressGraph(ticksData, gpaData, unfulfilledData, plannedData, inProgressData, completeData, urls, ors, optionals, yMin, labels, options);
	} else {
		options = {
				gpa: {
					decimalPlaces: 3,
					showAllDecimals: true,
					truncate: true
				},
				hour: {
					decimalPlaces: 3,
					showAllDecimals: true
				}
		};
		ticksData = [[0, "Cummulative"], [-1, "University"], [-2, "College"], [-3, "Major"], [-4, "Minor"]]
		unfulfilledData = [[28.00, 0], [19.00, -1], [6.00, -2], [6.00, -3]];
		plannedData = [[34.00, 0], [40.00, -1], [18.00, -2], [3.00, -3], [6.00, -4]];
		inProgressData = [[36.00, 0], [15.00, -1], [15.00, -2], [6.00, -3], [3.00, -4]];
		completeData = [[50.00, 0], [54.00, -1], [24.00, -2], [12.00, -3], [6.00, -4]];
		gpaData = [['3.840', 0], ['3.500', -1], ['2.200', -2], ['3.900', -3], ['1.200', -4]];
		urls = [];
		ors = [1, 1, 1, 1, 1];
		optionals = [1, 1, 1, 1, 1];
		yMin = -4.5;
		printAcademicProgressGraph(ticksData, gpaData, unfulfilledData, plannedData, inProgressData, completeData, urls, ors, optionals, yMin, labels, options)
	}
}

function printAcademicProgressGraph(ticksData, gpaData, unfulfilledData, plannedData, inProgressData, completeData, urls, ors, optionals, yMin, labels, options) {
	var graphColors = getGraphColors();
	var academicProgressGraphOptions = {
			legend: {
				show: false
			},
			series: {
				grow: {
					active: true,
					steps: 100,
					growings:[ { valueIndex: 0 } ],
	                labels:[ 
	                        {
			                	active: true,
			                	float: 'right',
			                	draw: 'before',
			                    classes: 'graphOptionalLabel',
			                    offset: {
			                    	x: -46,
			                    	y: -8
			                    },
			                    data: convertLabels(optionals, 'Optional', false)
	                        }, {
	                        	active: true,
			                	float: 'left',
			                	draw: 'before',
			                    classes: 'graphOrLabel',
			                    offset: {
			                    	x: -18,
			                    	y: -14
			                    },
			                    data: convertLabels(ors, 'OR', false)
	                        } 
	                ]
				}
			},
			yaxis: {
				ticks: ticksData,
				alignTicksWithAxis: true,
				tickLength: 0,
				font: {
					size: 12,
					color: "#000000"
				}
			},
			xaxes: [ {min: 0} ],
			yaxes: [ {min: yMin, max: 0.5} ],
			grid: {
				color: '#000000',
				borderWidth: 1,
				borderColor: '#000000',
				clickable: true,
				hoverable: true
			},
			colors: [graphColors.OKborderColor, graphColors.IPborderColor, graphColors.PLborderColor, graphColors.NOborderColor],
			tooltip: true,
			tooltipOpts: {
				content: '%x.' + options.hour.decimalPlaces +' %s'
			},
			accessibility: { level: 1, label: 'Academic Progress Bar Graph', srData: generateYBeforeSRData( [], [ convertLabels(optionals, 'Optional', false), convertLabels(ors, 'OR', false) ], 0) }
	};
	if (!options.hour.showAllDecimals) {
		academicProgressGraphOptions.tooltipOpts.content = '%x %s';
	}
	var academicProgressGPAGraphOptions = {
			legend: {
				show: false
			},
			series: {
				bars: { show: true, barWidth: 0.6 , align: 'center', horizontal: true, fillColor: graphColors.GPAcolor, lineWidth: 2},
				grow: {
					active: true,
					steps: 100,
					growings:[ { valueIndex: 0 } ],
	                labels:[ 
	                         {
	                        	 active: true,
	                        	 draw: 'after',
	                        	 classes: 'graphGPALabel',
	                        	 offset: {
	                        		 x: -13 - (options.gpa.decimalPlaces * 6),
	                        		 y: -8
	                        	 },
	                        	 data: gpaData
	                         } 
	                ]
				}
			},
			xaxis: {
				ticks: [0.0, 2.0, 4.0],
				color: '#000000'
			},
			yaxis: {
				show: false,
				ticks: ticksData,
				alignTicksWithAxis: true,
				tickLength: 0,
				font: {
					size: 12,
					color: "#000000"
				}
			},
			xaxes: [ { min: 0, max: 4, tickDecimals: 1 } ],
			yaxes: [ {min: yMin, max: 0.5} ],
			grid: {
				borderWidth: 1,
				markings: function (axes) {
					var markings = [];
					for (var y = 0.5; y >= yMin; y-=0.2) {
						for (var x = 1; x <= 3; x+=2) {
							markings.push({ yaxis: { from: y, to: y - 0.04}, xaxis: { from: x, to: x }, color: '#000000', lineWidth: 1});
						}
					}
					return markings;
				},
				color: '#000000',
				hoverable: true
			},
			colors: [graphColors.GPAborderColor],
			tooltip: false,
			tooltipOpts: {
				content: '%x.' + options.gpa.decimalPlaces +' %s'
			},
			accessibility: { level: 1, label: 'Academic Progress GPA Bar Graph', srData: generateYYReplaceSRData( [ { after: labels.gpa } ], [ ticksData ], 1) }
	};
	if (!options.gpa.showAllDecimals) {
		academicProgressGPAGraphOptions.tooltipOpts.content = '%x %s';
	}
	var unfulfilledSeries = {			
			bars: { show: true, barWidth: 0.6 , align: 'center', horizontal:true, fillColor: graphColors.NOcolor, lineWidth: 2},
			highlightColor: graphColors.NOborderColor,
			label: labels.unfulfilled + ' ' + labels.hours,
			data: unfulfilledData,
			stack: 'Credit Hours'
	}
	var plannedSeries = {			
			bars: { show: true, barWidth: 0.6 , align: 'center', horizontal:true, fillColor: graphColors.PLcolor, lineWidth: 2},
			highlightColor: graphColors.PLborderColor,
			label: labels.planned + ' ' + labels.hours,
			data: plannedData,
			stack: 'Credit Hours'
	}
	var inProgressSeries = {			
			bars: { show: true, barWidth: 0.6 , align: 'center', horizontal:true, fillColor: graphColors.IPcolor, lineWidth: 2},
			highlightColor: graphColors.IPborderColor,
			label: labels.inProgress + ' ' + labels.hours,
			data: inProgressData,
			stack: 'Credit Hours'
	}
	var completeSeries = {			
			bars: { show: true, barWidth: 0.6 , align: 'center', horizontal:true, fillColor: graphColors.OKcolor, lineWidth: 2},
			highlightColor: graphColors.OKborderColor,
			label: labels.complete + ' ' + labels.hours,
			data: completeData,
			stack: 'Credit Hours'
	}
	var gpaSeries = {
			highlightColor: graphColors.GPAborderColor,
			label: labels.gpa,
			data: gpaData
	}
	academicProgressGraphOptions.data = [clone(completeSeries), clone(inProgressSeries), clone(plannedSeries), clone(unfulfilledSeries)];
	academicProgressGPAGraphOptions.data = [clone(gpaSeries)];
	$j( '#academicProgressGraphHtmlHours' ).height( $j( '#academicProgressGraphHtmlHours' ).height() + (ors.length - 5) * 23 );
	$j( '#academicProgressGraphHtmlGPA' ).height( $j( '#academicProgressGraphHtmlGPA' ).height() + (ors.length - 5) * 23 );
	$j.plot('#academicProgressGraphHtmlHours', [completeSeries, inProgressSeries, plannedSeries, unfulfilledSeries], academicProgressGraphOptions);
	$j.plot('#academicProgressGraphHtmlGPA', [gpaSeries], academicProgressGPAGraphOptions);
	
	$j('#academicProgressGraphHtmlHours').bind('plotclick', function (event, pos, item) {
		if (item && urls.length > 0) {
			window.location.assign(urls[0 - item.datapoint[1]]);
		}
	});
}

function loadTranscriptGraph(url, labels, json) {
	var ticksData = [];
	var gpaData = [];
	var plannedData = [];
	var inProgressData = [];
	var completeData = [];
	var urls = [];
	var xMax = 0;
	var options = {};
	var data = {};
	if (url.length > 0) {
		options = json.options;
		data = json.data;
		for (i = 0; i < data.length; i++) {
			if (data[i].label.length > 0) {
				ticksData[ticksData.length] = [i, data[i].label];
			}
			if (data[i].completedHours != 0) {
				completeData[completeData.length] = [i, cleanNumber(data[i].completedHours, options.hour.decimalPlaces, false)];
			}
			if (data[i].inProgressHours != 0) {
				inProgressData[inProgressData.length] = [i, cleanNumber(data[i].inProgressHours, options.hour.decimalPlaces, false)];
			}
			if (data[i].plannedHours != 0) {
				plannedData[plannedData.length] = [i, cleanNumber(data[i].plannedHours, options.hour.decimalPlaces, false)];
			}
			if (data[i].gpa != 0) {
				gpaData[gpaData.length] = [i, cleanNumber(data[i].gpa, options.gpa.decimalPlaces, options.gpa.truncate)];
			}
			urls[i] = url + data[i].stabx;
		}
		xMax = data.length - 0.5;
		printTranscriptGraph(ticksData, gpaData, plannedData, inProgressData, completeData, urls, xMax, labels, options);
	} else {
		options = {
				gpa: {
					decimalPlaces: 3,
					showAllDecimals: true,
					truncate: true
				},
				hour: {
					decimalPlaces: 3,
					showAllDecimals: true
				}
		};
		ticksData = [[0, "s1"], [1, "s2"], [2, "s3"], [3, "s4"]];
		gpaData = [[0, 2.4], [1, 2.7], [2, 3], [3, 3.1]];
		plannedData = [[0, 12], [1, 7], [2, 8], [3, 4]];
		inProgressData = [[0, 2], [1, 4], [2, 9], [3, 17]];
		completeData = [[0, 5], [1, 10], [2, 10], [3, 13]];
		xMax = 3.5;
		printTranscriptGraph(ticksData, gpaData, plannedData, inProgressData, completeData, urls, xMax, labels, options);
	}
}

function printTranscriptGraph(ticksData, gpaData, plannedData, inProgressData, completeData, urls, xMax, labels, options) {
	var graphColors = getGraphColors();
	var cumGpaData = generateCumGpaData(gpaData, plannedData, inProgressData, completeData, ticksData);
	var transcriptGraphOptions = {
			legend: {
				show: false
			},
			series: {
				lines: { show: false, fill: true, steps: false },
				grow: {
					active: true,
					steps: 100
				}
			},
			xaxis: {
				ticks: ticksData,
				alignTicksWithAxis: true,
				tickLength: 0,
				rotateTicks: 150,
				rotateTicksFont: '100% sans-serif'
			},
			yaxis: {
				color: '#000000'
			},
			xaxes: [ {min: -0.5, max: xMax} ],
			yaxes: [ {}, { position: "right", min: 0, max: 4, tickDecimals: 1 } ],
			grid: {
				color: '#000000',
				backgroundColor: { colors: ['#FFFFFF', '#EEFFFF'] },
				margin: {
					top: 0,
					left: 10,
					bottom: 0,
					right: 10
				},
				borderWidth: 1,
				borderColor: '#000000',
				clickable: true,
				hoverable: true
			},
			colors: [graphColors.OKborderColor, graphColors.IPborderColor, graphColors.PLborderColor, graphColors.GPAborderColor, graphColors.CumGPAborderColor],
			tooltip: true,
			tooltipOpts: {
				content: '%y.' + options.gpa.decimalPlaces +' %s'
			},
			accessibility: { level: 1, label: 'Transcript Bar and Line Graph' }
	};
	if (!options.gpa.showAllDecimals) {
		transcriptGraphOptions.tooltipOpts.content = '%y %s';
	}
	var gpaSeries = {
			lines: {
				show: true,
				lineWidth: 1,
				fill: false
			},
			points: {
				show: true,
				fill: true,
				fillColor: '#FFFFFF',
				radius: 3.5,
				symbol: 'circle'
			},
			bars: {
				show: false
			},
			grow: {
				steps: 1
			},
			highlightColor: graphColors.GPAborderColor,
			label: labels.gpa,
			data: gpaData,
			yaxis: 2
	}
	
	var cumGpaSeries = {
			lines: {
				show: true,
				lineWidth: 1,
				fill: false
			},
			points: {
				show: true,
				fill: true,
				fillColor: '#FFFFFF',
				radius: 3.5,
				symbol: 'circle'
			},
			bars: {
				show: false
			},
			grow: {
				steps: 1
			},
			highlightColor: graphColors.CumGPAborderColor,
			label: 'Cumulative ' + labels.gpa,
			data: cumGpaData,
			yaxis: 2
	}
	
	var plannedSeries = {
			bars: { show: true, barWidth: 0.3 , align: 'center', fillColor: graphColors.PLcolor, lineWidth: 2},
			highlightColor: graphColors.PLborderColor,
			label: labels.planned + ' ' + labels.hours,
			data: plannedData,
			yaxis: 1,
			stack: true
	}
	
	var inProgressSeries = {
			bars: { show: true, barWidth: 0.3 , align: 'center', fillColor: graphColors.IPcolor, lineWidth: 2},
			highlightColor: graphColors.IPborderColor,
			label: labels.inProgress + ' ' + labels.hours,
			data: inProgressData,
			yaxis: 1,
			stack: true
	}
	
	var completedSeries = {
			bars: { show: true, barWidth: 0.3 , align: 'center', fillColor: graphColors.OKcolor, lineWidth: 2},
			highlightColor: graphColors.OKborderColor,
			label: labels.complete + ' ' + labels.hours,
			data: completeData,
			yaxis: 1,
			stack: true
	}

	transcriptGraphOptions.data = [clone(completedSeries), clone(inProgressSeries), clone(plannedSeries), clone(gpaSeries)];
	$j.plot($j('#transcriptGraphHtml'), [ completedSeries, inProgressSeries, plannedSeries, gpaSeries/*, cumGpaSeries */], transcriptGraphOptions);
	
	$j('#transcriptGraphHtml').bind('plotclick', function (event, pos, item) {
		if (item && item.seriesIndex < 3 && urls.length > 0) {
			window.location.href = urls[item.datapoint[0]];
		}
	});
}

function getGraphColors() {
	var div =  [$j('<div class="graphStatusOK processingOnly"></div>'), 
	        $j('<div class="graphStatusNO processingOnly"></div>'), 
	        $j('<div class="graphStatusIP processingOnly"></div>'), 
	        $j('<div class="graphStatusPL processingOnly"></div>'), 
	        $j('<div class="graphGPA processingOnly"></div>'), 
	        $j('<div class="graphCumGPA processingOnly"></div>')];
	for (i = 0; i < div.length; i++) {
		$j('#footerContainer').after(div[i]);
	}
	var graphColors = {
		OKcolor: $j('.graphStatusOK').css('color'),
		NOcolor: $j('.graphStatusNO').css('color'),
		IPcolor: $j('.graphStatusIP').css('color'),
		PLcolor: $j('.graphStatusPL').css('color'),
		GPAcolor: $j('.graphGPA').css('color'),
		CumGPAcolor: $j('.graphCumGPA').css('color'),
		OKborderColor: $j('.graphStatusOK').css('border-left-color'),
		NOborderColor: $j('.graphStatusNO').css('border-left-color'),
		IPborderColor: $j('.graphStatusIP').css('border-left-color'),
		PLborderColor: $j('.graphStatusPL').css('border-left-color'),
		GPAborderColor: $j('.graphGPA').css('border-left-color'),
		CumGPAborderColor: $j('.graphCumGPA').css('border-left-color')
	}
	$j('.processingOnly').remove();
	return graphColors;
}

function generateCumGpaData(gpaData, plannedData, inProgressData, completeData, ticksData) {
	var cumGpaData = [];
	var qualityHours = 0;
	var thisQualityHours = 0;
	var hours = 0;
	var thisHours = 0;
	for (i = 0; i < gpaData.length; i++) {
		thisQualityHours = 0;
		thisHours = 0;
		for (j = 0; j < completeData.length; j++) {
			if (completeData[j][0] == gpaData[i][0]) {
				thisHours += completeData[j][1];
			}
		}
		for (j = 0; j < inProgressData.length; j++) {
			if (inProgressData[j][0] == gpaData[i][0]) {
				thisHours += inProgressData[j][1];
			}
		}
		for (j = 0; j < plannedData.length; j++) {
			if (plannedData[j][0] == gpaData[i][0]) {
				thisHours += plannedData[j][1];
			}
		}
		for (j = 0; j < gpaData.length; j++) {
			if (gpaData[j][0] == gpaData[i][0]) {
				thisQualityHours = gpaData[j][1] * thisHours;
			}
		}
		qualityHours += thisQualityHours;
		hours += thisHours;
		if (qualityHours != 0) {
			cumGpaData[cumGpaData.length] = [gpaData[i][0], qualityHours/hours];
		}
	}
	return cumGpaData;
}

function convertLabels(array, string) {
	return convertLabels(array, string, true);
}

function convertLabels(array, string, isAcending) {
	var retArray = [];
	var multiplier = 1;
	if (!isAcending) {
		multiplier = -1;
	}
	for (var i = 0; i < array.length; i++) {
		if (array[i]) {
			retArray[retArray.length] = [string, ( i * multiplier )];
		}
	}
	return retArray;
}

function generateYBeforeSRData(array, dataArrays, xy) {
	var otherXY = 1;
	if ( xy ) {
		otherXY = 0;
	}
	for (var i = 0; i < dataArrays.length; i++) {
		for (var j = 0; j < dataArrays[i].length; j++)
		array[array.length] = { y: [ dataArrays[i][j][otherXY] ], before: dataArrays[i][j][xy] };
	}
	return array;
}

function generateYYReplaceSRData(array, dataArrays, xy) {
	var otherXY = 1;
	if ( xy ) {
		otherXY = 0;
	}
	for (var i = 0; i < dataArrays.length; i++) {
		for (var j = 0; j < dataArrays[i].length; j++)
		array[array.length] = { y: [ dataArrays[i][j][otherXY] ], yReplace: dataArrays[i][j][xy] };
	}
	return array;
}

function cleanNumber(number, decimalPlaces, truncate) {
	var cleanNumber = Number(number);
	var mult = Math.pow(10,decimalPlaces);
	if ((cleanNumber + "").indexOf('.') > 0) {
		if (truncate) {
			cleanNumber = Math.floor(cleanNumber*mult)/mult;
		} else {
			cleanNumber = Math.round(cleanNumber*mult)/mult;		
		}
	}
	return cleanNumber;
}

function padDecimals(number, decimalPlaces) {
	var paddedNum = number + "";
	if (paddedNum.indexOf('.') == -1 && decimalPlaces > 0) {
		paddedNum += ".";
	}
	while (paddedNum.length <= (paddedNum.indexOf('.') + decimalPlaces)) {
		paddedNum += "0";
	}
	return paddedNum;
	}

function clone(obj){
    if(obj === null || typeof(obj) !== 'object'){ return obj;}
    var temp = new obj.constructor();
    for(var key in obj){temp[key] = clone(obj[key]); }
    return temp;
}