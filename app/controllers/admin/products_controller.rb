module Admin
  class ProductsController < Admin::BaseController
    def index
      @products = Product.all.order('updated_at DESC')
    end

    def show
      @product = Product.find(params[:id])
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        update_product_images
        redirect_to admin_product_path(@product)
      else
        render "new"
      end
    end

    def edit
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:id])

      if @product.update(product_params)
        update_product_images
        redirect_to admin_product_path(@product)
      else
        render "edit"
      end
    end

    def destroy
	    @product = Product.find(params[:id])

	    @product.destroy

	    redirect_to admin_products_path
    end

    def search
      if params[:brand_id].present?
        search_brand = Brand.find(params[:brand_id])
        include_products = search_brand.products
      else
        include_products = Product.all
      end

      if params[:product_name].present?
        @products = include_products.where("name like ?", "%#{params[:product_name]}%").order('updated_at DESC')
      else
        @products = include_products.order('updated_at DESC')
      end

      render "index"
    end

    private

    def product_params
      params.require(:product).permit(:brand_id, :name, :tag, :slogan, :content, :list_price, :selling_price, :shelved, :on_sale, :is_new, :is_pop)
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
