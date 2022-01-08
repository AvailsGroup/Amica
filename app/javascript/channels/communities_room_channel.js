import consumer from "./consumer"

window.addEventListener("DOMContentLoaded", function () {
    const CommunitiesRoomChannel = consumer.subscriptions.create({
        channel: "CommunitiesRoomChannel",
        room: $('#messages').data('community')
    }, {
        connected() {
            // Called when the subscription is ready for use on the server
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received: function (data) {
            const messages = $('#messages')
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
                    ' <div class="col-sm-12 message-main-sender" style=" position:relative;">' +
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
            return messages.append(html);
        },

        speak: function (message, community_id) {
            return this.perform('speak', {
                message: message,
                community_id: community_id
            });
        }
    });


    $(document).on('keypress', '[data-behavior~=communities_room_speaker]', function (event) {
        if (event.key === 'Enter') {
            CommunitiesRoomChannel.speak(event.target.value, $("#messages").data('community'));
            event.target.value = '';
            return event.preventDefault();
        }
    });
})