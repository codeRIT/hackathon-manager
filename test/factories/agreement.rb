FactoryBot.define do
  factory :agreement do
    name { "HackFoo Agreement" }
    agreement { "Please read and accept https://www.foo.com" }
  end
end
