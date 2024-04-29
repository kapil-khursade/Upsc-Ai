//= require active_admin/base
//= require active_admin_flat_skin


$(document).ready(function() {

//This is to refresh_status  
let progress_bars_to_update = [];

$(".refresh_status").each(function () {
    let the_id = $(this).attr("id");
    progress_bars_to_update.push({
        id: the_id,
    });
});

progress_bars_to_update.forEach(function (item) {
    let theUrl = `/internal_api/refresh_status?id=${item.id}`;

    let intervalId = setInterval(function () {
        $.get(theUrl, function (data) {
          $(`#answer_div`).html(data);
          if (data.includes("no_more_refresh")) {
            clearInterval(intervalId);
          }
        });
      }, 5000);
});
});

