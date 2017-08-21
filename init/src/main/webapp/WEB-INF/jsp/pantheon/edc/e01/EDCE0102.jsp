<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<script>

var EDCE0102_grid = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(EDCE0102_grid.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#EDCE0102_grid',
  },
  //데이터 연계 옵션
  proxy: {
	url : './selectESignSubjectList.do',
    param: {},
    type: 'post',
    dataType: 'json',
    //페이징 true, false 로 지정
    paging: false,
    //처음 시작시 데이터 로딩
    autoLoad: true,
  },
  //AUI 그리드 옵션
  	gridPros: {
    // 페이징 사용
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : true,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : false,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 5,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",
    displayTreeOpen : true,
    
  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "NAME1",
    headerText : "site",
    filter : {
    	showIcon : true
    }
  },{
    dataField : "SUBJECT_NO",
    headerText : "Subject",
    filter : {
    	showIcon : true
    },
    width : 150
  },{
    dataField : "ELTSGN_STTUS_CODE",
    headerText : "Status",
    filter : {
    	showIcon : true
    },
    width : 120
  },{
    dataField : "VISIT_STTUS",
    headerText : "Visit Status",
    filter : {
    	showIcon : true
    },
    width : 120
  },{
	dataField : "SAVE_STATUS",
    headerText : "Save Visit",
    filter : {
    	showIcon : true
    },
    width : 120
  },{
    dataField : "SAVE_CODE", 
    headerText : "SC",
    visible : false
  },{
    dataField : "OPEN_QUERY",
    headerText : "Open query",
    filter : {
    	showIcon : true
    },
    width : 120
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
},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};

$(document).ready(function() {
	EDCE0102_grid.createGrid();
});

window.onresize = function() {
if (typeof EDCE0102_grid.id !== "undefined") {
	 AUIGrid.resize(EDCE0102_grid.id);
 }
};

$(function(){
	// 팝업레이어
	$('.popup_01').click(function(){
		var checkedItems = AUIGrid.getCheckedRowItems(EDCE0102_grid.id);
		if (checkedItems.length <= 0) {
			alert("일괄 서명할 데이터를 선택하세요.");
		} else {
			var rows;
			for (var i = 0; i < checkedItems.length; i++) {
				
				if(checkedItems[i].item.OPEN_QUERY != '0'){
					alert("Open query가 0인 데이터만 일괄 서명이 가능합니다. ");
					return;
				}else if(checkedItems[i].item.SAVE_CODE != '03'){
					alert("Save Status가 완료인 데이터만 일괄 서명이 가능합니다. ");
					return; 
				}else if(checkedItems[i].item.SAVE_CODE == '01' && checkedItems[i].item.OPEN_QUERY == '0'){
					if(i == 0){
						rows = checkedItems[i].item.SUBJECT_NO;
					}else{
						rows = rows + "," + checkedItems[i].item.SUBJECT_NO;
					}
				} 
				
				if(i == 0){
					rows = checkedItems[i].item.SUBJECT_NO;
				}else{
					rows = rows + "," + checkedItems[i].item.SUBJECT_NO;
				}
			}
			
			var param = {
					rows : rows,
					type : "SUBJECT"
				};
			
			 mkLayerPopupOpen("/edc/e01/popupEDCE0103.do", param);
		}
		
		
	});

	// 탭메뉴
	$('#tab_01').click(function(){
		$("#searchForm").attr({
			action : './EDCE0101.do',
			method : 'post'
		}).submit();
	});
	$('#tab_02').click(function(){
		$("#searchForm").attr({
			action : './EDCE0102.do',
			method : 'post'
		}).submit();
	});
	
});

function searchClick() {
	var param = $("#searchForm").serialize();
	EDCE0102_grid.proxy.param = param;
	EDCE0102_grid.load();
}
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCE0102&&UPPER_MENU_ID=EDCE" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCE0102&&UPPER_MENU_ID=EDCE" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>eSign List</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>eSign</li>
						<li>eSign List</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner">
				<form name="searchForm" id="searchForm">
					<div id="tab" class="tab tab01 mgT16">
						<ul>
							<li id="tab_01" class="tab_menu">Visit</li>
							<li id="tab_02" class="port_back tab_menu">Subject</li>
						</ul>
					</div>
					<article style="overflow:hidden;">
						<div class="conTitBtnL">
							<span style="font-family:'NanumGothicBold';">Site</span>
							<input type="text" id="INSTT_NM" name="INSTT_NM" style="width: 140px;">
							<span style="font-family:'NanumGothicBold'; margin-left: 20px;">Subject</span>
							<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" style="width: 140px;">
							<button class="oneBtn" popup_type="ProductSearch" type="button" onclick="searchClick()">
									<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
							</button>
						</div>
						<div class="conTitBtnR">									
							<input type="button" class="popup_01" value="일괄서명">
						</div>
					</article>
 					<article class="mgT16">
                        <div id="EDCE0102_grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
                    </article>
                </form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>
</html>