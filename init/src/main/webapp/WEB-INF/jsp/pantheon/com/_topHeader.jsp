<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>
$(document).ready(function() {
	$('body').keydown(function(event){
		resetTime();		
	});
	$('body').mousemove(function(event){
		resetTime();
	});
});

var globalInterval = setInterval(convertTime, 1000);

function convertTime() {
	var test = $('#headerTimeData').text();
	var test2 = test.split(':');
	var test3 = (test2[0] * 60) + test2[1] * 1;
	
	if(!test3) {
		location.href = '/com/i01/pantheonLogout.do';
	}
	
	var test4 = '';
	var test5 = '';
	
	test3 = test3 - 1;
	
	if(test3%60 < 10) {
		test4 = '0' + test3%60; 
	} else {
		test4 = test3%60;
	}
	
	if(parseInt(test3/60) < 10) {
		test5 = '0' + parseInt(test3/60); 
	} else {
		test5 = parseInt(test3/60);
	}
	
	$('#headerTimeData').text(test5 + ':' + test4);   	
}

function resetTime() {
	var test = $('#headerTimeData').text();
	var test2 = test.split(':');
	var test3 = (test2[0] * 60) + test2[1] * 1;
	
	if(test3 < 1740) {
		$('#headerTimeData').text('30:00');	
	}
}





</script>




<style>
.gnb_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.gnb_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>





<script type="text/javascript">


var testData_gnb =[
{
  "과제명":"XXX 연구과제 1",
  "과제번호":"Cj_xxx_xx1",
  "과제유형":"임상"
}, {
  "과제명":"XXX 연구과제 1",
  "과제번호":"Cj_xxx_xx1",
  "과제유형":"임상"
}, {
  "과제명":"XXX 연구과제 1",
  "과제번호":"Cj_xxx_xx1",
  "과제유형":"임상"
}, {
  "과제명":"XXX 연구과제 1",
  "과제번호":"Cj_xxx_xx1",
  "과제유형":"임상"
}, {
  "과제명":"XXX 연구과제 1",
  "과제번호":"Cj_xxx_xx1",
  "과제유형":"임상"
}, {
  "과제명":"XXX 연구과제 1",
  "과제번호":"Cj_xxx_xx1",
  "과제유형":"임상"
}];




var myGridOption_gnb = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption_gnb.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap_gnb'
  },
  //데이터 연계 옵션
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    //페이징 true, false 로 지정
    paging: true,
    //처음 시작시 데이터 로딩
    autoLoad: true,
  },
  //AUI 그리드 옵션
  gridPros: {
    // 페이징 사용
    //usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    //showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",
    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "과제명",
    headerText : "과제명"

  },{
    dataField : "과제번호",
    headerText : "과제번호",
    width : 110,
    style : "gnb_column_style"
  },{
    dataField : "과제유형",
    headerText : "과제유형",
    width : 100
  
  }],


  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
    if(me.proxy.autoLoad) {
      me.load();
    }

    //me.createPagingNavigator(1);
  },
  //AUI 그리드 이벤트 
  binding: function() {
    
  },
  //AUI 그리드 데이터 요청
  load: function(v1, v2) {
    var me = this;
   
    AUIGrid.setGridData(me.id, testData_gnb);

  }
};


$(document).ready(function() {
  myGridOption_gnb.createGrid();
  
});


window.onresize = function() {
 if (typeof myGridOption_gnb.id !== "undefined") {
   AUIGrid.resize(myGridOption_gnb.id);
   }
};


$(function(){
	//모듈/과제
	$('.gnb_01, .gnb_icon_01').click(function(){
		$('.gnb_01').toggleClass("gnb_on_01");
		$('.gnb_icon_01').toggleClass("gnb_icon_on_01");
		$('.gnb_detail_01').fadeToggle(400);
		$(".detail_in_01").scrollTop(0);
		AUIGrid.resize(myGridOption_gnb.id);

	});
	
	$('.gnb_close_01').click(function(){
		$(this).parent().fadeOut(400);
		$('.gnb_01').removeClass("gnb_on_01");
		$('.gnb_icon_01').removeClass("gnb_icon_on_01");
	});
	
	//$('.gnb_01').trigger('click');



	//바로가기
	$('.gnb_02').hover(function(){
		$('.gnb_02').toggleClass("gnb_on_02");
		$('.gnb_icon_02').toggleClass("gnb_icon_on_02");
		$('.gnb_detail_02').stop().fadeToggle(400);
	});
	
	
	//설정
	$('.gnb_03').click(function(){
		mkLayerPopupOpen('/sample/page/_COMZ0101.do', {
			'REQUST_NM': '테스트결재',
			'callbackFunction': 'f_requestRequstNo_1'
		}, 1);
	});
	
	
});




</script>









