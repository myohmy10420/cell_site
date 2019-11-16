namespace :products do
  desc "Add default category 手機 if product dosen't belong_to any category"
  task add_default_category: :environment do
    logger_path_in_app = "log/#{Time.zone.now.strftime("%Y%m%d-%H%M%S")}-products_add_default_category.log"
    logger_file = "#{Rails.root}/#{logger_path_in_app}"
    logger = Logger.new(logger_file)

    brands = Brand.all
    has_default_category_brands = brands.select do |b|
      b.categories.pluck(:name).include?('手機')
    end

    products = Product.where(category_id: nil)
    products.each do |product|
      if has_default_category_brands.exclude?(product.brand)
        next "#{product.name} 的品牌沒有手機這個子分類"
      end

      category_id = product.brand.categories.find_by(name: '手機').id
      product.update(category_id: category_id)
      if product.save
        logger.info("#{product.name} 新增子分類 手機 成功")
      else
        logger.error("新增失敗, 原因: #{product.errors.full_messages.join(', ')}")
      end
    end

    puts "執行完成, 詳細訊息請查看 #{logger_path_in_app}"
  end
end
