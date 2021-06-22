require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = create(:event)
  end

  context "while not authenticated" do
    should "be able to get all events" do
      get events_path, params: { format: :json }
      assert_response :success
    end

    should "be able to show event" do
      get event_path(@event), params: { format: :json }
      assert_response :success
    end
  end
end
