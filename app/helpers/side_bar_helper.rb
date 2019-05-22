module SideBarHelper
  def expanded_brand?(brand, product, type)
    return '' if !product

    if brand == product.brand
      return 'true' if type == 'btn'
      return 'show' if type == 'collapse'
    else
      return ''
    end
  end
end
