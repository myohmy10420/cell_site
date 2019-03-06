namespace :products do

  desc "Creates or updates the only name and image of models"
  task creates_or_updates: :environment do
    file_path = "#{Rails.root}/doc/products.csv"
    image_dir = "#{Rails.root}/doc/images/products"
    puts "新增或更新開始"

    CSV.foreach(file_path, headers: :first_row) do |row|
      attributes = row.to_hash

      image_file_name = attributes["name"]
      image_path = File.join(image_dir, "#{image_file_name}.jpg")

      brand = Brand.find_by(name: attributes["brand_name"])

      product = Product.find_by(name: attributes["name"])
      product ||= Product.new

      if !File.exist?(image_path)
        puts "新增或更新失敗，找不到#{attributes["name"]}圖片"
      elsif !brand
        puts "新增或更新失敗，找不到#{attributes["brand_name"]}品牌"
      else
        product.brand_id = brand.id
        product.name = attributes["name"]
        product.slogan = attributes["slogan"]
        product.content = attributes["content"]
        product.list_price = attributes["list_price"]&.to_i || nil
        product.selling_price = attributes["selling_price"]&.to_i || nil
        product.shelved = true?(attributes["shelved"])
        product.priced = true?(attributes["priced"])
        if product.save
          puts "新增或更新#{attributes["name"]}成功"
        else
          puts "新增或更新#{attributes["name"]}失敗"
        end
      end
    end

    puts "----------------next model----------------"
  end
end

def true?(obj)
  obj.to_s == "yes"
end
