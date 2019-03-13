module Api
  module V1
    module Excel
      class RecoveriesController < ApplicationController
        def export
          @recoveries = Recovery.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=二手回收價格.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path)
          workbook.drop(1).each do |row|
            brand = Brand.find_by(name: row[0])
            params = ActionController::Parameters.new({
              recovery: {
                brand_id: brand.id,
                name: row[1],
                max_price: row[2].to_i,
                min_price: row[3].to_i
              }
            })
            recovery_params = params.require(:recovery).permit(:brand_id, :name, :max_price, :min_price)

            recovery = Recovery.find_by(name: row[1])
            if recovery.present?
              recovery.update(recovery_params)
            else
              Recovery.create(recovery_params)
            end
          end

          redirect_to admin_recoveries_path
        end
      end
    end
  end
end
