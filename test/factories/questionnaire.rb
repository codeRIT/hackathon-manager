FactoryBot.define do
  factory :questionnaire do
    phone { "(123) 456-7890" }
    international { false }
    date_of_birth { Date.today - 20.years }
    experience { "first" }
    interest { "design" }
    school_id { create(:school).id }
    shirt_size { "Unisex - M" }
    dietary_restrictions { "" }
    special_needs { "" }
    can_share_info { true }
    gender { "Male" }
    major { "Computer Science" }
    level_of_study { "University (Undergraduate)" }
    graduation_year { Date.today.year }
    race_ethnicity { "Other" }
    why_attend { "This sounds cool" }
    agreements  { [create(:agreement)] }

    association :user
  end
end
