module Admin
  class ProductsController < Admin::BaseController
    def index
      @name_keyword = params[:product_name] || ''
      @products = Product.where(["name like ?", "%#{@name_keyword}%"]).order('selling_time DESC')
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(create_product_params)
      if @product.save
        redirect_to edit_admin_product_path(@product)
      else
        render "new"
      end
    end

    def edit
      @product = Product.friendly.find(params[:id])
    end

    def update
      @product = Product.friendly.find(params[:id])

      if @product.update(update_product_params)
        update_product_images
        flash[:notice] = "更新成功"
        redirect_to edit_admin_product_path(@product)
      else
        flash[:alert] = "更新失敗"
        render "edit"
      end
    end

    def destroy
	    @product = Product.friendly.find(params[:id])

	    @product.destroy

      redirect_back(fallback_location: admin_products_path)
    end

    def quick_add_images
      if params[:files].presence
        params[:files].each do |file|
          extension_dot = file.original_filename.rindex(".")
          double_dash = file.original_filename.rindex("__")
          file_name = file.original_filename.slice(0, double_dash || extension_dot)

          product = Product.find_by(name: file_name)
          product.product_images.create(image: file) if product
        end
      end

      redirect_back(fallback_location: admin_products_path)
    end

    private

    def create_product_params
      params.require(:product).permit(:brand_id, :name, :selling_time)
    end

    def update_product_params
      params.require(:product).permit(:category_id, :name, :tag, :slogan, :content, :list_price, :selling_price, :shelved, :on_sale, :pre_orderable, :is_new, :is_pop, :is_unlisted, :slug, :color, :selling_time)
    end

    def update_product_images
      if params[:product][:product_image]
        params[:product][:product_image][:images].each { |image|
          @product.product_images.create(image: image)
        }
      end
    end
  end
end
