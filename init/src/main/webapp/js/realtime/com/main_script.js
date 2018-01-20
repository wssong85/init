$(function() { 

$(".vertical_menu_list").stop().on("mouseenter",function() {
if ($(this).children("a").hasClass("close")) {
$(this).children("a").siblings("ul.vertical_menu_sub").stop().slideDown(500);
$(this).children("a").removeClass('close').addClass('open');
}
});

$(".vertical_menu_list").stop().on("mouseleave",function() {
if ($(this).children("a").hasClass("open")) {
$(this).children("a").siblings("ul.vertical_menu_sub").stop().slideUp(500);
$(this).children("a").removeClass('open').addClass('close');
}
});

});

