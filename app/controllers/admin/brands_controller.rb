module Admin
  class BrandsController < Admin::BaseController
    def index
      @brands = Brand.all.order('updated_at DESC')
    end

    def new
      @brand = Brand.new
    end

    def create
      @brand = Brand.new(brand_params)
      if @brand.save
        redirect_to admin_brands_path
      else
        render "new"
      end
    end

    def edit
      @brand = Brand.find(params[:id])
    end

    def update
      @brand = Brand.find(params[:id])

      if @brand.update(brand_params)
        redirect_to admin_brands_path
      else
        render "edit"
      end
    end

    def destroy
	    @brand = Brand.find(params[:id])

	    @brand.destroy

	    redirect_to admin_brands_path
    end

    def search
      if params[:brand_name].present?
        @brands = Brand.where("name like ?", "%#{params[:brand_name]}%").order('updated_at DESC')
      else
        @brands = Brand.all.order('updated_at DESC')
      end

      render "index"
    end

    def quick_add_logos
      params[:files].each do |file|
        extension_dot = file.original_filename.rindex(".")
        file_name = file.original_filename.slice(0, extension_dot)

        brand = Brand.find_by(name: file_name)
        brand.update(logo: file) if brand
      end if params[:files].presence

      redirect_to admin_brands_path
    end

    private

    def brand_params
      params.require(:brand).permit(:logo, :name)
    end
  end
end
