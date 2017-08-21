<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>Product List</title>
<style>
/* 
.aui-grid-default-header{ text-indent: 0px;}
.aui-grid-default-header .aui-grid-renderer-base span:first-child{ line-height:12px; font-size:12px; display:inline-block; padding:6px 0 0 10px;}

.aui-grid-row-num-header{text-indent: 10px;}
 */
</style>

<script type="text/javascript">
$(function(){
	btnInit();
});

function btnInit(){
	$('#btnAdd').click(function(){
		window.location.href = "/sdb/b01/SDBB0102.do";
	});
	
	$('#btnSearch').click(function(){
		
		var param = {
				PRDUCT_CODE : $('#hdProductCode').val()
			};
		
		grProductList.proxy.param = param;				
		grProductList.load();
	});
	
	$('#btnExcel').click(function() {
		
		var data = AUIGrid.getGridData(grProductList.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grProductList.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grProductList.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
	
	$('button[popup_type=ProductSearch], input[popup_type=ProductSearch]').click(function(){
		mkLayerPopupOpen("/sdb/b02/popupSDBB0204.do", null);
		if (typeof grProductList_Search.id !== "undefined") {
			AUIGrid.resize(grProductList_Search.id);
		}
		return false;
	});
	
}

$(document).ready(function() {
	grProductList.createGrid();
});

var me;
var grProductList = {
 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grProductList.id);
 	id: '',
 	//AUI그리드 생성할 div 및 페이징 옵션
 	div: {
 		gridDiv: '#grProductList',
 		paging: {
 			pagingDiv: 'pagingClCode',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	//데이터 연계 옵션
 	proxy: {
 		url: './selectProductList.do',
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
		selectionMode: 'singleRow',
		editable: true,
		enableFilter : true,
		showStateColumn: false,
		pageRowCount : 5,
	    showPageButtonCount : 5,
	    headerHeight: 40,
	    rowHeight: 37
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [
 	{
 		dataField : "PRDUCTNM_CODE",
 		headerText : "Brand Name", 
 		width : 118,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
 		headerText : "Pre Approval IP Name",
 		width : 175,
 		filter : {
 			showIcon : true
 		}	
 	},{
 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE2",
 		headerText : "Pre Approval IP Name2",
 		width : 183,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE3",
 		headerText : "Pre Approval IP Name3",
 		width : 183,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CONFM_DTE",
 		headerText : "Approval Date",
 		//formatString : "yyyy/mm/dd",
 		dataType:"date",
 		width : 132,
 		formatString : "yyyy-mm-dd",
		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FRST_MFBIZ_CODE",
 		headerText : "Original Manufacture",
 		width : 170,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "GNRL_NM_CODE1",
 		headerText : "Generic Name",
 		//width : 129,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "COMAVA_AT",
 		headerText : "Commercially",
 		width : 125,
 		filter : {
 			showIcon : true
 		} 		
 	},{
 		dataField : "PRDUCT_CODE",
 		headerText : "prduct_code",
 		visible : false
 	}],
 	
 	//AUI 그리드 생성
 	createGrid: function() {
 		me = this;
 		
 		//이후 객체.id 로 AUIGrid 컨트롤
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		me.binding();
 		AUIGrid.bind(me.id, "cellDoubleClick", auiGridCellDoubleClickHandler);
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	//AUI 그리드 이벤트 
 	binding: function() {
 		AUIGrid.bind(grProductList.id, 'cellEditBegin', function(event) {
 			
 			var flag = false;
 			
 			var addedRowItems = AUIGrid.getAddedRowItems(grProductList.id);
 			
 			//uu_id 로 add 인지 아닌지 유효성 검사
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(grProductList.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			//현재 index가 0인지 아닌지 판단.(행추가 row는 상관이 없다.)
 			if(AUIGrid.getSelectedIndex(grProductList.id)[grProductList.id]) {
 				flag = true;
 			}
 			return flag;
 		});
 	},
 	//AUI 그리드 데이터 요청
 	load: function(v1, v2) {
 		me = this;
 		 var param = {
 				PRDUCT_CODE : $('#hdProductCode').val()
 		 };
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
 		    data: param,
 		    success:function(data){
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	 			    	
 		    	} else {
 		    		AUIGrid.removeAjaxLoader(me.id);
 		    		alert(data.message);
 		    	}
 		    }
 		});
 	}
 	
 };
function auiGridCellDoubleClickHandler(event) { 
	//alert(" ( " + event.rowIndex + ", " + event.columnIndex + ") :  " + event.value + " double clicked!!");
	
	var str = "";
	var i, rowItem, rowInfoObj, dataField;
	
	selectionMode = AUIGrid.getProperty(me.id, "selectionMode");
	
	var selectedItems = AUIGrid.getSelectedItems(me.id);
	rowInfoObj = selectedItems[0];
	rowItem = rowInfoObj.item;	
	
	if(selectedItems.length <= 0) {
		alert("없음");
		return;
	}
	
	url = "/sdb/b01/SDBB0102.do";
	id ="PRDUCT_CODE";
	val = rowItem.PRDUCT_CODE;	
	POSTSend(url, id, val);
	
};

$(function(){
	//검색 
	  $('#btnSearch').click(function(){	  	
		  grProductList.load();	  	 
	  });
	
// 	$('#btnClCodeDelete').click(function() {
// 		AUIGrid.removeRow(grProductList.id, "selectedIndex");
// 	});

});



$(window).resize(function(){
	if (grProductList.id) {
		AUIGrid.resize(grProductList.id);
	}	
});



</script>
</head>
<body>
<div id="wrap">
	<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0101&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0101&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>의약품 관리</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>기본정보관리</li>
						<li>의약품 관리</li>
					</ul>
				</nav>
			</article>
			<section class="conBox100 conBox">
				<div class="conBoxInner">		                  
	                    <!-- 상단 그리드 전체메뉴라인 시작-->        
	                    <article class="conGridUpper">
	
	                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
<!-- 	                        <div class="conTitBtnL"> -->
	
<!-- 	                            PRODUCT : <input type="text" id="prductnm_code" class="pdR15"><input type="button" class="btn mgL3"  id="btnSearch" value="검색"> -->
<!-- 	                            <input type="button" id="btnAdd" value="추가"> -->
<!-- 	                            <input type="button" id="btnExcel" value="엑셀"> -->
<!-- 	                        </div> -->
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
	                    <!-- 상단 그리드 전체메뉴라인 끝-->        
	
	                    <!-- 그리드 시작 -->
	                    <article class="mgT45">
	                        <!-- 에이유아이 그리드가 이곳에 생성 -->
	                        <div id="grProductList" class="gridHeiSz16 grid_wrap tb01_2"></div>
	                    </article>
	                    <!-- 그리드 끝 -->
	
	            </div>
				
			</section>
		</div>
	</section>
</div>	
</body>
</html>