$(function() {
	$(".sortable").sortable({
	  cursor: 'crosshair',
	  opacity: 0.6,
	  update: function(event, ui) {
	    $(this).parents('form:first').ajaxSubmit();
	  }
	});
	$(".sortable").disableSelection();
});
