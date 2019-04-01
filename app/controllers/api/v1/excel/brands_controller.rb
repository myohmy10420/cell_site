module Api
  module V1
    module Excel
      class BrandsController < Api::V1::Excel::BaseController
        before_action :get_brands

        def export
          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=品牌.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          @excel_import_errors = ""
          workbook.drop(1).each do |row|
            name = row[0]

            if Brand.find_by(name: name).nil?
              new_brand = Brand.new(name: name)
              next if new_brand.save
              @excel_import_errors += new_brand.name + new_brand.errors.full_messages.join(", ") + "<br>"
            end
          end if workbook

          if @excel_import_errors.presence
            @excel_import_errors = @excel_import_errors.html_safe
          else
            flash[:notice] = "匯入成功！"
          end

          render "admin/brands/index"
        end

        private

        def get_brands
          @brands = Brand.all.order('sort ASC')
        end
      end
    end
  end
end
