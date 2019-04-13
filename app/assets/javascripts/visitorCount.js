$(document).ready(function () {
  if ($('.visitor_count')[0]) {
    var visitor_count = localStorage.getItem('visitor_count')

    if (!visitor_count || expiredVisitorTimestamp()) {
      updateVisitorCount()
    } else {
      $('.count', '.visitor_count').text(visitor_count)
    }

    function expiredVisitorTimestamp () {
      var visitorTimestamp = localStorage.getItem('visitorTimestamp')
      var date = new Date

      if (Number(date.getTime()) - visitorTimestamp > 5 * 60 * 1000) {
        return true
      } else {
        return false
      }
    }

    function updateVisitorCount () {
      $.ajax({
        type: 'GET',
        url: '/api/v1/dashboard/visitor_count',
        success: function(data) {
          $('.count', '.visitor_count').text(data.visitor_count)
          var date = new Date
          localStorage.setItem('visitorTimestamp', date.getTime());
          localStorage.setItem('visitor_count', data.visitor_count);
        }
      })
    }
  }
})
