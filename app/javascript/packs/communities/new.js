function previewImage(obj) {
    var fileReader = new FileReader();
    fileReader.onload = function() {
        document.getElementById('preview').src = fileReader.result;
    };
    fileReader.readAsDataURL(obj.files[0]);
}