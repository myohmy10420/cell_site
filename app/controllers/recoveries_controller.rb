class RecoveriesController < ApplicationController
  def index
    @brands = Brand.all
  end
end
