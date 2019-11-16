namespace :brand do
  desc "Add default category 手機 if brand dosen't have any categories"
  task add_default_category: :environment do
    brands = Brand.all

    brands.each do |b|
      next puts "#{b.name} already has one category, we do now add defulat category" if b.categories.present?

      c = b.categories.create(name: '手機')
      if c.save
        puts "#{b.name} 新增子分類名稱 手機 成功"
      else
        puts "新增失敗, #{b.name} 的 #{c.errors.full_messages.join(', ')}"
      end
    end
  end
end
