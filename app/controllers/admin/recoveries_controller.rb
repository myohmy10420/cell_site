module Admin
  class RecoveriesController < Admin::BaseController
    def index
      @recoveries = Recovery.all
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

    private

    def recovery_params
      params.require(:recovery).permit(:brand_id, :name, :max_price, :min_price)
    end
  end
end
