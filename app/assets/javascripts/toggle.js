document.addEventListener('turbolinks:load', function() {
  $.fn.toggleDetails = function() {
    var toggle = function() {
      $('.details').slideUp();
      $(this)
        .parent()
        .find('.details:hidden')
        .slideDown();
    };

    $(this).each(function() {
      $(this).on('click', toggle);
    });
  };

  $('.toggle-details').toggleDetails();

  $.fn.toggleBlock = function() {
    var toggle = function() {
      var $this = $(this);
      $('.info').slideUp();
      $('#' + $this.data('target') + ':hidden').slideDown();
    };
    $(this).each(function() {
      $(this).on('click', toggle);
    });
  };
  $('.block .name').toggleBlock();
});
