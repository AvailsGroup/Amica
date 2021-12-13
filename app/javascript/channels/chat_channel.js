import consumer from "./consumer"


const appRoom = consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    return alert(data['message']);
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

$(document).on('keypress', '[data-behavior~=chat_speaker]', function(event) {
  if (event.keyCode === 13) {
    appRoom.speak(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
});
window.addEventListener("keypress", function(event) {
  if (event.key === 'Enter'){
    appRoom.speak(event.target.value);
    event.target.value = '';
    event.preventDefault();
  }
})