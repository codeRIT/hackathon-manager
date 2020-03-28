FactoryBot.define do
  factory :message_template do
    html { "<div>{{{ message_body }}}</div>" }
  end
end
