module Admin
  class StoresController < Admin::BaseController
    def index
      @stores = Store.all.order('updated_at DESC')
    end

    def show
      @store = Store.find(params[:id])
    end

    def new
      @store = Store.new
    end

    def create
      @store = Store.new(store_params)
      if @store.save
        redirect_to admin_stores_path
      else
        render "new"
      end
    end

    def edit
      @store = Store.find(params[:id])
      @telecommunications = Telecommunication.all
    end

    def update
      @store = Store.find(params[:id])

      if @store.update(store_params)
        redirect_to admin_stores_path
      else
        render "edit"
      end
    end

    def destroy
	    @store = Store.find(params[:id])

	    @store.destroy

	    redirect_to admin_stores_path
    end

    def search
      if params[:store_name].present?
        @stores = Store.where("name like ?", "%#{params[:store_name]}%").order('updated_at DESC')
      else
        @stores = Store.all.order('updated_at DESC')
      end

      render "index"
    end

    private

    def store_params
      params.require(:store).permit(:name, :image, :service_line, :fax, :phone, :email, :line_ID, :address, :google_map_url, :time)
    end
  end
end
