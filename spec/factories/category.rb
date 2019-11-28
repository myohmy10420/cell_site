FactoryBot.define do
  factory :category do
    brand
    name { Faker::Name.unique.name }
  end
end
