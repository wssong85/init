<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<style>


.order_style_01{ text-align:center; }
.order_style_01 .aui-grid-renderer-base{padding:0 !important;}

.use_style_01{ text-align:center; }
.use_style_01 .aui-grid-renderer-base{padding:0 !important;}

/* 
.aui-grid-default-header{ text-indent: 0px;}
.aui-grid-default-header .aui-grid-renderer-base span:first-child{ line-height:12px; font-size:12px; display:inline-block; padding:6px 0 0 10px;}

.aui-grid-row-num-header{text-indent: 10px;}

 */
</style>
<script type="text/javascript">

var grCmUpperMenu = {
 	id: '',
 	div: {
 		gridDiv: '#grCmUpperMenu'
 	},
 	proxy: {
 		url: "<c:url value='/com/a01/selectCmMenuListForUpperMenuId.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		//페이징 true, false 로 지정
 		paging: false,
 		//처음 시작시 데이터 로딩
 		autoLoad: true
 	},
 	gridPros: {
 		showStateColumn: true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    enableFilter : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    headerHeight: 40,
	    rowHeight: 37
	    //selectionMode : "multipleRows"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText : '<spring:message code="coma0101.gr.MODULE_CODE" /><span class="must_01"></span>',
 		filter : {
 			showIcon : true
 		},
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			var me = grCmUpperMenu;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[0].editRenderer.list.length; i++) {
				if(me.columnLayout[0].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[0].editRenderer.list[i]['CMMN_CODE'];
					break;
				}
			}
			
			if(retStr) {
				return retStr;	
			} else {
				return value;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : '',
			keyField : "CMMN_CODE",
			valueField : "CMMN_CODE_NM"
		}
 	},{
 		dataField : "MENU_ID",
 		headerText : '<spring:message code="coma0101.gr.MENU_ID"/><span class="must_01"></span>',
 		width : 93,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_NM"/><span class="must_01"></span>',
 		width : 147,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ENG_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_ENG_NM"/>',
 		width : 165,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_JAPAN_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_JAPAN_NM"/>',
 		width : 180,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_CHINA1_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_CHINA1_NM"/>',
 		width : 183,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_CHINA2_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_CHINA2_NM"/>',
 		width : 183,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ORDR",
 		headerText : '<spring:message code="coma0101.gr.MENU_ORDR"/><span class="must_01"></span>',
 		width: 96,
 		style:"order_style_01",
 		filter : {
 			showIcon : true
 		},
		editRenderer : {
			type : "NumberStepRenderer",
			min : 0,
			max : 20,
			step : 1
		}
 	},{
 		dataField : "MENU_DC",
 		headerText : '<spring:message code="coma0101.gr.MENU_DC"/>',
 		width : 156,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USE_YN",
 		headerText : '<spring:message code="coma0101.gr.USE_YN"/>',
 		width : 96,
 		style:"use_style_01",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPDATE_NM",
 		headerText : '<spring:message code="coma0101.gr.UPDATE_NM"/>',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="coma0101.gr.LAST_UPDDE"/>',
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		width : 96,
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
 		
		$.ajax({
			url : "<c:url value='/com/common/selectQueryDataList.do'/>",
			type: 'post',
			dataType: 'json',
			data:{'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'COM007'},
			success : function(data) {
				if(data.success) {
					me.columnLayout[0].editRenderer.list = data.result;
				} else {
			    	alert(data.message);
			    }
			},
			error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
			}
		});
 		
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		grCmMenu.createGrid();
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	//AUI 그리드 이벤트 
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
 			
 			var flag = false;
 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
 			
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			if(AUIGrid.getSelectedIndex(me.id)[1] > 1 && AUIGrid.getSelectedIndex(me.id)[1] < 10) {
 				flag = true;
 			}
 			
 			return flag;
 		});
 		
		AUIGrid.bind(me.id, 'selectionChange', function(e) {
			grCmMenu.proxy.param['UPPER_MENU_ID'] = e.selectedItems[0].item['MENU_ID'];
			grCmMenu.load();
		});
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		AUIGrid.showAjaxLoader(me.id);
 		
 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
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

