module Api
  module V1
    module Excel
      class StoresController < Api::V1::Excel::BaseController
        before_action :get_stores

        def export
          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=門市.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          @excel_import_errors = ""
          workbook.drop(1).each do |row|
            params = ActionController::Parameters.new({
              store: {
                name: row[0],
                service_line: row[1],
                fax: row[2],
                phone: row[3],
                email: row[4],
                line_ID: row[5],
                address: row[6],
                google_map_url: row[7],
                time: row[8]
              }
            })
            store_params = params.require(:store).permit(:name, :service_line, :fax, :phone, :email, :line_ID, :address, :google_map_url, :time)

            store = Store.find_by(name: row[0])
            if store.present?
              next if store.update(store_params)
              add_error(store)
            else
              new_store = Store.new(store_params)
              next if new_store.save
              add_error(new_store)
            end
          end if workbook

          if @excel_import_errors.presence
            @excel_import_errors = @excel_import_errors.html_safe
          else
            flash[:notice] = "匯入成功！"
          end

          render "admin/stores/index"
        end

        private

        def get_stores
          @stores = Store.all.order('updated_at DESC')
        end

        def add_error(store)
          @excel_import_errors += store.name + store.errors.full_messages.join(", ") + "<br>"
        end
      end
    end
  end
end
