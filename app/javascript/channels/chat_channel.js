import consumer from "./consumer"

const appRoom = consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    return alert(data['message']);
  },

  speak: function(message) {
    return this.perform('speak', {message: message});
  }
});
window.addEventListener("keypress", function(e) {
  if (e.keyCode === 13) {
    appRoom.speak(e.target.value);
    e.target.value = '';
    e.preventDefault();
  }
})