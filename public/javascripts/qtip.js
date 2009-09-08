jQuery(function($) {
  $('ul li.active').qtip({
     content: 'This is an active list element',
     show: 'mouseover',
     hide: 'mouseout',
     position: { target: 'mouse' }     
  })
});