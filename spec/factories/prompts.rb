FactoryBot.define do
  factory :prompt do
    text { Faker::Lorem.characters(number: 100) }
  end
end
