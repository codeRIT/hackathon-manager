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

  should "raise exception if message uses an unknown recipient type" do
    message = create(:message, recipients: ['incomplete', 'all', 'not-valid'], queued_at: Time.now)
    exception = assert_raises(Exception) do
      BulkMessageWorker.perform_async(message.id)
    end
    assert_match /recipient type/, exception.message
  end
end
