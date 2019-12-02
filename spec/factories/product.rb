FactoryBot.define do
  factory :product do
    brand
    name { Faker::Name.unique.name }

    trait :complete_datas do
      category
      content { Faker::Lorem.sentence }
      slogan { Faker::Lorem.sentence }
      tag { Faker::Name.unique.name }
      list_price {Faker::Number.number(digits: 5) }
      selling_price {Faker::Number.number(digits: 5) }
      color { Faker::Color.color_name }
      shelved { false }
      on_sale { false }
      is_new { false }
      is_pop { false }
      pre_orderable { false }
      is_unlisted { false }
    end

    factory :complete_datas_product, traits: [:complete_datas]
  end
end
