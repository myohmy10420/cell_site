module RecoveriesHelper
  def render_brand_name(variant)
    brand = Brand.find_by(id: variant.brand_id)
    brand.name || "-"
  end
end
