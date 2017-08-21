<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>Literature 조회/리스트</title>
<script type="text/javascript">

$(function(){
	btnInit();
	grLiterature_list.createGrid();
	AUIGrid.setGridData(grLiterature_list.id, []);
	
	$('#btnSearch').click(function(){
		grLiterature_list.load();
	});
	
	$('#btnAdd').click(function(){
		window.location.href='/sdb/c01/SDBC0107.do';
	});
});
	
function btnInit(){
	$('#tabTrial').click(function(){
		window.location.href ="/sdb/c01/SDBC0101.do";
	});
	$('#tabSpontaneous').click(function(){
		window.location.href ="/sdb/c01/SDBC0104.do";
	});
	$('#tabLiterature').click(function(){
		window.location.href ="/sdb/c01/SDBC0106.do";
	});	
	$('#tabEtc').click(function(){
		window.location.href ="/sdb/c01/SDBC0108.do";
	});
	$('#tabICSR').click(function(){
		window.location.href ="/sdb/c01/SDBC0110.do";
	});
	
	$('#btnExcel').click(function() {
		
		var data = AUIGrid.getGridData(grLiterature_list.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grLiterature_list.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grLiterature_list.id, true, exportProps);
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

window.onresize = function() {
	if (typeof grLiterature_list.id !== "undefined") {
		AUIGrid.resize(grLiterature_list.id);
	}

}

var grLiterature_list = {
 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grLiterature_list.id);
 	id: '',
 	//AUI그리드 생성할 div 및 페이징 옵션
 	div: {
 		gridDiv: '#grLiterature_list',
 		paging: {
 			pagingDiv: '',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	//데이터 연계 옵션
 	proxy: {
 		url: './selectLiteratureList.do',
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
		'selectionMode': 'singleRow',
		'editable': false,		
	    usePaging : false,
	    enableFilter : true,
	    pageRowCount : 5,
	    showPageButtonCount : 5,
	    fixedColumnCount : 2,
	    headerHeight: 40,
	    rowHeight: 37
 	},
 	//AUI 그리드 레이아웃 
 	columnLayout : [{
 		dataField : "PRDUCTNM_CODE",
 		headerText : "PRODUCT",
		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LTRTRE_NO",
 		headerText : "Literature No.",
 		width: 130,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LTRTRE_SJ",
 		headerText : "Literature Title",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FOLLOW_NO",
 		headerText : "FOLLOW",
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
 		AUIGrid.bind(me.id, "cellDoubleClick", auiGridCellDoubleClickHandler);
		 		 		
 		me.binding();
 		
//  		if(me.proxy.autoLoad) {
//  			me.load();
//  		}
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
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: param,
 		    success:function(data){
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 		    	} else {
 		    		AUIGrid.removeAjaxLoader(me.id);
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
 	}
};

function auiGridCellDoubleClickHandler() {

	var str = "";
	var i, rowItem, rowInfoObj, dataField;

	selectionMode = AUIGrid.getProperty(grLiterature_list.id, "selectionMode");

	var selectedItems = AUIGrid.getSelectedItems(grLiterature_list.id);
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

	
	$('#iLTRTRE_NO').val(rowItem.LTRTRE_NO);
	$('#iform').submit();
}
</script>
</head>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<form id="iform" method="post" action="/sdb/c01/SDBC0107.do">
	<input type="hidden" name="LTRTRE_NO" id="iLTRTRE_NO" />
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
					<form id="iform" method="post" action="/sdb/c01/SDBC0107.do">
					<input type="hidden" name="LTRTRE_NO" id="iLTRTRE_NO" />
					

						<div class="button_tab_01">
							<ul>
								<li id="tabTrial" class="tab_menu">Study</li>
								<li id="tabSpontaneous" class="tab_menu">Spontaneous</li>
								<li id="tabLiterature" class="port_back tab_menu">Literature</li>
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
	                        <div id="grLiterature_list" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>
					</form>
				</div>
            </section>
		</div>
	</section>
</div>
</form>
</body>
</html>