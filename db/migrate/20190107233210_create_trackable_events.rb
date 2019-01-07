class CreateTrackableEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :trackable_events do |t|
      t.string :band_id
      t.references :trackable_tag, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
