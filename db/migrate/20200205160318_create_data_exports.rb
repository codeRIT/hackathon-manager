class CreateDataExports < ActiveRecord::Migration[5.2]
  def change
    create_table :data_exports do |t|
      t.string :export_type, null: false
      t.datetime :queued_at
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
