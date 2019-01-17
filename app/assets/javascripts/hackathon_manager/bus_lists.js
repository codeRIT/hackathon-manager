$(document).ready(function() {

  $checkboxes = $('[data-boarded-bus]');

  function updateCount() {
    var count = $checkboxes.filter(':checked').length
    $('#boarded-bus-count').text(count + ' boarded')
  }

  if ($checkboxes.length < 1) {
    return;
  }

  $checkboxes.on('change', function() {
    $checkbox = $(this);
    var checked = $checkbox.is(':checked');

    $.ajax({
      url: $checkbox.data('action'),
      type: 'PATCH',
      data: {
        questionnaire: {
          boarded_bus: checked,
          id: $checkbox.data('id'),
        }
      }
    }).done(function() {
      $checkbox.prop('checked', checked);
    }).fail(function() {
      alert("Request failed, please refresh the page or try again later.");
    }).always(function() {
      $('[type=submit][data-bulk-row-edit]').prop('disabled', false);
      updateCount()
    });
  });
});
