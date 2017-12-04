$(document).ready(function() {
  $('[name="questionnaire[travel_not_from_school]"]').on('change', function() {
    var $location = $('[name="questionnaire[travel_location]"]');
    if (this.value === "true") {
      $location.parent().show();
      $location.prop('disabled', false);
    }
    else {
      $location.parent().hide();
      $location.prop('disabled', true);
    }
  });

  $('[name="questionnaire[acc_status]"]').on('change', function() {
    var $content = $('.hide-if-not-attending');
    if ($(this).val() == 'rsvp_denied') {
      $content.hide();
    }
    else {
      $content.show();
    }
  });
});
