class RemoveAllDayFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :allDay, :boolean
  end
end
