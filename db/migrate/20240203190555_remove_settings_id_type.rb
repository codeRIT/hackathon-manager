class RemoveSettingsIdType < ActiveRecord::Migration[7.1]
  def change
    remove_column :settings, :thing_id
    remove_column :settings, :thing_type
  end
end
