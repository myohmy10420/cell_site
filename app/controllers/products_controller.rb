class ProductsController < ApplicationController
  def index
    @brands = find_brands_with_products
    set_meta_tag
  end

  def show
    @product = Product.friendly.find(params[:id])
    check_product_viewable
    set_meta_tag

    @telecommunications = Telecommunication.all
    @variants = []
    @brands = Brand.includes(:recoveries).all
    @pre_order = PreOrder.new
  end

  def search
    @brands = find_brands_with_products

    render "index"
  end

  def search_varirnt
    @product = Product.friendly.find(params[:product_id])
    @brands = Brand.includes(:recoveries).joins(:recoveries).uniq

    tele_id = params[:product][:tele_id]

    if tele_id.present?
      tele = Telecommunication.find(tele_id)
      @variants = tele.variants
    else
      @variants = []
    end

    respond_to do |format|
      format.html {
        render partial: "products/discount_selector", locals: { brands: @brands, product: @product }
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
      Brand.order('sort ASC').each do |brand|
        @page_keywords += "," + brand.name
      end
    when "show"
      @page_title = @product.name
      @page_description = @product.slogan
      @page_keywords = @product.name
    end
  end

  def find_brands_with_products
    @search_key = params[:search_key] || ''
    brand_ids = Product.where(shelved: true).where("name like ?", "%#{@search_key}%").pluck(:brand_id).uniq
    Brand.where(id: brand_ids).includes(:products)
  end

  def check_product_viewable
    redirect_to root_path if !@product.shelved && !params[:preview]
  end
end
