function toggleMobileNav() {
  $('.sidebar').toggleClass('sidebar-mobile');
  if ($('.sidebar').hasClass('sidebar-mobile')) {
    $('.navbar-mobile-toggle').addClass('navbar-mobile-toggle--active');
  } else {
    $('.navbar-mobile-toggle').removeClass('navbar-mobile-toggle--active');
  }
}
