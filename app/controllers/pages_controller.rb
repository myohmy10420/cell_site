class PagesController < ApplicationController
  def home
    @carousel_ads = CarouselAd.order('sort ASC')
    @new_products = new_products
    @pop_products = pop_products
    @unlisted_products = unlisted_products
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
end
