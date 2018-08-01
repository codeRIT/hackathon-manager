var setupDataTables = function() {

  window.questionnairesDataTable = $('.datatable.questionnaires').DataTable({
    order      : [3, 'desc'],
    columns    : [
      { orderable: false, data: 'bulk' },
      { orderable: false, data: 'link' },
      { orderable: false, data: 'note' },
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email', visible: false },
      { orderable: true, data: 'phone', visible: false },
      { orderable: true, data: 'gender', visible: false },
      { orderable: true, data: 'date_of_birth', visible: false },
      { orderable: true, data: 'acc_status' },
      { orderable: true, data: 'checked_in' },
      { orderable: true, data: 'school' },
      { orderable: true, data: 'created_at' },
      { orderable: true, data: 'dietary_restrictions', visible: false },
      { orderable: true, data: 'special_needs', visible: false },
    ]
  });

  $('.datatable.users').DataTable({
    order      : [1, 'asc'],
    columns    : [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'admin_limited_access' }
    ]
  });

  $('.datatable.messages').DataTable({
    order      : [0, 'desc'],
    columns    : [
      { orderable: true, data: 'id', visible: false},
      { orderable: true, data: 'name'},
      { orderable: true, data: 'subject'},
      { orderable: true, data: 'trigger'},
      { orderable: false, data: 'status'},
      { orderable: true, data: 'delivered_at'}
    ]
  });

  $('.datatable.schools').DataTable({
    order      : [4, 'desc'],
    columns    : [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'name' },
      { orderable: true, data: 'city' },
      { orderable: true, data: 'state' },
      { orderable: true, data: 'questionnaire_count' },
      { orderable: false, data: 'bus_list' }
    ]
  });

  $('.datatable.stats').DataTable({
    processing : false,
    serverSide : false
  });
};
