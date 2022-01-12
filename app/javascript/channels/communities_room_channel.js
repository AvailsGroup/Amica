import consumer from "./consumer"

window.addEventListener("DOMContentLoaded", function (utterance) {
    const content = $('#community_content')
    const upload = $('#file_uploader')
    const preview = $('#preview')
    const messages = $("#community_messages")
    const community = messages.data('community')
    const maxFileSize = 10485760

    const CommunitiesRoomChannel = consumer.subscriptions.create({
        channel: "CommunitiesRoomChannel",
        room: community
    }, {
        connected() {
            // Called when the subscription is ready for use on the server
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received: function (data) {
            if (messages.data('user') === data[0].user_id) {
                messages.append(data[1])
            } else {
                messages.append(data[2])
            }
            bottom_scroll()
        },

        speak: function (message, community_id, type) {
            return this.perform('speak', {
                message: message,
                community_id: community_id,
                type: type
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


    $(document).on('keypress', '[data-behavior~=communities_room_speaker]', function (event) {
            if (event.shiftKey && event.key === 'Enter' && content.val()) {
                sendText()
                return false;
            }

    });

    $('#community_submit_button').click('[data-behavior~=communities_room_speaker]', function () {
        if (content.val() && content.val().match(/\S/g)) {
            sendText()
        }
    });

    $('#community_file_submit_button').click('[data-behavior~=communities_room_speaker]', function () {
        $(".error_msg").remove()
        let file = upload.prop('files')[0];
        if (!checkFileSize(file.size)) return;
        upload.click(function () {
            $(this).val("");
        })
        sendFile(file)
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

    function sendText() {
        upload.val('');
        CommunitiesRoomChannel.speak(content.val(), community, 'text');
        bottom_scroll()
        content.val('');
        content.height(0);
    }

    function sendFile(file) {
        let reader = new FileReader;
        reader.readAsDataURL(file);
        reader.onload = function () {
            let file_name = file.name;
            let value = reader.result + "@" + file_name;
            CommunitiesRoomChannel.speak(value, community, 'file');
            content.height(0);
            $('#fileModal').modal('hide');
            preview.val('');
            bottom_scroll()
        }
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

    function checkFileSize(size) {
        if (maxFileSize < size) {
            upload.val("");
            upload.before("<p class='error_msg'>アップロードできる最大サイズは10MBです</p>")
            return false;
        }
        return true;
    }

    function bottom_scroll() {
        const elm = document.documentElement;
        const bottom = elm.scrollHeight - elm.clientHeight;
        window.scroll(0, bottom);
    }
});
