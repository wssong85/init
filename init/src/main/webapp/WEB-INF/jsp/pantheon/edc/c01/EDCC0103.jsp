<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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

var EDCC0103_grid = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(EDCC0103_grid.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#EDCC0103_grid',
    paging: {
      pagingDiv: 'EDCC0103_grid_paging',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
	url : './selectVisitList.do',
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
    editable : false,
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
    dataField : "VISIT_SN",
    headerText : "방문",
    style : "edc_column_style"
  },{
    dataField : "방문일",
    headerText : "방문일",
    width : 100
  },{
    dataField : "SAVE",
    headerText : "저장",
    width : 80
  },{
    dataField : "TEMP_SAVE",
    headerText : "임시저장",
    width : 90
  },{
    dataField : "NOT_SAVE",
    headerText : "미저장",
    width : 80
  },{
    dataField : "OPEN_QUERY",
    headerText : "오픈 쿼리",
    width : 100
  },{
    dataField : "QUERY_END",
    headerText : "쿼리 해결",
    width : 100
  },{
    dataField : "ELTSGN_STTUS_CODE",
    headerText : "전자서명",
    width : 120
  },{
    dataField : "SDV_STTUS_CODE",
    headerText : "SDV",
    width : 100
  },{
    dataField : "SDV_COMPT_STTUS_CODE",
    headerText : "SDV Completion",
    width : 140
  }],


  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
   // me.binding();
    
    if(me.proxy.autoLoad) {
      me.load();
    }

    //me.createPagingNavigator(1);
  },
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	},
	//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
	createPagingNavigator : function(goPage) {
		var me = this;
		if (!me.div.paging.pagingDiv) {
			return;
		}
		fn_createPagingNavigator(me, goPage);
	},
	//페이징 에서 어느 페이지로 갈 것인지 지정
	moveToPage : function(goPage, rowCount) {
		var me = this;
		if (!me.div.paging.pagingDiv) {
			return;
		}
		$("#searchForm PAGE").val(goPage);
		fn_moveToPage(me, goPage, rowCount)
	}
};

$(document).ready(function() {
  EDCC0103_grid.createGrid();
  fnLoad('');
  category_View($("#dlSubjectList").find("dd > a").index($("#${subjectNo}")));
});


window.onresize = function() {
 if (typeof EDCC0103_grid.id !== "undefined") {
   AUIGrid.resize(EDCC0103_grid.id);
   }
};

function fnLoad(subjectNo) {
	$("#searchForm #PAGE").val(1);
	$("#searchForm #COUNT").val(EDCC0103_grid.div.paging.rowCount);
	if(subjectNo == null || subjectNo ==""){
	}else{
		$("#subjectNo").val(subjectNo);	
	}
	var param = $("#searchForm").serialize();
	EDCC0103_grid.proxy.param = param;
	EDCC0103_grid.load();
}

function searchClick() {
	$("#searchForm").attr({
		action : './EDCC0103.do',
		method : 'post'
	}).submit();
}


//내용부분 1뎁스
function category_View(d1){
	var dep1 = d1;

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

	//1뎁스 고정메뉴
	category_View($("#dlSubjectList").find("dd > a").index($("#${subjectNo}")));
	
	// 탭메뉴
	$('#tab_01').click(function(){
		$("#searchForm").attr({
			action : './EDCC0102.do',
			method : 'post'
		}).submit();
	});
	$('#tab_02').click(function(){
		$("#searchForm").attr({
			action : './EDCC0103.do',
			method : 'post'
		}).submit();
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
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0103&&UPPER_MENU_ID=EDCC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0103&&UPPER_MENU_ID=EDCC" charEncoding="utf-8"/>
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
				<form name="searchForm" id="searchForm">
				<input type="hidden" id="subjectNo" name="subjectNo" value="${subjectNo}">
						<article class="mgT10" style="overflow:hidden;">
							<div class="conTitBtnL">
							<input type="hidden" id="PAGE" name="PAGE">
							<input type="hidden" id="COUNT" name="COUNT">
								<span style="font-family:'NanumGothicBold';">Site </span>
								<input type="text" id="INSTT_NM" name="INSTT_NM" value="${INSTT_NM}" style="width: 140px;">
								<span style="font-family:'NanumGothicBold'; margin-left: 20px;">Subject </span>
								<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" value="${SUBJECT_NO}" style="width: 140px;">
								<button class="oneBtn" popup_type="ProductSearch" type="button" onclick="searchClick()">
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
									<dl id="dlSubjectList" class="depth_01">
									<c:forEach var="result" items="${SubjectMenuList}">
										<dd>
											<a id="${result.SUBJECT_NO }" href="javascript:fnLoad('${result.SUBJECT_NO}')"><span>${result.SUBJECT_NO}</span></a>
										</dd>
									</c:forEach>
									</dl>
									<div class="dumi_02"></div>
								</div>
							</nav>

							<section class="contents_02">
								<div class="contents_02_in">
				 					<article class="mgT16">
				 						<div id="EDCC0103_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                        			<div id="EDCC0103_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				                    </article>
								</div>
							</section>	
						</section>
				</form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>
</html>