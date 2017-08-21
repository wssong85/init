/*아코디언  열지 마시오.. 각 화면 복사 후 직접 구현하시오.*/
$(function() { 
  /*for(var ai=0; ai<3; ai++){
    aiP = ai+1;
    //console.log(aiP);

(function(aiE){ 
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

})(aiP); //반복문 적용끝

} //반복문끝
*/
});


/*팝업*/
$(document).ready(function() {

 var popNum = $(".popup").length;

  for(var pi=0; pi<popNum; pi++){
    piP = pi+1;
    //console.log(piP);

    // 팝업 버튼 클릭 이벤트
    (function(piE){ 
    $('.popup-button0'+piE+'').click(function() {
        $('.popup_bg, .popup0'+piE+'').fadeIn(500);
        AUIGrid.resize("#grid_wrap");
        AUIGrid.resize("#grid_wrap"+piE+"");
    });
    
    // 닫기 버튼 클릭 이벤트
    // fade시 남아있는 div가 다른 팝업에 영향을 줘서 주석처리함 
    // 2016.04.07 by wss
//    $('.popup_close').click(function() {
//        $('.popup_bg, .popup').fadeOut(500);
//    });
//    $('.popup_bg').click(function() {
//        $('.popup_bg, .popup').fadeOut(500);
//    });

    popupCenter(); // 첫 팝업 띄울때 center 정렬

    $(window).resize(function() {
        popupCenter();
    }); // 브라우저 창 사이즈 조절할 때도 항상 중앙 정렬

    function popupCenter() { // 팝업 center 정렬 함수
    var width = $('.popup0'+piE+'').width();
    var height = $('.popup0'+piE+'').height(); // 펍업 너비, 높이 변수 정의
    $('.popup0'+piE+'').css({
        'left': ($(window).width() - width) / 2 + "px",
        'top': ($(window).height() - height) / 2 + "px"
    }); // 팝업 중앙 위치 계산
    } // 팝업 center 정렬 함수 끝

})(piP);

} //반복문 끝

});


/*탭버튼*/
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
   var fileVal = $(this).val();
   console.log("fileVal : "+fileVal);
   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
});

});

/*진행상태바*/
$(function(){

$(".progBar").each(function() {
var progBar = $(this)
var progBarWd = $(this).css("width")
console.log(progBarWd)

setTimeout(function(){ 
progBar.css("width","0%");
}, 0);

setTimeout(function(){ 
progBar.animate({width:''+progBarWd+''},500);
}, 1000);

});

});

/*클릭버튼*/
$(function() {

$(".btnCl").click(function() {

if( $(this).hasClass("btnCl_on") ) {
$(this).addClass("btnCl_off").removeClass("btnCl_on")
} else {
$(this).addClass("btnCl_on").removeClass("btnCl_off")
}
});
});