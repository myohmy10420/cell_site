FactoryBot.define do
  factory :user do
    store
    name { Faker::Name.unique.name }
    phone { Faker::PhoneNumber.subscriber_number(length: 10) }
    sex { 'male' }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      after(:create) do |user|
        user.add_role :admin
      end
    end

    factory :admin_user, traits: [:admin]
  end
end
