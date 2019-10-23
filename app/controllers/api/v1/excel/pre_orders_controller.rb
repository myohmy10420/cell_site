module Api
  module V1
    module Excel
      class PreOrdersController < ApplicationController
        def export
          if current_user.has_role? :admin
            @pre_orders = PreOrder.all.order('updated_at DESC')
          elsif current_user.has_role? :store_manager
            @pre_orders = PreOrder.where(user_id: current_user.id).order('updated_at DESC')
          else
            @pre_orders = []
          end

          authorize! :export, PreOrder

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
