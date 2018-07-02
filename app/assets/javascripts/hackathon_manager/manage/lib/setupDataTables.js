var setupDataTables = function() {

  window.questionnairesDataTable = $('.datatable.questionnaires').DataTable({
    order      : [3, 'desc'],
    scrollX    : false,
    columns    : [
      { orderable : false, data: 'bulk' },
      { orderable : false, data: 'link' },
      { orderable : false, data: 'note' },
      { orderable: true, data: 'id' },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email', visible: false },
      { orderable: true, data: 'phone', visible: false },
      { orderable: true, data: 'gender', visible: false },
      { orderable: true, data: 'date_of_birth', visible: false },
      { orderable: true, data: 'acc_status' },
      { orderable: true, data: 'checked_in' },
      { orderable: true, data: 'school' },
      { orderable: true, data: 'created_at', visible: false }
    ]
  });

  $('.datatable.users').DataTable({
    order      : [1, 'asc'],
    scrollX    : false,
    columns    : [
      { orderable: false, data: 'link' },
      { orderable: true, data: 'id' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'admin_limited_access' }
    ]
  });

  $('.datatable.messages').DataTable({
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

  $('.datatable.schools').DataTable({
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

  $('.datatable.stats').DataTable({
    scrollX    : false,
    processing : false,
    serverSide : false
  });
};
