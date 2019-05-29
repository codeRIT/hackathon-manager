class CheckinDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_checkin_path, :display_datetime, :bold

  def view_columns
    @view_columns ||= {
      first_name: { source: "Questionnaire.first_name" },
      last_name: { source: "Questionnaire.last_name" },
      checked_in: { source: "Questionnaire.checked_in_at", searchable: false },
    }
  end

  private

  def about(record)
    output = ""
    output += [record.first_name, record.last_name].join(" ") + " "
    output += '<span class="badge badge-warning"><i class="fa fa-exclamation-triangle icon-space-r"></i>Minor</span>' if record.minor?
    output += "<br /><small>" + record.school.name + "</small>"
    output.html_safe
  end

  def data
    records.map do |record|
      {
        first_name: record.first_name,
        last_name: record.last_name,
        about: about(record),
        checked_in: record.checked_in? ? "<span class=\"text-success\">Yes</span>".html_safe : "No",
        actions: "<a class=\"btn btn-primary btn-sm\" href=\"#{manage_checkin_path(record)}\">View</a>".html_safe,
      }
    end
  end

  def get_raw_records
    Questionnaire.includes(:user, :school).references(:user, :school)
  end
end
