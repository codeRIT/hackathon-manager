class DietarySpecialNeedsDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_stats_path, :manage_questionnaire_path, :bold, :display_datetime

  def view_columns
    @view_columns ||= {
      id: { source: "Questionnaire.id" },
      first_name: { source: "User.first_name" },
      last_name: { source: "User.last_name" },
      email: { source: "User.email" },
      phone: { source: "Questionnaire.phone" },
      checked_in_at: { source: "Questionnaire.checked_in_at", searchable: false },
      dietary_restrictions: { source: "Questionnaire.dietary_restrictions" },
      special_needs: { source: "Questionnaire.special_needs" }
    }
  end

  private

  def data
    records.map do |record| 
      {
        id: record.id,
        first_name: record.user.first_name,
        last_name: record.user.last_name,
        email: record.user.email,
        phone: record.phone,
        questionnaire: link_to(bold("View &raquo;".html_safe), manage_questionnaire_path(record.id)),
        checked_in_at: record.checked_in_at,
        dietary_restrictions: record.dietary_restrictions,
        special_needs: record.special_needs
      }
    end
  end

  def get_raw_records
    # Condition: only retrieve users that have dietary restrictions or special dietary needs
    restrictions = "acc_status = 'rsvp_confirmed' AND "\
    "dietary_restrictions != '' OR special_needs != ''"

    q_attributes = [
      :id,
      :phone,
      :checked_in_at,
      :dietary_restrictions,
      :special_needs
    ]

    Questionnaire.includes(:user).references(:user).where(restrictions).select(q_attributes)
  end
end
