import consumer from "./consumer"

const ChatChannel =  consumer.subscriptions.create("ChatChannel", {
  connected() {
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
document.addEventListener("DOMContentLoaded", function() {
  const content = document.getElementById('content')
  const submitButton = document.getElementById('submit_button')
  const room_id = document.getElementById('room_id')

    let $textarea = $('#content');
    const lineHeight = parseInt($textarea.css('lineHeight'));
    // 最低行数を指定
    let minHeight = lineHeight * 2;
    // 最高幅を指定
    let maxHeight = parseInt($(window).height() * 0.5);
    $textarea.on('input', function() {
      let lines = ($(this).val() + '\n').match(/\n/g).length;
      $(this).height(Math.min(maxHeight, Math.max(lineHeight * lines, minHeight)));
      if ( content.value === "") {
        $(this).height(0);
      }
    });

    $(document).on('keypress', '[data-behavior~=chat_speaker]', function(event) {
      if(event.shiftKey) {
        if (event.key === 'Enter' && event.target.value !== "") {
          ChatChannel.speak(event.target.value, room_id.value);
          bottom_scroll()
          event.target.value = '';
          $($textarea).height(0);
          return event.preventDefault();
        }
      }
    });
    $(submitButton).click('[data-behavior~=chat_speaker]', function () {
      if ( content.value !== "") {
        const message = content.value
        ChatChannel.speak(message, room_id.value);
        bottom_scroll()
        content.value = '';
        $($textarea).height(0);
        return content.preventDefault();
      }
    });
});

function bottom_scroll(){
  var elm = document.documentElement;
  var bottom = elm.scrollHeight - elm.clientHeight;
  window.scroll(0, bottom);
}