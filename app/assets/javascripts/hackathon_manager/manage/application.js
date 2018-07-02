//= require_directory ../
//= require_directory .
//= require popper
//= require bootstrap
//= require ../vendor/datatables.min
//= require selectize
//= require highcharts
//= require chartkick
//= require_directory ./lib

$(document).ready(function() {
  $('.selectize').selectize();
  $('select[data-bulk-row-edit]').bulkRowEdit();
  $().bulkRowSelect();
  $('body').chartkickAutoReload();
  setupDataTables();
  setupHighcharts();
});
