class TrackableTag < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  strip_attributes
end
