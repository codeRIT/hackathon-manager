var setupManageForms = function() {
  var disable = function($element) {
    $element.hide();
    $element.find('input').prop('disabled', true);
  };
  var enable = function($element) {
    $element.show();
    $element.find('input').prop('disabled', false);
  };

  var updateQuestionForm = function() {
    var $type = $('[name="extra_question[data_type]"]');
    if(typeof $type === 'undefined'){
      return;
    }

    $select_collection = $('.extra_question_select_collection');
    $placeholder = $('.extra_question_placeholder');

    var type = $type.val();
    if (type === "select") {
      enable($select_collection);
      disable($placeholder);
    } else if(type === "boolean"){
      disable($placeholder);
      disable($select_collection);
    }else {
      enable($placeholder);
      disable($select_collection);
    }
  };

  var addRow = function(ev) {
    var $nearest_row, $new_row, $remove_button;
    ev.preventDefault();
    $nearest_row = $(this).prev();
    $nearest_row.find('.text-array__remove').show();
    $new_row = $nearest_row.clone();
    $new_row.find('input').val("");
    $remove_button = $new_row.find('.text-array__remove');
    $remove_button.click(removeRow);
    return $new_row.insertBefore(this);
  };
  var removeRow = function(ev) {
    ev.preventDefault();
    this.parentElement.remove();
    return hideRemoveButton();
  };
  var hideRemoveButton = function() {
    return $('.text-array').each(function(i, el) {
      var $rows;
      $rows = $(el).children('.text-array__row');
      if ($rows.length === 1) {
        return $rows.find('.text-array__remove').hide();
      }
    });
  };
  $('.text-array__add').click(addRow);
  $('.text-array__remove').click(removeRow);

  var updateMessageForm = function() {
    var $type = $('[name="message[type]"]');
    if (typeof $type === 'undefined') {
      return;
    }

    $recipients = $('.message_recipients');
    $trigger = $('.message_trigger');

    var type = $type.val();
    if (type === 'automated') {
      disable($recipients);
      enable($trigger);
    } else {
      disable($trigger);
      enable($recipients);
    }
  };
  updateQuestionForm();
  hideRemoveButton();
  updateMessageForm();
  $('[name="message[type]"]').on('change', function() {
    updateMessageForm();
  });
  $('[name="extra_question[data_type]"]').on('change', function() {
    updateQuestionForm();
  });
};
