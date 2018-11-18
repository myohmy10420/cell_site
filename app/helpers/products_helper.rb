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
end
