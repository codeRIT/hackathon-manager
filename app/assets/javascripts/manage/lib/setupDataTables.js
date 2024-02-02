/*
 * NOTE: This should only be used for legacy datatables.
 * All future datatables should be generated using data-table-* HTML attributes.
 * See app/views/manage/application/_questionnaire_datatable.html.haml for an example.
 *
 */

var setupDataTables = function () {
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

  // MARK: Datatables for the stats

  $('.datatable.stats-notschooltravel').DataTable({
    order: [1, 'asc'],
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'phone', visible: false },
      { orderable: false, data: 'questionnaire' },
      { orderable: true, data: 'travel_location' },
      { orderable: true, data: 'acc_status' }
    ]
  });

  $('.datatable.stats-attendeeinfo').DataTable({
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'school_name' },
      { orderable: true, data: 'vcs_url' },
      { orderable: true, data: 'portfolio_url' }
    ]
  });

  $('.datatable.stats-info-checkedin').DataTable({
    order: [1, 'asc'],
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'phone' },
      { orderable: true, data: 'school_name' },
      { orderable: true, data: 'country' }
    ]
  });


};
