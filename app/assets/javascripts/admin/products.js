$(document).ready(function () {
  $(".badge-shelved").click(function () {
    var badgeDom = this
    var productId = badgeDom.dataset.productId
    var targetStatus = ""

    if (badgeDom.classList.contains("badge-success")) {
      targetStatus = "下架"
    } else {
      targetStatus = "上架"
    }

    var isConfirm = confirm("確定要讓此商品" + targetStatus + "嗎？")
    if (!isConfirm) return

    $.ajax({
      type: 'POST',
      url: "/api/v1/product/switch-shelved",
      data: { productId: productId },
      success: function(data) {
        badgeDom.classList.remove("badge-success", "badge-secondary")
        badgeDom.classList.add(data.class_name)
      }
    });
  })
})
