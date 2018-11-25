class AddGradYearAndRaceEthnicityToQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaires, :graduation_year, :integer, limit: 4
    add_column :questionnaires, :race_ethnicity, :string
  end
end
