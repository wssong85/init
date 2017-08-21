<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>EDC List</title>
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
	setinit();
});

	function btnInit(){
		$('#btnAdd').click(function(){
			window.location.href = "/sdb/b01/SDBB0102.do";
		});
		
		$('#btnSearch').click(function(){
			
			var param = {
					PRDUCT_CODE : $('#hdProductCode').val()
				};
			
			grEdcList.proxy.param = param;				
			grEdcList.load();
		});
		
		$('#btnExcel').click(function() {
			
			var data = AUIGrid.getGridData(grEdcList.id);
			
			if(data.length) {
				var exportProps = {
						fileName : "Study_List"
				};
				AUIGrid.setProperty(grEdcList.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
				AUIGrid.exportToXlsx(grEdcList.id, true, exportProps);
			} else {
				alert('데이터 확인');
			}
		});
		
		$('button[popup_type=ProductSearch], input[popup_type=ProductSearch]').click(function(){
			mkLayerPopupOpen("/sdb/b02/popupSDBB0204.do", null);
			if (typeof grEdcList_Search.id !== "undefined") {
				AUIGrid.resize(grEdcList_Search.id);
			}
			return false;
		});
		
	}

function setinit(){
	txtdate_st
	
	mkSetDatePickerYYMMDD("#txtdate_st", "#txtdate_end");
	$("#txtdate_st, #txtdate_end").val('');
	
	
}
$(document).ready(function() {
	grEdcList.createGrid();
});

var me;
var grEdcList = {
 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grEdcList.id);
 	id: '',
 	//AUI그리드 생성할 div 및 페이징 옵션
 	div: {
 		gridDiv: '#grEdcList',
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
 		url: "<c:url value='/sdb/b01/selectProductList.do'/>",
 		
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
 		headerText : "MAFU NO.", 
 		width : "10%",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
 		headerText : "Product Name", 		
 		filter : {
 			showIcon : true
 		}	
 	},{
 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE2",
 		headerText : "Serious",
 		width : "5%",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CONFM_DTE",
 		headerText : "등록일",
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		width : "8%",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE3",
 		headerText : "Casuality",
 		//formatString : "yyyy/mm/dd", 		
 		width : "15%", 		
		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FRST_MFBIZ_CODE",
 		headerText : "Status",
 		width : "10%",
 		 renderer : { // HTML 템플릿 렌더러 사용
 			type : "TemplateRenderer"
 		},
 		// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
 		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
 			if(!value)	return "";		
 			var template = '<div style="display:inline-block; margin-top:4px; line-height:12px;">';		
 			template += '<img style="width:auto; height:12px;" src="/images/pantheon/common/AUIGrid/download_icon.png">';		
 			template += '</div>';
 			return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
 		}, 	  
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "GNRL_NM_CODE1",
 		headerText : "Email",
 		width : "20%",
 		renderer : { // HTML 템플릿 렌더러 사용
 			type : "TemplateRenderer"
 		},
 		// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
 		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
 			if(!value)	return "";		
 			var template = '<div style=" margin:0 auto;">';		
 			template += '<a href="#" class="my_a_tag" style=" padding:10px 10px 0 0; display:block; text-align:center;" onclick="javascript:Email_charge('+ item.DETAIL_SN+');"><img src="/images/pantheon/common/AUIGrid/download_icon.png"/>';		
 			template += '</a></div>';
 			return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
 		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "COMAVA_AT",
 		headerText : "Query",
 		width : "10%",
 		renderer : { // HTML 템플릿 렌더러 사용
 			type : "TemplateRenderer"
 		},
 		// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
 		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
 			if(!value)	return "";		
 			var template = '<div style=" margin:0 auto;">';		
 			template += '<a href="#" class="my_a_tag" style=" padding:10px 10px 0 0; display:block; text-align:center;" onclick="javascript:fn_downFile('+ value +','+ item.DETAIL_SN+');"><img src="/images/pantheon/common/AUIGrid/download_icon.png"/>';		
 			template += '</a></div>';
 			return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
 		},
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
 		AUIGrid.bind(grEdcList.id, 'cellEditBegin', function(event) {
 			
 			var flag = false;
 			
 			var addedRowItems = AUIGrid.getAddedRowItems(grEdcList.id);
 			
 			//uu_id 로 add 인지 아닌지 유효성 검사
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(grEdcList.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			//현재 index가 0인지 아닌지 판단.(행추가 row는 상관이 없다.)
 			if(AUIGrid.getSelectedIndex(grEdcList.id)[grEdcList.id]) {
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
		  grEdcList.load();	  	 
	  });
	
// 	$('#btnClCodeDelete').click(function() {
// 		AUIGrid.removeRow(grEdcList.id, "selectedIndex");
// 	});

});

$(window).resize(function(){
	if (grEdcList.id) {
		AUIGrid.resize(grEdcList.id);
	}
});

function Email_charge(num){
	mkLayerPopupOpen("/sdb/e03/popupSDBE0308.do", null);
	if (typeof grCharge_D.id !== "undefined") {
		AUIGrid.resize(grCharge_D.id);
	}
	return false;
	
}

function fn_sendMail(email, dname, dcode, hrmflns_case_code, follow_no){
	var params = {
		 EMAIL 				: email
		,DNAME 				: dname
		,CHARGER_SN			: dcode
		,HRMFLNS_CASE_CODE 	: hrmflns_case_code
		,FOLLOW_NO 			: follow_no
		,USER_ID 			: '${loginMap.USER_ID}'
	};
	$.ajax({
		type : "post",
		url : "/sdb/e03/insertSendMail.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {
			if (data.success) {
				alert('메일을 발송하였습니다.');
				
			} else {
				alert(data.message);
			}
		},
		error : function(xhr, textStatus, errorThrown) {
			alert("실패");
		}
	});	
}





</script>
</head>
<body>
<div id="wrap">
	<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBE0305&UPPER_MENU_ID=SDBE" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBE0305&UPPER_MENU_ID=SDBE" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>EDC LIST</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>분석</li>
						<li>EDC LIST</li>
					</ul>
				</nav>
			</article>
			<section class="conBox100 conBox">
				<div class="conBoxInner">		                  
	                    <!-- 상단 그리드 전체메뉴라인 시작-->        
	                    <article class="conGridUpper">
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold';">등록일 </span>
								<div class="dateBox">
								<input type="text" id="txtdate_st" class="pdR15" >
								</div>
								~
								<div class="dateBox">
								<input type="text" id="txtdate_end" class="pdR15" >
								</div>
								
								<input type="button" class="btn mgL10" id="btnSearch" value="검색">
							</div>
	                       <div class="conTitBtnR">									
								<input type="button" id="btnEmail" value="Email전송내역">
								<input type="button" id="btnExcel" value="엑셀">
							</div>
	
	                    </article>
	                    <!-- 상단 그리드 전체메뉴라인 끝-->        
	
	                    <!-- 그리드 시작 -->
	                    <article class="mgT55">
	                        <!-- 에이유아이 그리드가 이곳에 생성 -->
	                        <div id="grEdcList" class="grid_wrap tb01_2"></div>
	                    </article>
	                    <!-- 그리드 끝 -->
	
	            </div>
				
			</section>
		</div>
	</section>
</div>	
</body>
</html>