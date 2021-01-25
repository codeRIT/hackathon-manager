document.addEventListener('turbolinks:load', function () {
  $('.map-button').click(function (){
    var map = $('#map');
    if(map.is(':visible')){
      map.hide();
      $(this).html('Show Map');
    }
    else{
      map.show();
      $(this).html('Hide Map');
    }
  });
});
