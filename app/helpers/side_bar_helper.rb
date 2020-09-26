module SideBarHelper
  def pre_expand_brand(brand)
    'show' if brand == (@product.try(:brand) || @category.try(:brand))
  end
end
