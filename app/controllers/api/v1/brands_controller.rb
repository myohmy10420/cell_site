module Api
  module V1
    class BrandsController < ApplicationController
      def up_sort
        if sort != 1
          target = Brand.find_by(sort: sort)
          up_brand = Brand.find_by(sort: sort - 1)

          switch_index = target.sort

          target.update(sort: up_brand.sort)
          up_brand.update(sort: switch_index)
        end
        redirect_to admin_brands_path
      end

      def down_sort
        if sort != Brand.all.size
          target = Brand.find_by(sort: sort)
          down_brand = Brand.find_by(sort: sort + 1)

          switch_index = target.sort

          target.update(sort: down_brand.sort)
          down_brand.update(sort: switch_index)
        end
        redirect_to admin_brands_path
      end

      private

      def sort
        params[:sort].to_i
      end
    end
  end
end
