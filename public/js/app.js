$(document).ready(function () {
    refresh_url_monitor();
    setInterval(refresh_url_monitor, 10000);
});

function submit_form(formid) {
    var group_id = $('#group_select').val();
    var group_input = $("<input>").attr("type", "hidden").attr("name", "group_id").val(group_id);
    $('#' + formid).append($(group_input));
    $('#' + formid).submit();
}

function update_status_with_ajax(monitor_id, element_id) {
    $.ajax({url: '/url_dependency/status/' + monitor_id,
            type: 'GET',
            async: true,
            success: function (data) {
                if ('success' == data) {
                    $('#' + element_id).attr('class', 'panel panel-primary');
                } else {
                    $('#' + element_id).attr('class', 'panel panel-danger');
                }
            }
        }
    );
}

function refresh_url_monitor() {
    $("div[id^='url_dependency_monitor_']").each(
        function () {
            var element_id = $(this).attr('id');
            var monitor_id = element_id.substr(element_id.lastIndexOf("_") + 1);
            update_status_with_ajax(monitor_id, element_id);
        }
    );
}
