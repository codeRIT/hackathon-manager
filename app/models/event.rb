class Event < ApplicationRecord
  validates_presence_of :title, :start, :finish
end
