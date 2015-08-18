$(function() {
  
  $('.favorite').on('click', function() {
    var $star = $(this).find('.glyphicon');
    $star.removeClass('glyphicon-star-empty').addClass('glyphicon-star');

    // POST request to server to create favorite in db
    $.post('/favorites', {
      favorite: { recipe_id: $(this).attr('data-id') }
    },
    function(data) {
      console.log(data);
    });
  });

});