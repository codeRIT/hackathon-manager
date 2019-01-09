require 'test_helper'

class TrackableTagTest < ActiveSupport::TestCase
  should strip_attribute :name
  should validate_presence_of :name
  should validate_uniqueness_of :name
  should have_many :trackable_events

  should "implement has_events?" do
    trackable_tag_1 = create(:trackable_tag)
    trackable_tag_2 = create(:trackable_tag)
    trackable_tag_3 = create(:trackable_tag)
    create_list(:trackable_event, 3, trackable_tag: trackable_tag_1)
    create(:trackable_event, trackable_tag: trackable_tag_3)
    assert_equal true, trackable_tag_1.has_events?
    assert_equal false, trackable_tag_2.has_events?
    assert_equal true, trackable_tag_3.has_events?
  end

  should "implement sorted_events" do
    trackable_tag = create(:trackable_tag)
    create(:trackable_event, trackable_tag: trackable_tag, band_id: 'one', created_at: 10.minutes.ago)
    create(:trackable_event, trackable_tag: trackable_tag, band_id: 'two', created_at: 5.minutes.ago)
    create(:trackable_event, trackable_tag: trackable_tag, band_id: 'three', created_at: 1.minute.ago)
    assert_equal ['three', 'two', 'one'], trackable_tag.sorted_events.pluck(:band_id)
  end
end
