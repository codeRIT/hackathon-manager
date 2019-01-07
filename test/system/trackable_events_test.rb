require "application_system_test_case"

class TrackableEventsTest < ApplicationSystemTestCase
  setup do
    @trackable_event = trackable_events(:one)
  end

  test "visiting the index" do
    visit trackable_events_url
    assert_selector "h1", text: "Trackable Events"
  end

  test "creating a Trackable event" do
    visit trackable_events_url
    click_on "New Trackable Event"

    fill_in "Band", with: @trackable_event.band_id
    fill_in "Trackable tag", with: @trackable_event.trackable_tag_id
    fill_in "User", with: @trackable_event.user_id
    click_on "Create Trackable event"

    assert_text "Trackable event was successfully created"
    click_on "Back"
  end

  test "updating a Trackable event" do
    visit trackable_events_url
    click_on "Edit", match: :first

    fill_in "Band", with: @trackable_event.band_id
    fill_in "Trackable tag", with: @trackable_event.trackable_tag_id
    fill_in "User", with: @trackable_event.user_id
    click_on "Update Trackable event"

    assert_text "Trackable event was successfully updated"
    click_on "Back"
  end

  test "destroying a Trackable event" do
    visit trackable_events_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trackable event was successfully destroyed"
  end
end
