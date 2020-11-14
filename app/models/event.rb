class Event < ApplicationRecord
  validates_presence_of :title, :start, :end

end
