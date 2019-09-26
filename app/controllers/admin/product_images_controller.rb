module Admin
  class ProductImagesController < Admin::BaseController
    def delete_images
      ProductImage.where(id: params[:product_images_ids]).destroy_all
      render json: {
        message: 'ok'
      }, status: 200
    end
  end
end
