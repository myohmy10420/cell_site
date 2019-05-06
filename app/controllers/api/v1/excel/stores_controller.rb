module Api
  module V1
    module Excel
      class StoresController < Api::V1::Excel::BaseController
        def export
          @stores = get_stores

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=門市.xlsx"
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
              store_params = build_params_by(row)

              find_store(row)
              if @store.present?
                next if @store.update(store_params)
                add_error(@store)
              else
                new_store = Store.new(store_params)
                next if new_store.save
                add_error(new_store)
              end
            end

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
            else
              flash[:notice] = "匯入成功！"
            end
          end

          @stores = get_stores

          render "admin/stores/index"
        end

        private

        def get_stores
          Store.all.order('updated_at DESC')
        end

        def find_store(row)
          @store = Store.find_by(name: row[0])
        end

        def add_error(store)
          name = store.name || 'Unknow'
          @excel_import_errors += name + store.errors.full_messages.join(", ") + "<br>"
        end

        def build_params_by(row)
          ActionController::Parameters.new({
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
          }).require(:store).permit(:name, :service_line, :fax, :phone, :email, :line_ID, :address, :google_map_url, :time)
        end
      end
    end
  end
end
