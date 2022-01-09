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
            const current_user = messages.data('user').id
            if(current_user === data[0].user_id){
                messages.append(data[1])
            }else{
                messages.append(data[2])
            }
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
