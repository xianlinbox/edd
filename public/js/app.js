$(document).ready(function () {
    $('#service_type_select').change(function () {
        $('#' + $(this).val() + '_dependency').removeClass('hidden');
    });
});

function submit_form(formid) {
    var form = document.getElementById(formid);
    form.submit();
}