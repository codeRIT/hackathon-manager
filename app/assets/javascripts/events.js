function eventCalendar() {
  return $('#calendar').fullCalendar({
    defaultView: 'listYear',
    eventRender: function(info) {

    },
    events: '/manage/events.json',
    eventClick: function(info) {
      $('#eventModal').modal('show');
      document.addEventListener('turbolinks:load', function () {
        $('#showDelete').click(function () {
          $('#eventModal').modal('hide');
          $('#confirmModal').modal('show')
        });
        $('#saveChanges').click(function(){

        });
        $('#confirmDelete').click(function(){

        });
      })
    }
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
