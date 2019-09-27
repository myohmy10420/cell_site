$(document).ready(function () {
  console.log('init')
  $(".up_sort", ".side_bar_ads_image_editor").click(function() {
    console.log(this.dataset.sort)
    sort_side_bar_ads("up_sort", this.dataset.sort)
  })
  $(".down_sort", ".side_bar_ads_image_editor").click(function() {
    sort_side_bar_ads("down_sort", this.dataset.sort)
  })

  var sort_side_bar_ads = function(action, sort) {
    var url = "/api/v1/side_bar_ad/" + action
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
