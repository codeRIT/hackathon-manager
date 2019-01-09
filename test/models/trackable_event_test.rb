require 'test_helper'

class TrackableEventTest < ActiveSupport::TestCase
  should strip_attribute :band_id
  should validate_presence_of :band_id
  should validate_presence_of :user
  should validate_presence_of :trackable_tag
  should belong_to :user
  should belong_to :trackable_tag
end
