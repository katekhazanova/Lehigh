/**
 * Used by the pages constructs.
 * 
 * @author jonchase
 */

selfservice.namespace('selfservice.pages');


/*
 * --------------------------------------------------- classes
 * ---------------------------------------------------
 */

selfservice.pages = function () {

	// private variables
	// var myPrivateVar = "I can be accessed only from within
	// YAHOO.myProject.myModule.";

	// private methods
	/*
	 * var myPrivateMethod = function () { YAHOO.log("I can be accessed only
	 * from within YAHOO.myProject.myModule"); }
	 */

	return  {
		

		// -------------------------------------------------
		// general functions
		// -------------------------------------------------
		/**
		 * Attaches a "check all/uncheck all" click handler to the "Delete"
		 * label in master views.
		 * 
		 * @method checkUncheckAll
		 * @static
		 */
		checkUncheckAll: function() {
			Event.observe(window, 'load', function() {
				var delSelAll = $('delete-select-all');
				
				if (delSelAll) {
					Event.observe(delSelAll, 'click', function (event) {
						// don't allow the click to pass through
						event.stop();
						
						// decide to check or uncheck all by querying only the
						// state of the first checkbox
						var firstCheckbox = $$('#pageMasterViewDeleteForm input[name="delete_id"]:first')[0];
						var checkState = firstCheckbox ? !firstCheckbox.checked : true;
						
						// find all checkboxes and check/uncheck them
						$$('#pageMasterViewDeleteForm input[name="delete_id"]').each(function (e) {
							e.checked = checkState;
						});
					});
	
					// wrap the "Delete" <span> with an <a> so that it looks
					// more like a link
					// (we do this here so that if Javascript is not disabled
					// the "Delete" is not a link)
					$(delSelAll).wrap('a', { 'href': '#', 'title': 'Check/Uncheck All','onclick':'toggleDelete()'});
					
				}
			});
		},
	/**
	 * Attaches a "check all/uncheck all" click handler to the "Delete" label in
	 * master views.
	 * 
	 * @method checkUncheckAll
	 * @static
	 */
	enableToggle: function() {
		Event.observe(window, 'load', function() {
			var rowGroupToggleImages = $$('i.rowGroupToggleImage');
			if (rowGroupToggleImages) 
				{
					rowGroupToggleImages.each(function(rowGroupToggleImage)
					{
					if (rowGroupToggleImage.id.indexOf('Close')>0)
					{
						rowGroupToggleImage.hide();
					}
				    Event.observe(rowGroupToggleImage, 'click', function (event) {
					// don't allow the click to pass through
					event.stop();
					var element = event.element();
					var id = element.id;
					var idKey = id.substr(0, id.indexOf('RowGroupToggleImage'));
					var toggleElement = idKey+'RowGroup';
					var rowGroup = $(toggleElement);
					rowGroup.toggle();
					var closeElement = idKey+'RowGroupToggleImageClose';
					var openElement = idKey+'RowGroupToggleImageOpen';
  				    $(closeElement).toggle();
					$(openElement).toggle();
				});
    			$(rowGroupToggleImage).wrap('a', { 'href': '#', 'title': 'Expand/Contract' });
						});
			}
		});
	}

	};

}(); // execute immediately and return

function toggleDelete(){
	// decide to check or uncheck all by querying only the
	// state of the first checkbox
	var firstCheckbox = $$('#pageMasterViewDeleteForm input[name="delete_id"]:first')[0];
	var checkState = firstCheckbox ? !firstCheckbox.checked : true;
	
	// find all checkboxes and check/uncheck them
	$$('#pageMasterViewDeleteForm input[name="delete_id"]').each(function (e) {
		e.checked = checkState;
	});
}

// attach the checkUncheckAll event handler on page load
selfservice.pages.checkUncheckAll();
selfservice.pages.enableToggle();