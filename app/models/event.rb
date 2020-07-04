class Event < ApplicationRecord
  validates_presence_of :title, :owner, :start, :end
end
