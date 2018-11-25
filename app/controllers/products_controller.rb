class ProductsController < ApplicationController
  def index
    @brands = Brand.all
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
