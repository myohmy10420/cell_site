module Api
  module V1
    module Excel
      class TelecommunicationsController < Api::V1::Excel::BaseController

        def export
          @telecommunications = get_telecommunications

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=telecommunications.xlsx"
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

              find_telecommunication(name)

              if @telecommunication.nil?
                new_telecommunication = Telecommunication.new(name: name)
                next if new_telecommunication.save

                @excel_import_errors += new_telecommunication.name + new_telecommunication.errors.full_messages.join(", ") + "<br>"
              end
            end

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
            else
              flash[:notice] = "匯入成功！"
            end
          end

          @telecommunications = get_telecommunications

          render "admin/telecommunications/index"
        end

        private

        def get_telecommunications
          Telecommunication.all.order('updated_at DESC')
        end

        def find_telecommunication(name)
          @telecommunication = Telecommunication.find_by(name: name)
        end
      end
    end
  end
end
