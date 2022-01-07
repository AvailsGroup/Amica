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
            return $('#messages').append(data);
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