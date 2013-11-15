$(document).ready(function () {
    $('#service_type_select').change(function () {
        $('#' + $(this).val().toLowerCase() + '_dependency_div').removeClass('hidden');
    });
});

function submit_form(formid) {
    var group_id = $('#group_select').val();
    var group_input = $("<input>").attr("type", "hidden").attr("name", "group_id").val(group_id);
    $('#' + formid).append($(group_input));
    $('#' + formid).submit();
}