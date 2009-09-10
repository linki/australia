// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function($) {
  $('#flash_notice, #flash_error').hide();
  $('#flash_notice, #flash_error').each(function() {
    $.gritter.add({
      // (string | mandatory) the heading of the notification
      title: 'Notice',
      // (string | mandatory) the text inside the notification
      text: $(this).html()
    });
  });
});