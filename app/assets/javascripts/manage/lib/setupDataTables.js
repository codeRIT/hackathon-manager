/*
 * NOTE: This should only be used for legacy datatables.
 * All future datatables should be generated using data-table-* HTML attributes.
 * See app/views/manage/application/_questionnaire_datatable.html.haml for an example.
 */

var setupDataTables = function() {
  $('.datatable.checkins').DataTable({
    order: [1, 'asc'],
    columns: [
      { orderable: true, data: 'first_name', visible: false },
      { orderable: true, data: 'last_name', visible: false },
      { orderable: false, data: 'about' },
      { orderable: true, data: 'checked_in' },
      { orderable: false, data: 'actions' },
    ],
  });

  $('.datatable.users').DataTable({
    order: [1, 'asc'],
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'role' },
      { orderable: true, data: 'active' },
      { orderable: true, data: 'receive_weekly_report' },
      { orderable: true, data: 'created_at' },
    ],
  });

  $('.datatable.bulk-messages').DataTable({
    order: [4, 'desc'],
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'name' },
      { orderable: true, data: 'subject' },
      { orderable: false, data: 'status' },
      { orderable: true, data: 'created_at' },
      { orderable: true, data: 'updated_at', visible: false },
      { orderable: true, data: 'delivered_at' },
    ],
  });

  $('.datatable.schools').DataTable({
    order: [[5, 'desc'], [4, 'desc']],
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'name' },
      { orderable: true, data: 'city' },
      { orderable: true, data: 'state' },
      { orderable: true, data: 'questionnaire_count' },
      { orderable: true, data: 'home_school' },
    ],
  });

  $('.datatable.stats').DataTable({
    processing: false,
    serverSide: false,
  });
};
