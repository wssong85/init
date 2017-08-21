<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<script>

var testData =[
{
  "버전":"12.0",
  "업로드 일자":"2015.12.15",
  "업로드 사용자":"admin",
  "...":"..."
}, {
  "버전":"12.0",
  "업로드 일자":"2015.12.15",
  "업로드 사용자":"admin",
  "...":"..."
}, {
  "버전":"12.0",
  "업로드 일자":"2015.12.15",
  "업로드 사용자":"admin",
  "...":"..."
}, {
  "버전":"12.0",
  "업로드 일자":"2015.12.15",
  "업로드 사용자":"admin",
  "...":"..."
}, {
  "버전":"12.0",
  "업로드 일자":"2015.12.15",
  "업로드 사용자":"admin",
  "...":"..."
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
    dataField : "버전",
    headerText : "버전",
    width : 130
  },{
    dataField : "업로드 일자",
    headerText : "업로드 일자",
    width : 130
  },{
    dataField : "업로드 사용자",
    headerText : "업로드 사용자",
    width : 130
  },{
    dataField : "...",
    headerText : "..."
 
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






$(function(){
	// 팝업레이어
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./_COMC0205.do", null);
	});

	//$('.popup_01').trigger('click');
	
	
	// 탭메뉴
	$('#tab_01').click(function(){
		window.location.href ="./_COMC0201.do";
	});
	$('#tab_02').click(function(){
		window.location.href ="./_COMC0202.do";
	});
	$('#tab_03').click(function(){
		window.location.href ="./_COMC0203.do";
	});
	$('#tab_04').click(function(){
		window.location.href ="./_COMC0204.do";
	});
	
	
	mkSetDatePickerYYMMDD("#day_01");
	mkSetDatePickerYYMMDD("#day_02");
	
	
});
</script>







</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMD0101&UPPER_MENU_ID=COMD" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMD0101&UPPER_MENU_ID=COMD" charEncoding="utf-8"/>




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Medical dictionary</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>임상자료관리</li>
						<li>Medical dictionary</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner">
				
				
					<div id="tab" class="tab tab01 mgT16">
						<ul>
							<li id="tab_01" class="port_back tab_menu">MedDRA</li>
							<li id="tab_02" class="tab_menu" onClick="">ATC</li>
							<li id="tab_03" class="tab_menu" onClick="">WHOART</li>
							<li id="tab_04" class="tab_menu" onClick="">KIMS</li>
						</ul>
					</div>
				

					<article style="overflow:hidden;">
						<div class="conTitBtnL">
							
							<span style="font-family:'NanumGothicBold';">버전 :</span>
							<input type="text" id="" name="" style="width: 140px;">
							<span style="font-family:'NanumGothicBold'; margin-left: 20px;">업로드기간 :</span>
							<div class="dateBox">
								<input type="text" id="day_01" style="width: 120px;" />
							</div>
							 - 
							<div class="dateBox">
								<input type="text" id="day_02" style="width: 120px;" />
							</div>
							<button class="oneBtn" popup_type="ProductSearch" type="sumit">
								<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
							</button>
						</div>
						<div class="conTitBtnR">									
							<input type="button" class="popup_01" value="업로드">
							<input type="button" value="양식 다운로드">
						</div>
					</article>




 					<article class="mgT16">
                        <div id="grid_wrap" class="gridHeiSz04 grid_wrap tb01_2"></div>
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
				</div>
            </section>




            <section class="conBox100 conBox">
				<div class="conBoxInner">
				
                    <article class="conTitBox">
                        <h5>MedDra List</h5>
                    </article>
                    
                    
					<article class="mgT16" style="overflow:hidden;">
						<div class="conTitBtnL">
							
							<span style="font-family:'NanumGothicBold';">HLT :</span>
							<input type="text" id="" name="" style="width: 200px;">
							<button class="oneBtn" popup_type="ProductSearch" type="sumit">
								<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
							</button>
						</div>
					</article>



 					<article class="mgT16">
                        <div id="grid_wrap" class="gridHeiSz04 grid_wrap tb01_2"></div>
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
				</div>
            </section>







		</div>
	</section>
</div>
</body>
</html>