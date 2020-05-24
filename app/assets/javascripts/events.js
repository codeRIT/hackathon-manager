function eventCalendarPublic() {
  return $('#calendarPublic').fullCalendar({
    defaultView: 'listYear',
    events: [
      {
        id: "1",
        title: "Test Public",
        start: "2020-05-19T10:30:00",
        end: "2020-05-19T11:30:00"
      },
      {
        id: "2",
        title: "Test Event",
        start: "2020-05-20T10:30:00",
        end: "2020-05-20T11:30:00"
      },
      {
        id: "3",
        title: "Test All Day",
        start: "2020-05-20T10:30:00",
        allDay: true
      },
    ]
  });
}

function eventCalendarMaster() {
  return $('#calendarMaster').fullCalendar({
    defaultView: 'listYear',
    events: [
      {
        id: "1",
        title: "Test Master",
        start: "2020-05-19T10:30:00",
        end: "2020-05-19T11:30:00"
      },
      {
        id: "2",
        title: "Test Event",
        start: "2020-05-20T10:30:00",
        end: "2020-05-20T11:30:00"
      },
      {
        id: "3",
        title: "Test All Day",
        start: "2020-05-20T10:30:00",
        allDay: true
      },
    ]
  });
}

function clearCalendar() {
  $('#calendarMaster').fullCalendar('delete');
  $('#calendarMaster').html('');
  $('#calendarPublic').fullCalendar('delete');
  $('#calendarPublic').html('');
}


function showMaster() {
  $('#calendarPublic').hide();
  $('#calendarMaster').show();
}

function showPublic() {
  $('#calendarMaster').hide();
  $('#calendarPublic').show();
}

document.addEventListener('turbolinks:load', function () {
  eventCalendarPublic();
  eventCalendarMaster();
  showMaster();
  $('#masterButton').click(function(){
    showMaster()
  });
  $('#publicButton').click(function(){
    showPublic()
  });

});
document.addEventListener('turbolinks:before-cache', clearCalendar);
