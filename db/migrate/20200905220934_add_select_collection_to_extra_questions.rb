class AddSelectCollectionToExtraQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :extra_questions, :select_collection, :string
  end
end
