class ChangeQuestionnaireDietarySpecialNeedsStringToText < ActiveRecord::Migration[5.2]
  def change
    change_column :questionnaires, :dietary_restrictions, :text
    change_column :questionnaires, :special_needs, :text
  end
end
