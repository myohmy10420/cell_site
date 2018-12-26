namespace :variants do

  desc "Creates or updates the only name and image of models"
  task creates_or_updates: :environment do
    file_path = "#{Rails.root}/doc/variants.csv"
    puts "新增或更新開始"

    CSV.foreach(file_path, headers: :first_row) do |row|
      attributes = row.to_hash

      telecommunication = Telecommunication.find_by(name: attributes["telecommunication_name"])

      if telecommunication
        variant = Variant.find_by(name: attributes["name"])
        variant ||= Variant.new

        variant.telecommunication_id = telecommunication.id
        variant.name = attributes["name"]
        variant.content = attributes["content"]
        variant.discount = attributes["discount"].to_i
        variant.prepaid = attributes["prepaid"].to_i
        variant.traffic = attributes["traffic"]
        variant.period = attributes["period"]
        if variant.save
          puts "新增或更新#{attributes["name"]}成功"
        else
          puts "新增或更新#{attributes["name"]}失敗"
        end
      else
        puts "新增或更新失敗，找不到電信#{attributes["name"]}"
      end
    end

    puts "----------------next model----------------"
  end
end
