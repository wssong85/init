
$(function() { 
    loginWrap(); 

    $(window).resize(function() {
        loginWrap();
    }); 

    function loginWrap() { 
    var width = $('#loginWrap').width();
    var height = $('#loginWrap').height(); 
    $('#loginWrap').css({
        'left': ($(window).width() - width) / 2,
        'top': ($(window).height() - height) / 2
    }); 
    } 
});