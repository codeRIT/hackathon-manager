/*
 * NOTE: This should only be used for legacy datatables.
 * All future datatables should be generated using data-table-* HTML attributes.
 * See app/views/manage/application/_questionnaire_datatable.html.haml for an example.
 *
 * 1/1/2024: Temporarily restored Questionnaires to legacy due to an InvalidSearchColumn exception
 */

var setupDataTables = function () {
  $('.datatable.questionnaires').DataTable({
    order: [2, 'asc'],
    columns: [
      { orderable: false, data: 'link' },
      { orderable: false, data: 'note' },
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'phone', visible: false },
      { orderable: true, data: 'gender', visible: false },
      { orderable: true, data: 'date_of_birth', visible: false },
      { orderable: false, data: 'acc_status' },
      { orderable: true, data: 'checked_in' },
      { orderable: true, data: 'boarded_bus', visible: false },
      { orderable: true, data: 'bus_captain', visible: false },
      { orderable: true, data: 'school' },
      { orderable: true, data: 'created_at', visible: false },
      { orderable: true, data: 'dietary_restrictions', visible: false },
      { orderable: true, data: 'special_needs', visible: false },
    ],
  });
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

  $('.datatable.stats-dietary').DataTable({
    order: [1, 'asc'],
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'phone', visible: false },
      { orderable: false, data: 'questionnaire' },
      { orderable: true, data: 'checked_in_at', visible: false },
      { orderable: true, data: 'dietary_restrictions' },
      { orderable: true, data: 'special_needs' }
    ]
  });

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

  $('.datatable.stats-info-applied').DataTable({
    order: [1, 'asc'],
    columns: [
      { orderable: true, data: 'id', visible: false },
      { orderable: true, data: 'first_name' },
      { orderable: true, data: 'last_name' },
      { orderable: true, data: 'email' },
      { orderable: true, data: 'phone', visible: false },
      { orderable: true, data: 'school_name' },
      { orderable: true, data: 'country' },
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
