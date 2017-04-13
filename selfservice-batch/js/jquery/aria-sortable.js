/*!
 * ARIA UI Sortable implementation 0.1.0
 * Compatible with jQuery UI Sortable 1.11.2
 *
 * Copyright 2014 CollegeSource, Inc.
 */	
$j.widget( "collegesource.ariaSortable", {
	
	options: {
	},
	
	_create: function() {
		this.element.bind( "keydown", function (e) {
			if ($j(e.target).hasClass( "ui-sortable-handle" )) {
			    switch(e.which) {				    
				    case 32: // space
				    	e.preventDefault();
				    	if ($j(e.target).hasClass( "ariaSortable-selected" )) {
				    		$j(e.target).removeClass( "ariaSortable-selected" );
				    		$j(e.target).attr( "aria-grabbed", false );
				    		$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Deselected row ' + ($j(e.target).index() + 1) + '.');
				    		$j(e.target).parent().attr( 'role', 'list' );
							$j(e.target).find(".last_mod_user").val("");
							$j(e.target).find(".last_mod_date").val("");
				    	} else {
				    		$j(e.target).parent().attr( 'role', 'application' );
				    		$j(e.target).addClass( "ariaSortable-selected" );
				    		$j(e.target).attr( "aria-grabbed", true );
				    		$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Selected row ' + ($j(e.target).index() + 1) + ' of ' + ($j(e.target).siblings().length + 1) + '.');
				    	}
				    	break;
				               	
				    case 35: // end
						if ($j(e.target).hasClass( "ariaSortable-selected" )) {
				       		e.preventDefault();
				       		if ($j(e.target).next().length) {				       			
				       			$j(e.target).insertAfter( $j(e.target).siblings().last() );
				       			$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Moved row to row ' + ($j(e.target).index() + 1) + ' of ' + ($j(e.target).siblings().length + 1) + '.');
				       			$j(e.target).parent().ariaSortable( "sorted" );
				       		}
				       		$j(e.target).focus();
						}
				       	break;
				              	
				    case 36: // home
						if ($j(e.target).hasClass( "ariaSortable-selected" )) {
				       		e.preventDefault();
				       		if ($j(e.target).prev().length) {				       			
				       			$j(e.target).insertBefore( $j(e.target).siblings().first() );
				       			$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Moved row to row ' + ($j(e.target).index() + 1) + ' of ' + ($j(e.target).siblings().length + 1) + '.');
				       			$j(e.target).parent().ariaSortable( "sorted" );
				       		}
				       		$j(e.target).focus();
						}
				       	break;
					        	
				    case 38: // up
						if ($j(e.target).hasClass( "ariaSortable-selected" )) {
				       		e.preventDefault();
				       		if ($j(e.target).prev().length) {				       			
				       			$j(e.target).prev().insertAfter( $j(e.target) );
				       			$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Moved row to row ' + ($j(e.target).index() + 1) + ' of ' + ($j(e.target).siblings().length + 1) + '.');
				       			$j(e.target).parent().ariaSortable( "sorted" );
				       		}
						}
				       	break;
				        	
					case 40: // down
						if ($j(e.target).hasClass( "ariaSortable-selected" )) {
				       		e.preventDefault();
				       		if ($j(e.target).next().length) {				       			
				       			$j(e.target).next().insertBefore( $j(e.target) );
				       			$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Moved row to row ' + ($j(e.target).index() + 1) + ' of ' + ($j(e.target).siblings().length + 1) + '.');
				       			$j(e.target).parent().ariaSortable( "sorted" );
				       		}
						}
			       		break;
			       		
					case 77: // m
						if (e.ctrlKey) {
							e.preventDefault();
					    	if ($j(e.target).hasClass( "ariaSortable-selected" ) && !$j(e.target).parent().ariaSortable( "option", "moving" )) {
					    		$j(e.target).removeClass( "ariaSortable-selected" );
					    		$j(e.target).attr( "aria-grabbed", false );
					    		$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Deselected row ' + ($j(e.target).index() + 1) + '.');
					    		$j(e.target).parent().attr( 'role', 'list' );
					    	}
			    		}
			       		break;
	
					default: 
						return; // exit this handler for other keys
			    }
			}
		});
		this.element.bind( "focusout", function (e) {
	    	if ($j(e.target).hasClass( "ariaSortable-selected" ) && !$j(e.target).parent().ariaSortable( "option", "moving" )) {
	    		$j(e.target).removeClass( "ariaSortable-selected" );
	    		$j(e.target).attr( "aria-grabbed", false );
	    		$j( "#" + $j(e.target).parent().attr( "id" ) + "Alerts" ).html( 'Deselected row ' + ($j(e.target).index() + 1) + '.');
	    		$j(e.target).parent().attr( 'role', 'list' );
	    	}
		});
		this.element.sortable(this.options);
		this.element.addClass( "ariaSortable" );
		this.element.attr( 'role', 'list' );
		this.element.children( '.ui-state-default' ).each(function() {
			$j( this ).attr( 'role', 'listitem' );
			$j( this ).attr( 'tabindex', '0' );
			$j( this ).attr( 'aria-grabbed', 'false' );
		});
		$j( 'body' ).append('<div id="' + this.element.attr( "id" ) + 'Alerts" class="sr-only" aria-live="assertive"></div>');
	},
	
	_setOption: function( key, value ) {
		this.options[ key ] = value;
		this.element.sortable( "option", key, value )
	},
	
	sorted: function() {
		this._trigger( "sorted", null, { element: this.element } );
	},
	
	newRow: function() {
		this.element.children( '.ui-state-default' ).each(function() {
			$j( this ).addClass( 'ui-sortable-handle' );
			$j( this ).attr( 'role', 'listitem' );
			$j( this ).attr( 'tabindex', '0' );
			$j( this ).attr( 'aria-grabbed', 'false' );
		});
	},
	
	destroy: function() {
		this.element
		.removeClass( "ariaSortable" )
		.text( "" );
		// Call the base destroy function.
		$j.Widget.prototype.destroy.call( this );
	}
	
});