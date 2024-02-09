function eventCalendar() {
  return $('#calendar').fullCalendar({
    defaultView: 'listYear',
    buttonText: {
      today: 'Today'
    },
    eventRender: function (event, element, view) {
      element.find('.fc-event-dot').css('display', 'none');
      if(event.description) {
        element.find('.fc-list-item-title').append('<div></div><span style="font-size: 12px">' + event.description + '</span>');
      }
      if (event.location) {
        element.find('.fc-list-item-title').append('<div></div><span style="font-size: 12px"><b>Location: </b>' + event.location + '</span>');
      }
      if (event.category) {
        element.find('.fc-list-item-title').append('<div></div><span style="font-size: 12px"><b>Category: </b>' + event.category + '</span>');
      }
    },
    events: {
      url: '/manage/events.json',
      success: function (response) {
        // due to "end" being a keyword in ruby and what fullcalender uses it is stored as finish and than it is
        // converted to "end" when sending it to fullcalendar
        response = JSON.parse(JSON.stringify(response).split('"finish":').join('"end":'));
        return response;
      }
    },
    eventClick: function (info) {
      window.location = 'events/' + info.id;
    },
    height: 'auto',
  });
}

function clearCalendar() {
  $('#calendar').fullCalendar('delete');
  $('#calendar').html('');
}

document.addEventListener('turbo:load', function () {
  eventCalendar();
});
document.addEventListener('turbo:before-cache', clearCalendar);
