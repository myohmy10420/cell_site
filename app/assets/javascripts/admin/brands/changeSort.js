$(document).ready(function () {
  $(".up_sort", ".brand").click(function() {
    sort_brands("up_sort", this.dataset.sort)
  })
  $(".down_sort", ".brand").click(function() {
    sort_brands("down_sort", this.dataset.sort)
  })

  var sort_brands = function(action, sort) {
    var url = "/api/v1/brand/" + action
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
