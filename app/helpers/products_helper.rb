module ProductsHelper
  def render_tag(tag)
    content_tag :div, "", class: "tag tag--red" do
      content_tag :span, tag
    end if tag
  end
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
      content = "特價中請來電詢問"
      price = 0
    else
      content = "$ "+product.selling_price.to_s
      price = product.selling_price.to_s
    end

    content_tag :span, content,
      class: "font font--red  font--16r",
      id:"selling_price",
      data: { price: price }
  end

  def product_is_searched?(product, search_key)
    product.name.downcase.include?(search_key.downcase)
  end

  def tele_options
    Telecommunication.all.map { |tele| [tele.name, tele.id] }
  end

  def variant_options
    @variants.map { |variant| [variant.name, variant.discount] }
  end

  def recovery_options
    options = []
    @brands.each do |brand|
      if brand.recoveries.any?
        options << ["品牌：(#{brand.name})", "0"]
        brand.recoveries.each do |recovery|
          options << [recovery.name, recovery.min_price]
        end
      end
    end
    options
  end
end
