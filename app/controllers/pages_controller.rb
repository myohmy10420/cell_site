class PagesController < ApplicationController
  def home
    @new_products = slice_three_items_a_group(Product.all)
    @pop_products = slice_three_items_a_group(Product.all)
  end

  private

  def slice_three_items_a_group(array)
    groups_array = []
    array.each_slice(3) do |items|
      groups_array.push(items)
    end
    return groups_array
  end
end
