class AltTravelDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_stats_path, :manage_questionnaire_path, :bold, :display_datetime

  def view_columns
    @view_columns ||= {
      id: { source: "Questionnaire.id" },
      first_name: { source: "User.first_name" },
      last_name: { source: "User.last_name" },
      email: { source: "User.email" },
      phone: { source: "Questionnaire.phone" },
      travel_location: { source: "Questionnaire.travel_location" },
      acc_status: { source: "Questionnaire.acc_status" }
    }
  end

  private

  def data
    records.map do |record| {
        id: record.id,
        first_name: record.user.first_name,
        last_name: record.user.last_name,
        email: record.user.email,
        phone: record.phone,
        questionnaire: link_to(bold("View &raquo;".html_safe), manage_questionnaire_path(record.id)),
        travel_location: record.travel_location,
        acc_status: record.acc_status
      }
    end
  end

  def get_raw_records
    restrictions = "travel_not_from_school = '1'"

    q_attributes = [
        :id,
        :phone,
        :travel_location,
        :acc_status,
    ]

    Questionnaire.includes(:user).references(:user).where(restrictions).select(q_attributes)
  end
end
