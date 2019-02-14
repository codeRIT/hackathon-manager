require 'test_helper'

class TrackableEventTest < ActiveSupport::TestCase
  should strip_attribute :band_id
  should validate_presence_of :band_id
  should validate_presence_of :user
  should validate_presence_of :trackable_tag
  should belong_to :user
  should belong_to :trackable_tag

  should "allow duplicate band IDs when tag#allow_duplicate_band_events is true" do
    trackable_tag = create(:trackable_tag, allow_duplicate_band_events: true)
    create(:trackable_event, band_id: 'foo', trackable_tag: trackable_tag)
    event2 = build(:trackable_event, band_id: 'foo', trackable_tag: trackable_tag)
    assert_equal true, event2.valid?
  end

  should "not allow duplicate band IDs when tag#allow_duplicate_band_events is false" do
    trackable_tag = create(:trackable_tag, allow_duplicate_band_events: false)
    create(:trackable_event, band_id: 'foo', trackable_tag: trackable_tag)
    event2 = build(:trackable_event, band_id: 'foo', trackable_tag: trackable_tag)
    assert_equal false, event2.valid?
  end

  should "allow same band ID for multiple tags when tag#allow_duplicate_band_events is false" do
    trackable_tag1 = create(:trackable_tag, allow_duplicate_band_events: false)
    trackable_tag2 = create(:trackable_tag, allow_duplicate_band_events: false)
    create(:trackable_event, band_id: 'foo', trackable_tag: trackable_tag1)
    event2 = build(:trackable_event, band_id: 'foo', trackable_tag: trackable_tag2)
    assert_equal true, event2.valid?
  end
end
