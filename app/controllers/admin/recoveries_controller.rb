module Admin
  class RecoveriesController < Admin::BaseController
    def index
      @recoveries = Recovery.all.order('updated_at DESC')
    end

    def new
      @recovery = Recovery.new
      @brands = Brand.all
    end

    def create
      @recovery = Recovery.new(recovery_params)
      if @recovery.save
        redirect_to admin_recoveries_path
      else
        render "new"
      end
    end

    def edit
      @recovery = Recovery.find(params[:id])
      @brands = Brand.all
    end

    def update
      @recovery = Recovery.find(params[:id])

      if @recovery.update(recovery_params)
        redirect_to admin_recoveries_path
      else
        render "edit"
      end
    end

    def destroy
	    @recovery = Recovery.find(params[:id])

	    @recovery.destroy

	    redirect_to admin_recoveries_path
    end

    def search
      if params[:recovery_name].present?
        @recoveries = Recovery.where("name like ?", "%#{params[:recovery_name]}%").order('updated_at DESC')
      else
        @recoveries = Recovery.all.order('updated_at DESC')
      end

      render "index"
    end

    private

    def recovery_params
      params.require(:recovery).permit(:brand_id, :name, :max_price, :min_price)
    end
  end
end
