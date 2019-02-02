module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.all
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

    private

    def user_params
      params.require(:user).permit(:store_id, :name, :email, :line, :birthday)
    end
  end
end
