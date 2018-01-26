var setupDataTables = function() {

  var defaultDataTableOptions = function() {
    return {
      dom: 'Bfrtip',
      processing : true,
      serverSide : true,
      ajax       : {
        url   : $(this).data('source'),
        type  : "POST"
      },
      pagingType : 'full_numbers',
      lengthMenu: [
        [ 10, 25, 50, 100, -1 ],
        [ '10 rows', '25 rows', '50 rows', '100 rows', 'Show all' ]
      ],
      buttons: [
        'pageLength',
        'colvis',
        {
          extend: 'collection',
          text: 'Export',
          buttons: [
            {
              extend: 'csv',
              exportOptions: {
                columns: ':visible'
              }
            },
            {
              extend: 'pdfHtml5',
              exportOptions: {
                columns: ':visible'
              }
            },
          ]
        }
      ]
    }
  };

  var setupDataTable = function($table, options) {
    var lastTable;
    $table.each(function() {
      lastTable = $(this).DataTable($.extend(defaultDataTableOptions.call(this), options));
    });

    return lastTable;
  };

  window.questionnairesDataTable = setupDataTable($('.datatable.questionnaires'), {
    order      : [3, 'desc'],
    scrollX    : false,
    columns    : [
      { orderable : false, data: 'bulk' },
      { orderable : false, data: 'link' },
      { orderable : false, data: 'note' },
      { orderable: true, data: 'id' },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'phone', visible: false },
      { orderable: true, data: 'gender', visible: false },
      { orderable: true, data: 'date_of_birth', visible: false },
      { orderable: true, data: 'acc_status' },
      { orderable: true, data: 'checked_in' },
      { orderable: true, data: 'school' },
      { orderable: true, data: 'created_at', visible: false }
    ]
  });

  setupDataTable($('.datatable.users'), {
    order      : [1, 'asc'],
    scrollX    : false,
    columns    : [
      { orderable: false, data: 'link' },
      { orderable: true, data: 'id' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'admin_limited_access' }
    ]
  });

  setupDataTable($('.datatable.messages'), {
    order      : [1, 'desc'],
    scrollX    : false,
    columns    : [
      { orderable: false, data: 'link'},
      { orderable: true, data: 'id'},
      { orderable: true, data: 'name'},
      { orderable: true, data: 'subject'},
      { orderable: true, data: 'trigger'},
      { orderable: false, data: 'status'},
      { orderable: true, data: 'delivered_at'}
    ]
  });

  setupDataTable($('.datatable.schools'), {
    order      : [5, 'desc'],
    scrollX    : false,
    columns    : [
      { orderable: false, data: 'link' },
      { orderable: true, data: 'id' },
      { orderable: true, data: 'name' },
      { orderable: true, data: 'city' },
      { orderable: true, data: 'state' },
      { orderable: true, data: 'questionnaire_count' },
      { orderable: false, data: 'bus_list' }
    ]
  });

  setupDataTable($('.datatable.stats'), {
    scrollX    : false,
    processing : false,
    serverSide : false
  });
};
