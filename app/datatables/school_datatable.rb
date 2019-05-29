class SchoolDatatable < ApplicationDatatable
  def_delegators :@view, :link_to, :manage_school_path, :bold

  def view_columns
    @view_columns ||= {
      id: { source: "School.id", cond: :eq },
      name: { source: "School.name" },
      city: { source: "School.city" },
      state: { source: "School.state" },
      questionnaire_count: { source: "School.questionnaire_count", searchable: false },
      home_school: { source: "School.is_home", searchable: false },
    }
  end

  private

  def data
    records.map do |record|
      {
        id: record.id,
        name: link_to(bold(record.name), manage_school_path(record)),
        city: record.city,
        state: record.state,
        questionnaire_count: record.questionnaire_count,
        home_school: yes_no_display(record.is_home),
      }
    end
  end

  def get_raw_records
    School.all
  end
end
