FactoryBot.define do
  factory :store do
    name { Faker::Name.unique.name }
    service_line { Faker::Code.asin }
    address { Faker::Address.full_address }
    time { '24h' }
    google_map_url { 'https://www.google.com.tw/maps/preview?hl=zh-TW' }
  end
end
