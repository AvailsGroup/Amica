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
          content = '<img style="max-width:100%" data-lity="data-lity" src="' + data.url +'">';
        }else if (data.file_name !== null) {
          content ='<a href="'+data.url +'" download="'+ data.file_name.substr(1) +'">'+data.file_name.substr(1)+'</a>'
        }else{
          content = AutoLink(data.content);
        }

        $('#append').append(
            '<div class="row message-body text-wrap " style="white-space: pre;">'+
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
        if( data.image !== null){
          content = '<img style="max-width:100%" data-lity="data-lity" src="'+url_for()+'">';
        }else if (data.file_name !== null) {
          content = '<a href="/chats/room1/files/' + data.file_name +'" download="'+ data.file_name +'">'+data.file_name+'</a>'
        }else{
          content = AutoLink(data.content);
        }
        $('#append').append(
            '<div class="row message-body text-wrap " style="white-space: pre;">'+
            '<div class="col-sm-12 message-main-receiver" style=" position:relative;">'+
            '<a class="userLink" href="/profiles/'+ partneruserid + '">'+
            '<img class="icon bd-placeholder-img flex-shrink-0 me-2 mt-2" style="float: left" width="40px" height="40px" src='+ partnerimage+'>' +
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
  const file_uploader = document.getElementById('file_uploader')
  const preview = document.getElementById("preview")

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
      if (event.key === 'Enter' && content.value) {
        $(file_uploader).val('');
        ChatChannel.speak(content.value, room_id.value);
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


  $('#file_button').click(function(){
    preview.style.display="none";
    preview.src = null
    $(file_uploader).val('');
  });
  $(file_uploader).click(function (){
    preview.style.display="none";
    preview.src = null
    $(this).val('');
  });
  $(file_uploader).change(function() {
    if($(file_uploader).prop('files')[0].type.match(/^image\/(png|jpeg|gif)$/)) {
      preview.style.display="";
      var fileReader = new FileReader();
      fileReader.onload = (function() {
        preview.src = fileReader.result;
      });
      fileReader.readAsDataURL(this.files[0]);
    }
  });
  $('#file_submit_button').click('[data-behavior~=chat_speaker]', function () {
    const maxFileSize=10485760 //アップロードできる最大サイズを指定(1048576=1MB 10485760=10MB)
    let val = null
    $(".error_msg").remove()　//エラーメッセージ削除
    let file = $(file_uploader).prop('files')[0];
    if (maxFileSize < file.size) {
      $(file_uploader).val("")
      $(file_uploader).before("<p class='error_msg'>アップロードできる最大サイズは10MBです</p>") //エラーメッセージ表示
    }else{
      $(file_uploader).click(function () {
        $(this).val("")
      })
      let reader = new FileReader;
      reader.readAsDataURL(file);
      reader.onload = function() {
        val = reader.result;
        let file_name = file.name
        val = val + "@" + file_name
        ChatChannel.speak(val, room_id.value);
        $($textarea).height(0);
        $('#fileModal').modal('hide');
        $('#file_uploader').val('');
        files_bottom_scroll()
      }
    }
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

function files_bottom_scroll(){
  window.addEventListener('load', function (){
    var elm = document.documentElement;
    var bottom = elm.scrollHeight - elm.clientHeight;
    window.scroll(0, bottom);
  })
}

function bottom_scroll(){
  var elm = document.documentElement;
  var bottom = elm.scrollHeight - elm.clientHeight;
  window.scroll(0, bottom);
}

