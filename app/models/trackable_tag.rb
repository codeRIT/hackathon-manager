class TrackableTag < ApplicationRecord
  audited

  validates_presence_of :name
  validates_uniqueness_of :name
  strip_attributes
  has_many :trackable_events, dependent: :destroy

  def sorted_events
    trackable_events.order(created_at: :desc)
  end
end
