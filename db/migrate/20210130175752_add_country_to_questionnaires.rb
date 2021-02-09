class AddCountryToQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaires, :country, :string
  end
end
