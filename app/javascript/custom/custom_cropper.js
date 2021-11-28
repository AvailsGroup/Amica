var $uploadCrop,
    rawImg

function readFile(input, modalId, modalBodyId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $(modalBodyId).addClass('ready');
            $(modalId).modal('show');
            rawImg = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}

$uploadCrop = $('#upload-demo').croppie({
    viewport: {
        width: 100,
        height: 100,
        type: 'circle',
    },
    enforceBoundary: false,
    enableExif: false
});

$('#cropImagePop').on('shown.bs.modal', function () {
    $uploadCrop.croppie('bind', {
        url: rawImg
    }).then(function () { });
});

$('.image').on('change', function () {
    imageId = $(this).data('id');
    $('#cancelCropBtn').data('id', imageId);
    readFile(this, '#cropImagePop', '#upload-demo');
    $(this).val('');
});

$('#cropImageBtn').on('click', function (ev) {
    $uploadCrop.croppie('result', {
        type: 'base64',
        format: 'jpg',
        backgroundColor: '#fff',
        size: { width: 320, height: 320 }
    }).then(function (resp) {
        $('#image-output').attr('src', resp);
        $('#cropImage').val(resp);
        $('#cropImagePop').modal('hide');
    });
});