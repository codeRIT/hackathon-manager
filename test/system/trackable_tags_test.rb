require "application_system_test_case"

class TrackableTagsTest < ApplicationSystemTestCase
  setup do
    @trackable_tag = trackable_tags(:one)
  end

  test "visiting the index" do
    visit trackable_tags_url
    assert_selector "h1", text: "Trackable Tags"
  end

  test "creating a Trackable tag" do
    visit trackable_tags_url
    click_on "New Trackable Tag"

    fill_in "Name", with: @trackable_tag.name
    click_on "Create Trackable tag"

    assert_text "Trackable tag was successfully created"
    click_on "Back"
  end

  test "updating a Trackable tag" do
    visit trackable_tags_url
    click_on "Edit", match: :first

    fill_in "Name", with: @trackable_tag.name
    click_on "Update Trackable tag"

    assert_text "Trackable tag was successfully updated"
    click_on "Back"
  end

  test "destroying a Trackable tag" do
    visit trackable_tags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trackable tag was successfully destroyed"
  end
end
