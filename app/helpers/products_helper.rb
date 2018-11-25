module ProductsHelper
  def render_list_selling_price(product)
    if !product.priced || !product.selling_price
      content_tag :h5, "特價中", class: "font font--red"
    else
      content_tag :h4, "$ "+product.selling_price.to_s, class: "font font--red"
    end
  end

  def render_details_selling_price(product)
    if !product.priced || !product.selling_price
      content_tag :span, "特價中請來電詢問", class: "font font--red"
    else
      content_tag :span, "$ "+product.selling_price.to_s, class: "font font--red  font--large"
    end
  end
end
