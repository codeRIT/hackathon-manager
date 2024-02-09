//= require_directory ../
//= require_directory .
//= require popper
//= require bootstrap
//= require ../vendor/datatables.min
//= require ../vendor/codemirror
//= require ../vendor/codemirror-modes/htmlmixed
//= require ../vendor/codemirror-modes/xml
//= require ../vendor/codemirror-modes/css
//= require selectize
//= require_directory ./lib

function applicationReady() {
  $('.selectize').selectize();
  $('select[data-bulk-row-edit]').bulkRowEdit();
  $().bulkRowSelect();
  $('body').chartkickAutoReload();
  setupHighcharts();
  $('[data-toggle="popover"]').popover();
  $('[data-message-live-preview="textarea"]').messageLivePreview();
  setupSimpleMde();
  setupEmailEvents();
  setupManageForms();
  setupCodeMirror();

  $.ajaxSetup({
    beforeSend: function(xhr) {
      Rails.CSRFProtection(xhr);
    },
  });
}

document.addEventListener('turbo:load', applicationReady);
