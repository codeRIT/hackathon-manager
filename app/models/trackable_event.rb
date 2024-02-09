class TrackableEvent < ApplicationRecord
  validates_presence_of :band_id, :trackable_tag, :user
  validates_uniqueness_of :band_id, case_sensitive: false, scope: :trackable_tag_id, if: -> { !trackable_tag&.allow_duplicate_band_events }

  strip_attributes

  belongs_to :trackable_tag
  belongs_to :user
end
