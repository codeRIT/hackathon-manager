class AddLocationToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :location, :string
  end
end
