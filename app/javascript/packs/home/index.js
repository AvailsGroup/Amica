import { animon } from 'animon';
import "cookieconsent"

$(document).ready(function () {
    animon();
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

    $(".goSection").on("click", function() {
        const scrollTarget = $(this)[0].attributes[1].nodeValue;
        const offsetTop = $(scrollTarget).offset().top;
        $("html, body").animate({ scrollTop: offsetTop }, 600);
        return false;
    });
});
