// Global settings and initializer

$.extend($.fn.dataTable.defaults, {
  processing: true,
  serverSide: true,
  scrollX: false,
  ajax: {
    url: $(this).data('source'),
    type: 'POST',
  },
  initComplete: function(settings, json) {
    var table = settings.oInstance.api();
    table
      .buttons()
      .container()
      .appendTo($('.col-md-6', table.table().container()).first());
  },
  pagingType: 'full_numbers',
  lengthChange: false,
  lengthMenu: [[10, 25, 50, 100, -1], ['10', '25', '50', '100', 'all']],
  buttons: [
    {
      extend: 'pageLength',
      className: 'btn-sm',
    },
    {
      extend: 'colvis',
      className: 'btn-sm',
    },
    {
      extend: 'collection',
      text: 'Export',
      className: 'btn-sm',
      buttons: [
        {
          extend: 'csv',
          exportOptions: {
            columns: ':visible',
          },
        },
        {
          extend: 'pdfHtml5',
          exportOptions: {
            columns: ':visible',
          },
        },
      ],
    },
  ],
  //dom:
  //  "<'row'<'col-sm-4 text-left'f><'right-action col-sm-8 text-right'<'buttons'B> <'select-info'> >>" +
  //  "<'row'<'dttb col-12 px-0'tr>>" +
  //  "<'row'<'col-sm-12 table-footer'lip>>"
});

$(document).on('preInit.dt', function(e, settings) {
  var api, table_id, url;
  api = new $.fn.dataTable.Api(settings);
  table_id = '#' + api.table().node().id;
  url = $(table_id).data('source');
  if (url) {
    return api.ajax.url(url);
  }
});

// init on turbolinks load
$(document).on('turbolinks:load', function() {
  if (!$.fn.DataTable.isDataTable('table[id^=dttb-]')) {
    $('table[id^=dttb-]').DataTable();
  }
});

// turbolinks cache fix
$(document).on('turbolinks:before-cache', function() {
  var dataTable = $($.fn.dataTable.tables(true)).DataTable();
  if (dataTable !== null) {
    dataTable.clear();
    dataTable.destroy();
    return dataTable == null;
  }
});
