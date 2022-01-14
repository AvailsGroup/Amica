import "jquery"

function flexTextarea(el) {
    const dummy = el.querySelector('.FlexTextarea__dummy')
    el.querySelector('.FlexTextarea__textarea').addEventListener('input', e => {
        dummy.textContent = e.target.value + '\u200b'
    })
}

document.querySelectorAll('.FlexTextarea').forEach(flexTextarea)

$(function () {
    $(document).on('keypress', function (event) {
        if (event.shiftKey && event.key === 'Enter' && $('#FlexTextarea').val()) {
            $('#timelineSubmit').click()
            return false;
        }
    })
});