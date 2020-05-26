class MoveUserInfoFromQuestionnaireToUserModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :questionnaires, :first_name, :string
    remove_column :questionnaires, :last_name, :string

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
