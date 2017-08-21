<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false" />
<title></title>



<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}


.con_category_01{ border:1px solid #d5d5d5; border-bottom:none;  top:-2px;  }
.dumi_02{ border-left:1px solid #d5d5d5; /* border-top:1px solid #d5d5d5; */ border-bottom:1px solid #d5d5d5; }
 .contents_02_in{  border-left:none; border:1px solid #d5d5d5; }
 
</style>


<script type="text/javascript">

var testData =[
{
  "방문":"등록",
  "방문일":"2015-04-25",
  "저장":"7/17",
  "임시저장":"0/17",
  "미저장":"10/17",
  "오픈 쿼리":"0",
  "쿼리 해결":"12",
  "전자서명":"완료",
  "SDV":"완료",
  "SDV Completion":"4",
  "Free zing":"완료"
},{
  "방문":"V1",
  "방문일":"2015-04-25",
  "저장":"7/17",
  "임시저장":"0/17",
  "미저장":"10/17",
  "오픈 쿼리":"0",
  "쿼리 해결":"12",
  "전자서명":"완료",
  "SDV":"완료",
  "SDV Completion":"4",
  "Free zing":"완료"
},{
  "방문":"V2",
  "방문일":"2015-04-25",
  "저장":"2/11",
  "임시저장":"0/11",
  "미저장":"10/17",
  "오픈 쿼리":"11",
  "쿼리 해결":"12",
  "전자서명":"완료",
  "SDV":"완료",
  "SDV Completion":"4",
  "Free zing":"완료"
},{
  "방문":"UV1",
  "방문일":"2015-04-25",
  "저장":"3/11",
  "임시저장":"0/11",
  "미저장":"10/17",
  "오픈 쿼리":"11",
  "쿼리 해결":"12",
  "전자서명":"완료",
  "SDV":"완료",
  "SDV Completion":"4",
  "Free zing":"완료"


}];


var myGridOption = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap',
    paging: {
      pagingDiv: 'grid_paging',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
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
    dataField : "방문",
    headerText : "방문",
    style : "edc_column_style"
  },{
    dataField : "방문일",
    headerText : "방문일",
    width : 100
  },{
    dataField : "저장",
    headerText : "저장",
    width : 80
  },{
    dataField : "임시저장",
    headerText : "임시저장",
    width : 90
  },{
    dataField : "미저장",
    headerText : "미저장",
    width : 80
  },{
    dataField : "오픈 쿼리",
    headerText : "오픈 쿼리",
    width : 100
  },{
    dataField : "쿼리 해결",
    headerText : "쿼리 해결",
    width : 100
  },{
    dataField : "전자서명",
    headerText : "전자서명",
    width : 120
  },{
    dataField : "SDV",
    headerText : "SDV",
    width : 100
  },{
    dataField : "SDV Completion",
    headerText : "SDV Completion",
    width : 140
  },{
    dataField : "Free zing",
    headerText : "Free zing",
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
    
    //AUIGrid.showAjaxLoader(me.id);
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    me.createPagingNavigator(me.div.paging.currentPage);

  },
  //사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
  createPagingNavigator: function(goPage) {
    var me = this;
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    this.div.paging.totalPage = Math.ceil(this.div.paging.totalRowCount/this.div.paging.rowCount);
    
    var retStr = "";
    var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * ( me.div.paging.pageButtonCount /*-3*/);
    var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount +1 ;
    prevPage = Math.max(0,prevPage );
    nextPage = Math.min(nextPage, me.div.paging.totalPage);
    if ( goPage == 0 ) { prevPage.stop() }



    //셀렉트박스
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption.div.paging.currentPage, this.value)'>"
    if(myGridOption.div.paging.rowCount == 20) {
      retStr += "<option value=20 selected=true>rows 20</option>"
    } else {
      retStr += "<option value=20>rows 20</option>"
    }
    if(myGridOption.div.paging.rowCount == 50) {
      retStr += "<option value=50 selected=true>rows 50</option>"
    } else {
      retStr += "<option value=50>rows 50</option>"
    }
    if(myGridOption.div.paging.rowCount == 100) {
      retStr += "<option value=100 selected=true>rows 100</option>"
    } else {
      retStr += "<option value=100>rows 100</option>"
    }
    if(myGridOption.div.paging.rowCount == 300) {
      retStr += "<option value=300 selected=true>rows 300</option>"
    } else {
      retStr += "<option value=300>rows 300</option>"
    }
    if(myGridOption.div.paging.rowCount == 500) {
      retStr += "<option value=500 selected=true>rows 500</option>"
    } else {
      retStr += "<option value=500>rows 500</option>"
    }
    retStr += "</select>"

    
	// 처음
	retStr += "<span class='aui-grid-paging-grup'>";
	retStr += "<a href='javascript:myGridOption.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";
	// 이전
	retStr += "<a href='javascript:myGridOption.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";

	for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage); i<=len; i++) {
		if (goPage == i) {
			retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
		} else {
			retStr += "<a href='javascript:myGridOption.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
			retStr += i;
			retStr += "</span></a>";
		}
		if (i >= me.div.paging.totalPage) {
			break;
		}
	}

	// 다음
	retStr += "<a href='javascript:myGridOption.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
	// 마지막
	retStr += "<a href='javascript:myGridOption.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>";
	retStr += "</span>";

    //el식 테스트
    document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
  },
  //페이징 에서 어느 페이지로 갈 것인지 지정
  moveToPage: function(goPage, rowCount) {
    var me = this;
    
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    // 현재 페이지 보관
    me.div.paging.currentPage = goPage ;
    
    // selectBox에서 요청시, 1페이지부터 시작
    if(rowCount) {
      me.div.paging.rowCount = rowCount;
      me.div.paging.currentPage = 1;
      goPage = 1;
    }
    
    me.load(me.div.paging.rowCount, goPage);
  }
};


