FactoryBot.define do
  factory :trackable_tag do
    sequence :name do |n|
      "Tag #{n}"
    end
    allow_duplicate_band_events { :false }
  end
end
