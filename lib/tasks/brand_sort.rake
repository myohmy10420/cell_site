namespace :brands do
  desc "Give init sort by index"
  task give_init_sort_by_id: :environment do
    Brand.all.each_with_index do |brand, index|
      brand.sort = index + 1
      brand.save
    end
  end
end
