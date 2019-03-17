module Admin
  class PreOrdersController < Admin::BaseController
    before_action :find_product, only: [:create]

    def create
      pre_order = PreOrder.new(pre_order_params)
      pre_order.user = current_user
      pre_order.product = @product
      pre_order.product_name = @product.name
      pre_order.selling_price = @product.selling_price

      if pre_order.save
        flash[:notice] = "預購成功"
      else
        flash[:alert] = "預購失敗，請聯絡我們"
      end

      redirect_to product_path(@product)
    end

    private

    def find_product
      @product = Product.find(params[:pre_order][:product_id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "已經找不到此商品"
      redirect_to products_path
    end

    def pre_order_params
      params.require(:pre_order).permit(:content)
    end
  end
end
