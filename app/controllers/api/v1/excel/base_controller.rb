module Api
  module V1
    module Excel
      class BaseController < ApplicationController
        layout :resolve_layout

        private

        def resolve_layout
          case action_name
          when "import"
            "admin"
          else
            "application"
          end
        end
      end
    end
  end
end
