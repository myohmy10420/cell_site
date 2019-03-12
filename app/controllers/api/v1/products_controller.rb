module Api
  module V1
    class ProductsController < ApplicationController
      def switch_shelved
        product = Product.find(params[:productId])
        product.shelved = !product.shelved

        if product.shelved
          class_name = "badge-success"
        else
          class_name = "badge-secondary"
        end

        if product.save
          render json: { class_name: class_name }, status: 200
        else
          render json: {}, status: 400
        end
      end
    end
  end
end
