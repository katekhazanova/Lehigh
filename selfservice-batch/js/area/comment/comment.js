
/*
 * This is a re-implemented version of jquery version of comment.js that is used in 
 * u.direct. This version is implemented with prototype which is the primary js 
 * library used by selfservice
 * 
 * Justin Shelton
 */

function expandComment(){
	
	var commentId = expandComment.arguments[0];
	var toHide = 'closed-historicalComment-' + commentId; 
	var toShow = 'historicalComment-' + commentId;
	$(toHide).up('tr').addClassName('hidden');
	$(toShow).up('tr').removeClassName('hidden');
}

function collapseComment(){
	
	var commentId = collapseComment.arguments[0];
	var toHide = 'historicalComment-' + commentId; 
	var toShow = 'closed-historicalComment-' + commentId ;
	$(toHide).up('tr').addClassName('hidden');
	$(toShow).up('tr').removeClassName('hidden');

}

function expandAllComments(){
	
	var toHide = '.closed-historicalComment'; 
	var toShow = '.historicalComment';

	$$(toHide).each(function(d){
		  d.up('tr').addClassName("hidden");
		});

	$$(toShow).each(function(d){
		d.up('tr').removeClassName("hidden");
	});
}

function collapseAllComments(){
	
	var toHide = '.historicalComment'; 
	var toShow = '.closed-historicalComment';
	
	
	$$(toHide).each(function(d){
		  d.up('tr').addClassName("hidden");
		});

	$$(toShow).each(function(d){
		d.up('tr').removeClassName("hidden");
	});
}

