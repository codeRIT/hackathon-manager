class BusList < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name], using: { tsearch: { prefix: true } }
  audited

  validates_presence_of :name, :capacity
  validates_uniqueness_of :name, case_sensitive: false

  has_many :questionnaires

  strip_attributes

  def self.ransackable_attributes(_)
    ["created_at", "id", "name", "updated_at"]
  end

  def full?
    passengers.count >= capacity
  end

  def passengers
    questionnaires.where("acc_status = 'rsvp_confirmed'")
  end

  def schools
    passengers.joins(:school).map(&:school).uniq
  end

  def checked_in_passengers
    passengers.select(&:checked_in?)
  end

  def boarded_passengers
    passengers.select(&:boarded_bus?)
  end

  def captains
    passengers.where(is_bus_captain: true)
  end

  def name_maybe_full
    full? ? "(full) #{name}" : name
  end
end
