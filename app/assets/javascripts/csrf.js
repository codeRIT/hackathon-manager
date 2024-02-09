document.addEventListener('turbo:load', function() {
  $.ajaxSetup({
    beforeSend: function(xhr) {
      Rails.CSRFProtection(xhr);
    },
  });
});
