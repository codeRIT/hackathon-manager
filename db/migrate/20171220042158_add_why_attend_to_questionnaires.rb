class AddWhyAttendToQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    add_column :questionnaires, :why_attend, :text
  end
end
