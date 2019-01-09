class TrackableEvent < ApplicationRecord
  validates_presence_of :band_id, :trackable_tag, :user

  strip_attributes

  belongs_to :trackable_tag
  belongs_to :user
end
