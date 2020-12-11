require "test_helper"

class BulkMessageJobTest < ActiveJob::TestCase
  should "process a message with valid recipients" do
    message = create(:message, recipients: ["incomplete", "all"], queued_at: Time.now)
    BulkMessageJob.perform_now(message)
    message.reload
    assert_not_nil message.started_at
    assert_not_nil message.delivered_at
  end

  should "queue a mailer per recipient" do
    create_list(:questionnaire, 5, agreements: Agreement.all)
    message = create(:message, recipients: ["all"], queued_at: Time.now)
    assert_difference "enqueued_jobs.size", 5 do
      worker = BulkMessageJob.new
      worker.perform(message)
    end
  end

  should "support query recipients and simple recipients" do
    create(:school, name: "My University", id: 492)
    create_list(:questionnaire, 4, school_id: 492, acc_status: "accepted", agreements: Agreement.all)
    create_list(:questionnaire, 4, school_id: 492, acc_status: "rsvp_confirmed", agreements: Agreement.all)
    create_list(:questionnaire, 4, school_id: 492, acc_status: "denied", agreements: Agreement.all) # Decoy
    create_list(:user, 4)
    message = create(:message, recipients: ["incomplete", "school::492"], queued_at: Time.now)
    assert_difference "enqueued_jobs.size", 12 do
      worker = BulkMessageJob.new
      worker.perform(message)
    end
  end

  should "raise exception if message uses an unknown recipient type" do
    message = create(:message, recipients: ["incomplete", "all", "not-valid"], queued_at: Time.now)
    exception = assert_raises(Exception) do
      BulkMessageJob.perform_now(message)
    end
    assert_match /recipient type/, exception.message
  end

  context "recipient queries" do
    setup do
      bus_list = create(:bus_list, name: "Bus Foo", id: 186)
      create(:questionnaire, acc_status: "pending", agreements: Agreement.all)
      create(:questionnaire, acc_status: "waitlist", agreements: Agreement.all)
      create(:questionnaire, acc_status: "accepted", agreements: Agreement.all)
      create(:questionnaire, acc_status: "rsvp_confirmed", bus_list_id: bus_list.id, agreements: Agreement.all)
      create(:questionnaire, acc_status: "rsvp_denied", agreements: Agreement.all)
      create_list(:user, 4)
    end

    should "support bus-list::ID" do
      message = create(:message, recipients: ["bus-list::186"], queued_at: Time.now)
      assert_difference "enqueued_jobs.size", 1 do
        BulkMessageJob.perform_now(message)
      end
    end

    should "raise exception if model ID does not exist" do
      message = create(:message, recipients: ["bus-list::9999"], queued_at: Time.now)
      exception = assert_raises(Exception) do
        BulkMessageJob.perform_now(message)
      end
      assert_match /Could not find Bus List/, exception.message
    end
  end
end
