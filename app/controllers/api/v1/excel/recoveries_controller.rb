module Api
  module V1
    module Excel
      class RecoveriesController < Api::V1::Excel::BaseController
        before_action :get_recoveries

        def export
          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=二手回收價格.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          @excel_import_errors = ""
          workbook.drop(1).each do |row|
            brand = Brand.find_by(name: row[0])
            @excel_import_errors += row[1] + "找不到" + row[0] + "品牌<br>" if brand.nil?
            next if brand.nil?

            params = ActionController::Parameters.new({
              recovery: {
                brand_id: brand.id,
                name: row[1],
                max_price: row[2].to_i == 0 ? nil : row[2].to_i,
                min_price: row[3].to_i == 0 ? nil : row[3].to_i
              }
            })
            recovery_params = params.require(:recovery).permit(:brand_id, :name, :max_price, :min_price)

            recovery = Recovery.find_by(name: row[1])
            if recovery.present?
              recovery.update(recovery_params)
            else
              new_recovery = Recovery.new(recovery_params)
              next if new_recovery.save
              @excel_import_errors += new_recovery.name + new_recovery.errors.full_messages.join(", ") + "<br>"
            end
          end if workbook

          if @excel_import_errors.presence
            @excel_import_errors = @excel_import_errors.html_safe
          else
            flash[:notice] = "匯入成功！"
          end

          render "admin/recoveries/index"
        end

        private

        def get_recoveries
          @recoveries = Recovery.all.order('updated_at DESC')
        end
      end
    end
  end
end
