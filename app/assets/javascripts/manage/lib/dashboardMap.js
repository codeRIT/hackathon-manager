document.addEventListener('turbolinks:load', function () {
  $('.map-button').click(function (){
    const map = $('#map');
    if(map.is(":visible")){
      map.hide();
    }
    else{
      map.show();
    }
  })
});
