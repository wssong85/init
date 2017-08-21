<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/com/common.do" flush="false"/>

<title>메뉴 관리</title>
<script type="text/javascript">
$(document).ready(function() {
	grCmUpperMenu.createGrid();
});

window.onresize = function() {
	if (typeof grCmUpperMenu.id !== "undefined") {
		AUIGrid.resize(grCmUpperMenu.id);
	}
	if (typeof grCmMenu.id !== "undefined") {
		AUIGrid.resize(grCmMenu.id);
	}
}

var grCmUpperMenu = {
 	id: '',
 	div: {
 		gridDiv: '#grCmUpperMenu'
 	},
 	proxy: {
 		url: './selectCmMenuListForUpperMenuId.do',
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		//페이징 true, false 로 지정
 		paging: false,
 		//처음 시작시 데이터 로딩
 		autoLoad: true
 	},
 	gridPros: {
	    // 페이징 사용
// 	    usePaging : true,
// 	    pageRowCount : 15,
// 	    showPageButtonCount : 5,
	    
	    enableFilter : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    showStateColumn: true,
// 		height: 265,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText : "모듈<span class='must_01'></span>",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ID",
 		headerText : "메뉴ID<span class='must_01'></span>",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText : "메뉴명",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ORDR",
 		headerText : "정렬순서",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_DC",
 		headerText : "설명",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USE_YN",
 		headerText : "사용여부",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPDATE_ID",
 		headerText : "등록자",
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : "등록일",
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		editable : false
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
 		
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
 			
 			if(AUIGrid.getSelectedIndex(me.id)[1]) {
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
//  		    cache: true,
//  		    async: true,
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
 		url: './selectCmMenuListByUpperMenuId.do',
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
	    usePaging : true,
	    pageRowCount : 5,
	    showPageButtonCount : 5,
	    
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,
		height: 265,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText : "모듈<span class='must_01'></span>",
 		width: 120,
 		editable : false,
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
			valueField : "CMMN_CODE"
		}
 	},{
 		dataField : "MENU_ID",
 		headerText : "메뉴ID<span class='must_01'></span>",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText : "메뉴명",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MODULE_SE",
 		headerText : "대표메뉴",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ORDR",
 		headerText : "정렬순서",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_DC",
 		headerText : "설명",
 		width: 120,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USE_YN",
 		headerText : "사용여부",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		}
 	},{
 		dataField : "UPDATE_ID",
 		headerText : "등록자",
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : "등록일",
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
 		
		$.ajax({
			url : '/com/common/selectQueryDataList.do',
			type: 'post',
			dataType: 'json',
			data:{'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'COM007'},
			success : function(data) {
				if(data.success) {
					me.columnLayout[0].editRenderer.list = data.result;
					
			 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			 		
			 		me.binding();
			 		
			 		if(me.proxy.autoLoad) {
			 			me.load();
			 		}
				} else {
			    	alert(data.message);
			    }
			},
			error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
			}
		});
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
 			
 			if(AUIGrid.getSelectedIndex(me.id)[1]) {
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

function f_requestRequstNo_1(v) {
	console.log('RequstNo : ' + v);
}
function f_requestRequstNo_2(v) {
	console.log('RequstNo : ' + v);
}

$(function(){
	
	$('#btnTest').click(function() {
		mkLayerPopupOpen('/com/z09/COMZ0901.do', {
			'REQUST_NM': '테스트결재',
			'callbackFunction': 'f_requestRequstNo_1'
		}, 1);
	});
	
	$('#btnTest2').click(function() {
		mkLayerPopupOpen('/com/z09/popupCOMZ0903.do', {
			'REQUST_NO': '39',
			'callbackFunction': 'f_requestRequstNo_2'
		});
	});
	
	$('#btnCmMenuAdd').click(function() {
		var row = {
				'MODULE_CODE': AUIGrid.getSelectedItems(grCmUpperMenu.id)[0].item['MODULE_CODE'],
				'MENU_ID': '',
				'UPPER_MENU_ID': AUIGrid.getSelectedItems(grCmUpperMenu.id)[0].item['MENU_ID'], 
				'MENU_NM': '',
				'MENU_ORDR': '',
				'MENU_DC': '',
				'USE_YN': 'Y',
				'UPDATE_ID': '${loginMap.USER_ID}',
				'LAST_UPDDE': new Date(),
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmMenu.id, row, 'first'); // 최하단에 행 추가
	});
	
	$('#btnCmMenuDelete').click(function() {
		AUIGrid.removeRow(grCmMenu.id, "selectedIndex");
	});
	
	$('#btnCmMenuSave').click(function() {
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
		
// 		for(var i = 0; i < arJson.length; i++ ) {
// 			if(!arJson[i]['CMMN_CLCODE'] || !arJson[i]['CMMN_CLCODE_NM']) {
// 				alert('입력확인');
// 				return;
// 			}    
// 		}
		
		$.ajax({
			  url : './insertCmMenuByUpperMenu.do',
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
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
				'UPDATE_ID': '${loginMap.USER_ID}',
				'LAST_UPDDE': new Date(),
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmUpperMenu.id, row, 'first'); // 최하단에 행 추가
	});
	
	$('#btnCmUpperMenuDelete').click(function() {
		AUIGrid.removeRow(grCmUpperMenu.id, "selectedIndex");
	});
	
	$('#btnCmUpperMenuSave').click(function() {
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
		
// 		for(var i = 0; i < arJson.length; i++ ) {
// 			if(!arJson[i]['CMMN_CLCODE'] || !arJson[i]['CMMN_CLCODE_NM']) {
// 				alert('입력확인');
// 				return;
// 			}    
// 		}
		
		$.ajax({
			  url : './insertCmMenuForUpperMenu.do',
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
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
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMA0101&UPPER_MENU_ID=COMA" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMA0101&UPPER_MENU_ID=COMA" charEncoding="utf-8"/>




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>메뉴관리</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>메뉴관리</li>
						<li>메뉴관리</li>
					</ul>
				</nav>
			</article>



            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                 <!-- 컨텐츠 타이틀 시작-->
                 <article class="conTitBox">
                     <h5>상위메뉴</h5>
                 </article>
						
				<article class="conTitBtnR">
					<input type="button" id="btnCmUpperMenuAdd" value="행추가">
					<input type="button" id="btnCmUpperMenuDelete" value="행삭제">
					<input type="button" id="btnCmUpperMenuSave" value="저장">
					<input type="button" id="btnTest" class="popup-button" value="테스트">
					<input type="button" id="btnTest2" value="테스트2">
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
						<h5>하위메뉴</h5>
		            </article>
		            
					<article class=" conTitBtnR">
						<input type="button" id="btnCmMenuAdd" value="행추가">
						<input type="button" id="btnCmMenuDelete" value="행삭제">
						<input type="button" id="btnCmMenuSave" value="저장">
					</article>
					
					<article class="mgT16">
						<div id="grCmMenu" class="gridHeiSz05 grid_wrap tb01_2"></div>
	                </article>
				</div>
			</section>








            <!-- 컨텐츠박스 끝-->
		</div>
	</section>
</div>
</body>
</html>