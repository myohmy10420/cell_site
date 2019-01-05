class ProductsController < ApplicationController
  before_action :set_search_key
  def index
    @brands = Brand.all
  end

  def show
    @product = Product.find(params[:id])
    @telecommunications = Telecommunication.all
    @brands = Brand.all
  end

  def search
    @brands = has_valid_products_brands

    respond_to do |format|
      format.html { render :index }
    end
  end

  private

  def set_search_key
    @search_key = params[:search_key] || ''
  end

  def has_valid_products_brands
    products = Product.where("name like ?", "%#{@search_key}%")

    brands = []
    products.each do  |product|
      brands << product.brand
    end

    brands.uniq
  end

end
