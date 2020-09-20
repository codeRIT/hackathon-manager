class QuestionnaireDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_questionnaire_path, :manage_school_path, :toggle_bus_captain_manage_bus_list_path, :current_user, :acc_status_class, :display_datetime, :bold

  def view_columns
    @view_columns ||= {
      id: { source: "Questionnaire.id", cond: :eq },
      first_name: { source: "User.first_name" },
      last_name: { source: "User.last_name" },
      email: { source: "User.email" },
      phone: { source: "Questionnaire.phone" },
      gender: { source: "Questionnaire.gender" },
      date_of_birth: { source: "Questionnaire.date_of_birth", searchable: false },
      role: { source: "User.role", cond: :eq, searchable: false },
      acc_status: { source: "Questionnaire.acc_status", searchable: true },
      checked_in: { source: "Questionnaire.checked_in_at", searchable: false },
      boarded_bus: { source: "Questionnaire.boarded_bus_at", searchable: false },
      bus_captain: { source: "Questionnaire.is_bus_captain", searchable: false },
      school: { source: "School.name" },
      created_at: { source: "Questionnaire.created_at", searchable: false },
      dietary_restrictions: { source: "Questionnaire.dietary_restrictions", searchable: true },
      special_needs: { source: "Questionnaire.special_needs", searchable: true },
    }
  end

  private

  def note(record)
    output = ""
    output += '<i class="fa fa-exclamation-triangle"></i> <small>Minor</small>' if record.minor?
    output += '<i class="fa fa-bus" title="Riding bus"></i>' if record.bus_list_id?
    output += "<small>Captain</small>" if record.is_bus_captain?
    output = '<div class="center">' + output + "</div>" if output.present?
    output.html_safe
  end

  def bus_captain(record)
    return "No" unless record.bus_list_id?
    return record.is_bus_captain? ? '<span class="badge badge-success">Yes</span>' : "No" unless current_user.director?

    if record.is_bus_captain?
      link_to("Remove", toggle_bus_captain_manage_bus_list_path(record.bus_list_id, questionnaire_id: record.id, bus_captain: "0"), method: "post", class: "text-danger")
    else
      link_to("Promote", toggle_bus_captain_manage_bus_list_path(record.bus_list_id, questionnaire_id: record.id, bus_captain: "1"), method: "post", data: { confirm: "Are you sure you want to make #{record.user.full_name} a bus captain? They will receive a confirmation email." })
    end
  end

  def data
    records.map do |record|
      {
        bulk: current_user.director? ? "<input type=\"checkbox\" data-bulk-row-edit=\"#{record.id}\">".html_safe : "",
        link: link_to('<i class="fa fa-search"></i>'.html_safe, manage_questionnaire_path(record)),
        note: note(record),
        id: record.id,
        first_name: bold(record.user.first_name),
        last_name: bold(record.user.last_name),
        email: record.email,
        phone: record.phone,
        gender: record.gender,
        date_of_birth: record.date_of_birth_formatted,
        acc_status: "<span class=\"text-#{acc_status_class(record.acc_status)}\">#{Questionnaire::POSSIBLE_ACC_STATUS[record.acc_status]}</span>".html_safe,
        checked_in: yes_no_display(record.checked_in?),
        boarded_bus: yes_no_display(record.boarded_bus?),
        bus_captain: bus_captain(record),
        school: link_to(record.school.name, manage_school_path(record.school)),
        created_at: record.created_at.present? ? display_datetime(record.created_at) : "",
        dietary_restrictions: record.dietary_restrictions,
        special_needs: record.special_needs,
      }
    end
  end

  def get_raw_records
    records = Questionnaire.includes(:user, :school, :bus_list).references(:user, :school, :bus_list)
    if @params[:school_id].present?
      records = records.where(school_id: @params[:school_id])
    end
    if @params[:bus_list_id].present?
      records = records.where(bus_list_id: @params[:bus_list_id])
    end
    if @params[:acc_status].present?
      records = records.where(acc_status: @params[:acc_status])
    end
    records
  end
end
