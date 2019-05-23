class CreateMessageTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :message_templates do |t|
      t.text :html

      t.timestamps
    end
  end
end
