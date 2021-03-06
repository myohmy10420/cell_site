module ProductsHelper
  def render_tag(tag)
    content_tag :div, "", class: "tag tag--red" do
      content_tag :span, tag
    end if tag.presence
  end

  def render_shelved_status(product)
    if product.shelved
      class_name = "badge badge-shelved badge-success"
    else
      class_name = "badge badge-shelved badge-secondary"
    end
    content_tag :span, "上架", class: class_name, data: { product_id: product.id }
  end

  def render_on_sale_status(product)
    if product.on_sale
      content_tag :span, "特價中", class: "badge badge-info"
    else
      content_tag :span, "特價中", class: "badge badge-secondary"
    end
  end

  def render_pre_orderable_status(product)
    if product.pre_orderable
      content_tag :span, "可預購", class: "badge badge-primary"
    else
      content_tag :span, "可預購", class: "badge badge-secondary"
    end
  end

  def render_index_selling_price(product)
    if product.on_sale || !product.selling_price
      context = "特價中"
    elsif product.is_unlisted
      context = "特價中"
    else
      context = "$ " + product.selling_price.to_s
    end
    content_tag :span, context, class: "font font--red font--12r"
  end

  def render_details_selling_price(product)
    if product.on_sale || !product.selling_price
      content = "特價中請來電詢問"
      price = 0
    elsif product.is_unlisted
      content = "特價中請來電詢問"
      price = 0
    else
      content = "$ " + product.selling_price.to_s
      price = product.selling_price.to_s
    end

    content_tag :span, content,
      class: "font font--red  font--16r",
      id:"selling_price",
      data: { price: price }
  end

  def render_index_list_price(product)
    if product.list_price.to_i == 0
      content_tag :span, "原價請見官網", class: "font font--red font--12r"
    else
      content_tag :span, "$" + product.list_price.to_s, class: "font font--red font--12r"
    end
  end

  def render_details_list_price(product)
    if product.list_price.to_i == 0
      content_tag :span, "原價請見官網", class: "font"
    else
      content_tag :span, "$" + product.list_price.to_s, class: "font font--delete"
    end
  end

  def render_subtotal(product)
    if product.on_sale || product.is_unlisted
      content_tag :span, '特價中請來電詢問', class: "font font--red"
    else
      content_tag :span do
        [
          content_tag(:span, "$ ", class: "font--16r"),
          content_tag(:span, product.selling_price, id: "subtotal", class: "font--16r")
        ].join('').html_safe
      end
    end
  end

  def product_is_searched?(product, search_key)
    key = search_key || ''

    product.name.downcase.include?(key)
  end

  def tele_options
    Telecommunication.all.map { |tele| [tele.name, tele.id] }
  end

  def variant_options
    @variants.map { |variant| [variant.name, variant.discount] }
  end
end
