FactoryBot.define do
  factory :message do
    type         "bulk"
    name         "Message Name"
    subject      "Message Subject"
    recipients   ["all"]
    body         "Hello world!"
    queued_at    nil
    delivered_at nil
  end
end
