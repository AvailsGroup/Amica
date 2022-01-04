window.addEventListener("DOMContentLoaded", function (utterance) {
    const user_id = document.getElementById('user_id');
    let partner_userid = document.getElementById("partner_userid").value
    let partner_image = document.getElementById("partner_image").value

//もっとみるで前の50件を表示
    let messageHash = $('#messagesJson').data('messages');
    let startnum = Number(messageHash.length) - 5
    $('.morebtn').click(function () {
        startnum = startnum - 5
        let num = startnum + 4
        messageHash.slice(startnum, startnum + 5).forEach(function () {
            let content = AutoLink(messageHash[num].content);
            if (messageHash[num].image !== null) {
                content = '<img style="max-width:100%" data-lity="data-lity" src="' + messageHash[num].url + '">';
            }

            if (messageHash[num].file_name !== null) {
                content = '<a href="' + messageHash[num].url + '" download="' + messageHash[num].file_name + '">' + messageHash[num].file_name + '</a>'
            }

            if (partner_image === "") {
                partner_image = "/assets/default_icon.png"
            }
            let today = new Date();
            let time
            let send_time = new Date(messageHash[num].created_at) - new Date(messageHash[num - 1].created_at)
            let time_ber = ''
            if(Math.floor(send_time/1000/60/60/24) >= 1 || num === startnum){
                time_ber = '<div id="'+messageHash[num].created_at.slice(0, 10)+'" class="date">'+messageHash[num].created_at.slice(0, 10)+'</div>'
            }
            today = today.getFullYear() + "-" +  ("0" + (today.getMonth()+1)).slice(-2) + "-"+ ("0" + (today.getDate())).slice(-2)
            if (messageHash[num].created_at.slice(0, 10) === today) {
                 time = '今日 ' + messageHash[num].created_at.slice(11, 16)}
            else {
                time = messageHash[num].created_at.slice(11, 16)
            }


            let html = time_ber+
                '<div class="row message-body text-wrap" style="white-space: pre;">' +
                '<div class="col-sm-12 message-main-receiver" style=" position:relative;">' +
                '<a class="userLink" href="/profiles/' + partner_userid + '">' +
                '<img class="icon bd-placeholder-img flex-shrink-0 me-2 mt-2" style="float: left" width="40px" height="40px" src=' + partner_image + '>' +
                '</a>' +
                '<div class="receiver my-1 p-1 mt-2" style="max-width: 40%;">' +
                '<div class="messages container p-1">' +
                content +
                '</div>' +
                '</div>' +
                '<div class="text-gray small" style="float: left">' +
                '<p class="time">' +
                time +
                '</p>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div class="clear"></div>'
            if (Number(messageHash[num].user_id) === Number(user_id.value)){
                html = time_ber+
                    '<div class="row message-body text-wrap" style="white-space: pre;">' +
                    ' <div class="col-sm-12 message-main-sender" style=" position:relative;">' +
                    '<div class="sender my-1 p-1 mt-2" style="max-width: 40%;">' +
                    '<div class="messages container p-1">' +
                    content +
                    '</div>' +
                    '</div>' +
                    '<div class="text-gray small sender_time h-100" style="padding-bottom: 5px">' +
                    time +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="clear"></div>'
            }

                $(html).prependTo('#messages');

            num = num - 1
        })
    })
    function AutoLink(str) {
        var regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g;
        var regexp_makeLink = function (all, url, h, href) {
            return '<a href="h' + href + '" target="_blank">' + url + '</a>';
        }
        let content;
        content = str.replace(regexp_url, regexp_makeLink)
        return content.replace(/\r?\n/g, '<br>');
    }
})