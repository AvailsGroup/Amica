import Cropper from "cropperjs";
import "jquery"
import "jquery-ui/ui/widget"
import "jquery-ui/ui/widgets/autocomplete"
import "tag-it"

document.addEventListener("DOMContentLoaded", function(){
    $('#header_trim_img_uploder').click(function(e){
        $(this).val('');
        document.getElementById("header_prev_img").style.display = '';
        document.getElementById("header_cropped_canvas").style.display = 'none';
        $('#user_header').fadeIn();
    });

    $('#header_trim_img_uploder').change(function(e){
        document.getElementById("header_prev_img").style.display = 'none';
        $('#header_modal_area').fadeIn();
        $('.header_modal-text').fadeOut();
       });

    let cropper = null;
    const scaled_width = 1920;
    const header_aspect_numerator = parseFloat(document.getElementById("header_aspect_numerator").value)
    const header_aspect_denominator = parseFloat(document.getElementById("header_aspect_denominator").value)
    const crop_aspect_ratio = header_aspect_denominator / header_aspect_numerator;

    const crop_image = function (e) {
        const files = e.target.files;
        if (files.length === 0) {
            return;
        }
        let file = files[0];
        let image = new Image();
        let reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function (e) {
            image.src = e.target.result;
            document.getElementById("header_source_canvas").src = image.src;
            image.onload = function () {

                let scale = scaled_width / image.width;
                const canvas = document.getElementById("header_source_canvas");
             /*  const test = document.getElementById("test");
                test.width = image.width * scale;
                test.height = image.height * scale;
                let ctx = test.getContext("2d");
                ctx.drawImage(image, 0, 0, image.width, image.height, 0, 0, canvas.width, canvas.height);*/
                if (cropper != null) {
                    cropper.destroy();
                }
                cropper = new Cropper(canvas,
                    {
                        aspectRatio: crop_aspect_ratio,
                        data: {width: canvas.width, height: canvas.width * crop_aspect_ratio},
                        crop: function (event) {
                            document.getElementById("header_image_x").value = event.detail.x;
                            document.getElementById("header_image_y").value = event.detail.y;
                            document.getElementById("header_image_w").value = event.detail.width;
                            document.getElementById("header_image_h").value = event.detail.height;
                        }
                    }
                )

                $('#close_button,#modal_back_area').click(function(){
                    const cropped_canvas = document.getElementById("header_cropped_canvas");
                    let ctx = cropped_canvas.getContext("2d");
                    let cropped_image_width = image.height * crop_aspect_ratio;
                    cropped_canvas.width = cropped_image_width * scale;
                    cropped_canvas.height = image.height * scale;

                    let image_x = document.getElementById("header_image_x").value;
                    let image_y = document.getElementById("header_image_y").value;
                    let image_w = document.getElementById("header_image_w").value;
                    let image_h = document.getElementById("header_image_h").value;
                    ctx.drawImage(image, image_x/scale, image_y/scale, image_w/scale , image_h/scale ,0 ,0 , cropped_canvas.width ,cropped_canvas.height);
                    document.getElementById("header_text").innerHTML = "選択したヘッダー";
                    $('#user_header').fadeOut();
                    document.getElementById("header").value = cropper.getCroppedCanvas().toDataURL('image/jpeg');
                    let header_base64 = cropper.getCroppedCanvas().toDataURL('image/jpeg');
                    var result = document.getElementById('header_result-img');
                    result.style.display = '';
                    result.src = header_base64;
                });
            }
        }
    }

    const uploader = document.getElementById('header_trim_img_uploder');
    uploader.addEventListener('change', crop_image);
});
