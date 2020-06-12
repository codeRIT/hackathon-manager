class Event < ApplicationRecord
  validates_presence_of :title, :owner ,:start, :end

  # false.blank? is true, so you need a different validations then validates_presence_of for boolean data
  validates :allDay, inclusion: { in: [true, false] }
  validates :allDay, exclusion: { in: [nil] }
  validates :public, inclusion: { in: [true, false] }
  validates :public, exclusion: { in: [nil] }

end
