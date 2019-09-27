$(document).ready(function () {
  $(".up_sort", ".carousel_ads_image_editor").click(function() {
    sort_carousel_ads("up_sort", this.dataset.sort)
  })
  $(".down_sort", ".carousel_ads_image_editor").click(function() {
    sort_carousel_ads("down_sort", this.dataset.sort)
  })

  var sort_carousel_ads = function(action, sort) {
    var url = "/api/v1/carousel_ad/" + action
    $.ajax({
      type: 'POST',
      url: url,
      data: { sort: sort },
      success: function() {
        location.reload()
      }
    });
  }
})