<header id="topHeader">

	<a href="<c:url value='/com/i01/intro.do'/>" ><img id="logo" src="<c:url value='/images/pantheon/common/logo.png'/>" alt=""></a>
	
	<nav id="topMenu">
		<ul class="gnb">
			<a href="<c:url value='/com/i01/intro.do'/>" ><li><div class="gnbIco gnbIco01"></div><span>Home</span></li></a>
			
			<li>
				<div class="gnbIco gnbIco02 gnb_icon_01"></div>
				<span class="gnb_01">모듈/과제</span>
				<div class="gnb_detail_01">
					<div class="arrow00"></div>
					<a href="#" class="gnb_close_01">×</a>
					<div class="detail_in_01">
						<table class="in_001">
							<colgroup>
								<col width="18%">
								<col width="">
								<col width="15%">
							</colgroup>
							<tr>
								<th>모듈</th>
								<td colspan="2">
								<table class="in_002">
								<colgroup>
									<col width="">
									<col width="36%">
									<col width="34%">
								</colgroup>
									<tr>
										<td><input type="radio" id="r01" name="aa" checked><label for="r01" class="raLab"><span>CTMS 전체</span></label></td>
										<td><input type="radio" id="r02" name="aa"><label for="r02" class="raLab"><span>CTMS 과제선택</span></label></td>
										<td><input type="radio" id="r03" name="aa"><label for="r03" class="raLab"><span>CTMS 업무종료</span></label></td>
									</tr>
									<tr>
										<td><input type="radio" id="r04" name="aa"><label for="r04" class="raLab"><span>EDC</span></label></td>
										<td><input type="radio" id="r05" name="aa"><label for="r05" class="raLab"><span>IWRS</span></label></td>
										<td><input type="radio" id="r06" name="aa"><label for="r06" class="raLab"><span>Safety DB</span></label></td>
									</tr>
									<tr>
										<td><input type="radio" id="r07" name="aa"><label for="r07" class="raLab"><span>DM Center</span></label></td>
										<td><input type="radio" id="r08" name="aa"><label for="r08" class="raLab"><span>시스템관리</span></label></td>
										<td></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<th>과제명</th>
								<td><input type="text" style="width:100%;"></td>
								<td rowspan="2">
									<input type="button" class="gnb_big_button_01" value="검색">
								</td>
							</tr>
							<tr>
								<th>과제번호</th>
								<td><input type="text" style="width:100%;"></td>
							</tr>
						</table>
						<div class="detail_in_001">
							<div id="grid_wrap_gnb" class="gridHeiSz05 grid_wrap tb01_2"></div>
						</div>
					</div>
				</div>
			</li>
			
			<li><div class="gnbIco gnbIco02"></div><span><spring:message code="global.lang" /></span></li>
			<li><div class="gnbIco gnbIco02"></div><span>${pageContext.response.locale}2</span></li>
			
			<li>
				<ul class="gnbSel">
					<li class="gnbSelLst">
						<c:if test="${pageContext.response.locale eq 'kr'  || pageContext.response.locale eq 'ko_KR'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>Korean</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						<c:if test="${pageContext.response.locale eq 'jp'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>日本語</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						<c:if test="${pageContext.response.locale eq 'en'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>ENGLISH</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<c:if test="${pageContext.response.locale eq 'ch_1'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>簡体中文</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<c:if test="${pageContext.response.locale eq 'ch_2'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>繁体中文</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<ul class="gnbSelSub">
							<div class="arrow01"></div>
							<li class="gnbSelSubLst"><a href="/com/anonymous/changeLocale.do?locale=kr&URL=${LOCALE_RETURN}">Korean</a></li>
							<li class="gnbSelSubLst"><a href="/com/anonymous/changeLocale.do?locale=en&URL=${LOCALE_RETURN}">ENGLISH</a></li>
							<li class="gnbSelSubLst"><a href="/com/anonymous/changeLocale.do?locale=jp&URL=${LOCALE_RETURN}">日本語</a></li>
							<li class="gnbSelSubLst"><a href="/com/anonymous/changeLocale.do?locale=ch_1&URL=${LOCALE_RETURN}">簡体中文</a></li>
							<li class="gnbSelSubLst"><a href="/com/anonymous/changeLocale.do?locale=ch_2&URL=${LOCALE_RETURN}">繁体中文</a></li>
						</ul>
					</li>
				</ul>
			</li>
			
			<li><div class="gnbIco gnbIco04"></div><span>${loginMap.USER_NM}</span></li>
			<li><div class="gnbIco gnbIco05"></div><span id="headerTimeData">30:00</span></li>
			<a href="<c:url value='/com/i01/pantheonLogout.do'/>" >
				<li style="margin-right:0px;">
					<div class="gnbIco gnbIco06"></div>
					<span>로그아웃</span>
				</li>
			</a>
			<li class="gnb_02" style="padding-left:20px; padding-right:28px; margin-right:0px;  ">
				<div class="gnbIco gnbIco06_01"></div>
				
				<span>바로가기</span>
				<div class="gnb_detail_02">
					<div class="arrow03"></div>
					<div class="detail_in_02">
						<ul>
							<li><a href="#">메뉴관리</a></li>
							<li><a href="#">역할관리</a></li>
							<li><a href="#">CDISC관리</a></li>
							<li><a href="#">Medical Dictionary 관리 Dictionary 관리 Dictionary 관리</a></li>
							<li><a href="#">역할관리</a></li>
							<li><a href="#">Medical Dictionary Dictionary 관리</a></li>
						</ul>
					</div>
				</div>
			</li>
			<li class="gnb_03" style="padding-left:0px; padding-right:24px; margin-right:10px;  ">
				<div class="gnbIco gnbIco07"></div>
				<span>설정</span>
			</li>

		</ul>
	</nav>
</header>