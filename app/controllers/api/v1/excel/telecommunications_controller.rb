module Api
  module V1
    module Excel
      class TelecommunicationsController < ApplicationController
        def export
          @telecommunications = Telecommunication.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=電信.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          workbook.drop(1).each do |row|
            name = row[0]
            Telecommunication.create(name: name) if Telecommunication.find_by(name: name).nil?
          end if workbook

          redirect_to admin_telecommunications_path
        end
      end
    end
  end
end
