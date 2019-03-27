module Api
  module V1
    module Excel
      class ProductsController < Api::V1::Excel::BaseController
        before_action :get_products

        def export
          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=商品.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          @excel_import_errors = ""
          workbook.drop(1).each do |row|
            brand = Brand.find_by(name: row[0])
            @excel_import_errors += row[1] + "找不到" + row[0] + "品牌<br>" if brand.nil?
            next if brand.nil?

            params = ActionController::Parameters.new({
              product: {
                brand_id: brand.id,
                name: row[1],
                tag: row[2],
                slogan: row[3],
                content: row[4],
                list_price: row[5].to_i,
                selling_price: row[6].to_i,
                shelved: row[7] == 'O' ? true : false,
                on_sale: row[8] == 'O' ? true : false
              }
            })
            product_params = params.require(:product).permit(:brand_id, :name, :tag, :slogan, :content, :list_price, :selling_price, :shelved, :on_sale, :is_new, :is_pop)

            product = Product.find_by(name: row[1])
            if product.present?
              product.update(product_params)
            else
              new_product = Product.new(product_params)
              next if new_product.save
              @excel_import_errors += new_product.name + new_product.errors.full_messages.join(", ") + "<br>"
            end
          end if workbook

          if @excel_import_errors.presence
            @excel_import_errors = @excel_import_errors.html_safe
          else
            flash[:notice] = "匯入成功！"
          end

          render "admin/products/index"
        end

        private

        def get_products
          @products = Product.all.order('updated_at DESC')
        end
      end
    end
  end
end
