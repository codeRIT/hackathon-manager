class AddUserIdToIndividualMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :individual_messages, :user_id, :int
  end
end
