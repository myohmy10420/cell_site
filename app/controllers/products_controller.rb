class ProductsController < ApplicationController
  before_action :set_search_key
  def index
    @brands = has_valid_products_brands
  end

  def show
    @product = Product.find(params[:id])
    redirect_to root_path if !@product.shelved && !params[:preview]
    @telecommunications = Telecommunication.all
    @variants = []
    @brands = Brand.all
  end

  def search
    @brands = has_valid_products_brands

    respond_to do |format|
      format.html { render :index }
    end
  end

  def search_varirnt
    @product = Product.find(params[:product_id])
    @brands = has_valid_products_brands

    tele_id = params[:product][:tele_id]

    if tele_id != ""
      tele = Telecommunication.find(tele_id)
      @variants = tele.variants
    else
      @variants = []
    end

    respond_to do |format|
      format.html {
        render partial: "products/discount_selector"
      }
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
