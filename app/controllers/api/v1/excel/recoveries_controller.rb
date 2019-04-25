module Api
  module V1
    module Excel
      class RecoveriesController < Api::V1::Excel::BaseController
        def export
          @recoveries = get_recoveries

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=二手回收價格.xlsx"
            }
          end
        end

        def import
          require 'roo'

          if !params[:file]
            flash[:alert] = "請選擇檔案"
          else
            @excel_import_errors = ""

            excel_page = Roo::Excelx.new(params[:file].path) if params[:file]
            excel_page.drop(1).each do |row|
              find_brand(row)
              next if @brand.nil?

              recovery_params = build_params_by(row)

              find_recovery(row)
              if @recovery.present?
                next if @recovery.update(recovery_params)
                add_error(@recovery)
              else
                new_recovery = Recovery.new(recovery_params)
                next if new_recovery.save
                add_error(new_recovery)
              end
            end

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
            else
              flash[:notice] = "匯入成功！"
            end
          end

          @recoveries = get_recoveries

          render "admin/recoveries/index"
        end

        private

        def get_recoveries
          Recovery.all.order('updated_at DESC')
        end

        def find_brand(row)
          @brand = Brand.find_by(name: row[0].to_s)
          return if @brand.presence
          add_error_brand_not_found(row)
        end

        def find_recovery(row)
          @recovery = Recovery.find_by(name: row[1])
        end

        def add_error_brand_not_found(row)
          @excel_import_errors += row[1].to_s + "找不到" + row[0].to_s + "品牌<br>"
        end

        def add_error(recovery)
          @excel_import_errors += recovery.name + recovery.errors.full_messages.join(", ") + "<br>"
        end

        def build_params_by(row)
          ActionController::Parameters.new({
            recovery: {
              brand_id: @brand.id,
              name: row[1],
              max_price: row[2].to_i == 0 ? nil : row[2].to_i,
              min_price: row[3].to_i == 0 ? nil : row[3].to_i
            }
          }).require(:recovery).permit(:brand_id, :name, :max_price, :min_price)
        end
      end
    end
  end
end
