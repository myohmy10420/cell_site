module ProductsHelper
  def render_shelved_status(shelved)
    if shelved
      content_tag :span, "已上架", class: "badge badge-success"
    else
      content_tag :span, "未上架", class: "badge badge-secondary"
    end
  end

  def render_priced_status(priced)
    if priced
      content_tag :span, "已標價", class: "badge badge-info"
    else
      content_tag :span, "未標價", class: "badge badge-secondary"
    end
  end

  def render_list_selling_price(product)
    if !product.priced || !product.selling_price
      context = "特價中"
    else
      context = "$ "+product.selling_price.to_s
    end
    content_tag :span, context, class: "font font--red font--16r"
  end

  def render_details_selling_price(product)
    if !product.priced || !product.selling_price
      content_tag :span, "特價中請來電詢問", class: "font font--red"
    else
      content_tag :span, "$ "+product.selling_price.to_s,
        class: "font font--red  font--16r",
        id:"selling_price",
        data: { price: product.selling_price.to_s }
    end
  end

  def product_is_searched?(product, search_key)
    product.name.downcase.include?(search_key.downcase)
  end
end
