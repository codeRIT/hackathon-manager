require 'test_helper'

class EventTest < ActiveSupport::TestCase

  should validate_presence_of :title
  should validate_presence_of :owner
  should validate_presence_of :start
  should validate_presence_of :end

  should validates :allDay, inclusion: { in: [true, false] }
  should validates :allDay, exclusion: { in: [nil] }
  should validates :public, inclusion: { in: [true, false] }
  should validates :public, exclusion: { in: [nil] }

end
