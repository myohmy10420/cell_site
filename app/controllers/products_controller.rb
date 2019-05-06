class ProductsController < ApplicationController
  def index
    @brands = has_valid_products_brands
    set_meta_tag
  end

  def show
    @product = Product.friendly.find(params[:id])
    check_product_viewable
    set_meta_tag

    @telecommunications = Telecommunication.all
    @variants = []
    @brands = Brand.all
    @pre_order = PreOrder.new
  end

  def search
    @brands = has_valid_products_brands

    render "index"
  end

  def search_varirnt
    @product = Product.friendly.find(params[:product_id])
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

  def set_meta_tag
    case action_name
    when "index"
      @page_title = "手機價格總覽"
      @page_description = "手機價格總覽"
      @page_keywords = ""
      Brand.all.each do |brand|
        @page_keywords += "," + brand.name
      end
    when "show"
      @page_title = @product.name
      @page_description = @product.slogan
      @page_keywords = @product.name
    end
  end

  def has_valid_products_brands
    @search_key = params[:search_key] || ''
    products = Product.where("name like ?", "%#{@search_key}%").includes(:brand)

    brands = []
    products.each do |product|
      brands << product.brand
    end

    brands.uniq
  end

  def check_product_viewable
    redirect_to root_path if !@product.shelved && !params[:preview]
  end
end
