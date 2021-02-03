class AddCategoryToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :category, :string
  end
end
