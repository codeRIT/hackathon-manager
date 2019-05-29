class QuestionnaireDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_questionnaire_path, :manage_school_path, :current_user, :acc_status_class, :display_datetime, :bold

  def view_columns
    @view_columns ||= {
      id: { source: 'Questionnaire.id', cond: :eq },
      first_name: { source: 'Questionnaire.first_name' },
      last_name: { source: 'Questionnaire.last_name' },
      email: { source: 'User.email' },
      phone: { source: 'Questionnaire.phone' },
      gender: { source: 'Questionnaire.gender' },
      date_of_birth: { source: 'Questionnaire.date_of_birth', searchable: false },
      role: { source: 'User.role', cond: :eq, searchable: false },
      acc_status: { source: 'Questionnaire.acc_status', searchable: true },
      checked_in: { source: 'Questionnaire.checked_in_at', searchable: false },
      school: { source: 'School.name' },
      created_at: { source: 'Questionnaire.created_at', searchable: false },
      dietary_restrictions: { source: 'Questionnaire.dietary_restrictions', searchable: true },
      special_needs: { source: 'Questionnaire.special_needs', searchable: true }
    }
  end

  private

  def note(record)
    output = ''
    output += '<i class="fa fa-exclamation-triangle icon-space-r"></i> <small>Minor</small>' if record.minor?
    output += '<i class="fa fa-bus icon-space-r" title="Riding bus"></i>' if record.bus_list_id?
    output += '<small>Captain</small>' if record.is_bus_captain?
    output = '<div class="center">' + output + '</div>' if output.present?
    output.html_safe
  end

  def data
    records.map do |record|
      {
        bulk: current_user.admin? ? "<input type=\"checkbox\" data-bulk-row-edit=\"#{record.id}\">".html_safe : '',
        link: link_to('<i class="fa fa-search"></i>'.html_safe, manage_questionnaire_path(record)),
        note: note(record),
        id: record.id,
        first_name: bold(record.first_name),
        last_name: bold(record.last_name),
        email: record.email,
        phone: record.phone,
        gender: record.gender,
        date_of_birth: record.date_of_birth_formatted,
        acc_status: "<span class=\"text-#{acc_status_class(record.acc_status)}\">#{record.acc_status.titleize}</span>".html_safe,
        checked_in: record.checked_in? ? '<span class="text-success">Yes</span>'.html_safe : 'No',
        school: link_to(record.school.name, manage_school_path(record.school)),
        created_at: record.created_at.present? ? display_datetime(record.created_at) : '',
        dietary_restrictions: record.dietary_restrictions,
        special_needs: record.special_needs
      }
    end
  end

  def get_raw_records
    Questionnaire.includes(:user, :school).references(:user, :school)
  end
end
