/*$(document).ready(function() {
    $('#test').text('成功！！');
});*/

$(document).ready(function () {
    $(".title-image").fadeIn(1500, function () {
        $(".title-text").animate({opacity: 1}, 1000)
        $(".buttons").animate({opacity: 1}, 1000)
    })
});


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