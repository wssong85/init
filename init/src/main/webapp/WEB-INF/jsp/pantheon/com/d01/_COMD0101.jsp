<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>

<!-- <title>공통코드관리</title> -->
<title>공통코드관리</title>
<script type="text/javascript">
$(document).ready(function() {
	grClCode.createGrid();
});

window.onresize = function() {
	if (typeof grClCode.id !== "undefined") {
		AUIGrid.resize(grClCode.id);
	}
	if (typeof grCmmnCode.id !== "undefined") {
		AUIGrid.resize(grCmmnCode.id);
	}
}

var grClCode = {
 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
 	id: '',
 	//AUI그리드 생성할 div 및 페이징 옵션
 	div: {
 		gridDiv: '#grClCode',
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
 		url: './selectCmClCodeListByPk.do',
 		param: {},
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
		'editable': true,
		'showStateColumn': true,
// 	    usePaging : true,
// 	    pageRowCount : 5,
// 	    showPageButtonCount : 5,
		enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{ 
 		dataField : "CMMN_CLCODE",
 		headerText : '<spring:message code="comd0101.gr.CMMN_CLCODE_NM" />',
 		width : 120,
		editRenderer : {
			type : "InputEditRenderer",
			
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, rowItem) {
				var isValid = false;
				var matcher = /^[A-Za-z0-9+]{1,10}$/;
				
				if(matcher.test(newValue)) { 
					isValid = true;
				}
				
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : '<spring:message code="message.validation.1" />' };
			}
		}
 	},{
 		dataField : 'CMMN_CLCODE_NM',
 		headerText : '<spring:message code="comd0101.gr.CMMN_CLCODE_NM" />',
 		width: 120
 	},{
 		dataField : "CMMN_CLCODE_ENGNM",
 		headerText : '<spring:message code="comd0101.gr.CMMN_CLCODE_ENGNM" />',
 		width: 120
 	},{
 		dataField : "USE_AT",
 		headerText : '<spring:message code="gr.USE_YN" />',
		editRenderer : {
			type : "ComboBoxRenderer",
			showEditorBtnOver : true,
			list : ['Y', 'N']
		}
 	},{
 		dataField : "UPDATE_ID",
 		headerText : '<spring:message code="gr.REGIST_ID" />',
 		editable : false
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="gr.FRST_CREDE" />',
 		formatString : "yyyy/mm/dd",
 		dataType:"date",
 		editable : false
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
 		
 		//이후 객체.id 로 AUIGrid 컨트롤
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		grCmmnCode.createGrid();
 		
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
 			
 			//uu_id 로 add 인지 아닌지 유효성 검사
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			//현재 index가 0인지 아닌지 판단.(행추가 row는 상관이 없다.)
 			if(AUIGrid.getSelectedIndex(me.id)[1]) {
 				flag = true;
 			}
 			return flag;
 		});
 		
		AUIGrid.bind(me.id, 'selectionChange', function(e) {
			grCmmnCode.proxy.param['CMMN_CLCODE'] = e.selectedItems[0].item['CMMN_CLCODE'];
			grCmmnCode.load();
		});
	
 	},
 	//AUI 그리드 데이터 요청
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

var grCmmnCode = {
 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
 	id: '',
 	//AUI그리드 생성할 div 및 페이징 옵션
 	div: {
 		gridDiv: '#grCmmnCode'
 	},
 	//데이터 연계 옵션
 	proxy: {
 		url: './selectCmCmmnCodeListByPk.do',
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		//처음 시작시 데이터 로딩
 		autoLoad: false
 	},
 	//AUI 그리드 옵션
 	gridPros: {
		'selectionMode': 'singleRow',
		'editable': true,
		'showStateColumn': true,
// 	    usePaging : true,
// 	    pageRowCount : 5,
// 	    showPageButtonCount : 5,
	    headerHeight: 40,
	    rowHeight: 37
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{ 
 		dataField : "CMMN_CLCODE",
 		headerText : '<spring:message code="comd0101.gr.CMMN_CLCODE" />',
 		editable : false
 	},{
 		dataField : "CMMN_CODE",
 		headerText : '<spring:message code="comd0101.gr.CMMN_CODE" />',
		editRenderer : {
			type : "InputEditRenderer",
			
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, rowItem) {
				var isValid = false;
				var matcher = /^[A-Za-z0-9+]{1,10}$/;
				
				if(matcher.test(newValue)) { 
					isValid = true;
				}
				
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : '<spring:message code="message.validation.1" />' };
			}
		}
 	},{
 		dataField : "UPPER_CMMNCODE",
 		headerText : '<spring:message code="comd0101.gr.UPPER_CMMNCODE" />',
//  		width: 90,
		editRenderer : {
			type : "InputEditRenderer",
			
			// 에디팅 유효성 검사
			validator : function(oldValue, newValue, rowItem) {
				var isValid = false;
				var matcher = /^[A-Za-z0-9+]{1,10}$/;
				
				if(matcher.test(newValue)) { 
					isValid = true;
				}
				
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : '<spring:message code="message.validation.1" />' };
			}
		}
 	},{
 		dataField : "CMMN_CODE_NM",
 		headerText : '<spring:message code="comd0101.gr.CMMN_CODE_NM" />'
 	},{
 		dataField : "CMMN_CODE_ENGNM",
 		headerText : '<spring:message code="comd0101.gr.CMMN_CODE_ENGNM" />'
//  		width: 90
 	},{
 		dataField : "SORT_ORDR",
 		headerText : '<spring:message code="gr.SORT_ORDR" />'
 	},{
 		dataField : "USE_AT",
 		headerText : '<spring:message code="gr.USE_YN" />',
		editRenderer : {
			type : "ComboBoxRenderer",
			showEditorBtnOver : true,
			list : ['Y', 'N']
		}
 	},{
 		dataField : "UPDATE_ID",
 		headerText : '<spring:message code="gr.REGIST_ID" />',
 		editable : false
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="gr.FRST_CREDE" />',
 		formatString : "yyyy/mm/dd",
 		dataType:"date",
 		editable : false
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
 	},
 	//AUI 그리드 이벤트 
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
 			var flag = false;
 			
 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
 			
 			//uu_id 로 add 인지 아닌지 유효성 검사
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			//현재 index가 0인지 아닌지 판단.(행추가 row는 상관이 없다.)
 			if(AUIGrid.getSelectedIndex(me.id)[1] != 1) {
 				flag = true;
 			}
 			return flag;
 		});
 	},
 	//AUI 그리드 데이터 요청
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

