/*$(document).ready(function() {
    $('#test').text('成功！！');
});*/

$(document).ready(function (){
    $(".title-image").fadeIn(1500,function (){
        $(".title-text").animate({opacity: 1},1000)
        $(".buttons").animate({opacity: 1},1000)
    })
});

