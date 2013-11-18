'use strict';

$(function () {
    bindModal('.show-monitor', '.modal.add-monitor');
    bindModal('.show-group', '.modal.add-group');

    $.each(['url', 'database', 'rest'], function (idx, elem) {
        bindModal('.monitor.' + elem, '.modal.monitor-' + elem);
    });

    selectMonitorType();
    $('.add-monitor .type').change(function () {
        selectMonitorType();
    });

    $('.box h3').click(function () {
        $(this).parent().toggleClass('active');
    });

    $('.edit').click(function () {
        $(this).parent().parent().addClass('in-edit');
    });
    $('.show').click(function () {
        $(this).parent().parent().removeClass('in-edit');
    });

    refresh_url_monitor();
});

function bindModal(triggerButtonSelector, modalSelector) {
    $(triggerButtonSelector).click(function () {
        $(modalSelector).modal('show');
    });
    $(modalSelector + ' .close').click(function () {
        $(modalSelector).modal('hide');
    });
}

function selectMonitorType() {
    var type = $('.add-monitor .type').val();
    var className = ".add-" + type.toLowerCase().replace(/\s/g, '-');
    $('.add-monitor .monitor-section').css('display', 'none');
    $('.add-monitor ' + className).css('display', 'block');
}

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
                    $('#' + element_id).attr('class', 'monitor icon url success');
                } else {
                    $('#' + element_id).attr('class', 'monitor icon url fail');
                }
            }
        }
    );
}

function refresh_url_monitor() {
    $("section[id^='url_dependency_monitor_']").each(
        function () {
            var element_id = $(this).attr('id');
            var monitor_id = element_id.substr(element_id.lastIndexOf("_") + 1);
            update_status_with_ajax(monitor_id, element_id);
        }
    );
}