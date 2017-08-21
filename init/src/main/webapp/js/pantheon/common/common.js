
/*LNB메뉴*/
$(function() { 

/*LNB 세로 끝까지 자동 늘리기*/
/*
var mainConHei = $("#mainCon").height();
var winHei = $(window).height() - 561; 

if ( winHei < mainConHei ) { $(".leftNav").height(mainConHei);}
else {$(".leftNav").height(winHei);}
*/

/*기본 메인메뉴ON*/
//$(".lnbLst:nth-of-type(2) > a").removeClass("lnbMusOut").addClass("lnbMusOn");

/*클릭시 서브메뉴 열기*/	
$(".lnbLst > a").on("click",function() {
if ($(this).hasClass("close")) {
$(this).siblings(".lnbSub").slideToggle(0);
$(this).toggleClass('open').removeClass("lnbMusOut").addClass("lnbMusOn");
$(this).children("div").removeClass('lnbArrow').addClass('lnbArrow_on');
/*
$(this).parent(".lnbLst").children(".lnbSub").children(".lnbSubLst:first").children("a").removeClass("lnbSubLstMusOut").addClass("lnbSubLstMusOn");
*/
}
});


/*클릭시 다른 열린 메뉴 닫기*/
$(".lnbLst").not(this).on("click",function() {
if ($(".lnbLst").not(this).children().hasClass("close")) {
$(".lnbLst").not(this).children(".lnbSub").slideUp(0);
/*
$(".lnbLst").not(this).children(".lnbSub").children(".lnbSubLst:first").children("a").addClass("lnbSubLstMusOut");
*/
}
});

/*클릭시 다른 열린 메뉴 css조정*/
$(".lnbLst > a").not(this).on("click",function() {
if ($(".lnbLst").not(this).children().hasClass("close")) {
$(".lnbLst > a").not(this).children("div").removeClass('lnbArrow_on').addClass('lnbArrow');
$(".lnbLst > a").not(this).removeClass("lnbMusOn").addClass("lnbMusOut");
/*
$(".lnbSubLst").not(this).children("a:first").not(this).removeClass("lnbSubLstMusOut").addClass("lnbSubLstMusOn");
*/
}
});

/*2뎁스메뉴*/

/*클릭시 해당 2뎁스 메뉴ON*/
$(".lnbSubLst").on("click",function() {
$(this).children("a").removeClass("lnbSubLstMusOut").addClass("lnbSubLstMusOn");
});
/*클릭시 해당 2뎁스 메뉴Out*/
$(".lnbSubLst").not(this).on("click",function() {
$(".lnbSubLst").not(this).children("a").removeClass("lnbSubLstMusOn").addClass("lnbSubLstMusOut");
});

});



/*탑무브*/
jQuery(document).ready(function() {  
	$('#topMove').hide();
	    $(window).on("scroll", function () {
        if ($(this).scrollTop() > 800) {
			$('#topMove').show().removeClass("topMove_off");
        } else {
            $('#topMove').addClass("topMove_off");
        }
    });
	$("#topMove").on("click", function() {
	$('html,body').animate({scrollTop:'0'},500);
});
});


/*셀렉트링크*/
$(function() {
$(".gnbSel").on("change",function(e){
 switch(e.currentTarget.selectedIndex){
  case 1: window.open("#"); 
  break;
  case 2: window.open("#"); 
  break; };
});
});

/*gnb셀렉트링크*/
$(function() {
/*
$(".gnbSelLst").on("click", function() {
$(".gnbSelSub").fadeToggle(400);
});
*/
  $(".gnbSelLst").stop().mouseenter(function(){
   $(".gnbSelSub").stop().fadeIn(400);
  });
  $(".gnbSelLst").stop().mouseleave(function(){
   $(".gnbSelSub").stop().fadeOut(400);
  });

/*로긴 랭귀지 셀렉트 링크*/
 $(".loginLagSel").stop().mouseenter(function(){
   $(".loginLagSelSub").stop().fadeIn(400);
  });
  $(".loginLagSel").stop().mouseleave(function(){
   $(".loginLagSelSub").stop().fadeOut(400);
  });

});

/*
 검색 엔터 처리 
 * */
$.fn.mkSearchEnter = function (Searchid) {
    this.bind("keypress", function (e) {
    	var code = e.which?e.which:event.keyCode
		if(code== 13){
			$('#'+Searchid).trigger('click');
		}
    });
    this.focus();
    return this;
};