class AddSortToCarouselAdAndSideBarAd < ActiveRecord::Migration[5.2]
  def change
    add_column :carousel_ads, :sort, :integer
    add_column :side_bar_ads, :sort, :integer
  end
end
