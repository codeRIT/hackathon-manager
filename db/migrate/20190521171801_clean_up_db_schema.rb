class CleanUpDbSchema < ActiveRecord::Migration[5.2]
  def change
    remove_column :questionnaires, :riding_bus
  end
end
