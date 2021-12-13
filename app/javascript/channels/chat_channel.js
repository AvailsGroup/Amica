import consumer from "./consumer"

// 「const appRoom =」を追記
const appRoom = consumer.subscriptions.create("RoomChannel", {
  // 省略

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