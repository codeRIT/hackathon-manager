require 'test_helper'

class TrackableTagTest < ActiveSupport::TestCase
  should strip_attribute :name
  should validate_presence_of :name
  should validate_uniqueness_of :name
end
