class TrackableTag < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name], using: { tsearch: { prefix: true } }
  audited

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  strip_attributes
  has_many :trackable_events, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def sorted_events
    trackable_events.order(created_at: :desc)
  end
end
