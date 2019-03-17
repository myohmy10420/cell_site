module Api
  module V1
    module Excel
      class PreOrdersController < ApplicationController
        def export
          @pre_orders = PreOrder.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=預購清單.xlsx"
            }
          end
        end
      end
    end
  end
end
