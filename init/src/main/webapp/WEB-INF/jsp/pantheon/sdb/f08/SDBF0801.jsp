<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>Reconciliation</title>
<script type="text/javascript">
$(function(){
	btnInit();
	setInit();
	grReconciliationList.createGrid();
});

function btnInit(){
	$('#btnAdd').click(function(){
		window.location.href = "/sdb/b01/SDBB0102.do";
	});
	
	$('#btnSearch').click(function(){
		
		var param = {
				ORGAN_DATE : $('#txtorgan_date').val(),
	 			ORGAN_DATE_END : $('#txtorgan_date_end').val()
			};
		
		grReconciliationList.proxy.param = param;				
		grReconciliationList.load();
	});
	
	$('#btnExcel').click(function() {
		
		var data = AUIGrid.getGridData(grReconciliationList.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grReconciliationList.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grReconciliationList.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
	
	
}

function setInit(){
	mkSetDatePickerYYMMDD("#txtorgan_date");
	mkSetDatePickerYYMMDD("#txtorgan_date_end");
	
}

var me;
var grReconciliationList = {
 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grReconciliationList.id);
 	id: '',
 	//AUI그리드 생성할 div 및 페이징 옵션
 	div: {
 		gridDiv: '#grReconciliationList',
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
 		url: './selectReconciliationList.do',
 		param: {
 			ORGAN_DATE : $('#txtorgan_date').val(),
 			ORGAN_DATE_END : $('#txtorgan_date_end').val()
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
 		dataField : "MAFU_NO",
 		headerText : "Manufactoring No", 		 		
 		filter : {
 			showIcon : true
 		}
 		
 	},{
 		dataField : "PRTCL_NO",
 		headerText : "Protocol No", 		
 		filter : {
 			showIcon : true
 		}	
 	},{
 		dataField : "SERIUSFMNM_AT",
 		headerText : "AE/SAE",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "ORGAN",
 		headerText : "보고기관",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "RECON",
 		headerText : "Reconciliation 여부", 		
		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "HRMFLNS_CASE_CODE",
 		headerText : "HRMFLNS_CASE_CODE",
 		visible : false
 	},{
 		dataField : "FOLLOW_NO",
 		headerText : "FOLLOW_NO",
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
 		var me = this;
 		
 	},
 	//AUI 그리드 데이터 요청
 	load: function(v1, v2) {
 		var me = this;
 		var param = {
 				ORGAN_DATE : $('#txtorgan_date').val(),
 	 			ORGAN_DATE_END : $('#txtorgan_date_end').val()
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


$(window).resize(function(){
	if(grReconciliationList.id){
		AUIGrid.resize(grReconciliationList.id);
	}
});





</script>
</head>
<body>
<div id="wrap">
	<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBF0801&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBF0801&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>${progrmMap.MENU_NM}</h3>
                <nav id="pathNav">
                    <ul>
                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
                        <li>${progrmMap.UPPER_MENU_NM}</li>
                        <li>${progrmMap.MENU_NM}</li>
                    </ul>
                </nav>
			</article>
			<section class="conBox100 conBox">
				<div class="conBoxInner">		                  
	                    <!-- 상단 그리드 전체메뉴라인 시작-->        
	                    <article class="conGridUpper">
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold';">보고일 :</span>
								<div class="dateBox">
									<input type="text" id="txtorgan_date" style="width:114px;"/>
								</div>
								 - 
								<div class="dateBox">
									<input type="text" id="txtorgan_date_end" style="width:114px;"/>
								</div>
								
								
								<input type="button" class="btn mgL10" id="btnSearch" value="검색">
							</div>
	                       <div class="conTitBtnR">									
								<input type="button" id="btnBind" value="바인드다운">								
							</div>
	
	                    </article>
	                    <!-- 상단 그리드 전체메뉴라인 끝-->        
	
	                    <!-- 그리드 시작 -->
	                    <article class="mgT55">
	                        <!-- 에이유아이 그리드가 이곳에 생성 -->
	                        <div id="grReconciliationList" class="grid_wrap tb01_2"></div>
	                    </article>
	                    <!-- 그리드 끝 -->
	
	            </div>
				
			</section>
		</div>
	</section>
</div>	
</body>
</html>