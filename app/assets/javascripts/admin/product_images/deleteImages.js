$(document).ready(function () {
  $('.product_images-editor__btn').click(function () {
    var checkedImages = $('.product_images-editor input:checked')
    if (checkedImages.length === 0) {
      alert('找不到勾選的商品圖片')
    } else {
      var confirm_result = confirm("確認要刪除勾選的圖片？");
      if (confirm_result === false) return

      ids = checkedImages.map(function (index, image) {
        return image.dataset.id
      })
      $.ajax({
        type: 'POST',
        url: '/admin/product_images/delete_images',
        data: { product_images_ids: ids.get() },
        success: function() {
          alert('刪除成功')
          location.reload()
        }
      });
    }
  })
})
