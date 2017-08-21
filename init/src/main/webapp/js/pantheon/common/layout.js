
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


