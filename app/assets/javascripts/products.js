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
      registerSelectVariantEvent()
    })

  var registerSelectVariantEvent = function () {
    $('.variant_select_form #product_variant_id')
      .on('change', function () {
        calculateSubtotal($(this)[0].value)
      })
  }

  $('.variant_select_form #product_recovery_id')
      .on('change', function () {
        calculateSubtotal($(this)[0].value)
      })

  var calculateSubtotal = function (value) {
    var sellingPriceTag = document.getElementById('selling_price');
    var sellingPrice = parseInt(sellingPriceTag.dataset.price)

    var variantDiscount = parseInt(document.getElementById("product_variant_id").value || 0)
    var recoveryDiscount = parseInt(document.getElementById("product_recovery_id").value || 0)

    if (!!recoveryDiscount) {
      $(".recoveriesStandard").show()
    } else {
      $(".recoveriesStandard").hide()
    }

    var subtotal = sellingPrice - variantDiscount - recoveryDiscount
    document.getElementById('subtotal').innerHTML = subtotal
  }
})
