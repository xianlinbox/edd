'use strict';

$(function () {
    bindModal('.show-monitor', '.modal.add-monitor');
    bindModal('.show-group', '.modal.add-group');

    $.each(['url', 'database', 'rest', 'soap'], function (idx, elem) {
        bindModalMonitor('.monitor.' + elem, '.modal.monitor-' + elem);
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

function update_modal_value_with_ajax(service_type, monitor_id, modalSelector, status) {
    $.ajax({url: '/dependency/' + service_type + '/' + monitor_id,
            type: 'GET',
            dataType: 'json',
            async: true,
            success: function (data) {
                $('#modal_header_' + service_type + '_monitor_name').text(data.name);
                $.each(['show', 'edit'], function (idx, item) {
                    $('#modal_' + service_type + '_monitor_name_' + item).text(data.name);
                    $('#modal_' + service_type + '_monitor_description_' + item).text(data.description);

                    switch (service_type) {
                        case "url":
                            $('#modal_' + service_type + '_monitor_url_' + item).text(data.url);
                            break;
                        case "soap":
                            $('#modal_' + service_type + '_monitor_endpoint_' + item).text(data.endpoint);
                            $('#modal_' + service_type + '_monitor_username_' + item).text(data.username);
                            $('#modal_' + service_type + '_monitor_password_' + item).text(data.password);
                            $('#modal_' + service_type + '_monitor_request_' + item).text(data.request);
                            $('#modal_' + service_type + '_monitor_response_' + item).text(data.response);
                            break;
                        default:
                            alert('Unsupport Operation!');
                            break;
                    }
                });
                $('#modal_' + service_type + '_monitor_status').text(status.toUpperCase());
                $('#modal_' + service_type + '_monitor_delete').attr('href', '/dependency/' + service_type + '/' + monitor_id + '/delete');
                $(modalSelector).modal('show');
            }
        }
    );
}
function bindModalMonitor(triggerButtonSelector, modalSelector) {
    $(triggerButtonSelector).click(function () {
        var element_id = $(this).attr('id');
        var service_type = element_id.substr(0, element_id.indexOf("_"));
        var monitor_id = element_id.substr(element_id.lastIndexOf("_") + 1);
        var class_str = $(this).attr('class');
        var status = class_str.substr(class_str.lastIndexOf(" ") + 1);
        update_modal_value_with_ajax(service_type, monitor_id, modalSelector, status);
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
