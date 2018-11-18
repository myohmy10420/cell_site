module Admin
  class ProductsController < Admin::BaseController
    def index
      @products = Product.all
    end

    def new

    end

    def create

    end
  end
end
