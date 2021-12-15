import consumer from "./consumer"

const ChatChannel =  consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log('connected')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    const user_id = document.getElementById("user_id").value
    const room_id = document.getElementById("room_id").value
    if (data.room_id === Number(room_id)){
      if (data.user_id === Number(user_id)) {
        $('#append').append('<div class="my-1 p-1 sender">' + '<div class="messages">'
            + '<p>' + data.content + '</p>' + '</div>' + '</div>' + ' <div class="clear"></div>' )
        bottom_scroll();
      } else {
        $('#append').append('<div class="my-1 p-1 receiver">' + '<div class="messages">'
            + '<p>' + data.content + '</p>' + '</div>' + '</div>' + ' <div class="clear"></div>')
        bottom_scroll();
      }
    }
  },

  speak: function(message,room_id) {
    return this.perform('speak', {message: message,room_id: room_id});
  }
});

$(document).on('keypress', '[data-behavior~=chat_speaker]', function(event) {
  if (event.key === 'Enter'&& event.target.value !== "") {
    const room_id =  document.getElementById("room_id").value
    ChatChannel.speak(event.target.value, room_id);
    bottom_scroll()
    event.target.value = '';
    return event.preventDefault();
  }
});

function bottom_scroll(){
  var elm = document.documentElement;
  var bottom = elm.scrollHeight - elm.clientHeight;
  window.scroll(0, bottom);
}