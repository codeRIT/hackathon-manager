$(document).ready(function() {
  $.fn.wizard = function() {
    var form = this;

    var goToStage = function($newStage) {
      $(form).find('.wizard-current').removeClass('wizard-current');
      $newStage.addClass('wizard-current');
      $("html, body").animate({ scrollTop: 0 }, "slow");
      if ($newStage.find('.field_with_errors').length > 0) {
        $newStage.find(".field_with_errors").first().find(":input").focus();
      } else {
        $newStage.find(":input").first().focus();
      }
    }

    var nextStage = function() {
      if (!$(form).find('.wizard-current').validate('now')) {
        return false;
      }
      goToStage($(form).find('.wizard-current').next());
    };

    var previousStage = function() {
      goToStage($(form).find('.wizard-current').prev());
    };

    if ($(form).find('.field_with_errors').length > 0) {
      goToStage($(form).find('.field_with_errors').first().parents('.wizard-stage'));
    }
    $(this).find('[data-wizard=next]').each(function() {
      $(this).on('click', nextStage);
    });
    $(this).find('[data-wizard=previous]').each(function() {
      $(this).on('click', previousStage);
    });
    if ($(this).is('.wizard-skip-valid')) {
      nextStage.call(this);
    }
  };

  $('.wizard').wizard();
});
