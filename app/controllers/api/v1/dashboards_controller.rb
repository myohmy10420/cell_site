module Api
  module V1
    class DashboardsController < ApplicationController
      before_action :load_dashboard

      def visitor_count
        @dashboard.visitor_count += 1
        @dashboard.save

        render json: {
          visitor_count: @dashboard.visitor_count
        }, status: 200
      end

      private

      def load_dashboard
        if Dashboard.exists?
          @dashboard = Dashboard.first
        else
          @dashboard = Dashboard.create!
        end
      end
    end
  end
end
