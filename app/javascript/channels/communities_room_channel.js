import consumer from "./consumer"

const CommunitiesRoomChannel = consumer.subscriptions.create("CommunitiesRoomChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received: function (data) {
        return $('#messages').append(data.content);
    },

    speak: function (message) {
        return this.perform('speak', {
            message: message
        });
    }
});


$(document).on('keypress', '[data-behavior~=communities_room_speaker]', function (event) {
    if (event.key === 'Enter') {
        CommunitiesRoomChannel.speak(event.target.value);
        event.target.value = '';
        return event.preventDefault();
    }
});

