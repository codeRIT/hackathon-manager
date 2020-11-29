FactoryBot.define do
  factory :event do
    title { "Testing" }
    description { "This is fun to test" }
    start { Date.today - 1.hour }
    finish { Date.today }
    location { "GOL-1455" }
  end
end
