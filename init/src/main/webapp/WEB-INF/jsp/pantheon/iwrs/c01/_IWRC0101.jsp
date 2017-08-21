<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>배송현황</title>





<script type="text/javascript">

var gridDelivery = {
		  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		  id: 'grDelivery',
		  //AUI그리드 생성할 div 및 페이징 옵션
		  div: {
		    gridDiv: '#grDelivery',
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
			  url: '/iwrs/c01/selectDeliveryInfo.do',
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

		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows",
		    displayTreeOpen : true,
		    

		  },
		  //AUI 그리드 레이아웃
		  columnLayout : [{
				dataField : "INSTT_CODE",
				headerText : "Site",
		 		filter : {
		 			showIcon : true
		 		},
				width:130
			}, {
				dataField : "DLVY_RQESTDE",
				headerText : "요청일시",
				formatString : "yyyy-mm-dd HH:MM:ss",
		 		dataType:"date",
		 		filter : {
		 			showIcon : true
		 		},
				width:140
			}, {
				dataField : "DLVY_HOPEDE",
				headerText : "배송희망일",
				renderer : { // HTML 템플릿 렌더러 사용
					type : "TemplateRenderer"
				},
				width:100,
				// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
					if(!value)	return "　";
					var template = "";
					if(("${ROLE}" == "CRA" || "${ROLE}" == "CRM") && (item.DLVY_STTUS_CODE == "02")){
						template = '<a href="#" onclick="javascript:showCraPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
					}else{
						template = value;
					}
					return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				},
		 		filter : {
		 			showIcon : true
		 		}
			}, {
				dataField : "DLVY_BGNDE",
				headerText : "배송일",
				renderer : { // HTML 템플릿 렌더러 사용
					type : "TemplateRenderer"
				},
				width:100,
				// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
					if(!value)	return "　";
					if("${ROLE}" == "IPM" && item.DLVY_STTUS_CODE == "04"){
						var template = '<a href="#" onclick="javascript:showConfirmPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
					}else{
						var template = value;
					}
					return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				},
		 		filter : {
		 			showIcon : true
		 		}
			}, {
				dataField : "DLVY_COMPTDE",
				headerText : "배송완료일",
				renderer : { // HTML 템플릿 렌더러 사용
					type : "TemplateRenderer"
				},
				width:100,
				
				// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
					if(!value)	return "　";
					if("${ROLE}" == "PHARM" && item.DLVY_STTUS_CODE == "06"){
						var template = '<a href="#" onclick="javascript:showInsulPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
					}else{
						var template = value;
					}
					return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				},
		 		filter : {
		 			showIcon : true
		 		},
		 		width:100
			}, {
				dataField : "DLVY_CNCDE",
				headerText : "배송취소일",
				renderer : { // HTML 템플릿 렌더러 사용
					type : "TemplateRenderer"
				},
				width:100,
				// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
					if(!value)	return "　";
					var template = '<a href="#" onclick="javascript:showDeliCancelPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
					return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				},
		 		filter : {
		 			showIcon : true
		 		}
			}, {
				dataField : "IP_CNT",
				headerText : "IP수량",
				renderer : { // HTML 템플릿 렌더러 사용
					type : "TemplateRenderer"
				},
				// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
					if(!value)	return "";
					var template = "";
					if(("${ROLE}" == "IPM" && item.DLVY_STTUS_CODE == "02") || ("${ROLE}" == "PHARM" && item.DLVY_STTUS_CODE == "04")){
						template = '<a href="#" onclick="javascript:showDeliConfirmPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';	
					}else{
						template = value;
					}
					
					return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				}
			}, {
				dataField : "DLVY_REQUST_COMMENT",
				headerText : "배송메모",
				width:150
			}, {
				dataField : "DLVY_REQUST_OCCRRNC_NM",
				headerText : "배송종류",
		 		filter : {
		 			showIcon : true
		 		},
		 		width:100,
				renderer : { // HTML 템플릿 렌더러 사용
					type : "TemplateRenderer"
				},
				// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
					if(!value)	return "";
					var template = "";
					if((("${ROLE}" == "CRA" || "${ROLE}" == "CRM") && item.DLVY_STTUS_CODE == "01")){
						template = '<a href="#" onclick="javascript:showCraPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';	
					}else{
						template = value;
					}
					
					return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				}
			}, {
				dataField : "DLVY_STTUS_NM",
				headerText : "배송상태",
		 		filter : {
		 			showIcon : true
		 		},
		 		width:100
			}, {
				headerText : "출하요청서"
			}, {
				headerText : "IP인수인계서",
				width:100
			}, {
				headerText : "Audit Trail",
				width:100
			}, {
				dataField : "DLVYMANAGE_CODE",
				headerText : "배송코드",
				visible : false
			}, {
				dataField : "DLVY_REQUST_OCCRRNC_CODE",
				visible : false
			}, {
				dataField : "DLVY_STTUS_CODE",
				visible : false
			}
		],


		  //AUI 그리드 생성
		  createGrid: function() {
		    var me = this;
		    
		    //이후 객체.id 로 AUIGrid 컨트롤
		    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		    //me.binding();
		    
		    if(me.proxy.autoLoad) {
		      me.load();
		    }

		 

		    //me.createPagingNavigator(1);
		  },
		  //AUI 그리드 이벤트 
		 // binding: function() {
		    
		 // },
		  //AUI 그리드 데이터 요청
		  load: function(v1, v2) {
		    var me = this;

	 		//autoLoad로 처음 화면 데이터 로딩 
	 		if(me.proxy.paging && !v1 && !v2) {
	 			me.proxy.param.page = me.div.paging.currentPage;		
	 			me.proxy.param.count= me.div.paging.rowCount;		
	 		}
	 		
	 		//moveToPage 로 데이터 요청
	 		if(v1 && v2) {
	 			me.proxy.param.page = v2;	
	 			me.div.paging.currentPage = v2;
	 			me.proxy.param.count = v1;		
	 			me.div.paging.rowCount = v1;		
	 		}
	 		
		    AUIGrid.showAjaxLoader(me.id);
		 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.result == "ok") {
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.list);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
	 			    	
	 			    	//샘플때문에 페이징 나타나게 하기위해 임의의 값 넣어줌 
