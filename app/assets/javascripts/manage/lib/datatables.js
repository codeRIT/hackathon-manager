// Global settings and initializer

function lowercaseFirstChar(string) {
  return string.charAt(0).toLowerCase() + string.slice(1);
}

function convertDataAttrsToConfig(target) {
  var allData = $(target).data();
  var data = Object.keys(allData)
    .filter(function(key) {
      return key.startsWith('table');
    })
    .reduce(function(data, rawKey) {
      var key = lowercaseFirstChar(rawKey.replace('table', ''));
      var value = allData[rawKey];
      if (value == 'true' || value == 'false') {
        value = value == 'true';
      }
      data[key] = value;

      return data;
    }, {});
  return data;
}

$.fn.autoDatatable = function() {
  var columns = [];
  $(this)
    .find('thead th')
    .each(function() {
      var data = convertDataAttrsToConfig(this);
      columns.push(data);
    });

  var config = convertDataAttrsToConfig(this);
  if (config.order) {
    var sequence = config.order.split(',').map(function(piece) {
      return piece.trim();
    });
    config.order = sequence.map(function(piece) {
      var parts = piece.split(' ');
      var index = parseInt(parts[0], 10);
      var direction = parts.length > 1 ? parts[1] : 'asc';
      return [index, direction];
    });
  } else {
    config.order = [1, 'asc'];
  }
  config.columns = columns;

  window.activeDatatable = $(this).DataTable(config);
};

function setupFooterSearch(table) {
  table.columns().every(function() {
    var column = this;
    $(':input', column.footer()).on('keyup change', function() {
      var input = this;
      if (column.search() !== input.value) {
        column.search(input.value).draw();
      }
    });
  });
}

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
    setupFooterSearch(table);
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
  $('table[data-auto-datatable]').autoDatatable();
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
