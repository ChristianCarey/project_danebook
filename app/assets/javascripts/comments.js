$(document).ready(function() { 
  $('.post-comment-input').hide();
  $('.open-comment-form').click(function(e) {
    e.preventDefault();
    var $id = $(e.target).data('comment-link-id');
    var $type = $(e.target).data('comment-link-type');
    var $form = $('[data-commentable-id="' + $id + '"][data-commentable-type="' + $type +'"]');
    $form.slideToggle(300);
  });
});