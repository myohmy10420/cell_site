$(document).ready(function () {
  $(".accept_terms").on("change", function () {
    if($(".accept_terms").prop("checked") == true) {
      $(".registrations_btn").prop("disabled", false)
    } else {
      $(".registrations_btn").prop("disabled", true)
    }
  })

  $(".birthday").on("change", function (event) {
    var birthArry = event.target.value.split("-")
    var year = parseInt(birthArry[0])
    var month = parseInt(birthArry[1]) - 1
    var day = parseInt(birthArry[2])
    var birthday = new Date(year, month, day)
    var ageDifMs = Date.now() - birthday
    var ageDate = new Date(ageDifMs)
    $(".age").text(parseInt(ageDate.getUTCFullYear() - 1970))
  })
})
