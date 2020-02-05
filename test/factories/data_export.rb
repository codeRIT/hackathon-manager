FactoryBot.define do
  factory :data_export do
    export_type { "sponsor_dump_rsvp_confirmed" }
    queued_at { nil }
    started_at { nil }
    finished_at { nil }
  end
end
