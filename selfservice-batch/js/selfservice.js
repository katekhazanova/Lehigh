/**
 * @author jonchase
 */


/* ---------------------------------------------------
 * classes
 * --------------------------------------------------- */

/** Extra methods are added to prototype's Element class by this addMethods() call. */
Element.addMethods({
	/**
	 * Returns all elements that have the specified attribute.  
	 * 
	 * Example usage:
	 *
	 * <pre>
	 * <span course="{department: 'MTH', number: '411'}">411</span>
	 * 
	 * ...
	 * 
	 * $A($('auditResults').getElementsByAttribute('course')).each(function (element) {
	 * 
	 *  // retrieve the attribute we're interested in
	 *  var attr = element.readAttribute('course');
	 *   
	 *   // create a JSON representation of attribute
	 *   var course = eval('(' + attr + ')');
	 *   
	 *   // use the object
	 *   console.log(course.department);
	 *   console.log(course.number);
	 * });
	 * </pre>
	 * 
	 * Taken from a presentation by Nik Krumm (Orbitz) during the Rich Web Experience.
	 */
	getElementsByAttribute: function () {
		var element = arguments[0], attribute = arguments[1];
		var tags = element.getElementsByTagName(arguments[2] || '*');
		var results = $A();
		var tagsLength = tags.length;
		for (var i = 0; i < tagsLength; i++) {
			var _tag = tags[i];
			if (_tag.getAttribute(attribute)) {
				results.push(Element.extend(_tag));
			}
		}
		return results;
	}
});

/** 
 * Implements an execution queue to allow for long running operations to continue 
 * to allow the browser to stay responsive.
 * 
 * Taken from http://debuggable.com/posts/run-intense-js-without-freezing-the-browser:480f4dd6-f864-4f72-ae16-41cccbdd56cb 
 */
$.queue = {
    _timer: null,
    _queue: [],
    add: function(fn, context, time) {
        var setTimer = function(time) {
            $.queue._timer = setTimeout(function() {
                time = $.queue.add();
                if ($.queue._queue.length) {
                    setTimer(time);
                }
            }, time || 2);
        }
 
        if (fn) {
            $.queue._queue.push([fn, context, time]);
            if ($.queue._queue.length == 1) {
                setTimer(time);
            }
            return;
        }
 
        var next = $.queue._queue.shift();
        if (!next) {
            return 0;
        }
        next[0].call(next[1] || window);
        return next[2];
    },
    clear: function() {
        clearTimeout($.queue._timer);
        $.queue._queue = [];
    }
};

selfservice = function () {

	// private variables
	//var myPrivateVar = "I can be accessed only from within YAHOO.myProject.myModule.";

	// private methods
	/*
	 var myPrivateMethod = function () {
		YAHOO.log("I can be accessed only from within YAHOO.myProject.myModule");
	}
	*/

	return  {
		

		// -------------------------------------------------
		// general functions
		// -------------------------------------------------
		/**
		 * Returns the namespace specified and creates it if it doesn't exist
		 * <pre>
		 * selfservice.namespace("property.package");
		 * selfservice.namespace("selfservice.property.package");
		 * </pre>
		 * Either of the above would create selfservice.property, then
		 * selfservice.property.package
		 *
		 * Be careful when naming packages. Reserved words may work in some browsers
		 * and not others. For instance, the following will fail in Safari:
		 * <pre>
		 * selfservice.namespace("really.long.nested.namespace");
		 * </pre>
		 * This fails because "long" is a future reserved word in ECMAScript.
		 * 
		 * This namespace() method was taken directly from YAHOO.namespace(), simply by
		 * replacing occurences of "YAHOO" with "selfservice".
		 *
		 * @method namespace
		 * @static
		 * @param  {String*} arguments 1-n namespaces to create 
		 * @return {Object}  A reference to the last namespace object created
		 */
		namespace : function() {
		    var a=arguments, o=null, i, j, d;
		    for (i=0; i<a.length; i=i+1) {
		        d=a[i].split(".");
		        o=selfservice;

		        // selfservice is implied, so it is ignored if it is included
		        for (j=(d[0] == "selfservice") ? 1 : 0; j<d.length; j=j+1) {
		            o[d[j]]=o[d[j]] || {};
		            o=o[d[j]];
		        }
		    }

		    return o;
		},

		/** Focuses the cursor on the first form input contained in a form that has class "focusable". */
		focusOnFirstFormInput: function () {
			Event.observe(window, 'load', function() {
				// find any form with a class of "focusable" and focus its first input
				var allForms = $$('form.focusable');
				if (allForms.length > 0) {
					var firstElement = allForms[0].findFirstElement();
					if (firstElement) {
						firstElement.activate();
					}
				}
			});
		},
		
		/** Creates a new html window popup, see http://jehiah.cz/archive/prototype-powered-popup-script */
		popup: function (options) {
			this.options = {
				url: '#',
				width: 700,
				height: 500,
				name:'_blank',
				location:'no',
				menubar:'no',
				toolbar:'no',
				status:'yes',
				scrollbars:'yes',
				resizable:'yes',
				left:'',
				top:'',
				normal:false
			};
	
			Object.extend(this.options, options || {});
	
			if (this.options.normal) {
				this.options.menubar = 'yes';
				this.options.status = 'yes';
				this.options.toolbar = 'yes';
				this.options.location = 'yes';
			}
	
			this.options.width = this.options.width < screen.availWidth?this.options.width:screen.availWidth;
			this.options.height=this.options.height < screen.availHeight?this.options.height:screen.availHeight;
			var openoptions = 'width='+this.options.width+',height='+this.options.height+',location='+this.options.location+',menubar='+this.options.menubar+',toolbar='+this.options.toolbar+',scrollbars='+this.options.scrollbars+',resizable='+this.options.resizable+',status='+this.options.status
			//if (this.options.top!='')openoptions+=',top='+this.options.top;
			//if (this.options.left!='')openoptions+=',left='+this.options.left;
			if (this.options.top!='')openoptions+=',top='+this.options.top;
			else                openoptions+=',top='+parseInt((parseInt(screen.height)/2) - (parseInt(this.options.height)/2));
			if (this.options.left!='')openoptions+=',left='+this.options.left;
			else                openoptions+=',left='+parseInt((parseInt(screen.width)/2) - (parseInt(this.options.width)/2));
			
			window.open(this.options.url, this.options.name,openoptions );
			
			return false;
		},
		
		/**
		 * Opens a window for a help topic. 
		 */
		helpPopup: function (url) {
			var newwindow = window.open(url + '&popup=true','help','height=400,width=960,resizable=yes,scrollbars=yes');
			if (window.focus) {
				newwindow.focus();
			}
		}

		/* 
		myPublicProperty: "I'm accessible as YAHOO.myProject.myModule.myPublicProperty."
		myPublicMethod: function () {
			YAHOO.log("I'm accessible as YAHOO.myProject.myModule.myPublicMethod.");

			//Within myProject, I can access "private" vars and methods:
			YAHOO.log(myPrivateVar);
			YAHOO.log(myPrivateMethod());

			//The native scope of myPublicMethod is myProject; we can
			//access public members using "this":
			YAHOO.log(this.myPublicProperty);
		}
		*/
	};

}(); // execute immediately and return

// focus first form input on page load
selfservice.focusOnFirstFormInput();