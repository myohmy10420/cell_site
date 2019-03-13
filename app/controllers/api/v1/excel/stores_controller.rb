module Api
  module V1
    module Excel
      class StoresController < ApplicationController
        def export
          @stores = Store.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=門市.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path)
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
              store.update(store_params)
            else
              Store.create(store_params)
            end
          end

          redirect_to admin_stores_path
        end
      end
    end
  end
end
