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
      end
    end
  end
end
