$(document).ready(function () {
  $('.variant_select_form #product_tele_id')
    .on('change', function () {
      $('.variant_select_form').submit()
    })

  $('.variant_select_form')
    .on('ajax:success', function (event, responds, status, error) {
      $data = $('<div>').html(responds)
      $variant_selector = $('.variant_select_panel', $data).html()
      $('.variant_select_panel').html($variant_selector)

      if (!!document.getElementById('subtotal')) {
        registerSelectVariantEvent()
      }
    })

  var registerSelectVariantEvent = function () {
    $('.variant_select_form #product_variant_id')
      .on('change', function () {
        var value = $(this)[0].value
        if (isNaN(value)) {
          $('._product-variant_select_hint').show()
        } else {
          $('._product-variant_select_hint').hide()
          calculateSubtotal(value)
        }
      })
  }

  var calculateSubtotal = function (value) {
    var sellingPriceTag = document.getElementById('selling_price');
    var sellingPrice = parseInt(sellingPriceTag.dataset.price)

    var variantDiscount = parseInt(document.getElementById("product_variant_id").value || 0)

    var subtotal = sellingPrice - variantDiscount
    console.log('subtotal', subtotal)
    if (subtotal < 0) subtotal = 0

    document.getElementById('subtotal').innerHTML = subtotal
  }
})
