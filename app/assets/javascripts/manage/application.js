//= require_directory ../
//= require_directory .
//= require popper
//= require bootstrap
//= require ../vendor/datatables.min
//= require selectize
//= require_directory ./lib

$(document).ready(function() {
  $(".selectize").selectize();
  $("select[data-bulk-row-edit]").bulkRowEdit();
  $().bulkRowSelect();
  $("body").chartkickAutoReload();
  setupDataTables();
  setupHighcharts();
  $('[data-toggle="popover"]').popover();
  $('[data-message-live-preview="textarea"]').messageLivePreview();
  setupSimpleMde();
});
