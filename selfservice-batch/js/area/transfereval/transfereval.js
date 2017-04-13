/**
 * selfservice.transfereval is used when viewing transfer evaluations.  It will enable 
 * unlocking/locking of all evaluation groups, exporting all groups, and some other stuff.
 *
 * This class uses the YUI module pattern as described here: 
 * http://yuiblog.com/blog/2007/06/12/module-pattern/
 * 
 * @author jonchase
 */
selfservice.namespace('selfservice.transfereval');

selfservice.transfereval = function () {
	// ---------------------------------------------------------------------------
	// private variables
	// ---------------------------------------------------------------------------
	/** Gets toggled everytime lock/unlock all occurs, so that the checkboxex are toggled.*/
	var lockAll = true;

	/** A selfservice constant - represents evallock value for "Original". */
	var EVALLOCK_ORIGINAL = ' ';
	
	/** A selfservice constant - represents evallock value for "Marked". */
	var EVALLOCK_MARKED = 'X';
	
	var EVALLOCK_PERMANENT = 'P';
	
	var EVALLOCK_PREFIX = 'evallock_StuEvalgrp|!!|';
	
	var CERTIFY_PREFIX = 'certify_StuEvalgrp|!!|'; 
	
	var EVALLOCK_ON = 'L';
	
	// ---------------------------------------------------------------------------
	// private methods
	// ---------------------------------------------------------------------------
	/** Sets all certify dropdowns to the value provided (like 'X' or ' '). */
	var setAllCertifiesTo = function (val) {
		$$('#pageMasterViewDeleteForm select').each(function (slct) {
			var i, options = slct.getElementsByTagName('option');
			for (i = 0; i < options.length; i++) {
				if (options[i].value === val) {
					slct.selectedIndex = i;
				}
			}
		});
	};

	/** Sets all evallock checkboxes to the passed in boolean value. */
	var setAllEvallocksTo = function (val) {
		$$('#pageMasterViewDeleteForm input.evallockcheckbox').each(function (cbox) {
			cbox.checked = val;
		});
	};

	/** 
	 * Attach event listener to the "Export All" link that will select all evallock
	 * checkboxes and set all certify dropdown values to "Marked" (X).   
	 */
	var initExportAll = function () {
		Event.observe('transferEvalListExportAll', 'click', function (e) {
			
			setAllEvallocksTo(true);

			// set all select box values to "Marked" (X)
			setAllCertifiesTo(EVALLOCK_MARKED);

			// stop the click event
			Event.stop(e);
		});
	};
	
	/** 
	 * Attach event listener to the "Lock/Unlock All" link that will toggle
	 * all evallock checkboxes and, in the case of unlocking, will set all 
	 * certify dropdown values to "Original" ( ).   
	 */
	var initLockUnlockAll = function () {
		Event.observe('transferEvalListLockUnlockAll', 'click', function (e) {

			// toggle all checkboxes
			setAllEvallocksTo(lockAll);

			// if unlocking, set all select box values to "Original" ( )
			if (lockAll === false) {
				setAllCertifiesTo(EVALLOCK_ORIGINAL);
			}

			// next time it's clicked it will set the checkboxes to their opposite value
			lockAll = !lockAll;
			
			// stop the click event
			Event.stop(e);
		});
	};
	
	/** Displays the export all and lock/unlock all links. */
	var showLinks = function () {
		$('transferEvalListToolbar').show();
	};
	
	var selectEvallock = function () {
		$$('#pageMasterViewDeleteForm select').each(function (slct) {
			Event.observe(slct, 'change', function (e) {
				var groupId = slct.id;
				groupId = groupId.replace(CERTIFY_PREFIX, "");
				var evallockFields = document.getElementsByName(EVALLOCK_PREFIX + groupId);
				
				if(slct.value != EVALLOCK_ORIGINAL)
				{
					for(var i=0; i<evallockFields.length; i++)
					{
						if(evallockFields[i].type == 'checkbox')
						{
							evallockFields[i].checked = true;
						}
					}
				}
					
				Event.stop(e);
			});
		});
	};
	
	var lockPermanent = function () {
		$$('#pageMasterViewDeleteForm input.evallockcheckbox').each(function (cbx) {
			Event.observe(cbx, 'click', function (e) {
				var groupId = cbx.id;
				groupId = groupId.replace(EVALLOCK_PREFIX, "");
				var evallockFields = document.getElementsByName(CERTIFY_PREFIX + groupId);
				
				if(evallockFields[0].value == EVALLOCK_PERMANENT)
				{
					cbx.checked = true;
					Event.stop(e);
				}
			});
		});
	};
	
	return {
		// ---------------------------------------------------------------------------
		// public variables
		// ---------------------------------------------------------------------------
		
		// ---------------------------------------------------------------------------
		// public methods
		// ---------------------------------------------------------------------------
		/**
		 * Initializes the toolbar that contains the "Export All" and "Lock/Unlock All" buttons.
		 */
		initTransferEvals: function () {
			showLinks();
			initExportAll();
			initLockUnlockAll();
			selectEvallock();
			lockPermanent();
		}
	};
}();
