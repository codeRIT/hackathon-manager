class AddPreventDuplicateBandEventsToTrackableTags < ActiveRecord::Migration[5.2]
  def change
    add_column :trackable_tags, :allow_duplicate_band_events, :bool, null: false, default: true
  end
end
