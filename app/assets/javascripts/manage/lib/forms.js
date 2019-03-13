$(document).ready(function() {
  var disable = function($element) {
    $element.hide();
    $element.find('input').prop('disabled', true);
  };
  var enable = function($element) {
    $element.show();
    $element.find('input').prop('disabled', false);
  };

  var updateMessageForm = function() {
    var $type = $('[name="message[type]"]');
    if (typeof $type === 'undefined') {
      return;
    }

    $recipients = $('.message_recipients');
    $trigger = $('.message_trigger');

    var type = $type.val();
    if (type === "automated") {
      disable($recipients);
      enable($trigger);
    } else {
      disable($trigger);
      enable($recipients);
    }
  };

  updateMessageForm();
  $('[name="message[type]"]').on('change', function() {
    updateMessageForm();
  });
});
