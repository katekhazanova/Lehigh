/* ========================================================================
* Extends Bootstrap v3.1.1

* Copyright (c) <2014> eBay Software Foundation

* All rights reserved.

* Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

* Neither the name of eBay or any of its subsidiaries or affiliates nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* ======================================================================== */
	
(function($) {
  "use strict";

  var uniqueId = function(prefix) {
      return (prefix || 'ui-id') + '-' + Math.floor((Math.random()*1000)+1)
  }

  // TOOLTIP Extension
  // ===============================

    var showTooltip =    $.fn.tooltip.Constructor.prototype.show
        , hideTooltip =    $.fn.tooltip.Constructor.prototype.hide

    $.fn.tooltip.Constructor.prototype.show = function () {
        showTooltip.apply(this, arguments)
        var $tip = this.tip()
            , tooltipID = $tip.attr('id') || uniqueId('ui-tooltip')
        $tip.attr({'role':'tooltip','id' : tooltipID})
        this.$element.attr('aria-describedby', tooltipID)
    }

    $.fn.tooltip.Constructor.prototype.hide = function () {
        hideTooltip.apply(this, arguments)
        removeMultiValAttributes(this.$element, 'aria-describedby', this.tip().attr('id'))
    }

  // Popover Extension
  // ===============================
    var showPopover =   $.fn.popover.Constructor.prototype.setContent
      , hideTPopover =   $.fn.popover.Constructor.prototype.hide

    $.fn.popover.Constructor.prototype.setContent = function(){
      showPopover.apply(this, arguments)
      var $tip = this.tip()
        , tooltipID = $tip.attr('id') || uniqueId('ui-tooltip')
      $tip.attr({'role':'alert','id' : tooltipID})
      this.$element.attr('aria-describedby', tooltipID)
      this.$element.focus()
    }
    $.fn.popover.Constructor.prototype.hide =  function(){
        hideTooltip.apply(this, arguments)
        removeMultiValAttributes(this.$element, 'aria-describedby', this.tip().attr('id'))
    }

  //Modal Extension
    $('.modal-dialog').attr( {'role' : 'document'})
    var modalhide =   $.fn.modal.Constructor.prototype.hide
    $.fn.modal.Constructor.prototype.hide = function(){
       var modalOpener = this.$element.parent().find('[data-target="#' + this.$element.attr('id') + '"]')
       modalhide.apply(this, arguments)
       modalOpener.focus()
    }
	

	// DROPDOWN Extension
	  // ===============================
    
    var toggle   = '[data-toggle=dropdown]';
    
	 $(document).ready(function(){
		    
			      var $par
			      , firstItem
			      , focusDelay = 200
			      , menus = $(toggle).parent().find('ul').attr('role','menu')
			      , lis = menus.find('li').attr('role','presentation')
	
			    lis.find('a').attr({'role':'menuitem', 'tabIndex':'-1'})
			    $(toggle).attr({ 'aria-haspopup':'true', 'aria-expanded': 'false'})
	
			    $(toggle).parent().on('shown.bs.dropdown',function(e){
			      $par = $(this)
			      var $toggle = $par.find(toggle)
			      $toggle.attr('aria-expanded','true')
	
			      setTimeout(function(){
			            firstItem = $('.dropdown-menu [role=menuitem]:visible', $par)[0]
			            try{ firstItem.focus()} catch(ex) {}
			      }, focusDelay)
			    })
	
			    $(toggle).parent().on('hidden.bs.dropdown',function(e){
			      $par = $(this)
			      var $toggle = $par.find(toggle)
			      $toggle.attr('aria-expanded','false')
			    })
	 });


	    //Adding Space Key Behaviour, opens on spacebar
	    $.fn.dropdown.Constructor.prototype.keydown = function (e) {
	      var  $par
	        , firstItem
	      if (!/(32)/.test(e.keyCode)) return
	        $par = $(this).parent()
	        $(this).trigger ("click")
	        e.preventDefault() && e.stopPropagation()

	        if (!$par.hasClass('open')){
	            var dropdownOpener = $(this).parent().find('[data-toggle=dropdown]')
	        	dropdownOpener.focus()
	        }
	    }

	    $(document)
	      .on('focusout.dropdown.data-api', '.dropdown-menu', function(e){
	        var $this = $(this)
	                    , that = this
	        setTimeout(function() {
	         if(!$.contains(that, document.activeElement)){
	          $this.parent().removeClass('open')
	          $this.parent().find('[data-toggle=dropdown]').attr('aria-expanded','false')
	         }
	        }, 150)
	       })
	      .on('keydown.bs.dropdown.data-api', toggle + ', [role=menu]' , $.fn.dropdown.Constructor.prototype.keydown)




  // GENERAL UTILITY FUNCTIONS
  // ===============================

    var removeMultiValAttributes = function (el, attr, val) {
     var describedby = (el.attr( attr ) || "").split( /\s+/ )
        , index = $.inArray(val, describedby)
     if ( index !== -1 ) {
       describedby.splice( index, 1 )
     }
     describedby = $.trim( describedby.join( " " ) )
     if (describedby ) {
       el.attr( attr, describedby )
     } else {
      el.removeAttr( attr )
     }
    }


})(jQuery);
