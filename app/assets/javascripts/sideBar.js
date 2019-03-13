$(document).ready(function () {
  $(".btn-link", ".side-bar").click(function () {
    var idName = this.dataset.target
    var classString = idName.substring(1, idName.length)
    var className = "." + classString
    if ($(className).hasClass(classString)) {
      $(className).removeClass(classString)
    }
  })
})
