class MLHCheckedInDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_stats_path, :bold, :display_datetime

  def view_columns
    @view_columns ||= {
      id: { source: "Questionnaire.id" },
      first_name: { source: "User.first_name" },
      last_name: { source: "User.last_name" },
      email: { source: "User.email" },
      phone: { source: "Questionnaire.phone" },
      school_name: { source: "School.name" }
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
        school_name: record.school_name
      }
    end
  end

  def get_raw_records
    restrictions = "checked_in_at > 0"

    q_attributes = [
      :id,
      :phone
    ]

    Questionnaire.includes(:user).references(:user).where(restrictions).select(q_attributes)
  end
end
