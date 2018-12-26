namespace :stores do

  desc "Creates or updates the only name and image of models"
  task creates_or_updates: :environment do
    file_path = "#{Rails.root}/doc/stores.csv"
    image_dir = "#{Rails.root}/doc/images/stores"
    puts "新增或更新開始"

    CSV.foreach(file_path, headers: :first_row) do |row|
      attributes = row.to_hash

      image_file_name = attributes["name"]
      image_path = File.join(image_dir, "#{image_file_name}.jpg")

      store = Store.find_by(name: attributes["name"])
      store ||= Store.new

      if File.exist?(image_path)
        store.name = attributes["name"]
        store.service_line = attributes["service_line"]
        store.fax = attributes["fax"]
        store.phone = attributes["phone"]
        store.email = attributes["email"]
        store.line_ID = attributes["line_ID"]
        store.address = attributes["address"]
        store.time = attributes["time"]
        store.image = File.open(image_path)
        if store.save
          puts "新增或更新#{attributes["name"]}成功"
        else
          puts "新增或更新#{attributes["name"]}失敗"
        end
      else
        puts "新增或更新失敗，找不到#{attributes["name"]}圖片"
      end
    end

    puts "----------------next model----------------"
  end
end
