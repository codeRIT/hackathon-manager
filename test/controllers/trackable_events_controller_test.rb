require 'test_helper'

class TrackableEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trackable_event = trackable_events(:one)
  end

  test "should get index" do
    get trackable_events_url
    assert_response :success
  end

  test "should get new" do
    get new_trackable_event_url
    assert_response :success
  end

  test "should create trackable_event" do
    assert_difference('TrackableEvent.count') do
      post trackable_events_url, params: { trackable_event: { band_id: @trackable_event.band_id, trackable_tag_id: @trackable_event.trackable_tag_id, user_id: @trackable_event.user_id } }
    end

    assert_redirected_to trackable_event_url(TrackableEvent.last)
  end

  test "should show trackable_event" do
    get trackable_event_url(@trackable_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_trackable_event_url(@trackable_event)
    assert_response :success
  end

  test "should update trackable_event" do
    patch trackable_event_url(@trackable_event), params: { trackable_event: { band_id: @trackable_event.band_id, trackable_tag_id: @trackable_event.trackable_tag_id, user_id: @trackable_event.user_id } }
    assert_redirected_to trackable_event_url(@trackable_event)
  end

  test "should destroy trackable_event" do
    assert_difference('TrackableEvent.count', -1) do
      delete trackable_event_url(@trackable_event)
    end

    assert_redirected_to trackable_events_url
  end
end
