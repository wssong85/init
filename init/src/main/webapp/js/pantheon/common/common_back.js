
/*아코디언*/
$(function() { 
  for(var ai=0; ai<3; ai++){
    aiP = ai+1;
    //console.log(aiP);

(function(aiE){
/*
$(".acdMenuLst0"+aiE+" > a").on("click",function() {
if ($(this).hasClass("close")) {
$(this).siblings(".acdMenuCts0"+aiE+"").slideToggle(500);
$(this).toggleClass('open');
}
});

if ( aiE !=2 ) {
$(".acdMenuLst0"+aiE+"").not(this).on("click",function() {
if ($(".acdMenuLst0"+aiE+"").not(this).children().hasClass("close")) {
$(".acdMenuLst0"+aiE+"").not(this).children(".acdMenuCts0"+aiE+"").slideUp(500);
}
});

$(".acdMenuLst0"+aiE+" > a").not(this).on("click",function() {
if ($(".acdMenuLst0"+aiE+" > a").hasClass('open')) {
$(".acdMenuLst0"+aiE+" > a").not(this).removeClass('open');
}
});
} //조건문끝
*/
})(aiP); //반복문 적용끝

} //반복문끝

});


/*아코디언01*/
/*
$(function() { 
$(".acdMenuLst01 > a").on("click",function() {
if ($(this).hasClass("close")) {
$(this).siblings(".acdMenuCts01").slideToggle(500);
$(this).toggleClass('open');
}
});

$(".acdMenuLst01").not(this).on("click",function() {
if ($(".acdMenuLst01").not(this).children().hasClass("close")) {
$(".acdMenuLst01").not(this).children(".acdMenuCts01").slideUp(500);
}
});

$(".acdMenuLst01 > a").not(this).on("click",function() {
if ($(".acdMenuLst01 > a").hasClass('open')) {
$(".acdMenuLst01 > a").not(this).removeClass('open');
}
});

});
*/


/*아코디언02*/
/*
$(function() { 
$(".acdMenuLst02 > a").on("click",function() {
if ($(this).hasClass("close")) {
$(this).siblings(".acdMenuCts02").slideToggle(500);
$(this).toggleClass('open');
}
});

});
*/

/*아코디언03*/
/*
$(function() { 
$(".acdMenuLst03 > a").on("click",function() {
if ($(this).hasClass("close")) {
$(this).siblings(".acdMenuCts03").slideToggle(500);
$(this).toggleClass('open');
}
});

$(".acdMenuLst03").not(this).on("click",function() {
if ($(".acdMenuLst03").not(this).children().hasClass("close")) {
$(".acdMenuLst03").not(this).children(".acdMenuCts03").slideUp(500);
}
});

$(".acdMenuLst03 > a").not(this).on("click",function() {
if ($(".acdMenuLst03 > a").hasClass('open')) {
$(".acdMenuLst03 > a").not(this).removeClass('open');
}
});

});
*/


/*팝업*/
$(document).ready(function() {

 var popNum = $(".popup").length;

  for(var pi=0; pi<popNum; pi++){
    piP = pi+1
    console.log(piP);

    // 팝업 버튼 클릭 이벤트
    (function(piE){ 
    $('.popup-button0'+piE+'').click(function() {
        $('.popup_bg, .popup0'+piE+'').fadeIn(500);
    });
    })(piP);

    // 닫기 버튼 클릭 이벤트
    $('.popup_close').click(function() {
        $('.popup_bg, .popup').fadeOut(500);
    });
    $('.popup_bg').click(function() {
        $('.popup_bg, .popup').fadeOut(500);
    });

    popupCenter(); // 첫 팝업 띄울때 center 정렬

    $(window).resize(function() {
        popupCenter();
    }); // 브라우저 창 사이즈 조절할 때도 항상 중앙 정렬

    function popupCenter() { // 팝업 center 정렬 함수
    var width = $('.popup0'+piP+'').width();
    var height = $('.popup0'+piP+'').height(); // 펍업 너비, 높이 변수 정의
    $('.popup0'+piP+'').css({
        'left': ($(window).width() - width) / 2,
        'top': ($(window).height() - height) / 2
    }); // 팝업 중앙 위치 계산
    } // 팝업 center 정렬 함수 끝

} //반복문 끝

});


