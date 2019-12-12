module Admin
  class UsersController < Admin::BaseController
    load_and_authorize_resource

    def index
      if current_user.has_role? :admin
        @users = User.all.order('updated_at DESC')
      elsif current_user.has_role? :store_manager
        @users = User.where(store_id: current_user.store_id).order('updated_at DESC')
      else
        @users = []
      end
    end

    def edit
      @user = User.find(params[:id])
      @telecommunications = Telecommunication.all
    end

    def update
      @user = User.find(params[:id])
      update_roles if current_user.has_role? :admin

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
        @users = include_users.where(["phone like ?", "%#{params[:user_phone]}%"]).order('updated_at DESC')
      else
        @users = include_users.order('updated_at DESC')
      end

      render "index"
    end

    private

    def user_params
      params.require(:user).permit(:store_id, :name, :comment, :sex, :address, :email, :line, :birthday)
    end

    def update_roles
      @user.roles.destroy_all
      role_ids = params[:user][:role_ids]
      role_ids.each do |id|
        next if id.empty?
        role = Role.find(id.to_i)
        @user.add_role(role.name)
      end
    end
  end
end
