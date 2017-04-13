selfservice.namespace('selfservice.exception');

selfservice.exception = function () {
	
	var initEditCourseLinks = function (){
		$$(".editStuExcCourse").each(function (link){
			Event.observe(link, 'click', function (event){
				Event.stop(event);
				$('courseEdit').value='edit';
				$('courseEditId').value=link.search.substring(4);
				$('row').submit();
			});
		});
	}
	
	var initAddCourseLink = function (){
		var addButton = $('pageAddButton');
		Event.observe(addButton, 'click', function (event){
			Event.stop(event);
			$('courseEdit').value = 'add';
			$('row').submit();
		});
	}

	var initDeleteCourseLink = function (){
		var deleteButton = $('pages.delete');
		Event.observe(deleteButton, 'click', function (event){
			Event.stop(event);
			$('courseEdit').value = 'delete';
			var toDelete = $$('input:checked[type="checkbox"][name="delete_id"]').pluck("value");
			$('courseEditId').value= toDelete;
			$('row').submit();
		});
	}
	
	return {
		initExceptions: function() {
			initEditCourseLinks();
			initAddCourseLink();
			initDeleteCourseLink();
		}
	};
}();