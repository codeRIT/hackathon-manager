document.addEventListener('turbolinks:load', function() {
  $.ajaxSetup({
    beforeSend: function(xhr) {
      Rails.CSRFProtection(xhr);
    },
  });
});
