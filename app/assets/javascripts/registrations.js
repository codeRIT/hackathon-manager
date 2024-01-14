document.addEventListener('turbo:load', function() {
  $('[data-school-picker]').autocomplete({
    source: function(request, response) {
      $(".ui-helper-hidden-accessible").hide();
      $.ajax({
        url: '/apply/schools',
        dataType: 'json',
        data: {
          name: request.term,
        },
        success: function(data) {
          response(data);
        },
      });
    },
    // hides helper messages
    messages: {
      noResults: '',
      results: function() {},
    },
    minLength: 3,
    delay: 100,
    autoFocus: true,
  });
});
