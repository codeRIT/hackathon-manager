require 'test_helper'

class TrackableTagTest < ActiveSupport::TestCase
  should strip_attribute :name
  should validate_presence_of :name
  should validate_uniqueness_of :name
  should have_many :trackable_events

  should "implement sorted_events" do
    trackable_tag = create(:trackable_tag)
    create(:trackable_event, trackable_tag: trackable_tag, band_id: 'one', created_at: 10.minutes.ago)
    create(:trackable_event, trackable_tag: trackable_tag, band_id: 'two', created_at: 5.minutes.ago)
    create(:trackable_event, trackable_tag: trackable_tag, band_id: 'three', created_at: 1.minute.ago)
    assert_equal ['three', 'two', 'one'], trackable_tag.sorted_events.pluck(:band_id)
  end
end
