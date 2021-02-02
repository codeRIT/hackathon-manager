FactoryBot.define do
  factory :extra_question do
    question { "Testing" }
    data_type { "boolean" }
    required { 0 }
  end
end
