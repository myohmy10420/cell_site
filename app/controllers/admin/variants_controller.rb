module Admin
  class VariantsController < Admin::BaseController
    def index
      @variants = Variant.all
    end

    def new
      @variant = Variant.new
      @telecommunications = Telecommunication.all
    end

    def create
      @variant = Variant.new(variant_params)
      if @variant.save
        redirect_to admin_variants_path
      else
        render "new"
      end
    end

    def edit
      @variant = Variant.find(params[:id])
      @telecommunications = Telecommunication.all
    end

    def update
      @variant = Variant.find(params[:id])

      if @variant.update(variant_params)
        redirect_to admin_variants_path
      else
        render "edit"
      end
    end

    def destroy
	    @variant = Variant.find(params[:id])

	    @variant.destroy

	    redirect_to admin_variants_path
    end

    def search
      if params[:tele_id].present?
        search_telt = Telecommunication.find(params[:tele_id])
        include_variants = search_telt.variants
      else
        include_variants = Variant.all
      end

      if params[:variant_name].present?
        @variants = include_variants.where(["name like ?", "%#{params[:variant_name]}%"]).order('updated_at DESC')
      else
        @variants = include_variants.order('updated_at DESC')
      end

      render "index"
    end

    private

    def variant_params
      params.require(:variant).permit(:telecommunication_id, :name, :discount, :prepaid, :traffic, :period, :content, :content2, :enable)
    end
  end
end
