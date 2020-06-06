class Event < ApplicationRecord
  def all_day?
    allDay.present?
  end

end
