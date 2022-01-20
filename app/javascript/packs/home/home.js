import sal from "sal.js";

$(function (){
    sal();
    $(".JS_ScrollAnimationItem").each(function(){
        var position = $(this).offset().top;
        var scroll = $(window).scrollTop();
        var windowHeight = $(window).height();
        if (scroll > position - windowHeight){
            $(this).addClass('isActive');
        }
    });
})
