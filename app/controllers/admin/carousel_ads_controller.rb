module Admin
  class CarouselAdsController < Admin::BaseController
    def index
      @carousel_ads = CarouselAd.order('sort ASC')
      @new_carousel_ad = CarouselAd.new
    end

    def create
      @carousel_ads = CarouselAd.order('sort ASC')
      @new_carousel_ad = CarouselAd.new(carousel_ad_params)
      if @new_carousel_ad.save
        redirect_to admin_carousel_ads_path
      else
        render "index"
      end
    end

    def destroy
      @carousel_ad = CarouselAd.find(params[:id])
      @carousel_ad.destroy
      resort_carousel_ads

	    redirect_to admin_carousel_ads_path
    end

    private

    def carousel_ad_params
      params[:carousel_ad] ||= {image: nil}
      params.require(:carousel_ad).permit(:image, :url)
    end

    def resort_carousel_ads
      CarouselAd.order('sort ASC').each_with_index do |ad, index|
        ad.sort = index + 1
        ad.save
      end
    end
  end
end
