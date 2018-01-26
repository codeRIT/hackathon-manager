class AddBoardedBusToQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    add_column :questionnaires, :boarded_bus_at, :datetime
  end
end
