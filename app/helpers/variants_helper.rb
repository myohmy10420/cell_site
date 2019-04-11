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
end
