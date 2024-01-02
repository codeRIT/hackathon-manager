class CheckinDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_checkin_path, :display_datetime, :bold

  def view_columns
    @view_columns ||= {
      first_name: { source: "User.first_name" },
      last_name: { source: "User.last_name" },
      about: {},
      checked_in: { source: "Questionnaire.checked_in_at", searchable: false },
      actions: {},
    }
  end

  private

  def about(record)
    output = ""
    output += [record.user.first_name, record.user.last_name].join(" ") + " "
    output += '<span class="badge badge-warning"><i class="fa fa-exclamation-triangle"></i>Minor</span>' if record.minor?
    output += "<br /><small>" + record.school.name + "</small>"
    output.html_safe
  end

  def data
    records.map do |record|
      {
        first_name: record.user.first_name,
        last_name: record.user.last_name,
        about: about(record),
        checked_in: yes_no_display(record.checked_in?),
        actions: "<a class=\"btn btn-primary btn-sm\" href=\"#{manage_checkin_path(record)}\">View</a>".html_safe,
      }
    end
  end

  def get_raw_records
    Questionnaire.includes(:user, :school).references(:user, :school)
  end
end
