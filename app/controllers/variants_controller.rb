class VariantsController < ApplicationController
  def index
    @telecommunications = Telecommunication.all
  end
end
