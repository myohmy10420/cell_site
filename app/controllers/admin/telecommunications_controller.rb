module Admin
  class TelecommunicationsController < Admin::BaseController
    def index
      @telecommunications = Telecommunication.all
    end

    def new
      @telecommunication = Telecommunication.new
    end

    def create
      @telecommunication = Telecommunication.new(telecommunication_params)
      if @telecommunication.save
        redirect_to admin_telecommunications_path
      else
        render "new"
      end
    end

    def edit
      @telecommunication = Telecommunication.find(params[:id])
    end

    def update
      @telecommunication = Telecommunication.find(params[:id])

      if @telecommunication.update(telecommunication_params)
        redirect_to admin_telecommunications_path
      else
        render "edit"
      end
    end

    def destroy
	    @telecommunication = Telecommunication.find(params[:id])

	    @telecommunication.destroy

	    redirect_to admin_telecommunications_path
    end

    private

    def telecommunication_params
      params.require(:telecommunication).permit(:name)
    end
  end
end
