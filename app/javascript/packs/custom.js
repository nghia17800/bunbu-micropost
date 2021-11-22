$( ".reply-to-comment" ).on('click', function() {
  $(this).parent().next().next().css('visibility', 'visible');;
  $(this).parent().next().next().show();
});
