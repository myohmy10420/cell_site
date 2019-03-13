module Api
  module V1
    module Excel
      class ProductsController < ApplicationController
        def export
          @products = Product.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=商品.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path)
          workbook.drop(1).each do |row|
            brand = Brand.find_by(name: row[0])
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
              Product.create(product_params)
            end
          end

          redirect_to admin_products_path
        end
      end
    end
  end
end
