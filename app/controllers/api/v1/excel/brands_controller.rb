module Api
  module V1
    module Excel
      class BrandsController < ApplicationController
        def export
          @brands = Brand.all

          respond_to do |format|
            format.xls { headers["Content-Disposition"] = "attachment; filename=品牌.xls" }
          end
        end
      end
    end
  end
end
