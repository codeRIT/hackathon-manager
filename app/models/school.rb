class School < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }
  audited

  validates_presence_of :name

  validates_uniqueness_of :name, case_sensitive: false

  strip_attributes

  has_many :questionnaires

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def full_name
    out = ""
    out << name
    if full_location.present?
      out << " in "
      out << full_location
    end
    out
  end

  def full_location
    out = ""
    out << city if city.present?
    out << ", " if city.present? && state.present?
    out << state if state.present?
    out
  end

  def fips_code
    Fips.where(city: city, state: state).first
  end
end
