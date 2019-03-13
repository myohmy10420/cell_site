require 'csv'

namespace :brands_dev do

  desc "Creates or updates the only name and image of models"
  task creates_or_updates: :environment do
    file_path = "#{Rails.root}/doc/brands_dev.csv"
    image_dir = "#{Rails.root}/doc/images/brands/"
    puts "新增或更新開始"

    CSV.parse(File.readlines(file_path).drop(1).join, headers: :first_row) do |row|
      attributes = row.to_hash

      logo_file_name = attributes["logo"]
      logo_path = File.join(image_dir, logo_file_name)

      brand = Brand.find_by(name: attributes["name"])
      brand ||= Brand.new

      if !File.exist?(logo_path)
        puts "新增或更新失敗，找不到#{attributes["logo"]}圖片"
      else
        brand.name = attributes["name"]
        brand.logo = File.open(logo_path)
        if brand.save
          puts "新增或更新#{attributes["name"]}成功"
        else
          puts "新增或更新#{attributes["name"]}失敗"
        end
      end
    end

    puts "----------------next model----------------"
  end
end
