require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should validate_presence_of :title
  should validate_presence_of :owner
  should validate_presence_of :start
  should validate_presence_of :end
end
