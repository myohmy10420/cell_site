$(document).ready(function () {
  $(".accept_terms").on("change", function () {
    if($(".accept_terms").prop("checked") == true) {
      $(".registrations_btn").prop("disabled", false)
    } else {
      $(".registrations_btn").prop("disabled", true)
    }
  })
})
