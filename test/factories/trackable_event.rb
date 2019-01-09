FactoryBot.define do
  factory :trackable_event do
    band_id { "foo" }
    association :user
    association :trackable_tag
  end
end
