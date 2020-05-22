class CreateDeletedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :deleted_users do |t|
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
