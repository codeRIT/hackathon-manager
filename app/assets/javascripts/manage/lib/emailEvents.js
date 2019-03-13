$(document).ready(function() {
  $('.email-events').each(function() {
    var events_container = this;

    $(events_container).html('<span class="fa fa-circle-o-notch fa-spin"></span>');

    var data_url = $(events_container).data('url');
    $.ajax(data_url)
      .done(function(json) {
        if (!json.length) {
          $(events_container).html('<em>No events found.</em>');
          return;
        }

        const reducer = function(accumulator, event) {
          const key = event.message_id;
          if (key in accumulator === false) {
            accumulator[key] = [];
          }
          accumulator[key].push(event);
          return accumulator;
        };
        const groupedEvents = json.reduce(reducer, {});

        const innerHtml = Object.keys(groupedEvents).map(function(key) {
          const group = groupedEvents[key];
          const groupHtml = group.map(function(event) {
            const timestamp = new Date(event.timestamp);
            return '<br /><small>' + event.type + ' at ' + timestamp.toLocaleString() + '</small>';
          }).join('');
          return '<li><p><strong>' + group[0].subject + '</strong>' + groupHtml + '</li>';
        }).join('');
        const newHtml = '<ul>' + innerHtml + '</ul>';

        $(events_container).html(newHtml);
      })
      .fail(function() {
        $(events_container).html('<em>An error ocurred. Please try again later.</em>');
      });
  });
});
