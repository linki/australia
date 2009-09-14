$(function() {
  $("#selectable li").each(function(){
		$(this).children('input:first').hide();
	});
	$("#selectable").selectable({
		stop: function(){
			$(".ui-selected", this).each(function(){
				$(this).children('input:first').attr('checked', true);
			});
		}
	});
});
