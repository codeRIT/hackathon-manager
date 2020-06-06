function eventCalendar() {
  return $('#calendar').fullCalendar({
    defaultView: 'listYear',
    eventRender: function(event, element, view) {
      console.log(event);
      let publicText= "";
      if(event.public)
        publicText = "Public";
      element.find('.fc-list-item-title').append('<div class="hr-line-solid-no-margin" style="float: right"><span style="color: red">' + publicText + '</span></div>');
      element.find('.fc-list-item-title').append('<div class="hr-line-solid-no-margin"></div><span style="font-size: 12px">' + event.description + '</span>');
      element.find('.fc-list-item-title').append('<div class="hr-line-solid-no-margin"></div><span style="font-size: 12px">' + event.owner + '</span>')
    },
    events: '/manage/events.json',
    eventClick: function(info) {
      // $('#eventModal').show();
      // $('#editEventBody').html("<%= escape_javascript(render(:partial => 'show', :locals => { :id => "+info.id+" })) %>");
      window.location = "events/"+info.id
    },
    height: "auto",
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
