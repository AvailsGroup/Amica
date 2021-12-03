import {Modal} from "bootstrap";
document.addEventListener("DOMContentLoaded", function(){

    //-------------------------------- 解説1 ----------------------------------
    $('#trim_img_uploder').click(function(e){
        $(this).val('');
        document.getElementById("prev_img").style.display = '';
        document.getElementById("cropped_canvas").style.display = 'none';
        var result = document.getElementById('result-img');
        result.style.display="none";
        let base64 = "";
        result.src = base64;
        $('#user_icon').fadeIn();
    });

    $('#trim_img_uploder').change(function(e){
        document.getElementById("prev_img").style.display = 'none';
        $('#modal_area').fadeIn();
        $('.modal-text').fadeOut();
       });

    //-------------------------------- 解説2 ----------------------------------
    let cropper = null;
    const scaled_width = 500;
    const aspect_numerator = parseFloat(document.getElementById("aspect_numerator").value)
    const aspect_denominator = parseFloat(document.getElementById("aspect_denominator").value)
    const crop_aspect_ratio = aspect_denominator / aspect_numerator;

    //-------------------------------- 解説3 ----------------------------------
    const crop_image = function (e) {
        const files = e.target.files;
        if (files.length == 0) {
            return;
        }
        let file = files[0];
        let image = new Image();
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (e) {
            image.src = e.target.result;
            image.onload = function () {

                //-------------------------------- 解説4 ----------------------------------
                let scale = scaled_width / image.width;
                const canvas = document.getElementById("source_canvas");
                canvas.width = image.width * scale;
                canvas.height = image.height * scale;

                let ctx = canvas.getContext("2d");
                ctx.drawImage(image, 0, 0, image.width, image.height, 0, 0, canvas.width, canvas.height);

                if (cropper != null) {
                    cropper.destroy();
                }

                //-------------------------------- 解説5 ----------------------------------
                cropper = new Cropper(canvas,
                    {
                        aspectRatio: crop_aspect_ratio,
                        data: {width: canvas.width, height: canvas.width * crop_aspect_ratio},
                        crop: function (event) {
                            document.getElementById("image_x").value = event.detail.x;
                            document.getElementById("image_y").value = event.detail.y;
                            document.getElementById("image_w").value = event.detail.width;
                            document.getElementById("image_h").value = event.detail.height;
                        }
                    }
                );

                //-------------------------------- 解説6 ----------------------------------
                $('#close_button,#modal_back_area').click(function(){
                    const cropped_canvas = document.getElementById("cropped_canvas");
                    let ctx = cropped_canvas.getContext("2d");
                    let cropped_image_width = image.height * crop_aspect_ratio;
                    cropped_canvas.width = cropped_image_width * scale;
                    cropped_canvas.height = image.height * scale;

                    let image_x = document.getElementById("image_x").value;
                    let image_y = document.getElementById("image_y").value;
                    let image_w = document.getElementById("image_w").value;
                    let image_h = document.getElementById("image_h").value;
                    ctx.drawImage(image, image_x/scale, image_y/scale, image_w/scale , image_h/scale ,0 ,0 , cropped_canvas.width ,cropped_canvas.height);
                    document.getElementById("image_text").innerHTML = "選択した画像";
                    $('#user_icon').fadeOut();
                    document.getElementById("image").value = cropper.getCroppedCanvas().toDataURL('image/jpeg');
                    let base64 = cropper.getCroppedCanvas().toDataURL('image/jpeg');
                    var result = document.getElementById('result-img');
                    result.style.display = '';
                    result.src = base64;


                });
            }
        }
    }



    // アップローダーに画像が設定されるとcrop_imageを設定
    const uploader = document.getElementById('trim_img_uploder');
    uploader.addEventListener('change', crop_image);
});
