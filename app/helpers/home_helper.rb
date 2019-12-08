module HomeHelper
  def slice_items_a_group(array)
    if browser.device.mobile?
      quantity = 2
    else
      quantity = 3
    end

    groups_array = []
    array.each_slice(quantity) do |items|
      groups_array.push(items)
    end
    return groups_array
  end
end
