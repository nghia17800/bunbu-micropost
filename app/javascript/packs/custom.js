$( ".reply-to-comment" ).on('click', function() {
    $(this).parent().next().css('visibility', 'visible');;
    $(this).parent().next().show();
});
