module SideBarHelper
  def pre_expand_product_brand(brand, brand_product)
    'show' if brand == brand_product
  end
end
