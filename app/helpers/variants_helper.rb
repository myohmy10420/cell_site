module VariantsHelper
  def render_telecommunication_name(variant)
    telecommunication = Telecommunication.find_by(id: variant.telecommunication_id)
    telecommunication.name || "-"
  end

  def render_variant_discount(discount)
    if discount.to_i == 0
      discount || "下殺"
    else
      "$" + discount.to_s
    end
  end

  def render_model_enable(model)
    return if model.try(:enable).nil?

    if model.enable
      class_name = "badge badge-shelved badge-success"
    else
      class_name = "badge badge-shelved badge-secondary"
    end
    content_tag :span, "啟用", class: class_name, data: { model_id: model.id }
  end
end
