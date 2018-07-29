class RemoveEmailFromQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    remove_column :questionnaires, :email, :string
  end
end
