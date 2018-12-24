namespace :name_and_image do

  desc "Creates or updates the only name and image of models"
  task :creates_or_updates, [:model_name] => [:environment] do |t, args|
    args.model_name.each do |name|
      file_path = "#{Rails.root}/doc/#{name}.csv"
      image_dir = "#{Rails.root}/doc/images/#{name}"
      model = find_model(name)
      puts "新增或更新開始"

      CSV.foreach(file_path, headers: :first_row) do |row|
        attributes = row.to_hash

        image_file_name = attributes["name"]
        image_path = File.join(image_dir, "#{image_file_name}.jpg")

        if File.exist?(image_path)
          relation = model.find_by(name: attributes["name"])
          relation ||= model.new

          relation.name = attributes["name"]
          relation.logo = File.open(image_path)
          if relation.save
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
end

def find_model(str)
  case str
  when 'brands'
    Brand
  when 'telecommunications'
    Telecommunication
  end
end
