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
    let partneruserid = document.getElementById("partner_userid").value
    let partnerimage = document.getElementById("partner_image").value
    if (data.room_id === Number(room_id)){
      if (data.user_id === Number(user_id)) {
        var content ="";
          if( data.image !== null){
            content = '<img style="max-width:100%" data-lity="data-lity" src="/chats/room'+room_id+'/'+data.image+'">';
          }else{
            content = AutoLink(data.content);
          }
        $('#append').append('<div class="row message-body" style="white-space: pre;">'+
                              ' <div class="col-sm-12 message-main-sender" style=" position:relative;">'+
                                  '<div class="sender my-1 p-1 mt-2" style="max-width: 40%;">' +
                                    '<div class="messages container p-1">' +
                                      content+
                                    '</div>' +
                                  '</div>'+
                                    '<div class="text-gray small sender_time">'+
                                     '今日 '+data.created_at.slice(11,16)+
                                    '</div>'+
                                 '</div>'+
                                '</div>'+
                                '<div class="clear"></div>'
        )
        bottom_scroll();
      } else {
        console.log(partnerimage)
        if (partnerimage === ""){
          partnerimage = "/assets/default_icon.png"
        }else {
          partnerimage = "/user_images/"+partnerimage
        }
        var content ="";
        if( data.image !== null){
          content = '<img style="max-width:100%" data-lity="data-lity" src="/chats/room'+room_id+'/'+data.image+'">';
        }else{
          content = AutoLink(data.content);
        }
      $('#append').append(
                            '<div class="row message-body" style="white-space: pre;">'+
                              '<div class="col-sm-12 message-main-receiver" style=" position:relative;">'+
                                '<a class="userLink" href="/profiles/'+ partneruserid + '">'+
                                '  <img class="icon bd-placeholder-img flex-shrink-0 me-2 mt-2" style="float: left" width="40px" height="40px" src='+ partnerimage+'>' +
                                '</a>'+
                                '<div class="receiver my-1 p-1 mt-2" style="max-width: 40%;">' +
                                  '<div class="messages container p-1">' +
                                     content+
                                  '</div>' +
                                '</div>'+
                               '<div class="text-gray small" style="float: left">' +
                                  '<p class="time">'+
                                  '今日 '+data.created_at.slice(11,16)+
                                  '</p>'+
                                '</div>'+
                              '</div>'+
                             '</div>'+
                            '<div class="clear"></div>'
        )
        bottom_scroll();
      }
    }
  },

  speak: function(message,room_id,send_image,uploaded_file) {
    return this.perform('speak', {message: message,room_id: room_id,send_image: send_image,uploaded_file: uploaded_file});
  }
});

window.addEventListener("DOMContentLoaded",function() {
  const content = document.getElementById('content');
  const room_id = document.getElementById('room_id');
  const images = document.getElementById('image_uploader')
  const send_image = document.getElementById('send_image')
  const files = document.getElementById('file_uploader')
  const send_file = document.getElementById('send_file')

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
    $('#submit_button').click('[data-behavior~=chat_speaker]', function () {
      if ( content.value && content.value.match(/\S/g)) {
        const message = content.value
        ChatChannel.speak(message, room_id.value);
        bottom_scroll()
        content.value = '';
        $($textarea).height(0);
        return content.preventDefault();
      }
    });
  $('#image_uploader').click(function(){
    send_image.value =""
    var canvas = $("#canvas");
    let base64
    $(this).val('');
    $(images).change(function() {
      var file = this.files[0];
      if (!file.type.match(/^image\/(png|jpeg|gif)$/)) return;
      var image = new Image();
      var reader = new FileReader();
      reader.onload = function(evt) {
        image.onload = function() {
          $(canvas).attr("width",image.width);
          $(canvas).attr("height",image.height);
          var ctx = canvas[0].getContext("2d");
          ctx.drawImage(image, 0, 0); //canvasに画像を転写
         　base64 =  canvas[0].toDataURL('image/jpeg');
         send_image.value = base64
        }
        image.src = evt.target.result;
      }
      reader.readAsDataURL(file);
    });
  });
  $('#image_submit_button').click('[data-behavior~=chat_speaker]', function () {
    if ( send_image.value != null ) {
      ChatChannel.speak(send_image.value,room_id.value);
      send_image.value = '';
      $($textarea).height(0);
      $('#imageModal').modal('hide');
      $('#image_uploader').val('');
      bottom_scroll()
    }
  });
  $('#file_uploader').click(function(){
    $(this).val('');
      const maxFileSize=10485760 //アップロードできる最大サイズを指定(1048576=1MB 10485760=10MB)
      $(files).change(function(){ //ファイルがアップロードされたら
        $(".error_msg").remove()　//エラーメッセージ削除
        let uploaded_file = $(this).prop('files')[0]; //アップロードファイル取得
        if(maxFileSize < uploaded_file.size){ //もし上限値を超えた場合
          $(this).val("")　//画像を空にする
          $(this).before("<p class='error_msg'>アップロードできる画像の最大サイズは10MBです</p>") //エラーメッセージ表示
        }else {
          $('#file_submit_button').click('[data-behavior~=chat_speaker]', function () {
            ChatChannel.speak(uploaded_file, room_id.value);
            $($textarea).height(0);
            $('#fileModal').modal('hide');
            $('#file_uploader').val('');
            bottom_scroll()
        })
      }
    });
  });
});

function AutoLink(str) {
  var regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g; // ']))/;
  var regexp_makeLink = function(all, url, h, href) {
    return '<a href="h' + href + '" target="_blank">' + url + '</a>';

  }
  let content;
      content = str.replace(regexp_url, regexp_makeLink)
     return  content.replace(/\r?\n/g, '<br>');

}

function bottom_scroll(){
  var elm = document.documentElement;
  var bottom = elm.scrollHeight - elm.clientHeight;
  window.scroll(0, bottom);
}