require 'test_helper'

class TrackableTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trackable_tag = trackable_tags(:one)
  end

  test "should get index" do
    get trackable_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_trackable_tag_url
    assert_response :success
  end

  test "should create trackable_tag" do
    assert_difference('TrackableTag.count') do
      post trackable_tags_url, params: { trackable_tag: { name: @trackable_tag.name } }
    end

    assert_redirected_to trackable_tag_url(TrackableTag.last)
  end

  test "should show trackable_tag" do
    get trackable_tag_url(@trackable_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_trackable_tag_url(@trackable_tag)
    assert_response :success
  end

  test "should update trackable_tag" do
    patch trackable_tag_url(@trackable_tag), params: { trackable_tag: { name: @trackable_tag.name } }
    assert_redirected_to trackable_tag_url(@trackable_tag)
  end

  test "should destroy trackable_tag" do
    assert_difference('TrackableTag.count', -1) do
      delete trackable_tag_url(@trackable_tag)
    end

    assert_redirected_to trackable_tags_url
  end
end
