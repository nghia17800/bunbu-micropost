$( ".reply-to-comment" ).on('click', function() {
  $(this).parents(".show-reply").next().next().css('visibility', 'visible');;
  $(this).parents(".show-reply").next().next().show();
});

$( ".icon-menu-comment" ).on('click', function() {
  $('.menu-comment').toggleClass('visible');
});
