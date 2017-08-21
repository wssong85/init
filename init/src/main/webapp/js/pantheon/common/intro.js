

$(function() { 
    introWrap(); 

    $(window).resize(function() {
        introWrap();
    }); 

    function introWrap() { 
    var width = $('.sstBtn').width();
    $('.sstBtn').css({
        'left': ($(window).width() - width) / 2,
    }); 
    } 
});
