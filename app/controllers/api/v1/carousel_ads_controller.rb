module Api
  module V1
    class CarouselAdsController < ApplicationController
      def up_sort
        if sort != 1
          target = CarouselAd.find_by(sort: sort)
          up_carousel_ad = CarouselAd.find_by(sort: sort - 1)

          switch_index = target.sort

          target.update(sort: up_carousel_ad.sort)
          up_carousel_ad.update(sort: switch_index)
        end
        redirect_to admin_carousel_ads_path
      end

      def down_sort
        if sort != CarouselAd.all.size
          target = CarouselAd.find_by(sort: sort)
          down_carousel_ad = CarouselAd.find_by(sort: sort + 1)

          switch_index = target.sort

          target.update(sort: down_carousel_ad.sort)
          down_carousel_ad.update(sort: switch_index)
        end
        redirect_to admin_carousel_ads_path
      end

      private

      def sort
        params[:sort].to_i
      end
    end
  end
end
