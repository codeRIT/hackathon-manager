$(document).ready(function() {
  var $sidebar = $('.sidebar');

  if ( $sidebar.hasClass('home') ) {
    $('.nav-link, .scroll-to').on('click', function(e) {
      e.preventDefault();
      $('.active').removeClass('active');
      $(e.currentTarget).addClass('active');
      var id = $(e.currentTarget).attr('href');
      id = id.substring(1);
      var $target = $(id);
      $target.addClass('active');
      $('html,body').animate({
        scrollTop: ($target.offset().top)
      }, 1000);
    });
  }

  $('#sidebar-toggle').on('click', toggleSidebar);

  function toggleSidebar (e) {
    if ($sidebar.hasClass('open')) {
      $('#main').off('click', toggleSidebar);
      $sidebar.removeClass('open');
    }
    else {
      $('#main').on('click', toggleSidebar);
      $sidebar.addClass('open');
    }
  }
});
