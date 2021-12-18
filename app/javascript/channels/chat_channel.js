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
        $('#append').append('<div class="message-body" style="white-space: pre;">'+
                              '<div class="sender my-1 p-1">' +
                                '<div class="messages">' +
                                  AutoLink(data.content)+
                                '</div>' +
                              '</div>'+
                            '</div>'+
                            '<div class="clear"></div>'+
                              '<span class="small" style="float: right">'+
                                 '今日 '+data.created_at.slice(11,16)+
                              '</span>'+
                            '<div class="clear"></div>'
        )
        bottom_scroll();
      } else {
        $('#append').append('<div class="message-body" style="white-space: pre;">'+
                              '<div class="receiver my-1 p-1">' +
                                '<div class="messages">' +
                                  data.content  +
                                '</div>' +
                              '</div>'+
                            '</div>'+
                            '<div class="clear"></div>'+
                              '<span class="small">'+
                              '今日 '+data.created_at.slice(11,16)+
                              '</span>'+
                            '<div class="clear"></div>'
        )
        bottom_scroll();
      }
    }
  },

  speak: function(message,room_id) {
    return this.perform('speak', {message: message,room_id: room_id});
  }
});

document.addEventListener("DOMContentLoaded", function() {
  const content = document.getElementById('content');
  const submitButton = document.getElementById('submit_button');
  const room_id = document.getElementById('room_id');

  //ブラウザがスクリーンサイズの50%以下or500px以下の時に相手の名前を消す
  const name = document.getElementById('user_name');
  let screen_50width = screen.availWidth * 0.5 ;
  window.addEventListener('resize', resizeWindow);
  function  resizeWindow(){
    let width_size = window.innerWidth;
      if (screen_50width > width_size || screen_50width * 2 < 500 ) {
        name.style.display = "none";
      } else {
        name.style.display = "";
      }
  }
  //改行や文字数に応じてtextareaを伸び縮みさせる
    let $textarea = $('#content');
    const lineHeight = parseInt($textarea.css('lineHeight'));
    // 最低行数を指定
    let minHeight = lineHeight;
    // 最高幅を指定
    let maxHeight = parseInt($(window).height() * 0.5);
    $textarea.on('input', function() {
      let lines = ($(this).val() + '\n').match(/\n/g).length;
      $(this).height(Math.min(maxHeight, Math.max(lineHeight * lines, minHeight)));
      if ( content.value === "") {
        $(this).height(0);
      }
    });
  //Shift+Enter or 紙飛行機ボタンでメッセ➖ジを送信させる
    $(document).on('keypress', '[data-behavior~=chat_speaker]', function(event) {
      if(event.shiftKey) {
        if (event.key === 'Enter' && event.target.value && event.target.value.match(/\S/g)) {
          ChatChannel.speak(event.target.value, room_id.value);
          bottom_scroll()
          event.target.value = '';
          $($textarea).height(0);
          return event.preventDefault();
        }
      }
    });
    $(submitButton).click('[data-behavior~=chat_speaker]', function () {
      if ( content.value && content.value.match(/\S/g)) {
        const message = content.value
        ChatChannel.speak(message, room_id.value);
        bottom_scroll()
        content.value = '';
        $($textarea).height(0);
        return content.preventDefault();
      }
    });
});

function AutoLink(str) {
  var regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g; // ']))/;
  var regexp_makeLink = function(all, url, h, href) {
    return '<a href="h' + href + '">' + url + '</a>';
  }
  return  str.replace(regexp_url, regexp_makeLink);


}

function bottom_scroll(){
  var elm = document.documentElement;
  var bottom = elm.scrollHeight - elm.clientHeight;
  window.scroll(0, bottom);
}