/*제이쿼리UI*/
  $(function() {
    /*제이쿼리UI-달력*/
    $( ".datePicker" ).datepicker({
      showOn: "button",
      buttonImage: "../../../images/pantheon/common/dateIco.png",
      buttonImageOnly: true,
      buttonText: "Select date"
    });

/*제이쿼리UI숫자생성*/
$( ".spinner" ).spinner();
  });


/*파일선택*/
  $(function() {

$(".fileIuputHid").change(function(){
   var fileVal = $(this).val()
   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
});

});

/*진행상태바*/
$(function(){
$(".progBar").css("width","0%");

var progBarWd = $(".progBar").css("width");
console.log(progBarWd)

setTimeout(function(){ 
$(".progBar").animate({width:''+progBarWd+''},500);
}, 1000);

});



$(function() {
/*배경슬라이드-사이즈*/
function windowResize() {

	var winWid = $(window).width();
	var winHei = $(window).height();
  var conHei = $("#mainCon").height();

	$(".visualImg, .sstBtnBoxInner").width(winWid).height(winHei);
	$(".sstBtnBoxInner").css("max-width",winWid+"px")
  //$("#leftNav").css("height",conHei+"px")

//	console.log(winWid);

} windowResize();
$(window).resize(windowResize);

});

//탭버튼
$(document).ready(function(){

$(".tab_list > *").eq(0).show().siblings().hide();

for(var ti=0; ti<5; ti++){
tiP = ti+1
  $("#tab_menu"+tiP+"").click(function(){
   $(".tab_sub"+tiP+"").show();
   $("#tab_menu"+tiP+"").addClass("port_back");
  });
}

$("#tab ul li").click(function (){
 var tragetLi = $(this).index();
 $(this).addClass("port_back").siblings().removeClass("port_back");
 $(".tab_list > *").eq(tragetLi).show().siblings().hide();
});

});

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
$(".lnbLst:nth-of-type(2) > a").removeClass("lnbMusOut").addClass("lnbMusOn");

/*클릭시 서브메뉴 열기*/	
$(".lnbLst > a").on("click",function() {
if ($(this).hasClass("close")) {
$(this).siblings(".lnbSub").slideToggle(400);
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
$(".lnbLst").not(this).children(".lnbSub").slideUp(400);
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




/*반응형 칼럼단-여백-css연동*/
/*
$(function() {

var col = 6 // 칼럼갯수
var MgPct = 2 //마진 퍼센트
var colPct = 100 / col // 칼럼 퍼센트
var colMn = col - 1 //전체 마진 갯수
var colMsum = colMn * MgPct // 전체 마진갯수와 마진퍼센트를 곱해, 전체 마진퍼센트 계산
var colMresult = colPct - (colMsum/col) 
$(".colM").css("width",colMresult + "%").css("marginRight",MgPct + "%");
$(".colML").css("width",colMresult + "%"); 

function windowResize() {

var col_md = 2 // 칼럼갯수
var MgPct_md = 3 //마진 퍼센트
var colPct_md = 100 / col_md // 칼럼 퍼센트
var colMn_md = col_md - 1 //전체 마진 갯수
var colMsum_md = colMn_md * MgPct_md // 전체 마진갯수와 마진퍼센트를 곱해, 전체 마진퍼센트 계산
var colMresult_md = colPct_md - (colMsum_md/col_md) 

	if( $(window).width() < 1200 ) { 
		$(".colM_md").css("width",colMresult_md + "%").css("marginRight",MgPct_md + "%");
		$(".colML_md").css("width",colMresult_md + "%"); } 
	else {  }  
	}  

windowResize(); 
$(window).resize(windowResize); 

});
*/


