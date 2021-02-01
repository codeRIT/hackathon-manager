class Event < ApplicationRecord
  validates_presence_of :title, :start

  validate :finish_before_start

  def finish_before_start
    return if finish.nil?
    unless finish > start
      errors.add(:finish, 'time must be after start time')
    end
  end

  def description=(value)
    if value.blank?
      value = nil
    end
    super value
  end

  def location=(value)
    if value.blank?
      value = nil
    end
    super value
  end

  def category=(value)
    if value.blank?
      value = nil
    end
    super value
  end
end