$(document).ready(function() {
  myGridOption.createGrid();
});


window.onresize = function() {
 if (typeof myGridOption.id !== "undefined") {
   AUIGrid.resize(myGridOption.id);
   }
};







//내용부분 1뎁스
function category_View(d1){
	var dep1 = d1 - 1 ;

	$(".depth_01 > dd > a").eq(dep1).addClass("open").next().slideDown("fast"); //첫번째 내용 보이기

	$(".depth_01 > dd > a").each(function () {
		 $(this).css("background-image","none");
	});

	$(".depth_01 > dd > a").click(function() {
		$(this).addClass("open").next("dl").slideDown("fast");

		//나머지 닫힘
		$(".depth_01 > dd > a").not(this).removeClass("open").next("dl").slideUp("fast");
	});
}

//내용부분 크기 조정
function Con_Resize(){
	var con_boxd = $('.contents_02_in').height();
	$('.con_category_01').css({"height": con_boxd + 18 + "px"});
	$('.conBox_01').css({"height": con_boxd + 22 + "px"});
	$('.depth_01').css({"height": con_boxd - 32 + "px"});
	$('.dumi_02').css({"height": con_boxd + 20 + "px"});
	$('.contents_02').css({"top": -con_boxd - 21 + "px"});
	$('.lnb').addClass('lnb_relative');
	
}

$(function(){

	Con_Resize();
	//내용부분 카테고리 닫기
	$(".con_category_close").click(function(){
        $(".con_category_close").hide();
        $(".con_category_open").show();
		$(".depth_01").addClass("hidden");
		$(".con_category_01").addClass("con_category_01_reduce");
		$(".dumi_02").addClass("dumi_02_move");
		$(".contents_02_in").addClass("contents_02_move");
		
        if($('.grid_wrap') && $('.grid_wrap').length) {
	    	for(var i = 0; i < $('.grid_wrap').length; i++) {
            	try {
					fn_lnbResize($('.grid_wrap')[i].id);
            	} catch(e) {
            	}
	    	}
        }
	});
	
	$(".con_category_open").click(function(){
        $(".con_category_open").hide();
        $(".con_category_close").show();
		$(".depth_01").removeClass("hidden");
		$(".con_category_01").removeClass("con_category_01_reduce");
		$(".dumi_02").removeClass("dumi_02_move");
		$(".contents_02_in").removeClass("contents_02_move");
		
        if($('.grid_wrap') && $('.grid_wrap').length) {
	    	for(var i = 0; i < $('.grid_wrap').length; i++) {
            	try {
					fn_lnbResize($('.grid_wrap')[i].id);
            	} catch(e) {
            	}
	    	}
        }

	});
	
	
});

//화면 로드, 리사이즈, 스크롤
$(window).load(function() {
	Con_Resize();
});

$(window).resize(function() {
	Con_Resize();
});

$(window).scroll(function(){
	Con_Resize();
});


$(function(){
	category_View(3);	//1뎁스 고정메뉴
	
	// 탭메뉴
	$('#tab_01').click(function(){
		window.location.href ="./_EDCC0102.do";
	});
	$('#tab_02').click(function(){
		window.location.href ="./_EDCC0103.do";
	});
	
	
	
});


</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>Subject List</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>Subject</li>
							<li>Subject List</li>
						</ul>
					</nav>
				</article>


	            <section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="mgT10" style="overflow:hidden;">
							<div class="conTitBtnL">
								
								<span style="font-family:'NanumGothicBold';">Site :</span>
								<input type="text" id="" name="" style="width: 140px;">
								<span style="font-family:'NanumGothicBold'; margin-left: 20px;">Subject :</span>
								<input type="text" id="" name="" style="width: 140px;">
								<button class="oneBtn" popup_type="ProductSearch" type="sumit">
										<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
							</div>
							<div class="conTitBtnR">									
								<input type="button" value="Unscheduled Visit 추가" onclick="">
							</div>
						</article>



						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="tab_01" class="tab_menu">View</li>
								<li id="tab_02" class="port_back tab_menu" onClick="">List</li>
							</ul>
						</div>


						<section class="conBox_01" style="margin:0;">
							<nav>
								<div class="con_category_01">
									<a href="#void" class="con_category_close"><span>SUBJECT NO</span></a>
									<a href="#void" class="con_category_open"></a>
									
									
									<dl class="depth_01">
										<dd>
											<a href="#1"><span>S111</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S999</span></a>
										</dd>
									</dl>
									<div class="dumi_02"></div>
									
									
			
								</div>
								
							</nav>
			
			
			
							<section class="contents_02">
								<div class="contents_02_in">





				 					<article class="mgT16">
				                        <div id="grid_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
				                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				                    </article>






								</div>
							</section>	
						</section>
								
			
			
			
								
								
						</section>
			
					</div>
	            </section>			
				
			</div>
		</section>
	</div>
</body>
</html>