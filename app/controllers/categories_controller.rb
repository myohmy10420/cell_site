class CategoriesController < ApplicationController
  def index
    @brands = Brand.includes(:categories).has_categories.order('sort ASC')
  end

  def show
    category = Category.find(params[:id])
    @products = category.products
  end
end
