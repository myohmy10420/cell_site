module Admin
  class CarouselAdsController < Admin::BaseController
    def index
      @carousel_ads = CarouselAd.all
      @new_carousel_ad = CarouselAd.new
    end

    def create
      @carousel_ads = CarouselAd.all
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

	    redirect_to admin_carousel_ads_path
    end

    private

    def carousel_ad_params
      params[:carousel_ad] ||= {image: nil}
      params.require(:carousel_ad).permit(:image)
    end
  end
end
