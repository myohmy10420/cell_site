module Api
  module V1
    module Excel
      class UsersController < ApplicationController
        def export
          @users = User.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=會員.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path)
          workbook.drop(1).each do |row|
            store = Store.find_by(name: row[1])
            params = ActionController::Parameters.new({
              user: {
                # phone: row[0], 不能改帳號
                store_id: store.id,
                name: row[2],
                sex: row[3],
                email: row[4],
                line: row[5],
                address: row[6],
                birthday: row[7].to_date
              }
            })
            user_params = params.require(:user).permit(:store_id, :name, :sex, :address, :email, :line, :birthday)

            user = User.find_by(phone: row[0])
            user.update(user_params)
          end

          redirect_to admin_users_path
        end
      end
    end
  end
end
