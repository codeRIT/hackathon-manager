class AddTriggerToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :trigger, :string
  end
end
