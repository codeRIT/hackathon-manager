class AddPlaceholderToExtraQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :extra_questions, :placeholder, :string
  end
end
