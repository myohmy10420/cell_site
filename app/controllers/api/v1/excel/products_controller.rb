module Api
  module V1
    module Excel
      class ProductsController < Api::V1::Excel::BaseController
        def export
          @products = get_products

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=商品.xlsx"
            }
          end
        end

        def import
          require 'roo'

          if !params[:file]
            flash[:alert] = "請選擇檔案"
          else
            @excel_import_errors = ""

            excel_page = Roo::Excelx.new(params[:file].path)
            excel_page.drop(1).each do |row|
              @product = Product.find_or_create_by(id: row[0])
              @product.name = row[3]
              next if brand_not_found_by_name(row[1])
              next if category_not_found_by_name(row[2])

              product_params = build_params_by(row)

              if !@product.update(product_params)
                add_error(@product)
              end
            end

            @products = get_products

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
              render 'admin/products/index'
            else
              flash[:notice] = "匯入成功！"
              redirect_to admin_products_path
            end
          end
        end

        private

        def get_products
          Product.includes(:brand, :category).all.order('updated_at DESC')
        end

        def brand_not_found_by_name(brand_name)
          @brand = Brand.find_by(name: brand_name)

          if @brand.nil?
            @excel_import_errors += @product.name + "找不到" + brand_name + "品牌<br>"
          end

          @brand.nil?
        end

        def category_not_found_by_name(category_name)
          @category = Category.find_by(name: category_name)

          if @category.nil?
            @excel_import_errors += @product.name + "找不到" + category_name + "子分類<br>"
          end

          @category.nil?
        end

        def add_error(product)
          name = product.name || 'Unknow'
          @excel_import_errors += name + product.errors.full_messages.join(", ") + "<br>"
        end

        def build_params_by(row)
          ActionController::Parameters.new({
            product: {
              brand_id: @brand.id,
              category_id: @category.id,
              name: ActionController::Base.helpers.strip_tags(row[3]),
              tag: row[4],
              slogan: row[5],
              color: row[6],
              content: row[7],
              list_price: row[8].to_i == 0 ? nil : row[6].to_i,
              selling_price: row[9].to_i == 0 ? nil : row[7].to_i,
              shelved: row[10] == 'O' ? true : false,
              on_sale: row[11] == 'O' ? true : false,
              is_unlisted: row[12] == 'O' ? true : false
            }
          }).require(:product).permit(:brand_id, :name, :tag, :slogan, :color, :content, :list_price, :selling_price, :shelved, :on_sale, :is_new, :is_pop, :is_unlisted, :slug)
        end
      end
    end
  end
end
