module Api
  module V1
    module Excel
      class VariantsController < Api::V1::Excel::BaseController
        before_action :get_variants

        def export
          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=方案.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          @excel_import_errors = ""
          workbook.drop(1).each do |row|
            telecommunication = Telecommunication.find_by(name: row[0])
            @excel_import_errors += row[1] + "找不到" + row[0] + "電信<br>" if telecommunication.nil?
            next if telecommunication.nil?

            params = ActionController::Parameters.new({
              variant: {
                telecommunication_id: telecommunication.id,
                name: row[1],
                content: row[2],
                discount: row[3].to_i,
                prepaid: row[4].to_i,
                traffic: row[5],
                period: row[6]
              }
            })
            variant_params = params.require(:variant).permit(:telecommunication_id, :name, :discount, :prepaid, :traffic, :period, :content)

            variant = Variant.find_by(name: row[1])
            if variant.present?
              variant.update(variant_params)
            else
              Variant.create(variant_params)
              new_variant = Variant.new(variant_params)
              next if new_variant.save
              @excel_import_errors += new_variant.name + new_variant.errors.full_messages.join(", ") + "<br>"
            end
          end if workbook

          if @excel_import_errors.presence
            @excel_import_errors = @excel_import_errors.html_safe
          else
            flash[:notice] = "匯入成功！"
          end

          render "admin/variants/index"
        end

        private

        def get_variants
          @variants = Variant.all.order('updated_at DESC')
        end
      end
    end
  end
end
