import consumer from "./consumer"

window.addEventListener("DOMContentLoaded", function (utterance) {
    const content = $('#community_content')

    const CommunitiesRoomChannel = consumer.subscriptions.create({
        channel: "CommunitiesRoomChannel",
        room: $('#community_messages').data('community')
    }, {
        connected() {
            // Called when the subscription is ready for use on the server
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received: function (data) {
            const messages = $('#community_messages')
            const current_user = messages.data('user')
            const current_user_image = messages.data('user-image')
            let html = '<div class="row message-body text-wrap" style="white-space: pre;">' +
                '<div class="col-sm-12 message-main-receiver" style=" position:relative;">' +
                '<a class="userLink" href="/profiles/' + current_user.userid + '">' +
                '<img class="icon bd-placeholder-img flex-shrink-0 me-2 mt-2" style="float: left" width="40px" height="40px" src=' + current_user_image + '>' +
                '</a>' +
                '<div class="receiver my-1 p-1 mt-2" style="max-width: 40%;">' +
                '<div class="messages container p-1">' +
                data.content +
                '</div>' +
                '</div>' +
                '<div class="text-gray small" style="float: left">' +
                '<p class="time">' +
                '今日 ' + data.created_at.slice(11, 16) +
                '</p>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="clear"></div>'

            if (data.user_id === current_user.id) {
                html =
                    '<div class="row message-body text-wrap" style="white-space: pre;">' +
                    '<div class="col-sm-12 message-main-sender" style=" position:relative;">' +
                    '<div class="sender my-1 p-1 mt-2" style="max-width: 40%;">' +
                    '<div class="messages container p-1">' +
                    data.content +
                    '</div>' +
                    '</div>' +
                    '<div class="text-gray small sender_time h-100" style="padding-bottom: 5px">' +
                    '今日 ' + data.created_at.slice(11, 16) +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="clear"></div>'
            }
            messages.append(html);
            bottom_scroll()
        },

        speak: function (message, community_id, type) {
            return this.perform('speak', {
                message: message,
                community_id: community_id
            });
        }
    });

    const lineHeight = parseInt(content.css('lineHeight'));
    let minHeight = lineHeight;
    let maxHeight = parseInt($(window).height() * 0.5);
    content.on('input', function () {
        let lines = ($(this).val() + '\n').match(/\n/g).length;
        $(this).height(Math.min(maxHeight, Math.max(lineHeight * lines, minHeight)));
        if (content.val() === "") {
            $(this).height(0);
        }
    });


    $(document).on('keypress', '[data-behavior~=communities_room_speaker]', function (event) {
        if (event.shiftKey) {
            if (event.key === 'Enter' && content.val()) {
                sendText()
                return false;
            }
        }
    });

    $('#community_submit_button').click('[data-behavior~=communities_room_speaker]', function () {
        if (content.val() && content.val().match(/\S/g)) {
            sendText()
        }
    });


    function sendText() {
        const content = $('#community_content')
        //$(file_uploader).val('');
        CommunitiesRoomChannel.speak(content.val(), $("#community_messages").data('community'), 'text');
        bottom_scroll()
        content.val('');
        content.height(0);
    }

    function bottom_scroll() {
        var elm = document.documentElement;
        var bottom = elm.scrollHeight - elm.clientHeight;
        window.scroll(0, bottom);
    }
});
