class PagesController < ApplicationController
  def home
    @new_product_groups = slice_three_items_a_group(new_products)
    @pop_product_groups = slice_three_items_a_group(pop_products)
  end

  private

  def new_products
    Product.where(is_new: true)
  end

  def pop_products
    Product.where(is_pop: true)
  end

  def slice_three_items_a_group(array)
    groups_array = []
    array.each_slice(3) do |items|
      groups_array.push(items)
    end
    return groups_array
  end
end
