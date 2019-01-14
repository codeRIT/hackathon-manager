require 'test_helper'

class BulkMessageWorkerTest < ActiveSupport::TestCase
  setup do
    Sidekiq::Testing.inline!
  end

  teardown do
    Sidekiq::Testing.fake!
  end

  should "process a message with valid recipients" do
    message = create(:message, recipients: ['incomplete', 'all'], queued_at: Time.now)
    BulkMessageWorker.perform_async(message.id)
    message.reload
    assert_not_nil message.started_at
    assert_not_nil message.delivered_at
  end

  should "queue a mailer per recipient" do
    create_list(:questionnaire, 5)
    message = create(:message, recipients: ['all'], queued_at: Time.now)
    assert_difference 'Sidekiq::Extensions::DelayedMailer.jobs.size', 5 do
      Sidekiq::Testing.fake! do
        # fake! to immediately execute BulkMessageWorker, but only queue DelayedMailer jobs
        # Otherwise, inline! performs everything immediately
        worker = BulkMessageWorker.new
        worker.perform(message.id)
      end
    end
  end

  should "support query recipients and simple recipients" do
    create(:school, name: "My University", id: 492)
    create_list(:questionnaire, 4, school_id: 492, acc_status: 'accepted')
    create_list(:questionnaire, 4, school_id: 492, acc_status: 'rsvp_confirmed')
    create_list(:questionnaire, 4, school_id: 492, acc_status: 'denied') # Decoy
    create_list(:user, 4)
    message = create(:message, recipients: ['incomplete', 'school::492'], queued_at: Time.now)
    assert_difference 'Sidekiq::Extensions::DelayedMailer.jobs.size', 12 do
      Sidekiq::Testing.fake! do
        worker = BulkMessageWorker.new
        worker.perform(message.id)
      end
    end
  end

  should "raise exception if message uses an unknown recipient type" do
    message = create(:message, recipients: ['incomplete', 'all', 'not-valid'], queued_at: Time.now)
    exception = assert_raises(Exception) do
      BulkMessageWorker.perform_async(message.id)
    end
    assert_match /recipient type/, exception.message
  end

  context "recipient queries" do
    setup do
      bus_list = create(:bus_list, name: "Bus Foo", id: 186)
      create(:questionnaire, acc_status: 'pending')
      create(:questionnaire, acc_status: 'waitlist')
      create(:questionnaire, acc_status: 'accepted')
      create(:questionnaire, acc_status: 'rsvp_confirmed', bus_list_id: bus_list.id)
      create(:questionnaire, acc_status: 'rsvp_denied')
      create_list(:user, 4)
    end

    should "support bus-list::ID" do
      message = create(:message, recipients: ['bus-list::186'], queued_at: Time.now)
      assert_difference 'Sidekiq::Extensions::DelayedMailer.jobs.size', 1 do
        Sidekiq::Testing.fake! do
          BulkMessageWorker.new.perform(message.id)
        end
      end
    end

    should "raise exception if model ID does not exist" do
      message = create(:message, recipients: ['bus-list::9999'], queued_at: Time.now)
      exception = assert_raises(Exception) do
        BulkMessageWorker.perform_async(message.id)
      end
      assert_match /Could not find Bus List/, exception.message
    end
  end
end
