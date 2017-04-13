/**
 * selfservice.audit is used when viewing audits.  It will enable expanding/collapsing of
 * requirements, turn on or off the special effects associated with expand/collapse, 
 * and helps with generating course catalog links from course names.
 * 
 * This class uses the YUI module pattern as described here: 
 * http://yuiblog.com/blog/2007/06/12/module-pattern/
 * 
 * @author jonchase
 */
selfservice.namespace('selfservice.audit');

selfservice.audit = function () {
	// ---------------------------------------------------------------------------
	// private variables
	// ---------------------------------------------------------------------------
	/** Should smoothing special effects be used when expanding/collapsing requirements? */
	var specialEffects = true;

	/** 
	 * Link to course catalog with @{department} and @{number} placeholders,
	 * like http://www.onlinephd.com/courses/@{department}/@{number}.html 
	 */ 
	var courseCatalogLink = null;
	
	/** List of all requirement divs in the audit. */
	var requirements = null;
	
	/** Replacement syntax for Prototype's Template object - replaces values like @{someVariable} */
	var syntax = /(^|.|\r|\n)(@\{(.*?)\})/;
	
	// ---------------------------------------------------------------------------
	// private methods
	// ---------------------------------------------------------------------------
	/** Finds all requirements in the dom. */
	var findAllRequirements = function () {
		return $$('#audit .requirement');
	};

	var isRequirementExpanded = function (req) {
		return req.down('.reqBody').style.display != 'none';
	};
	
	var collapseRequirement = function (req) {
		if (isRequirementExpanded(req)) {
			specialEffects ? new Effect.Fade(req.down('.reqBody')) : req.down('.reqBody').hide();
			//specialEffects ? new Effect.BlindUp(req.down('.body')) : req.down('.body').hide();
			//specialEffects ? new Effect.SlideUp(req.down('.body')) : req.down('.body').hide();
			
			var rightArrow = "<i class=\"fa fa-togglerCollapsed\"><span class=\"sr-only hidden-print\">Requirement collapsed, click to expand</span></i>";
			req.down('.toggler').addClassName('togglerCollapsed');
			$j(req).find('.toggler').first().empty();
			$j(req).find('.toggler').first().html(rightArrow);
			
			req.down('.toggler').removeClassName('togglerExpanded');
		}
	};
	var expandRequirement = function (req) {
		if (!isRequirementExpanded(req)) {
			specialEffects ? new Effect.Appear(req.down('.reqBody')) : req.down('.reqBody').show();
			//specialEffects ? new Effect.BlindDown(req.down('.body')) : req.down('.body').show();
			//specialEffects ? new Effect.SlideDown(req.down('.body')) : req.down('.body').show();
			
			var downArrow = "<i class=\"fa fa-togglerExpanded\"><span class=\"sr-only hidden-print\">Requirement expanded, click to collapse</span></i>";
			req.down('.toggler').addClassName('togglerExpanded');
			$j(req).find('.toggler').first().empty();
			$j(req).find('.toggler').first().html(downArrow);
			
			req.down('.toggler').removeClassName('togglerCollapsed');
		}
	};
	
	/** Expand all requirements. */
	var expandAll = function () {
		requirements.each(function (req) {
			expandRequirement(req);
		});
	};
	
	/** Collapse all requirements. */
	var collapseAll = function () {
		requirements.each(function (req) {
			collapseRequirement(req);
		});
	};
	
	/** Expand all requirements of a given status (like 'OK' or 'NO'). */
	var expandAllOfStatus = function (status) {
		collapseAll();
		requirements.each(function (req) {
			if (req.down('.status' + status)) {
				expandRequirement(req);
			}
		});
	};

	var expandComplete =	function () { expandAllOfStatus('OK'); };
	var expandIncomplete =	function () { expandAllOfStatus('NO'); };
	var expandInProgress =	function () { expandAllOfStatus('IP'); };
	var expandPlanned =		function () { expandAllOfStatus('PL'); };
	

	/** Register handler functions for all of the expand/collapse buttons. */
	var registerClickHandlers = function () {
		Event.observe($('expandAll'),        'click', function (e) { expandAll();        Event.stop(e); });
		Event.observe($('collapseAll'),      'click', function (e) { collapseAll();      Event.stop(e); });
//		Event.observe($('expandComplete'),   'click', function (e) { expandComplete();   Event.stop(e); });
//		Event.observe($('expandIncomplete'), 'click', function (e) { expandIncomplete(); Event.stop(e); });
//		Event.observe($('expandInProgress'), 'click', function (e) { expandInProgress(); Event.stop(e); });
//		Event.observe($('expandPlanned'),    'click', function (e) { expandPlanned();    Event.stop(e); });
	};


	/** Util method to register a click handler for hiding/showing requirements of certain statuses. */
	var showStatusOf = function (status) {
		if ( $('showStatus'+status))
		{
		Event.observe($('showStatus' + status), 'click', function (e) {
			$('auditRequirements').select('div.requirement.status_' + status).each(Element.show);
			$('auditRequirements').select('div.requirement:not(.status_' + status + ')').each(Element.hide);
			Event.stop(e);
		});
		}
	};
	/** Register handler functions for showing requirements of only a certain status. */
	var registerStatusHandlers = function () {
		if ( $('showStatusAll'))
		{
		Event.observe($('showStatusALL'), 'click', function (e) {
			$('auditRequirements').select('div.requirement').each(Element.show);
			Event.stop(e);
		});
		}
		showStatusOf('OK');
		showStatusOf('PL');
		showStatusOf('IP');
		showStatusOf('NO');
	};

	/** Generate course catalog links for courses in the audit. */
	var generateCourseCatalogLinks = function () {
		
		// Generating course catalog links can take a while if there are a lot 
		// of courses (like several thousand). So the generation is partitioned 
		// into chunks that execute one at a time so that the browser stays
		// responsive during the process.  See here for more:
		// http://debuggable.com/posts/run-intense-js-without-freezing-the-browser:480f4dd6-f864-4f72-ae16-41cccbdd56cb
		
		// Here's a walk through of the process:
		//
		// for each requirement...
		//   create a function called createLink() that parses each course in the requirement
		//   and creates a catalog link
		//
		//   add the createLink() function to a queue
		//
		// the queue will automatically execute each function provided to it, 
		// pausing intermittently to allow the browser time to breathe		
		courseCatalogLink = courseCatalogLink + '?department=@{department}&number=@{number}';
		var template = new Template('<a href="' + courseCatalogLink + '" onclick="return selfservice.audit.viewCourseCatalog(\'@{department}\', \'@{number}\');" class="courselink">@{html}</a>', syntax);
		requirements.each(function (requirement) {
			var self = this, createLink = function() {
				requirement.getElementsByAttribute('department').each(function (element) {
					// wrap the element, which is a span, inside of a <a href=...>
					element.innerHTML = template.evaluate({
						department: element.readAttribute('department').replace("&", "%26"),
						number: element.readAttribute('number').replace("&", "%26"),
						html: element.innerHTML
					});
				});
			};
			$.queue.add(createLink, this);
		});
		
	};
	
	/** Expand/collapse a requirement. */
	var toggleRequirement = function (req) {
		if (isRequirementExpanded(req)) {
			collapseRequirement(req);
		} else {
			expandRequirement(req);
		}
	};

	/** Displays the Open All/Close All links. */
	var showLinks = function () {
		$('expandCollapseAllLinks').show();
	};
	
	
	return {
		// ---------------------------------------------------------------------------
		// public variables
		// ---------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------
		// public methods
		// ---------------------------------------------------------------------------
		/** 
		 * Opens a new browser window to display the course catalog.
		 * 
		 * You may wish to override this function if you would like the course catalog popup
		 * displayed in a different manner.
		 */
		viewCourseCatalog: function (department, number) {
			var template = new Template(courseCatalogLink, syntax);
			var url = template.evaluate({department: department, number: number}, syntax);
			return selfservice.popup({url: url, width: 530, height: 400});
		},

		/** Initializes the audit display by registering click handlers and preparing the audit to be viewed. */		
		initAudit: function (ccl, effects, seriesIdentifierClass, collapseReqs) {

			specialEffects = effects;
			
			courseCatalogLink = ccl;
					
			showLinks();
						
			
			/** Displays the export all and lock/unlock all links. */
			var initLinks = function () {
				$('transferEvalListToolbar').show();
			};
			
			requirements = findAllRequirements();
			
            requirements.each(function (req) {
				var toggler = req.down('.toggler');
				var title = req.down('.reqText');
				
				// register expand/collapse handler
				Event.observe(toggler, 'click', function () { toggleRequirement(req); });
				if ( title )
				{
				Event.observe(title,   'click', function () { toggleRequirement(req); });
				}
			});
 
			 			
			if ( seriesIdentifierClass && seriesIdentifierClass != 'category_null')
			{
			  requirements.each(function (req) {
			    if (!req.hasClassName(seriesIdentifierClass))
			    {
				  req.remove();
		  	    }
			  });
			}
			requirements = findAllRequirements();
			registerStatusHandlers();
			registerClickHandlers();

			
			if($j('#showCourseLinks').val() == "true"){
			
			
				generateCourseCatalogLinks();
			}
			
			if(collapseReqs)
			{
				collapseAll();
				
				
				//if in exception mode show the selected requirement
				var exceptionMode = $j('#exceptionMode').val();
				var auditExceptionMode = $j('#auditExceptionMode').val();
				
				if(exceptionMode || auditExceptionMode){
					var reqId = $j('#selectedReqId').val();
					
					if(reqId != null){
						var req = document.getElementById(reqId);
						
						if(reqId.indexOf("subreq") >= 0){
							
							reqId = $j("#"+reqId).parents('.requirement').attr('id');
							req = document.getElementById(reqId);
						}

						expandRequirement(req);
					}
				}
			}
		}
	};
}();