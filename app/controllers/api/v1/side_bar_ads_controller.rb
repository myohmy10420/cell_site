module Api
  module V1
    class SideBarAdsController < ApplicationController
      def up_sort
        if sort != 1
          target = SideBarAd.find_by(sort: sort)
          up_side_bar_ad = SideBarAd.find_by(sort: sort - 1)

          switch_index = target.sort

          target.update(sort: up_side_bar_ad.sort)
          up_side_bar_ad.update(sort: switch_index)
        end
        redirect_to admin_side_bar_ads_path
      end

      def down_sort
        if sort != SideBarAd.all.size
          target = SideBarAd.find_by(sort: sort)
          down_side_bar_ad = SideBarAd.find_by(sort: sort + 1)

          switch_index = target.sort

          target.update(sort: down_side_bar_ad.sort)
          down_side_bar_ad.update(sort: switch_index)
        end
        redirect_to admin_side_bar_ads_path
      end

      private

      def sort
        params[:sort].to_i
      end
    end
  end
end
