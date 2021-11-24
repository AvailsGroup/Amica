(function() {
    "use strict";
    var cropper, file, cropperFile, cropperPreview, cropperCanvas, cropperHeight, cropperWidth;
    kintone.events.on([
        'app.record.create.show',
        'app.record.edit.show',
    ], function(event){
        kintone.app.record.setFieldShown('添付ファイル', false);
        kintone.app.record.getSpaceElement('space').innerHTML = '<div class="control-label-gaia"><span class="control-label-text-gaia">添付ファイル</span></div><div id="cropperWrapper"><input id="cropperFile" type="file"><div class="cropperContent"><div id="cropperPreview"></div><p><span id="cropperHeight"></span>*<span id="cropperWidth"></span>px</p></div><div class="cropperContent"><div id="cropperCanvas"></div></div></div>';
        cropperFile = document.getElementById('cropperFile');
        cropperPreview = document.getElementById('cropperPreview');
        cropperCanvas = document.getElementById('cropperCanvas');
        cropperHeight = document.getElementById('cropperHeight');
        cropperWidth = document.getElementById('cropperWidth');
        if(event.type === 'app.record.edit.show'){
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '/k/v1/file.json?fileKey=' + event.record.添付ファイル.value[0].fileKey);
            xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
            xhr.responseType = 'blob';
            xhr.addEventListener('load', function(){
                var image = new Image();
                image.addEventListener('load', function(){
                    cropperPreview.appendChild(image);
                    cropperHeight.innerHTML = image.naturalHeight;
                    cropperWidth.innerHTML = image.naturalWidth;
                    document.getElementsByClassName('cropperContent')[0].style.display = 'block';
                });
                image.src = (window.URL || window.webkitURL).createObjectURL(xhr.response);
            });
            xhr.send();
        }
        cropperFile.addEventListener('change', function(e){
            var reader = new FileReader();
            file = e.target.files[0] || file;
            if(file.type.indexOf("image") < 0){
                return false;
            }
            reader.addEventListener('load', function(e){
                cropperCanvas.innerHTML = '<img src="' + e.target.result + '">';
                cropper = new Cropper(cropperCanvas.children[0], {
                    aspectRatio: 1,
                    preview: cropperPreview
                });
                cropperCanvas.children[0].addEventListener('crop', function(e){
                    cropperHeight.innerHTML = Math.floor(e.detail.height);
                    cropperWidth.innerHTML = Math.floor(e.detail.width);
                });
                [].forEach.call(document.getElementsByClassName('cropperContent'), function(element){
                    element.style.display = 'block';
                });
            });
            reader.readAsDataURL(file);
        });
    });
    kintone.events.on([
        'app.record.create.submit.success',
        'app.record.edit.submit.success',
    ], function(event){
        if(!file) return event;
        return new kintone.Promise(function(resolve){
            cropper.getCroppedCanvas().toBlob(function(blob){
                var formData = new FormData();
                var xhr = new XMLHttpRequest();
                formData.append('__REQUEST_TOKEN__', kintone.getRequestToken());
                formData.append('file', blob, file.name);
                xhr.open('POST', encodeURI('/k/v1/file.json'));
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.addEventListener('load', function(){
                    kintone.api('/k/v1/record', 'PUT', {
                        app: kintone.app.getId(),
                        id: event.recordId,
                        record: {
                            添付ファイル: {
                                value: [
                                    {fileKey: JSON.parse(xhr.responseText).fileKey}
                                ]
                            }
                        }
                    }).then(function(){
                        resolve(event);
                    });
                });
                xhr.send(formData);
            }, file.type);
        });
    });
})();
// ポリフィル(参考URL:https://developer.mozilla.org/ja/docs/Web/API/HTMLCanvasElement/toBlob)
if(!HTMLCanvasElement.prototype.toBlob){
    Object.defineProperty(HTMLCanvasElement.prototype, 'toBlob', {
        value: function(callback, type, quality){
            var binStr = atob(this.toDataURL(type, quality).split(',')[1]),
                len = binStr.length,
                arr = new Uint8Array(len);
            for(var i=0; i<len; i++ ){
                arr[i] = binStr.charCodeAt(i);
            }
            callback(new Blob([arr], {type: type || 'image/png'}));
        }
    });
}