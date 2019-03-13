module Api
  module V1
    module Excel
      class BrandsController < ApplicationController
        def export
          @brands = Brand.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=品牌.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path)
          workbook.drop(1).each do |row|
            name = row[0]
            Brand.create(name: name) if Brand.find_by(name: name).nil?
          end

          redirect_to admin_brands_path
        end
      end
    end
  end
end
