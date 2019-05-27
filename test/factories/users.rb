FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "foo#{n}@example.com"
    end
    password { "password" }
    role { :user }
    is_active { true }
    receive_weekly_report { false }

    factory :admin do
      sequence :email do |n|
        "admin#{n}@example.com"
      end
      role { :admin }
    end

    factory :limited_access_admin do
      sequence :email do |n|
        "limited_admin#{n}@example.com"
      end
      role { :admin_limited_access }
    end
  end
end