//		  			    	data.count = 13;
//		  			    	console.log(data.count);
	 			    	//paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
	 			    	if(data.count && me.proxy.paging) {
	 			    		
	 			    		me.div.paging.totalRowCount = data.count;
	 			    		me.createPagingNavigator(me.div.paging.currentPage);
	 			    	}
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader(me.id);
	 		    		alert(data.message);
	 		    	}
	 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					AUIGrid.removeAjaxLoader(me.id);
					alert(textStatus);
				}
	 		});
		 		
		    //AUIGrid.setGridData(me.id, testData);
		    //me.div.paging.totalRowCount =testData.length;


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
		    retStr += "<select class='rowSel' onchange='javascript:gridDelivery.moveToPage(gridDelivery.div.paging.currentPage, this.value)'>"
		    if(gridDelivery.div.paging.rowCount == 20) {
		      retStr += "<option value=20 selected=true>rows 20</option>"
		    } else {
		      retStr += "<option value=20>rows 20</option>"
		    }
		    if(gridDelivery.div.paging.rowCount == 50) {
		      retStr += "<option value=50 selected=true>rows 50</option>"
		    } else {
		      retStr += "<option value=50>rows 50</option>"
		    }
		    if(gridDelivery.div.paging.rowCount == 100) {
		      retStr += "<option value=100 selected=true>rows 100</option>"
		    } else {
		      retStr += "<option value=100>rows 100</option>"
		    }
		    if(gridDelivery.div.paging.rowCount == 300) {
		      retStr += "<option value=300 selected=true>rows 300</option>"
		    } else {
		      retStr += "<option value=300>rows 300</option>"
		    }
		    if(gridDelivery.div.paging.rowCount == 500) {
		      retStr += "<option value=500 selected=true>rows 500</option>"
		    } else {
		      retStr += "<option value=500>rows 500</option>"
		    }
		    retStr += "</select>"
		    


		    // 처음
		    retStr += "<span class='aui-grid-paging-grup'>";
		    retStr += "<a href='javascript:gridDelivery.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";
		    // 이전
		    retStr += "<a href='javascript:gridDelivery.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
		    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
		      if (goPage == i) {
		        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
		      } else {
		        retStr += "<a href='javascript:gridDelivery.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
		        retStr += i;
		        retStr += "</span></a>";
		      }
		      
		      if (i >= me.div.paging.totalPage) {
		        break;
		      }
		    }



		    // 다음
		    retStr += "<a href='javascript:gridDelivery.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
		    // 마지막
		    retStr += "<a href='javascript:gridDelivery.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>"
		    retStr += "</span>";
		    ;

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
	gridDelivery.createGrid();
	pageSetting();
	buttonActive();
});


