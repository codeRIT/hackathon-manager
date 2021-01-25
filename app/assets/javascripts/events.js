function eventCalendar() {
  return $('#calendar').fullCalendar({
    defaultView: 'listYear',
    buttonText: {
      today: 'Today'
    },
    eventRender: function (event, element, view) {
      var description = event.description ? event.description : '';
      var location = event.location ? event.location : '';
      var category = event.category ? event.category : '';
      element.find('.fc-event-dot').css('display','none');
      element.find('.fc-list-item-title').append('<div></div><span style="font-size: 12px">' + description + '</span>');
      element.find('.fc-list-item-title').append('<div></div><span style="font-size: 12px">' + location + '</span>');
      element.find('.fc-list-item-title').append('<div></div><span style="font-size: 12px">' + category + '</span>');
    },
    events: {
      url: '/manage/events.json',
      success: function(response) {
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

document.addEventListener('turbolinks:load', function () {
  eventCalendar();
});
document.addEventListener('turbolinks:before-cache', clearCalendar);
