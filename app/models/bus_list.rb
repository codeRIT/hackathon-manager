class BusList < ApplicationRecord
  audited

  validates_presence_of :name, :capacity
  validates_uniqueness_of :name

  has_many :questionnaires

  strip_attributes

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
