module Admin
  class ProductImagesController < Admin::BaseController
    def destroy
      @product_image = ProductImage.find(params[:id])
      product = @product_image.product

	    @product_image.destroy

	    redirect_to edit_admin_product_path(product)
    end
  end
end
