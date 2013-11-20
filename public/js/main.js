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
    $('a.setting').click(function () {
        $(this).siblings(".setting-menu").toggleClass('active');
    });

    refresh_url_monitor();
    refresh_soap_monitor();
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
    $('#' + formid).submit();
}

function update_status_with_ajax(service_type, monitor_id, element_id) {
    $.ajax({url: '/dependency/status/' + service_type + '/' + monitor_id,
            type: 'GET',
            async: true,
            success: function (data) {
                if ('success' == data) {
                    $('#' + element_id).attr('class', 'monitor icon ' + service_type + ' success');
                } else {
                    $('#' + element_id).attr('class', 'monitor icon ' + service_type + ' fail');
                }
            }
        }
    );
}

function refresh_status() {
    var element_id = $(this).attr('id');
    var service_type = element_id.substr(0, element_id.indexOf("_"))
    var monitor_id = element_id.substr(element_id.lastIndexOf("_") + 1);
    update_status_with_ajax(service_type, monitor_id, element_id);
}

function refresh_url_monitor() {
    $("section[id^='url_dependency_monitor_']").each(
        function () {
            refresh_status.call(this);
        }
    );
}

function refresh_soap_monitor() {
    $("section[id^='soap_dependency_monitor_']").each(
        function () {
            refresh_status.call(this);
        }
    );
}
