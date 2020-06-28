class AttendeeSponsorInfoDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_stats_path, :manage_questionnaire_path, :bold, :display_datetime

  def view_columns
    @view_columns ||= {
      id: { source: "Questionnaire.id" },
      first_name: { source: "User.first_name" },
      last_name: { source: "User.last_name" },
      email: { source: "User.email" },
      school_name: { source: "School.name" },
      vcs_url: { source: "Questionnaire.vcs_url" },
      portfolio_url: { source: "Questionnaire.portfolio_url" }
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
        school_name: record.school_name,
        vcs_url: record.vcs_url,
        portfolio_url: record.portfolio_url
      }
    end
  end

  def get_raw_records
    # Condition: only retrieve users that have agreed to share data and are at the event
    restrictions = "can_share_info = '1' AND checked_in_at != 0"

    q_attributes = [
      :id,
      :vcs_url,
      :portfolio_url
    ]

    Questionnaire.includes(:user).references(:user).where(restrictions).select(q_attributes)
  end
end
