import "cookieconsent"

/*$(document).ready(function() {
    $('#test').text('成功！！');
});*/

$(document).ready(function () {
    $('#title-image').animate({paddingRight: 1}, {
        duration: 1000,
        step: function (now) {
            $(this).css({transform: 'scale(' + now + ')'});
        },
        complete: function () {
            $('#title-image').css('paddingRight', 0);
            $('#step').fadeIn(1000);
            $('#arrow').fadeIn(1000);
        },
    });
});


$(function () {
    window.cookieconsent.initialise({
        "palette": {
            "popup": {
                "background": "#252e39"
            },
            "button": {
                "background": "transparent",
                "text": "#14a7d0",
                "border": "#14a7d0"
            }
        },
        "content": {
            "message": "当サイトではCookieを使用します。「同意する」をクリックすると、当サイトでのCookieの使用を同意することになります。",
            "dismiss": "同意する",
            "link": "プライバシーポリシー",
            "href": "/privacy"
        }
    });
})