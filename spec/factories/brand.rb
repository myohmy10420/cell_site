FactoryBot.define do
  factory :brand do
    name { Faker::Name.unique.name }
  end
end
