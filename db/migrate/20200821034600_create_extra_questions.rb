class CreateExtraQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :extra_questions do |t|
      t.string :question
      t.string :data_type
      t.boolean :required
      t.string :select_collection
      t.string :placeholder

      t.timestamps
    end
  end
end
