module Admin
  class ProductsController < Admin::BaseController
    def index
      load_products
    end

    def show
      @product = Product.friendly.find(params[:id])
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
      @product = Product.friendly.find(params[:id])
    end

    def update
      @product = Product.friendly.find(params[:id])

      if @product.update(product_params)
        update_product_images
        redirect_to admin_product_path(@product)
      else
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

    def product_params
      params.require(:product).permit(:brand_id, :name, :tag, :slogan, :content, :list_price, :selling_price, :shelved, :on_sale, :pre_orderable, :is_new, :is_pop, :slug)
    end

    def update_product_images
      if params[:product][:product_image]
        params[:product][:product_image][:images].each { |image|
          @product.product_images.create(image: image)
        }
      end
    end

    def load_products
      @name_keyword = params[:product_name]
      @selected_brand = params[:brand_id]

      if @selected_brand.present?
        search_brand = Brand.find(@selected_brand)
        include_products = search_brand.products
      else
        include_products = Product.all
      end

      if @name_keyword.present?
        @products = include_products.where("name like ?", "%#{@name_keyword}%").order('updated_at DESC')
      else
        @products = include_products.order('updated_at DESC')
      end
    end
  end
end
