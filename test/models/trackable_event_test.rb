require 'test_helper'

class TrackableEventTest < ActiveSupport::TestCase
  should strip_attribute :band_id
  should validate_presence_of :band_id
  should belong_to :user
  should belong_to :trackable_tag
end
