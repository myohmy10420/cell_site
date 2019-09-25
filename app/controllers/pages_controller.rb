class PagesController < ApplicationController
  def home
    @carousel_ads = CarouselAd.all
    @new_product_groups = slice_three_items_a_group(new_products)
    @pop_product_groups = slice_three_items_a_group(pop_products)
    @unlisted_products_groups = slice_three_items_a_group(unlisted_products)
  end

  def web_terms
  end

  def privacy_policy
  end

  def disclaimer
  end

  private

  def new_products
    Product.is_new.order('updated_at DESC')
  end

  def pop_products
    Product.is_pop.order('updated_at DESC')
  end

  def unlisted_products
    Product.is_unlisted.order('updated_at DESC')
  end

  def slice_three_items_a_group(array)
    groups_array = []
    array.each_slice(3) do |items|
      groups_array.push(items)
    end
    return groups_array
  end
end
