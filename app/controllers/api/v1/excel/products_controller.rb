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
              find_brand(row)
              next if @brand.nil?

              product_params = build_params_by(row)

              find_product(row)
              if @product.present?
                next if @product.update(product_params)
                add_error(@product)
              else
                new_product = Product.new(product_params)
                next if new_product.save
                add_error(new_product)
              end
            end

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
            else
              flash[:notice] = "匯入成功！"
            end
          end

          @products = get_products

          render "admin/products/index"
        end

        private

        def get_products
          Product.all.order('updated_at DESC')
        end

        def find_brand(row)
          @brand = Brand.find_by(name: row[0].to_s)
          return if @brand.presence
          add_error_brand_not_found(row)
        end

        def find_product(row)
          @product = Product.find_by(name: row[1])
        end

        def add_error_brand_not_found(row)
          @excel_import_errors += row[1].to_s + "找不到" + row[0].to_s + "品牌<br>"
        end

        def add_error(product)
          name = product.name || 'Unknow'
          @excel_import_errors += name + product.errors.full_messages.join(", ") + "<br>"
        end

        def build_params_by(row)
          ActionController::Parameters.new({
            product: {
              brand_id: @brand.id,
              name: ActionController::Base.helpers.strip_tags(row[1]),
              tag: row[2],
              slogan: row[3],
              color: row[4],
              content: row[5],
              list_price: row[6].to_i == 0 ? nil : row[6].to_i,
              selling_price: row[7].to_i == 0 ? nil : row[7].to_i,
              shelved: row[8] == 'O' ? true : false,
              on_sale: row[9] == 'O' ? true : false,
              is_unlisted: row[10] == 'O' ? true : false
            }
          }).require(:product).permit(:brand_id, :name, :tag, :slogan, :color, :content, :list_price, :selling_price, :shelved, :on_sale, :is_new, :is_pop, :is_unlisted, :slug)
        end
      end
    end
  end
end