var grCmMenu = {
 	id: '',
 	div: {
 		gridDiv: '#grCmMenu'
 	},
 	proxy: {
 		url: "<c:url value='/com/a01/selectCmMenuListByUpperMenuId.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		//페이징 true, false 로 지정
 		paging: false,
 		//처음 시작시 데이터 로딩
 		autoLoad: false
 	},
 	gridPros: {
	    // 페이징 사용
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    showStateColumn: true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,
		height: 265,
	    headerHeight: 40,
	    rowHeight: 37
	    //selectionMode : "multipleRows"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText : '<spring:message code="coma0101.gr.MODULE_CODE"/><span class="must_01"></span>',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ID",
 		headerText : '<spring:message code="coma0101.gr.MENU_ID"/><span class="must_01"></span>',
 		width : 93,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_NM"/><span class="must_01"></span>',
 		width : 147,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ENG_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_ENG_NM"/>',
 		width : 165,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_JAPAN_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_JAPAN_NM"/>',
 		width : 180,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_CHINA1_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_CHINA1_NM"/>',
 		width : 183,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_CHINA2_NM",
 		headerText : '<spring:message code="coma0101.gr.MENU_CHINA2_NM"/>',
 		width : 183,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ORDR",
 		headerText : '<spring:message code="coma0101.gr.MENU_ORDR"/><span class="must_01"></span>',
 		width : 106,
 		style:"order_style_01",
		editRenderer : {
			type : "NumberStepRenderer",
			min : 0,
			max : 20,
			step : 1
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_DC",
 		headerText : '<spring:message code="coma0101.gr.MENU_DC"/>',
 		width : 156,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USE_YN",
 		headerText : '<spring:message code="coma0101.gr.USE_YN"/>',
 		width : 96,
 		style:"use_style_01",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPDATE_NM",
 		headerText : '<spring:message code="coma0101.gr.UPDATE_NM"/>',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="coma0101.gr.LAST_UPDDE"/>',
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		width : 96,
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	//AUI 그리드 이벤트 
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
 			
 			var flag = false;
 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
 			
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			if(AUIGrid.getSelectedIndex(me.id)[1] > 1 && AUIGrid.getSelectedIndex(me.id)[1] < 11) {
 				flag = true;
 			}
 			
 			return flag;
 		});
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		AUIGrid.showAjaxLoader(me.id);
 		
 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
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

function f_requestRequstNo_1(v) {
	console.log('RequstNo : ' + v);
}
function f_requestRequstNo_2(v) {
	console.log('RequstNo : ' + v);
}
function f_requestRequstNo_3(v) {
	console.log(v);
}

$(function(){
	grCmUpperMenu.createGrid();
	
	$('#btnCmUpperMenuInit').click(function() {
		AUIGrid.destroy(grCmUpperMenu.id);
		AUIGrid.destroy(grCmMenu.id);
		grCmUpperMenu.createGrid();
	});
	
	$('#btnTest').click(function() {
		mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
			'REQUST_NM': '테스트결재',
			'callbackFunction': 'f_requestRequstNo_1'
		}, 1);
	});
	
	$('#btnTest2').click(function() {
		mkLayerPopupOpen('/com/z09/popupCOMZ0903.do', {
			'REQUST_NO': '399',
			'callbackFunction': 'f_requestRequstNo_2'
		});
	});
	
	$('#btnTest3').click(function() {
		mkLayerPopupOpen('/com/anonymous/popupCOMZ0501.do', {
			'callbackFunction': 'f_requestRequstNo_3'
		});
	});
	
	$('#btnCmMenuAdd').click(function() {
		if(AUIGrid.getSelectedItems(grCmUpperMenu.id)[0].item['MODULE_CODE'] == AUIGrid.getSelectedItems(grCmUpperMenu.id)[0].item['MENU_ID']) {
			alert('<spring:message code="coma0101.msg.1"/>');
			return;
		}
		
		var row = {
				'MODULE_CODE': AUIGrid.getSelectedItems(grCmUpperMenu.id)[0].item['MODULE_CODE'],
				'MENU_ID': '',
				'UPPER_MENU_ID': AUIGrid.getSelectedItems(grCmUpperMenu.id)[0].item['MENU_ID'], 
				'MENU_NM': '',
				'MENU_ORDR': '',
				'MENU_DC': '',
				'USE_YN': 'Y',
				'UPDATE_NM': '${loginMap.USER_NM}',
				'LAST_UPDDE': new Date(),
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmMenu.id, row, 'first'); // 최하단에 행 추가
	});
	
	$('#btnCmMenuDelete').click(function() {
		AUIGrid.removeRow(grCmMenu.id, "selectedIndex");
	});
	
	$('#btnCmMenuSave').click(function() {
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}

		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grCmMenu.id);
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grCmMenu.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grCmMenu.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = '${loginMap.USER_ID}';
			arJson.push(editedItems[i]);
		}
				
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			arJson.push(removeItems[i]);
		}
		
		if(!arJson.length) {
			alert('<spring:message code="message.null.1"/>');
			return;
		}
		
		for(var i = 0; i < arJson.length; i++ ) {
			if(!arJson[i]['MODULE_CODE'] || !arJson[i]['MENU_ID'] || !arJson[i]['MENU_NM'] || !arJson[i]['MENU_ORDR']) {
				alert('<spring:message code="message.validation.2"/>');
				return;
			}
		}
		
		$.ajax({
			  url : "<c:url value='/com/a01/insertCmMenuByUpperMenu.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  alert('<spring:message code="message.save.2"/>');
					  grCmMenu.load()
				  } else {
					  AUIGrid.removeAjaxLoader(grCmMenu.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	
	$('#btnCmUpperMenuAdd').click(function() {
		var row = {
				'MODULE_CODE': '',
				'MENU_ID': '',
				'MENU_NM': '',
				'MENU_ORDR': '',
				'MENU_DC': '',
				'MODULE_SE': '0',
				'USE_YN': 'Y',
				'UPDATE_NM': '${loginMap.USER_NM}',
				'LAST_UPDDE': new Date(),
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmUpperMenu.id, row, 'first'); // 최하단에 행 추가
	});
	
	$('#btnCmUpperMenuDelete').click(function() {
		AUIGrid.removeRow(grCmUpperMenu.id, "selectedIndex");
	});
	
	$('#btnCmUpperMenuSave').click(function() {
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grCmUpperMenu.id);
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grCmUpperMenu.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grCmUpperMenu.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = '${loginMap.USER_ID}';
			arJson.push(editedItems[i]);
		}
				
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			arJson.push(removeItems[i]);
		}
		
		if(!arJson.length) {
			alert('<spring:message code="message.null.1"/>');
			return;
		}
		
		for(var i = 0; i < arJson.length; i++ ) {
			if(!arJson[i]['MODULE_CODE'] || !arJson[i]['MENU_ID'] || !arJson[i]['MENU_NM'] || !arJson[i]['MENU_ORDR']) {
				alert('<spring:message code="message.validation.2"/>');
				return;
			}
		}
		
		$.ajax({
			  url : "<c:url value='/com/a01/insertCmMenuForUpperMenu.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  alert('<spring:message code="message.save.2"/>');
					  grCmUpperMenu.load()
				  } else {
					  AUIGrid.removeAjaxLoader(grCmUpperMenu.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
});

$(window).resize(function() {
	if (grCmUpperMenu && grCmUpperMenu.id) {
		AUIGrid.resize(grCmUpperMenu.id);
	}
	if (grCmMenu && grCmMenu.id) {
		AUIGrid.resize(grCmMenu.id);
	}
});
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMA0101&UPPER_MENU_ID=COMA" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMA0101&UPPER_MENU_ID=COMA" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>${progrmMap.MENU_NM}</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="<c:url value='/images/pantheon/common/pathNavIco.png'/>" alt="">Home</li>
						<li>${progrmMap.UPPER_MENU_NM}</li>
						<li>${progrmMap.MENU_NM}</li>
					</ul>
				</nav>
			</article>

            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                 <!-- 컨텐츠 타이틀 시작-->
                 <article class="conTitBox">
                     <h5><spring:message code="coma0101.title_2" /></h5>
                 </article>
						
				<article class="conTitBtnR">
					<input type="button" id="btnCmUpperMenuInit" value=<spring:message code="btn.init"/> class="reset_01" title="<spring:message code="btn.init"/>">
					<input type="button" id="btnCmUpperMenuAdd" value=<spring:message code="btn.rowAdd"/> class="add_01" title="<spring:message code="btn.rowAdd"/>">
					<input type="button" id="btnCmUpperMenuDelete" value=<spring:message code="btn.rowDelete"/> class="del_01" title="<spring:message code="btn.rowDelete"/>">
					<input type="button" id="btnCmUpperMenuSave" value=<spring:message code="btn.save"/> class="save_01" title="<spring:message code="btn.save"/>">
					<input type="button" id="btnTest" class="popup-button" value="결재선테스트">
					<input type="button" id="btnTest2" value="전자결재테스트">
					<input type="button" id="btnTest3" value="우편번호테스트">
				</article>
				
				<article class="mgT16">
					<div id="grCmUpperMenu" class="gridHeiSz10 grid_wrap tb01_2"></div>
				</article>
				<!-- 컨텐츠 타이틀 끝-->

                </div>
            </section>
		
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5><spring:message code="coma0101.title_3" /></h5>
		            </article>
		            
					<article class="conTitBtnR">
						<input type="button" id="btnCmMenuAdd" value=<spring:message code="btn.rowAdd"/> class="add_01" title="<spring:message code="btn.rowAdd"/>">
						<input type="button" id="btnCmMenuDelete" value=<spring:message code="btn.rowDelete"/> class="del_01" title="<spring:message code="btn.rowDelete"/>">
						<input type="button" id="btnCmMenuSave" value=<spring:message code="btn.save"/> class="save_01" title="<spring:message code="btn.save"/>">
					</article>
					
					<article class="mgT16">
						<div id="grCmMenu" class="gridHeiSz06 grid_wrap tb01_2"></div>
	                </article>
				</div>
			</section>
            <!-- 컨텐츠박스 끝-->
            



            
		</div>
	</section>
</div>
</body>
</html>