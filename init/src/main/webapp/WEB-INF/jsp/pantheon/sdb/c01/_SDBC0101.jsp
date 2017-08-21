<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>Trial 조회/리스트 </title>
<script type="text/javascript">

$(function(){
	btnInit();
	
	//grStudy.createGrid();
});

function btnInit(){
	$('#tabTrial').click(function(){
		window.location.href ="/sdb/c01/_SDBC0101.do";
	});
	$('#tabSpontaneous').click(function(){
		window.location.href ="/sdb/c01/_SDBC0104.do";
	});
	$('#tabLiterature').click(function(){
		window.location.href ="/sdb/c01/_SDBC0106.do";
	});	
	$('#tabEtc').click(function(){
		window.location.href ="/sdb/c01/_SDBC0108.do";
	});
	$('#tabICSR').click(function(){
		window.location.href ="/sdb/c01/_SDBC0110.do";
	});
	
	$('#btnSearch').click(function(){
		grStudy.load();
	});
	
	$('#btnAdd').click(function(){
		window.location.href='/sdb/c01/_SDBC0102.do';
	});
	
	$('#btnExcel').click(function() {
		
		var data = AUIGrid.getGridData(grStudy.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grStudy.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grStudy.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
	
	$('button[popup_type=ProductSearch], input[popup_type=ProductSearch]').click(function(){
		mkLayerPopupOpen("/sdb/b02/popup_SDBB0204.do", null);
		if (typeof grProductList_Search.id !== "undefined") {
			AUIGrid.resize(grProductList_Search.id);
		}
		return false;
	});
	
}
	
var testData =[
{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
}, {
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
}];





var grStudy = {
 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grStudy.id);
 	id: '',
 	//AUI그리드 생성할 div 및 페이징 옵션
 	div: {
 		gridDiv: '#grStudy',
 		paging: {
 			pagingDiv: 'grid_paging',
 			totalRowCount: 500,
 			rowCount: 10,
 			pageButtonCount: 4,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	//데이터 연계 옵션
 	proxy: {
 		url: './selectTrialList.do',
 		param: {
 			PRDUCT_CODE : $('#hdProductCode').val()	
 		},
 		type: 'post',
 		dataType: 'json',
 		//페이징 true, false 로 지정
 		paging: false,
 		//처음 시작시 데이터 로딩
 		autoLoad: true
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
 		dataField : "PRTCL_NO",
 		visible : false
 	},{
 		dataField : "PRTCL_NM",
 		headerText : "Protocol",
 		width : "30%",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "RSRCH_KND_CODE",
 		headerText : "Study Type",
 		width: 210,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "AE_COUNT",
 		headerText : "AE",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "ADR_COUNT",
 		headerText : "ADR",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UAE_COUNT",
 		headerText : "UAE",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "SAE_COUNT",
 		headerText : "SAE",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "SADR_COUNT",
 		headerText : "SADR",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "SUSAR_COUNT",
 		headerText : "SUSAR",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USE_AT",
 		headerText : "Deleted",
 		filter : {
 			showIcon : true
 		}
 	}],
 	  //AUI 그리드 생성
 	  createGrid: function() {
 			var me = this;

 			//이후 객체.id 로 AUIGrid 컨트롤
 			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 			//AUIGrid.bind(me.id, "cellDoubleClick", auiGridCellDoubleClickHandler);
 			me.binding();

 			if (me.proxy.autoLoad) {
 				me.load();
 			}
 		},
 	  //AUI 그리드 이벤트 
 	  binding: function() {
 			var me = this;
 	  },
 	  //AUI 그리드 데이터 요청
 	  load: function(v1, v2) {
 	    var me = this;
 		var param = {
 				PRDUCT_CODE : $('#hdProductCode').val()
 		};
 	    
 	    AUIGrid.showAjaxLoader(me.id);
 		$.ajax({
 			url : me.proxy.url,
 			type : me.proxy.type,
 			dataType : me.proxy.dataType,
 			data : param,
 			success : function(data) {
 				if (data.success) {
 					AUIGrid.removeAjaxLoader(me.id);
 					AUIGrid.setGridData(me.id, data.result);
 					AUIGrid.setSelectionByIndex(me.id, 0);
 					
 					data.count= data.result.length;
 		            
 		            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
 		            if(data.count && me.proxy.paging) {
 		              me.div.paging.totalRowCount = data.count;
 		              /*높이 변경
 		              AUIGrid.resize(me.id, 800, 300);
 		              $("#"+me.div.paging.pagingDiv).offset({top: 495})
 		              */
 		              me.createPagingNavigator(me.div.paging.currentPage);
 		            }
 		            $(".aui-grid-template-renderer-wrapper").removeAttr("style");
 				} else {
 					AUIGrid.removeAjaxLoader(me.id);
 					alert(data.message);
 				}
 			},
 			error : function(jqXHR, textStatus, errorThrown) {
 				alert(textStatus);
 			}
 		});
 	    
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

 	            //console.log(goPage)
 	    
 	    //셀렉트박스

 	    retStr += "<select class='rowSel' onchange='javascript:grStudy.moveToPage(grStudy.div.paging.currentPage, this.value)'>"
 	    if(grStudy.div.paging.rowCount == 20) {
 	      retStr += "<option value=20 selected=true>rows 20</option>"
 	    } else {
 	      retStr += "<option value=20>rows 20</option>"
 	    }
 	    if(grStudy.div.paging.rowCount == 50) {
 	      retStr += "<option value=50 selected=true>rows 50</option>"
 	    } else {
 	      retStr += "<option value=50>rows 50</option>"
 	    }
 	    if(grStudy.div.paging.rowCount == 100) {
 	      retStr += "<option value=100 selected=true>rows 100</option>"
 	    } else {
 	      retStr += "<option value=100>rows 100</option>"
 	    }
 	    if(grStudy.div.paging.rowCount == 300) {
 	      retStr += "<option value=300 selected=true>rows 300</option>"
 	    } else {
 	      retStr += "<option value=300>rows 300</option>"
 	    }
 	    if(grStudy.div.paging.rowCount == 500) {
 	      retStr += "<option value=500 selected=true>rows 500</option>"
 	    } else {
 	      retStr += "<option value=500>rows 500</option>"
 	    }
 	    retStr += "</select>"
 	    


 	    
 		// 처음
 		retStr += "<span class='aui-grid-paging-grup'>";
 		retStr += "<a href='javascript:grStudy.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";

 		// 이전
 		retStr += "<a href='javascript:grStudy.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";

 		for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage); i<=len; i++) {
 			if (goPage == i) {
 				retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
 			} else {
 				retStr += "<a href='javascript:grStudy.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
 				retStr += i;
 				retStr += "</span></a>";
 			}
 			
 			if (i >= me.div.paging.totalPage) {
 				break;
 			}

 		}

 		// 다음
 		retStr += "<a href='javascript:grStudy.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";

 		// 마지막
 		retStr += "<a href='javascript:grStudy.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>";
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

function auiGridCellDoubleClickHandler() {
	var str = "";
	var i, rowItem, rowInfoObj, dataField;
	selectionMode = AUIGrid.getProperty(grStudy.id, "selectionMode");
	var selectedItems = AUIGrid.getSelectedItems(grStudy.id);
	if (selectedItems.length <= 0) {
		alert("없음");
		return;
	}
	rowInfoObj = selectedItems[0];
	rowItem = rowInfoObj.item;
	if(rowItem.USE_AT =="Deleted"){
		alert('삭제된 행입니다.');
		return;
	}
	$('#iPRTCL_NO').val(rowItem.PRTCL_NO);
	$('#iform').submit();
}



$(document).ready(function() {
  grStudy.createGrid();
});


// 윈도우 리사이징 이벤트
window.onresize = function() {
 // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
 if (typeof grStudy.id !== "undefined") {
   AUIGrid.resize(grStudy.id);
   }
};



</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Source별 등록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>Source별 등록</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner">
					<form id="iform" method="post" action="/sdb/c01/SDBC0102.do">
					<input type="hidden" name="PRTCL_NO" id="iPRTCL_NO" />
					

						<div class="button_tab_01">
							<ul>
								<li id="tabTrial" class="port_back tab_menu">Study</li>
								<li id="tabSpontaneous" class="tab_menu">Spontaneous</li>
								<li id="tabLiterature" class="tab_menu">Literature</li>
								<li id="tabEtc" class="tab_menu">Etc</li>
								<li id="tabICSR" class="tab_menu">ICSR</li>
							</ul>
						</div>
							

						<article class="conGridUpper">
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold';">PRODUCT :</span>
								<input type="text" id="txtProductCode" popup_type="ProductSearch" class="pdR15" readonly>
								<input type="hidden" id="hdProductCode" />
								<button class="oneBtn" popup_type="ProductSearch" type="sumit" style="left:-2px;">
									<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
								<input type="button" class="btn mgL10" id="btnSearch" value="검색">
							</div>
							<div class="conTitBtnR">									
								<input type="button" id="btnAdd" value="추가">
								<input type="button" id="btnExcel" value="엑셀">
							</div>
						</article>


						<article class="mgT43">
	                        <div id="grStudy" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>
					</form>
				</div>
            </section>


		
		






		</div>
	</section>
</div>
</body>
</html>