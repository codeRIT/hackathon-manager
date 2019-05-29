# This will guess the User class
FactoryBot.define do
  factory :bus_list do
    sequence :name do |n|
      "Bus List #{n}"
    end
    capacity { 50 }
    notes { "Notes!" }
  end
end
