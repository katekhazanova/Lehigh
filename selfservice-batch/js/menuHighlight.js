var $j = jQuery.noConflict();


$j(document).ready(function(){
	
	var group = $j('#pageGroup').val();
	$j('#'+group).addClass('active');
	
	var mobileGroup = $j('#mobilePageGroup').val();
	$j('.'+mobileGroup).addClass('active');
	
	//this fixes the issues with placeholders in ie9 and ie8
	$j('[placeholder]').focus(function() {
		  var input = $j(this);
		  if (input.val() == input.attr('placeholder')) {
		    input.val('');
		    input.removeClass('placeholder');
		  }
		}).blur(function() {
		  var input = $j(this);
		  if (input.val() == '' || input.val() == input.attr('placeholder')) {
		    input.addClass('placeholder');
		    input.val(input.attr('placeholder'));
		  }
		}).blur();
	
	$j('[placeholder]').parents('form').submit(function() {
		  $j(this).find('[placeholder]').each(function() {
		    var input = $j(this);
		    if (input.val() == input.attr('placeholder')) {
		      input.val('');
		    }
		  })
		});
});


