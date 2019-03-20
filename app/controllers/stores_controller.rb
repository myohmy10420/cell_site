class StoresController < ApplicationController
  def index
    @stores = Store.all
    set_meta_tag
  end

  private

  def set_meta_tag
    @page_title = "門市據點"
    @page_description = "就是便宜門市據點"
    @page_keywords = ""
    @stores.each do |store|
      @page_keywords += "," + store.name
    end
  end
end
