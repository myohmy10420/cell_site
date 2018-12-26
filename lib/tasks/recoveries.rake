namespace :recoveries do

  desc "Creates or updates the only name and image of models"
  task creates_or_updates: :environment do
    file_path = "#{Rails.root}/doc/recoveries.csv"
    puts "新增或更新開始"

    CSV.foreach(file_path, headers: :first_row) do |row|
      attributes = row.to_hash

      brand = Brand.find_by(name: attributes["brand_name"])

      if brand
        recovery = Recovery.find_by(name: attributes["name"])
        recovery ||= Recovery.new

        recovery.brand_id = brand.id
        recovery.name = attributes["name"]
        recovery.max_price = attributes["max_price"].to_i
        recovery.min_price = attributes["min_price"].to_i
        if recovery.save
          puts "新增或更新#{attributes["name"]}成功"
        else
          puts "新增或更新#{attributes["name"]}失敗"
        end
      else
        puts "新增或更新失敗，找不到品牌#{attributes["name"]}"
      end
    end

    puts "----------------next model----------------"
  end
end
