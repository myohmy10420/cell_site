module Api
  module V1
    module Excel
      class UsersController <  Api::V1::Excel::BaseController
        def export
          @users = get_users

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=會員.xlsx"
            }
          end
        end

        def import
          require 'roo'

          if !params[:file]
            flash[:alert] = "請選擇檔案"
          else
            @excel_import_errors = ""

            excel_page = Roo::Excelx.new(params[:file].path)
            excel_page.drop(1).each do |row|
              find_store(row)
              next if @store.nil?

              find_user(row)
              next if @user.nil?

              user_params = build_params_by(row)
              next if @user.update(user_params)
              add_error(@user)
            end

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
            else
              flash[:notice] = "匯入成功！"
            end
          end

          @users = get_users

          render "admin/users/index"
        end

        private

        def get_users
          User.all.order('updated_at DESC')
        end

        def find_store(row)
          @store = Store.find_by(name: row[1])
          return if @store.presence
          add_error_store_not_found(row)
        end

        def find_user(row)
          @user = User.find_by(phone: row[0])
          return if @user.presence
          add_error_user_not_found(row)
        end

        def add_error_store_not_found(row)
          @excel_import_errors += row[0].to_s + "找不到" + row[1].to_s + "註冊門市<br>"
        end

        def add_error_user_not_found(row)
          @excel_import_errors += "找不到" + row[0].to_s + "此帳號<br>"
        end

        def add_error(user)
          @excel_import_errors += "帳號" + user.phone + user.errors.full_messages.join(", ") + "<br>"
        end

        def build_params_by(row)
          ActionController::Parameters.new({
            user: {
              # phone: row[0], 不能改帳號
              store_id: @store.id,
              name: row[2],
              sex: row[3],
              email: row[4],
              line: row[5],
              address: row[6],
              birthday: row[7].to_date
            }
          }).require(:user).permit(:store_id, :name, :sex, :address, :email, :line, :birthday)
        end
      end
    end
  end
end
