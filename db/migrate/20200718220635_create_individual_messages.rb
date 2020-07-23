class CreateIndividualMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :individual_messages do |t|
      t.string :name
      t.string :subject
      t.string :recipient
      t.text :body
      t.datetime :queued_at
      t.datetime :started_at
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
