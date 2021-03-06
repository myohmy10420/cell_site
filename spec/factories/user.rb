FactoryBot.define do
  factory :user do
    store
    email { I18n.with_locale(:en) { Faker::Internet.unique.email } }
    password { 'password' }
    password_confirmation { 'password' }
    phone { "09#{Faker::PhoneNumber.subscriber_number(length: 8)}" }
    name { Faker::Name.unique.name }
    sex { 'male' }

    trait :admin do
      after(:create) do |user|
        user.confirm
        user.add_role :admin
      end
    end

    factory :admin_user, traits: [:admin]
  end
end
