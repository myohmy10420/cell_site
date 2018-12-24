namespace :brands do

  desc "Builds brands"
  task builds_or_updates: :environment do
    file_path = "#{Rails.root}/doc/brands.csv"
    image_dir = "#{Rails.root}/doc/images/brands"

    CSV.foreach(file_path, headers: :first_row) do |row|
      attributes = row.to_hash
      puts "新增或更新品牌#{attributes["name"]}"

      image_file_name = attributes["name"]
      image_path = File.join(image_dir, "#{image_file_name}.jpg")

      if File.exist?(image_path)
        brand = Brand.find_by(name: attributes["name"])
        brand ||= Brand.new

        brand.name = attributes["name"]
        brand.logo = File.open(image_path)
        if brand.save
          puts "新增或更新#{attributes["name"]}成功"
        else
          puts "新增或更新#{attributes["name"]}失敗"
        end
      else
        puts "新增或更新失敗，找不到#{attributes["name"]}圖片"
      end
    end
  end
end