function pageSetting(){
	if("${ROLE}" != "CRA" && "${ROLE}" != "CRM" && "${ROLE}" != "PHARM"){
		$("#btnDeliReq").hide();
	}
}
		
function buttonActive(){
	$("#btnDeliReq").click(function(){
		
		if("${ROLE}" == "PHARM"){
			showPharmPopup();
		}else{ //CRA, CRM
			showCraPopup();
		}
	});
	
	$("#btnIpDeliDoc").click(function(){
	
	});
	
	$("#btnDown").click(function(){
		var data = AUIGrid.getGridData(gridDelivery.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Delivery_List"
			};
			AUIGrid.setProperty(gridDelivery.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(gridDelivery.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
}

function showPharmPopup(){
	mkLayerPopupOpen("/iwrs/c01/popupIwrc0102.do");
}

function showCraPopup(dlvy_code){
	if(dlvy_code != ""){
		var param = {
			dlvymanage_code : dlvy_code,
			PAGE_ID : "IWRC0101"
		};
		mkLayerPopupOpen("/iwrs/c01/popupIwrc0103.do", param);
	}else{
		mkLayerPopupOpen("/iwrs/c01/popupIwrc0103.do");
	}
}

function showDeliConfirmPopup(dlvy_code){
	if("${ROLE}" == "PHARM"){
		showInsulPopup(dlvy_code);
	}else{
		showConfirmPopup(dlvy_code);
	}
}

function showConfirmPopup(dlvy_code){
	var param = {
			dlvymanage_code : dlvy_code
		};
	mkLayerPopupOpen("/iwrs/c01/popupIwrc0104.do", param);
}

function showCancelPopup(param){
	layerClose();
	mkLayerPopupOpen("/iwrs/c01/popupIwrc0105.do", param);
}

function showDeliCancelPopup(dlvy_code){
	var param = {
			dlvymanage_code : dlvy_code
		};
	mkLayerPopupOpen("/iwrs/c01/popupIwrc0106.do", param);
}

function showInsulPopup(dlvy_code){
	var param = {
			dlvymanage_code : dlvy_code
		};
	mkLayerPopupOpen("/iwrs/c01/popupIwrc0107.do", param);
	AUIGrid.resize(gridInsu.id);
}




 // 윈도우 리사이징 이벤트
  window.onresize = function() {
  // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
  if (typeof gridDelivery.id !== "undefined") {
    AUIGrid.resize(gridDelivery.id);
    }
  };





</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRC0101&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRC0101&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>배송현황</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>배송관리</li>
						<li>배송현황</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">

				<div class="conBoxInner">


		            	<articla class="conTitBox">
		            		<!-- <h5>Study List</h5> -->
		            	</articla>

						<article class="conTitBtnR">
							<input type="button" id="btnIpDeliDoc" value="IP수불문서" />
							<input type="button" id="btnDeliReq" value="배송요청" />
							<input type="button" id="btnDown" value="엑셀" />
						</article>


						<article class="mgT16">
	                        <div id="grDelivery" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>



<style>
.grid_wrap a{color: #5570e6 !important; text-decoration:underline; font-weight: bold;}
.grid_wrap a:hover{color: #5570e6 !important; text-decoration:underline; cursor:pointer;}
</style>



				</div>
            </section>


		</div>
	</section>
</div>
</body>
</html>