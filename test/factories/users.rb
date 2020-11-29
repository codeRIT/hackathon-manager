FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    sequence :email do |n|
      "foo#{n}@example.com"
    end
    password { "password" }
    role { :user }
    is_active { true }
    receive_weekly_report { false }

    factory :director do
      sequence :email do |n|
        "director#{n}@example.com"
      end
      role { :director }
    end

    factory :organizer do
      sequence :email do |n|
        "organizer#{n}@example.com"
      end
      role { :organizer }
    end

    factory :volunteer do
      sequence :email do |n|
        "volunteer#{n}@example.com"
      end
      role { :volunteer }
    end
  end
end
