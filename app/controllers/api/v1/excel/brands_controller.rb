module Api
  module V1
    module Excel
      class BrandsController < Api::V1::Excel::BaseController
        def export
          @brands = get_brands

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=品牌.xlsx"
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
              name = row[0]

              find_brand(name)

              if @brand.nil?
                new_brand = Brand.new(name: name)
                next if new_brand.save

                @excel_import_errors += new_brand.name + new_brand.errors.full_messages.join(", ") + "<br>"
              end
            end

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
            else
              flash[:notice] = "匯入成功！"
            end
          end

          @brands = get_brands

          render "admin/brands/index"
        end

        private

        def get_brands
          Brand.order('sort ASC')
        end

        def find_brand(name)
          @brand = Brand.find_by(name: name)
        end
      end
    end
  end
end
