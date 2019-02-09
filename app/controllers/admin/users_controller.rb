module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.all.order('updated_at DESC')
    end

    def edit
      @user = User.find(params[:id])
      @telecommunications = Telecommunication.all
    end

    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to admin_users_path
      else
        render "edit"
      end
    end

    def destroy
	    @user = User.find(params[:id])

	    @user.destroy

	    redirect_to admin_users_path
    end

    def search
      if params[:store_id].present?
        search_store = Store.find(params[:store_id])
        include_users = search_store.users
      else
        include_users = User.all
      end

      if params[:user_phone].present?
        @users = include_users.where("phone like ?", "%#{params[:user_phone]}%").order('updated_at DESC')
      else
        @users = include_users.order('updated_at DESC')
      end

      render "index"
    end

    private

    def user_params
      params.require(:user).permit(:store_id, :name, :email, :line, :birthday)
    end
  end
end
