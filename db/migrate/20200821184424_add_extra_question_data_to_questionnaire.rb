class AddExtraQuestionDataToQuestionnaire < ActiveRecord::Migration[5.2]
  def change
    add_column :questionnaires, :extra_question_data, :string
  end
end