$(function(){
	//메뉴상단 행추가
	$('#btnClCodeadd').click(function() {
		var row = {
				'CMMN_CLCODE': '',
				'CMMN_CLCODE_NM': '',
				'UPDATE_ID': '${loginMap.USER_ID}',
				'LAST_UPDDE': new Date(),
				'USE_AT': 'Y',
				'CURD': 'C'
		};
		AUIGrid.addRow(grClCode.id, row, 'last'); // 최하단에 행 추가
	});
	
	//메뉴상단 행삭제
	$('#btnClCodeDelete').click(function() {
		AUIGrid.removeRow(grClCode.id, "selectedIndex");
	});
	
	//메뉴하단 행추가
	$('#btnCmmnCodeAdd').click(function() {
		var row = {
				'CMMN_CLCODE': AUIGrid.getSelectedItems(grClCode.id)[0].item['CMMN_CLCODE'],
				'CMMN_CODE': '',
				'CMMN_CODE_NM': '',
				'UPDATE_ID': '${loginMap.USER_ID}',
				'LAST_UPDDE': new Date(),
				'SORT_ORDR': '1',
				'USE_AT': 'Y',
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmmnCode.id, row, 'last'); // 최하단에 행 추가
	});
	
	//메뉴하단 행삭제
	$('#btnCmmnCodeDelete').click(function() {
		AUIGrid.removeRow(grCmmnCode.id, "selectedIndex");
	});
	
	//메뉴상단 저장
	$('#btnClCodeSave').click(function() {
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grClCode.id);
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grClCode.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grClCode.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = 'admin';
			arJson.push(editedItems[i]);
		}
				
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			arJson.push(removeItems[i]);
		}
		
		for(var i = 0; i < arJson.length; i++ ) {
			if(!arJson[i]['CMMN_CLCODE'] || !arJson[i]['CMMN_CLCODE_NM']) {
				alert('<spring:message code="message.validation.2" />');
				return;
			}    
		}
		
		$.ajax({
 			  url : './insertCmClCode.do',
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  grClCode.load()
				  } else {
					  AUIGrid.removeAjaxLoader(grClCode.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	
	//메뉴하단 저장
	$('#btnCmmnCodeSave').click(function() {
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grCmmnCode.id);
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grCmmnCode.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grCmmnCode.id);

		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = 'admin';
			arJson.push(editedItems[i]);
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			arJson.push(removeItems[i]);
		}
		
		for(var i = 0; i < arJson.length; i++ ) {
			if(!arJson[i]['CMMN_CODE'] || !arJson[i]['CMMN_CODE_NM']) {
				alert('입력확인');
				return;
			}    
		}
		
		$.ajax({
			  url : './insertCmCmmnCode.do',
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {
					  	grCmmnCode.load();
				  } else {
					  AUIGrid.removeAjaxLoader(grCmmnCode.id);
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
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMD0101&UPPER_MENU_ID=COMD" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMD0101&UPPER_MENU_ID=COMD" charEncoding="utf-8"/>



	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>공통코드관리</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>공통코드관리</li>
						<li>공통코드관리</li>
					</ul>
				</nav>
			</article>
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5><spring:message code="comd0101.title_1" /></h5>
                    </article>
                    
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                        <input type="button" id="btnClCodeadd" value=<spring:message code="btn.rowAdd" />>
                        <input type="button" id="btnClCodeDelete" value=<spring:message code="btn.rowDelete" />>
                        <input type="button" id="btnClCodeSave" value=<spring:message code="btn.save" />>
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grClCode" class="gridHeiSz10 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5><spring:message code="comd0101.title_2" /></h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                        <input type="button" id="btnCmmnCodeAdd" value=<spring:message code="btn.rowAdd" />>
                        <input type="button" id="btnCmmnCodeDelete" value=<spring:message code="btn.rowDelete" />>
                        <input type="button" id="btnCmmnCodeSave" value=<spring:message code="btn.save" />>
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grCmmnCode" class="gridHeiSz08 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->
                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
		</div>
	</section>





</div>
</body>
</html>