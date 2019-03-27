class VariantsController < ApplicationController
  def index
    @telecommunications = Telecommunication.all
    set_meta_tag
  end

  private

  def set_meta_tag
    @page_title = "門號折扣"
    @page_description = "手機 門號 方案 電信 折扣"
    @page_keywords = "手機,門號,方案,電信,折扣"
  end
end
