class RemoveEmailFromQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    remove_column :questionnaires, :email, :string
  end
end
