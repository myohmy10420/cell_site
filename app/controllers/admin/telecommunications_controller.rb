module Admin
  class TelecommunicationsController < Admin::BaseController
    def index
      @telecommunications = Telecommunication.all.order('updated_at DESC')
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

    def search
      if params[:tele_name].present?
        @telecommunications = Telecommunication.where("name like ?", "%#{params[:tele_name]}%").order('updated_at DESC')
      else
        @telecommunications = Telecommunication.all.order('updated_at DESC')
      end

      render "index"
    end

    def quick_add_logos
      params[:files].each do |file|
        extension_dot = file.original_filename.rindex(".")
        file_name = file.original_filename.slice(0, extension_dot)

        telecommunication = Telecommunication.find_by(name: file_name)
        telecommunication.update(logo: file) if telecommunication
      end if params[:files].presence

      redirect_to admin_telecommunications_path
    end

    private

    def telecommunication_params
      params.require(:telecommunication).permit(:logo, :name)
    end
  end
end
