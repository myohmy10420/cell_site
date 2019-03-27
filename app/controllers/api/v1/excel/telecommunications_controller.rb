module Api
  module V1
    module Excel
      class TelecommunicationsController < Admin::BaseController
        before_action :get_telecommunications

        def export
          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=電信.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          @excel_import_errors = ""
          workbook.drop(1).each do |row|
            name = row[0]

            if Telecommunication.find_by(name: name).nil?
              new_telecommunication = Telecommunication.new(name: name)
              next if new_telecommunication.save
              @excel_import_errors += new_telecommunication.name + new_telecommunication.errors.full_messages.join(", ") + "<br>"
            end
          end if workbook

          if @excel_import_errors.presence
            @excel_import_errors = @excel_import_errors.html_safe
          else
            flash[:notice] = "匯入成功！"
          end

          render "admin/telecommunications/index"
        end

        private

        def get_telecommunications
          @telecommunications = Telecommunication.all.order('updated_at DESC')
        end
      end
    end
  end
end
