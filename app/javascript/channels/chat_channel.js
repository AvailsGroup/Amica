import consumer from "./consumer"

const ChatChannel = consumer.subscriptions.create("ChatChannel", {
        connected() {
            // Called when the subscription is ready for use on the server
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

    received: function (data) {
        const content = document.getElementById('content');
            if(Number(data[0].room_id) ===  Number(content.dataset.roomid)) {
                const messages = $('#messages');
                const current_user = content.dataset.userid
                if (Number(current_user) === Number(data[0].user_id)) {
                    messages.append(data[1])
                } else {
                    messages.append(data[2])
                }
                bottom_scroll()
            }
     },

            speak: function (message, room_id, file_name, type, file = null) {
                return this.perform('speak', {
                    message: message,
                    room_id: room_id,
                    file_name: file_name,
                    type: type,
                    file: file
                });
            }
        });

    content.on('input', function () {
        const lineHeight = parseInt(content.css('lineHeight'));
        let minHeight = lineHeight;
        let maxHeight = parseInt($(window).height() * 0.5);
        let lines = ($(this).val() + '\n').match(/\n/g).length;
        $(this).height(Math.min(maxHeight, Math.max(lineHeight * lines, minHeight)));
        if (content.val() === "") {
            $(this).height(0);
        }
    });

    $(document).on('keypress', '[data-behavior~=chat_speaker]', function (event) {
        if (event.shiftKey && event.key === 'Enter' && content.val()) {
            sendText()
            return false;
        }
    });

    $('#submit_button').click('[data-behavior~=chat_speaker]', function () {
        if (content.val() && content.val().match(/\S/g)) {
            sendText()
        }
    });

    $('#file_button').click(function () {
        initFileModal()
    });

    upload.click(function () {
        initFileModal()
    });

    upload.change(function () {
        if (checkImageFormat()) previewImage()
    });

    $('#file_submit_button').click('[data-behavior~=chat_speaker]', function () {
        $(".error_msg").remove()
        let file = upload.prop('files')[0];
        if (!checkFileSize(file.size)) return;
        upload.click(function () {
            $(this).val("");
        })
        sendFile(file)
    });
});

function files_bottom_scroll() {
    window.addEventListener('load', function () {
        var elm = document.documentElement;
        var bottom = elm.scrollHeight - elm.clientHeight;
        window.scroll(0, bottom);
    })
}

function bottom_scroll() {
    var elm = document.documentElement;
    var bottom = elm.scrollHeight - elm.clientHeight;
    window.scroll(0, bottom);
}

    function sendFile(file) {
        let reader = new FileReader;
        reader.readAsDataURL(file);
        reader.onload = function () {
            let value = reader.result;
            ChatChannel.speak(checkImageFormat() ? 'image' : 'file', room_id, file.name, checkImageFormat() ? 'image' : 'file', value);
            content.height(0);
            $('#fileModal').modal('hide');
            $('#preview').val('');
            bottom_scroll()
        }
    }

    function checkFileSize(size) {
        if (maxFileSize < size) {
            upload.val("");
            upload.before("<p class='error_msg'>アップロードできる最大サイズは10MBです</p>")
            return false;
        }
        return true;
    }

    function initFileModal() {
        preview.css("display", "none");
        preview.attr("src", null);
        upload.val('');
    }

    function checkImageFormat() {
        return upload.prop('files')[0].type.match(/^image\/(png|jpeg|gif)$/)
    }

    function previewImage() {
        preview.css("display", "")
        const fileReader = new FileReader();
        fileReader.onload = (function () {
            preview.attr("src", fileReader.result);
        });
        fileReader.readAsDataURL(upload.prop('files')[0]);
    }
});
