FactoryBot.define do
  factory :carousel_ad do
    url { 'url' }
    image_file_name { 'test.jpeg' }
    image_content_type { 'image/jpeg' }
    image_file_size { 0 }
    image_updated_at { Time.zone.now }
    sort { CarouselAd.all.size + 1 }
  end
end
