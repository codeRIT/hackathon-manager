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

    factory :limited_access_admin do
      sequence :email do |n|
        "limited_admin#{n}@example.com"
      end
      role { :admin_limited_access }
    end
  end
end
