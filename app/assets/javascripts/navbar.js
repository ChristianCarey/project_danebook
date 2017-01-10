var setNavSize = function() {
  if ($(window).width() < 770) {
      $('.big-nav').hide();
      if(!$('#collapse-nav').is(":visible")) {
        $('#expand-nav').show();
      }
    } else {
      $('.big-nav').show()
      $('.small-nav').hide();
      $('.toggle-nav').hide();
    }
}

$(document).ready(function() {  
  $('#collapse-nav').hide();
  $('.small-nav').hide();
  setNavSize();

  $('.toggle-nav').click(function(){
    $('.small-nav').slideToggle();
    $('.toggle-nav').toggle();
  });

  $(window).resize(function(){
    setNavSize();
  });
});