$(function(){
    'use strict';
    var URL = window.URL || window.webkitURL;
    var $image = $('#img');
    var $download = $('#download');
    var $dataX = $('#dataX');
    var $dataY = $('#dataY');
    var $dataHeight = $('#dataHeight');
    var $dataWidth = $('#dataWidth');
    var $dataRotate = $('#dataRotate');
    var $dataScaleX = $('#dataScaleX');
    var $dataScaleY = $('#dataScaleY');
    var uploadedImageType = 'image/jpeg';
    var uploadedImageName = 'cropped.jpg';
    var options = {
        aspectRatio : 16 / 9,
        //viewMode: 3,  // viewMode 無しで端を含められる
        crop : function(e){
            $dataX.val(Math.round(e.detail.x));
            $dataY.val(Math.round(e.detail.y));
            $dataHeight.val(Math.round(e.detail.height));
            $dataWidth.val(Math.round(e.detail.width));
            $dataRotate.val(e.detail.rotate);
            $dataScaleX.val(e.detail.scaleX);
            $dataScaleY.val(e.detail.scaleY);
        }
    };
    var result;
    var uploadedImageURL;

    $('#setcrop').click(function(){
        $image.cropper(options);
        $('#getData').prop('disabled', false);
    });

    $('#resetcrop').click(function(){
        $image.cropper('destroy');
        $(".docs-toggles label:nth-child(1) input[name='aspectRatio']").trigger('click');
        options['aspectRatio'] = 1.7777777777777777
        $('#getData').prop('disabled', true);
    });
    // aspect 比率変更
    $('.docs-toggles').on('change', 'input', function(){
        var $this = $(this);
        var name = $this.attr('name');
        var type = $this.prop('type');
        var cropBoxData;
        var canvasData;
        if (!$image.data('cropper')){
            return;
        }
        if(type === 'radio'){
            options[name] = $this.val();
        }
        $image.cropper('destroy').cropper(options);
    });

    $('#getData').click(function(){
        if ($(this).prop('disabled') || $(this).hasClass('disabled')){
            return;
        }
        result = $image.cropper('getCroppedCanvas');
        // Bootstrap's Modal
        $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);
        if (!$download.hasClass('disabled')){
            download.download = uploadedImageName;
            $download.attr('href', result.toDataURL(uploadedImageType));
        }
    });

    // Import image
    var $inputImage = $('#inputImage');
    $inputImage.change(function(){
        var files = this.files;
        var file;
        if (files && files.length){
            file = files[0];
            if (/^image\/\w+$/.test(file.type)){
                uploadedImageName = file.name;
                uploadedImageType = file.type;
                if (uploadedImageURL){
                    URL.revokeObjectURL(uploadedImageURL);
                }
                uploadedImageURL = URL.createObjectURL(file);
                $image.cropper('destroy').attr('src', uploadedImageURL).cropper(options);
                $inputImage.val('');
            }else{
                window.alert('Please choose an image file.');
            }
        }
    });
    // モーダルドラッグ可能にする
    $("#getCroppedCanvasModal").draggable({ cursor: "move" });
});