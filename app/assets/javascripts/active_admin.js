//= require active_admin/base
//= require active_admin_flat_skin

//This is to refresh_status

let progress_bars_to_update = [];

$(".refresh_status").each(function () {
    let the_class = "Question";
    let the_id = $(this).attr("the_id");
    let elementId = $(this).attr("id");
    progress_bars_to_update.push({
        class: the_class,
        the_id: the_id,
        el_id: elementId,
    });
});

progress_bars_to_update.forEach(function (item) {

    let theUrl = `/backend_api/status_update/${item.the_id}?c=${item.class}`
    alert(theUrl)

})