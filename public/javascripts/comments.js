$(function($) {
  $("#new_comment").submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  });
});