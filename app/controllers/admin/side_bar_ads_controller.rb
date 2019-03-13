module Admin
  class SideBarAdsController < Admin::BaseController
    def index
      @side_bar_ads = SideBarAd.all
      @new_side_bar_ad = SideBarAd.new
    end

    def create
      @side_bar_ads = SideBarAd.all
      @new_side_bar_ad = SideBarAd.new(side_bar_ad_params)
      if @new_side_bar_ad.save
        redirect_to admin_side_bar_ads_path
      else
        render "index"
      end
    end

    def destroy
      @side_bar_ad = SideBarAd.find(params[:id])
	    @side_bar_ad.destroy

	    redirect_to admin_side_bar_ads_path
    end

    private

    def side_bar_ad_params
      params[:side_bar_ad] ||= {image: nil}
      params.require(:side_bar_ad).permit(:image, :url)
    end
  end
end
