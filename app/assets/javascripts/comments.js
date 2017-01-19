$(document).ready(function() { 
  $('.post-comment-input').hide();
  $('body').on('click', '.open-comment-form', function(e) {
    e.preventDefault();
    var $id = $(e.target).data('comment-link-id');
    var $type = $(e.target).data('comment-link-type');
    var $form = $('[data-commentable-id="' + $id + '"][data-commentable-type="' + $type +'"]');
    $form.slideToggle(300);
  });
});