window.addEventListener("DOMContentLoaded", function (utterance) {
    let partner_image = document.getElementById("partner_image").value

//もっとみるで前の50件を表示
    let messageHash = $('#messagesJson').data('messages');
    let startnum = Number(messageHash.length) - 50
    let num
    $('.morebtn').click(function () {
        startnum = startnum - 50
        if(startnum<0){
            num = startnum + 49
            startnum = 0
        }else {
            num = startnum + 49
        }
        messageHash.slice(startnum, num + 1).forEach(function () {
            const content = document.getElementById('content');
            let text = AutoLink(messageHash[num].content);
            if (messageHash[num].image !== null) {
                text = '<img style="max-width:100%" data-lity="data-lity" src="' + messageHash[num].url + '">';
            }

            if (messageHash[num].file_name !== null) {
                text = '<a href="' + messageHash[num].url + '" download="' + messageHash[num].file_name.slice(1,messageHash[num].file_name.length) + '">'
                    + messageHash[num].file_name.slice(1,messageHash[num].file_name.length) + '</a>'
            }

            if (partner_image === "") {
                partner_image = "/assets/default_icon.png"
            }
            let today = new Date();
            let time
            let send_time
            num > 0 ? send_time = new Date(messageHash[num].created_at) - new Date(messageHash[num - 1].created_at) : send_time = new Date(messageHash[num].created_at)
            let time_ber = ''
            let time_flag = document.getElementById(messageHash[num].created_at.slice(0, 10))
            if(Math.floor(send_time/1000/60/60/24) >= 1 || num === startnum){
                time_ber = '<div id="'+messageHash[num].created_at.slice(0, 10)+'" class="date">'+messageHash[num].created_at.slice(0, 10)+'</div>'
            }
            if(time_flag != null)time_flag.style.display="none";
            today = today.getFullYear() + "-" +  ("0" + (today.getMonth()+1)).slice(-2) + "-"+ ("0" + (today.getDate())).slice(-2)
            if (messageHash[num].created_at.slice(0, 10) === today) {
                 time = '今日 ' + messageHash[num].created_at.slice(11, 16)}
            else {
                time = messageHash[num].created_at.slice(11, 16)
            }


            let html = time_ber +
                '<div class="row message-body text-wrap" style="white-space: pre;">' +
                '<div class="col-sm-12 message-main-receiver" style=" position:relative;">' +
                '<a class="userLink" href="/profiles/' + content.dataset.partnerid + '">' +
                '<img class="icon bd-placeholder-img flex-shrink-0 me-2 mt-2" style="float: left" width="40px" height="40px" src=' + partner_image + '>' +
                '</a>' +
                '<div class="receiver my-1 p-1 mt-2" style="max-width: 40%;">' +
                '<div class="messages container p-1">' +
                text +
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
            if (Number(messageHash[num].user_id) === Number(content.dataset.userid)){
                html = time_ber+
                    '<div class="row message-body text-wrap" style="white-space: pre;">' +
                    ' <div class="col-sm-12 message-main-sender" style=" position:relative;">' +
                    '<div class="sender my-1 p-1 mt-2" style="max-width: 40%;">' +
                    '<div class="messages container p-1">' +
                    text +
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
        let link_text;
        link_text = str.replace(regexp_url, regexp_makeLink)
        return link_text.replace(/\r?\n/g, '<br>');
    }
})