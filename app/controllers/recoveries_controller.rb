class RecoveriesController < ApplicationController
  def index
    @brands = Brand.all
    set_meta_tag
  end

  private

  def set_meta_tag
    @page_title = "二手機回收折扣"
    @page_description = "二手機回收 手機回收 折扣"
    @page_keywords = "二手機回收,手機回收,折扣"
  end
end
