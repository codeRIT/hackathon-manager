FactoryBot.define do
  factory :trackable_tag do
    sequence :name do |n|
      "Tag #{n}"
    end
  end
end
