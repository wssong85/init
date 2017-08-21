<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 상단 css, js 임포트 호출 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<jsp:include page="/com/common.do" flush="false"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
.atch_style_01{ }
.atch_style_01 .aui-grid-renderer-base .aui-grid-button-renderer{ padding:4px 2.2em 7px 1.2em;}
</style>

<script type="text/javascript">
var taskNo = "${loginMap.TASK_NO}";
var taskSn = "${loginMap.TASK_SN}";
var g_grid1 = "Y";
var userId = "${loginMap.USER_ID}";
var selectUserId; //연구자정보의 USER_ID
var selectTaskSn; // 과제순번
var selectKnd; //선택한 KND 종류 (버전관리)
var selectIem; //선택한 IEM 항목 (버전관리)
var selectRow; //선택한 row	(버전관리)
var selectCntrctSn = ""; //연구자정보의 계약번호
var validatorCnt; //byte 범위
var odrCnt ; //차수
var paymentPlans; //계획횟수
var wrap3rowIndex; //grid_wrap3 계획횟수
var pcpmnySum ; //연구비합계
/////////////////연구자정보 그리드///////////////////
var rsrchUserInfo = {
		id: 'rsrchUserInfo',
		div: {
			gridDiv: '#rsrchUserInfo'
		},
		proxy: {
			url: './selectRsrchUserInfo.do',
			param: {},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		reverseRowNum : true,
		showStateColumn: true,
	    showRowNumColumn : true,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
	    editable : false,
	    enableFilter : true,
		//height: 300,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "TASK_SN",
		headerText : "과제순번",
		visible : false,
		editable : false		
	},{
		dataField : "TASK_NO",
		headerText : "과제번호",
		visible : false,
		editable : false	
	},{
		dataField : "INSTT_CODE",
		headerText : "기관코드",
		width : 120,
		editable : false,
		filter : {
			showIcon : true
		}
	},{
		dataField : "ROLE_ID",
		headerText : "ROLE_ID",
		visible : false,
		editable : false
	},{
		dataField : "ROLE_NM",
		headerText : "ROLE",		
		editable : false,
		width : 100,
		filter : {
			showIcon : true
		}
	},{
		dataField : "USER_ID", //5
		headerText : "ID",		
		editable : false,
		visible : false
	},{
		dataField : "USER_NM",
		headerText : "연구자",		
		editable : false,
		width : 120,
		filter : {
			showIcon : true
		}
	},{
		dataField : "EMAIL",
		headerText : "E-mail",		
		editable : false,
		filter : {
			showIcon : true
		}
	},{
		dataField : "TELNO",
		headerText : "전화번호",		
		editable : false,
		width : 150,
		filter : {
			showIcon : true
		}
	},{
		dataField : "GOAL_NO",
		headerText : "목표례수",
		width : 100,
		editable : false,
		filter : {
			showIcon : true
		}
	},{
		dataField : "ISF_PYMNT_AT", //10
		headerText : "ISF 지급여부",		
		editable : true,
		width : 100,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = rsrchUserInfo;
			var retStr = "";
			for(var i=0; me.columnLayout[10].editRenderer.list.length > i; i++) {
				if(me.columnLayout[10].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[10].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
	},{
		dataField : "ISF_PYMNT_DE",
		headerText : "ISF 지급일",		
		editable : true,
		width : 100,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부
			
		}
	},{
		dataField : "DSCNTC_AT",
		headerText : "중단여부<span class='must_01'></span>",	
		editable : true,
		width : 100,
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {							
			var me = rsrchUserInfo;				
			var retStr = "";
			for(var i=0; me.columnLayout[12].editRenderer.list.length > i; i++) {
				if(me.columnLayout[12].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[12].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
		
		
	},{
		dataField : "LAST_PYMNT_DE",
		headerText : "중단 변경일",		
		editable : false,
		dataType : "date",
        formatString : "yyyy-mm-dd",
		
	},{
		dataField : "RM", //15
		headerText : "비고",		
		editable : true,
		editRenderer : {
 			type: "InputEditRenderer",
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false;
				fn_validator(newValue);
 				
 				if(validatorCnt < 1000){ 
 					isValid = true;
 				}
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "CNTRCT_SN",
		headerText : "계약번호",		
		editable : false,
		visible : false		
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
			
			AUIGrid.bind(me.id, "cellDoubleClick", function(event){		
				selectUserId = event.item.USER_ID;
				selectTaskSn = event.item.TASK_SN;
				selectCntrctSn = event.item.CNTRCT_SN;
				odrCnt = 1; //차수
				grid_wrap1.load();
				grid_wrap2.load();
				grid_wrap3.load();
				grid_wrap4.load();
				grid_wrap5.load();
				grid_wrap6.load();
			});
		},
		load: function(v1, v2) {
			var me = this;
			
			
			
			$.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: {'TASK_NO' : taskNo, "USER_NM" : $("#txtUserNm").val()},
			    success:function(data){
			    	if(data.success) {
			    		me.columnLayout[10].editRenderer.list = data.cmCode;
			    		me.columnLayout[12].editRenderer.list = data.activeCode;
			    		var item = data.result;
			    		
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		
				    	
			    	} else {
			    		
			    		alert(data.message);
			    	}
			    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
			});
		}
	};
/////////////////연구자정보 그리드 종료///////////////////

/////////////////조사연구기관 그리드///////////////////
var grid_wrap1 = {
		id: 'grid_wrap1',
		div: {
			gridDiv: '#grid_wrap1'
		},
		proxy: {
			url: './selectRsrchInstt.do',
			param: {},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		reverseRowNum : true,
		showStateColumn: true,
	    showRowNumColumn : true,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
		//height: 150,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "INSTT_CODE",
		headerText : "기관코드",
		visible : false,
		filter : {
			showIcon : true
		},
		editable : false		
	},{
		dataField : "HSPTL_SE",
		headerText : "병원구분",
		editable : true,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer",
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false;
				fn_validator(newValue);
 				
 				if(validatorCnt < 50){ 
 					isValid = true;
 				}
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "IRB_AT",
		headerText : "IRB여부",
		editable : false,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap1;
			var retStr = "";
			for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
				if(me.columnLayout[2].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[2].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
	},{
		dataField : "HSPTL_NM",
		headerText : "병원명",	
		filter : {
			showIcon : true
		},
		editable : false	
	},{
		dataField : "ADDRONE",
		headerText : "지역(시/도)",	
		filter : {
			showIcon : true
		},
		editable : false
	},{
		dataField : "CHRG_CRA",
		headerText : "담당CRA",		
		editable : true,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer",
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt < 32){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
		
	},{
		dataField : "SN",
		headerText : "순번",		
		editable : false,
		filter : {
			showIcon : true
		},
		visible : false
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
			
		},
		load: function(v1, v2) {
			var me = this;
			
			
			
			$.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: {'USER_ID' : selectUserId},
			    success:function(data){
			    	if(data.success) {			    		
			    		me.columnLayout[2].editRenderer.list = data.cmCode;
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		
				    	
			    	} else {
			    		
			    		alert(data.message);
			    	}
			    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
			});
		}
	};
/////////////////조사연구기관 그리드 종료///////////////////

/////////////////계약관리 그리드///////////////////
var grid_wrap2 = {
		id: 'grid_wrap2',
		div: {
			gridDiv: '#grid_wrap2'
		},
		proxy: {
			url: './selectCntrctManage.do',
			param: {},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		reverseRowNum : true,
		showStateColumn: true,
	    showRowNumColumn : true,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
		//height: 150,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "STTUS",
		headerText : "종류",		
		editable : false,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap2;
			var retStr = "";
			for(var i=0; me.columnLayout[0].editRenderer.list.length > i; i++) {
				if(me.columnLayout[0].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[0].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
	},{
		dataField : "EXMNT_REQUST_DE",
		headerText : "검토요청일",
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}		
	},{
		dataField : "CNTRCT_DE",
		headerText : "계약일",
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}		
	},{
		dataField : "CNTRCT_SN",
		headerText : "계약번호",		
		editable : false,
		filter : {
			showIcon : true
		},
	},{
		dataField : "ATCH_FILE",
		headerText : "계약서",	
 		width: 90,
 		maxWidth: 90,
		style:"atch_style_01",
		editable : false,
		filter : {
			showIcon : true
		},
		renderer : {
			type : "ButtonRenderer",				
			onclick : function(rowIndex, columnIndex, value, item){
				 var param = {							 
						 parent_value : item.ATCH_FILE
					};
				//AUIGrid.removeAjaxLoader(myGridID);
				if(item.ATCH_FILE != null){
					mkLayerPopupOpen("/ctms/f01/popupCTMF0104.do", param);
				}
			}
		},
	},{
		dataField : "ATCH_FILE_SE",
		headerText : "계약서 유무",		
		editable : false,
		filter : {
			showIcon : true
		},
		
	},{
		dataField : "PYMNT_PLAN_CNT",
		headerText : "분할지급 계획 횟수",		
		editable : true,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer",
 			onlyNumeric : true,
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 3){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "PYMNT_CNT",
		headerText : "분할지급 횟수",		
		editable : false,
		filter : {
			showIcon : true
		},
		dataType : "numeric"		
 		
	},{
		dataField : "USER_ID",
		headerText : "ID",
		editable : false,
		filter : {
			showIcon : true
		},
		
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
			
		},
		load: function(v1, v2) {
			var me = this;
			
			
			
			$.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: {'USER_ID' : selectUserId, 'TASK_SN' : taskSn},
			    success:function(data){
			    	if(data.success) {			  
			    		
			    		me.columnLayout[0].editRenderer.list = data.cmCode;
			    		paymentPlans = data.result;			    		
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		
				    	
			    	} else {			    	
			    		
			    		alert(data.message);
			    	}
			    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
			});
		}
	};
/////////////////계약관리 그리드 종료///////////////////

/////////////////연구비 그리드///////////////////
var grid_wrap3 = {
		id: 'grid_wrap3',
		div: {
			gridDiv: '#grid_wrap3'
		},
		proxy: {
			url: './selectResearchFunds.do',
			param: {},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
		reverseRowNum : true,
		showStateColumn: true,
	    showRowNumColumn : true,
	    enableCellMerge : true,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
		//height: 150,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "SN",
		headerText : "순번",
		visible : false,
		editable : true,
		filter : {
			showIcon : true
		},
			
	},{
		dataField : "ODR",
		headerText : "차수<span class='must_01'></span>",	
		editable : false,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer",
 			onlyNumeric : true,
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 3){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
		
	},{
		dataField : "RCPMNY_DE",
		headerText : "입금일<span class='must_01'></span>",
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}		
	},{
		dataField : "RCPMNY_AM",
		headerText : "입금액<span class='must_01'></span>",
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "numeric",
		editRenderer : {
 			type: "InputEditRenderer",
 			onlyNumeric : true,
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 15){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
		
	},{
		dataField : "LAST_PYMNT_AT",
		headerText : "최종연구비 지급여부",		
		editable : true,
		filter : {
			showIcon : true
		},
		cellMerge : true,
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap3;
			var retStr = "";
			for(var i=0; me.columnLayout[4].editRenderer.list.length > i; i++) {
				if(me.columnLayout[4].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[4].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
	},{
		dataField : "LAST_PYMNT_DE",
		headerText : "최종 연구비 지급일",		
		editable : true,
		filter : {
			showIcon : true
		},
		cellMerge : true,
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}	
	},{
		dataField : "RSRCCT_SUM",
		headerText : "연구비 합계",		
		editable : false,
		filter : {
			showIcon : true
		},
		dataType : "numeric",
		cellMerge : true
		
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
			var ptMntItem = {LAST_PYMNT_DE : null};		
			var pcpmnyAm;
			var pcpmnyCnt = 0;
			AUIGrid.bind(me.id, 'cellEditBegin', function(event) {				
	 			if(event.item.LAST_PYMNT_AT == "N" ){	//최종연구비 지급여부가 N이면 최종연구비 지급일 입력 불가
	 				if(event.columnIndex == 5){			
	 					return false
	 				}	 				
	 			}
	 		});
			//입금액을 더해서 연구비 합계에 넣기
			AUIGrid.bind(me.id, 'cellEditEnd', function(event) {
				if(event.item.LAST_PYMNT_AT == "N" ){
					AUIGrid.updateRow(me.id, ptMntItem, "selectedIndex");	
	 			}
				pcpmnyAm = AUIGrid.getColumnValues(me.id, "RCPMNY_AM");
				
				for(var i=0; i<pcpmnyAm.length; i++){
					pcpmnyCnt += Number(pcpmnyAm[i]) ;
				}
					
				pcpmnySum = pcpmnyCnt
				
				var sumItem = {RSRCCT_SUM : pcpmnySum};
				for(i=0; i<odrCnt; i++){
					AUIGrid.updateRow(me.id, sumItem, i);
				}
				
				pcpmnyCnt = 0;
					
			});
			
		},
		load: function(v1, v2) {
			var me = this;
			
			
			
			$.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: {'USER_ID' : selectUserId, 'TASK_SN' : taskSn},
			    success:function(data){
			    	if(data.success) {		  
			    	
			    		me.columnLayout[4].editRenderer.list = data.cmCode;
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		
				    	
			    	} else {			    	
			    		
			    		alert(data.message);
			    	}
			    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
			});
		}
	};
/////////////////연구비 그리드 종료///////////////////

/////////////////IRB심의 그리드///////////////////
var grid_wrap4 = {
		id: 'grid_wrap4',
		div: {
			gridDiv: '#grid_wrap4'
		},
		proxy: {
			url: './selectRsrchDlbrt.do',
			param: {},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
		reverseRowNum : true,
		showStateColumn: true,
	    showRowNumColumn : true,
	    enableCellMerge : true,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
		//height: 300,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "SN", //0
		headerText : "순번",
		visible : false,
		editable : true,
		filter : {
			showIcon : true
		},
	},{
		dataField : "DLBRT_KND",
		headerText : "심의종류<span class='must_01'></span>",		
		editable : true,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap4;
			var retStr = "";
			for(var i=0; me.columnLayout[1].editRenderer.list.length > i; i++) {
				if(me.columnLayout[1].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[1].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
	},{
		dataField : "PRESENTN_DE",
		headerText : "제출일<span class='must_01'></span>",		
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}
	},{
		dataField : "DLBRT_DE",
		headerText : "심의일",
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}
	},{
		dataField : "DLBRT_RESULT",
		headerText : "심의결과",
		editable : true,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer", 			
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 100){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "DLBRT_RESULT_DE", //5
		headerText : "심의 결과일",		
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}
	},{
		dataField : "DLBRTCT_RCPMNY_DE",
		headerText : "심의비 입금일",		
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}
	},{
		dataField : "DLBRTCT_RCPMNY_AM",
		headerText : "심의비 입금액",		
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "numeric",
		editRenderer : {
 			type: "InputEditRenderer",
 			onlyNumeric : true,
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 15){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "CONFM_NTC_DOC",
		headerText : "승인통보서",		
		editable : true,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap4;
			var retStr = "";
			for(var i=0; me.columnLayout[8].editRenderer.list.length > i; i++) {
				if(me.columnLayout[8].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[8].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
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
			
			
		},
		load: function(v1, v2) {
			var me = this;
			
			
			
			$.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: {'USER_ID' : selectUserId, 'TASK_SN' : taskSn},
			    success:function(data){
			    	if(data.success) {			    		
			    		me.columnLayout[1].editRenderer.list = data.cmCode016;
			    		me.columnLayout[8].editRenderer.list = data.cmCode001;
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		
				    	
			    	} else {			    	
			    		
			    		alert(data.message);
			    	}
			    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
			});
		}
	};
/////////////////IRB심의 그리드 종료///////////////////

/////////////////동의서 그리드///////////////////
var grid_wrap5 = {
		id: 'grid_wrap5',
		div: {
			gridDiv: '#grid_wrap5'
		},
		proxy: {
			url: './selectRsrchWrtcns.do',
			param: {},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		reverseRowNum : true,
		showStateColumn: true,
	    showRowNumColumn : true,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
		//height: 300,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "SN",
		headerText : "순번",
		visible : false,
		editable : false,
		filter : {
			showIcon : true
		},
	},{
		dataField : "AT",
		headerText : "유/무<span class='must_01'></span>",
		editable : true,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap5;
			var retStr = "";
			for(var i=0; me.columnLayout[1].editRenderer.list.length > i; i++) {
				if(me.columnLayout[1].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[1].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
	},{
		dataField : "DLIV_AT",
		headerText : "전달 여부",
		editable : true,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap5;
			var retStr = "";
			for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
				if(me.columnLayout[2].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[2].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
	},{
		dataField : "VALID_DE",
		headerText : "유효일",
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",		
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
		}
	},{
		dataField : "VER",
		headerText : "버전",		
		editable : true,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer", 		
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 5){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "RM",
		headerText : "코멘트",		
		editable : true,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer", 	
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 1000){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
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
			
		},
		load: function(v1, v2) {
			var me = this;
			
			
			
			$.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: {'USER_ID' : selectUserId, 'TASK_SN' : taskSn},
			    success:function(data){
			    	if(data.success) {			 
			    		me.columnLayout[1].editRenderer.list = data.cmCode;
			    		me.columnLayout[2].editRenderer.list = data.cmCode;
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		
				    	
			    	} else {
			    		
			    		alert(data.message);
			    	}
			    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
			});
		}
	};
/////////////////동의서 그리드 종료///////////////////

/////////////////버전관리 그리드///////////////////
var grid_wrap6 = {
		id: 'grid_wrap6',
		div: {
			gridDiv: '#grid_wrap6'
		},
		proxy: {
			url: './selectRsrchVer.do',
			param: {},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		reverseRowNum : true,
		showStateColumn: true,
	    showRowNumColumn : true,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    enableCellMerge : true,
	    editable : false,
	    enableFilter : true,
		//height: 300,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "SN",
		headerText : "순번",
		visible : false,
		editable : false		
	},{
		dataField : "KND",
		headerText : "종류<span class='must_01'></span>",
		editable : true,
		cellMerge : true,
		filter : {
			showIcon : true
		},
		editRenderer : {
 			type: "InputEditRenderer", 			
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 200){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "IEM",
		headerText : "항목<span class='must_01'></span>",
		editable : true,
		cellMerge : true,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap6;
			var retStr = "";
			for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
				if(me.columnLayout[2].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[2].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "ComboBoxRenderer",
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 200){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			},
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
		
	},{
		dataField : "VER",
		headerText : "버전<span class='must_01'></span>",
		filter : {
			showIcon : true
		},
		editable : true,
		editRenderer : {
 			type: "InputEditRenderer", 			
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 5){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
	},{
		dataField : "DLBRT_KND",
		headerText : "심의종류<span class='must_01'></span>",
		editable : true,
		filter : {
			showIcon : true
		},
		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grid_wrap6;
			var retStr = "";
			for(var i=0; me.columnLayout[4].editRenderer.list.length > i; i++) {
				if(me.columnLayout[4].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[4].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "ComboBoxRenderer",
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 200){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			},
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
		
	},{
		dataField : "CONFM_DE",
		headerText : "승인일",		
		editable : true,
		filter : {
			showIcon : true
		},
		dataType : "date",
        formatString : "yyyy-mm-dd",
        editRenderer : {
			type : "CalendarRenderer",
			showEditorBtnOver : true // 마우스 오버 시 에디터버턴 출력 여부			
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
			
			AUIGrid.bind(grid_wrap6.id, "cellClick", function(event){
				var items = event.item;				
				selectKnd = items.KND; //선택한 KND 종류
				selectIem = items.IEM; //선택한 IEM 항목
				selectRow = event.rowIndex;
			});
			
			
			
		},
		load: function(v1, v2) {
			var me = this;
			
			
			
			$.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: {'USER_ID' : selectUserId, 'TASK_SN' : taskSn},
			    success:function(data){
			    	if(data.success) {			 
			    		me.columnLayout[2].editRenderer.list = data.cmCodeItem;
			    		me.columnLayout[4].editRenderer.list = data.cmCodeReview;
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		
				    	
			    	} else {
			    		
			    		alert(data.message);
			    	}
			    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
			});
		}
	};
/////////////////버전관리 그리드 종료///////////////////

/*=================================================================================================================================*/
$(document).ready(function() {	
	rsrchUserInfo.createGrid();	
	AUIGrid.setCheckedRowsByValue(rsrchUserInfo.id, "DSCNTC_AT", "Inactive");
	 btnController();
	
	$("#btnSerchUserNm").click(function(){
		rsrchUserInfo.load();
		$("#txtUserNm").val("");
	});
	
	///////연구자정보 그리드 버튼 컨트롤////////
	$("#btnGridUpdate0").click(function(){
		$("#btnGridUpdate0").hide();
		$("#btnGridSave0").show();
		$("#btnX0").show();
		AUIGrid.setProperty(rsrchUserInfo.id, "editable" , true ); 
		
	});
	
	$("#btnX0").click(function(){
		$("#btnGridUpdate0").show();
		$("#btnGridSave0").hide();
		$("#btnX0").hide();
		AUIGrid.setProperty(rsrchUserInfo.id, "editable" , false ); 
	});
	
	$("#btnGridSave0").click(function(){
		if(confirm("저장하시겠습니까?") == true){
			//확인 진행
		}else{
			return;
		}
		
		var arJson = [];	
		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(rsrchUserInfo.id);
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CRUD = 'U';
			editedItems[i].LAST_UPDUSR = userId;
			arJson.push(editedItems[i]);
			
		}
		
		$.ajax({			
		    url: './updateRsrchUserInfo.do',
		    type: 'post',
		    contentType: "application/json; charset=UTF-8",
		    dataType: 'json',
		    data: JSON.stringify(arJson),
		    success:function(data){
		    	if(data.success) {
		    		$("#btnGridUpdate0").show();
		    		$("#btnGridSave0").hide();
		    		$("#btnX0").hide();
		    		rsrchUserInfo.load();
		    		AUIGrid.setProperty(rsrchUserInfo.id, "editable" , false );
		    	} else {
		    		
		    		alert(data.message);
		    	}
		    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
		});
	});
	///////연구자정보 그리드 버튼 컨트롤 종료////////
	
	///////조사연구기관 그리드 버튼 컨트롤////////	
	
	
	$("#btnGridUpdate1").click(function(){
		$("#btnGridUpdate1").hide();
		$("#btnGridSave1").show();
		$("#btnX1").show();
		AUIGrid.setProperty(grid_wrap1.id, "editable" , true ); 
	});
	
	$("#btnX1").click(function(){
		$("#btnGridUpdate1").show();
		$("#btnGridSave1").hide();
		$("#btnX1").hide();
		AUIGrid.setProperty(grid_wrap1.id, "editable" , false ); 
	});
	
	$("#btnGridSave1").click(function(){
		if(confirm("저장하시겠습니까?") == true){
			//확인 진행
		}else{
			return;
		}
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grid_wrap1.id);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grid_wrap1.id);		
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {			
			editedItems[i].USER_ID = selectUserId;
			editedItems[i].LAST_UPDUSR = userId;
			editedItems[i].TASK_SN = taskSn;
			
			arJson.push(editedItems[i]);
		}
		
		$.ajax({			
		    url: './insertRsrchInstt.do',
		    type: 'post',
		    contentType: "application/json; charset=UTF-8",
		    dataType: 'json',
		    data: JSON.stringify(arJson),
		    success:function(data){
		    	if(data.success) {		  
		    		$("#btnGridUpdate1").show();
		    		$("#btnGridSave1").hide();
		    		$("#btnX1").hide();
		    		grid_wrap1.load();	
		    		AUIGrid.setProperty(grid_wrap1.id, "editable" , false );
		    	} else {
		    		
		    		alert(data.message);
		    	}
		    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
		});
	});
	///////연구자정보 그리드 버튼 컨트롤 종료////////
	
	///////계약관리 그리드 버튼 컨트롤////////	
	
	
	$("#btnGridUpdate2").click(function(){
		$("#btnGridUpdate2").hide();
		$("#btnGridSave2").show();
		$("#btnX2").show();
		AUIGrid.setProperty(grid_wrap2.id, "editable" , true ); 
	});
	
	$("#btnX2").click(function(){
		$("#btnGridUpdate2").show();
		$("#btnGridSave2").hide();
		$("#btnX2").hide();
		AUIGrid.setProperty(grid_wrap2.id, "editable" , false ); 
	});
	
	$("#btnGridSave2").click(function(){
		
		if(confirm("저장하시겠습니까?") == true){
			//확인 진행
		}else{
			return;
		}
		
		
		
		var arJson = [];		
		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grid_wrap2.id);	
		
		for(var i = 0; i < editedItems.length; i++) {		
			editedItems[i].LAST_UPDUSR = userId;
			editedItems[i].TASK_SN = taskSn;
			editedItems[i].CRUD = "U";
			arJson.push(editedItems[i]);
		}
		
		$.ajax({			
		    url: './updateCntrctManage.do',
		    type: 'post',
		    contentType: "application/json; charset=UTF-8",
		    dataType: 'json',
		    data: JSON.stringify(arJson),
		    success:function(data){
		    	if(data.success) {
		    		$("#btnGridUpdate2").show();
		    		$("#btnGridSave2").hide();
		    		$("#btnX2").hide();
		    		grid_wrap2.load();
		    		AUIGrid.setProperty(grid_wrap2.id, "editable" , false );
		    	} else {
		    		
		    		alert(data.message);
		    	}
		    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
		});
	});
	///////계약관리 그리드 버튼 컨트롤 종료////////
	
	///////연구비 그리드 버튼 컨트롤////////	
	$("#btnGridAdd3").click(function(){
        wrap3rowIndex = AUIGrid.getRowCount(grid_wrap3.id);		
		if(wrap3rowIndex >= paymentPlans[0].PYMNT_PLAN_CNT){
			alert("계획 횟수를 초과 하였습니다.");
			return;
		}		
		odrCnt = wrap3rowIndex + 1;	
		var sumItems = AUIGrid.getColumnValues(grid_wrap3.id,"RSRCCT_SUM");
		
		var row = {
				 'USER_ID' : selectUserId
				,'TASK_SN' : taskSn
				,'SN' : ''
				,'ODR' : odrCnt
				,'RCPMNY_DE' : ''
				,'RCPMNY_AM' : ''
				,'LAST_PYMNT_DE' : ''
				,'LAST_PYMNT_AT' : 'N'
				,'RSRCCT_SUM' : sumItems[0]
				,'USE_AT' : 'Y'
				,'FRST_CREAT_DE' : ''
				,'FRST_CRTR' : userId
				,'LAST_UPDT_DE' : ''
				,'LAST_UPDUSR' : userId			
				,'CNTRCT_SN' : selectCntrctSn
				,'PYMNT_CNT' : odrCnt
				,'CRUD' : 'C'
		};		
		AUIGrid.addRow(grid_wrap3.id, row, 'first'); // 최상단에 행 추가	
		
	});
	     
	$("#btnGridDel3").click(function(){
		AUIGrid.removeRow(grid_wrap3.id, "selectedIndex");
	});
	
	$("#btnGridUpdate3").click(function(){
		$("#btnGridUpdate3").hide();
		$("#btnGridAdd3").show();
		$("#btnGridDel3").show();
		$("#btnGridSave3").show();
		$("#btnX3").show();
		AUIGrid.setProperty(grid_wrap3.id, "editable" , true ); 
	});
	
	$("#btnX3").click(function(){
		$("#btnGridUpdate3").show();
		$("#btnGridAdd3").hide();
		$("#btnGridDel3").hide();
		$("#btnGridSave3").hide();
		$("#btnX3").hide();
		AUIGrid.setProperty(grid_wrap3.id, "editable" , false ); 
		AUIGrid.resetUpdatedItems(grid_wrap3.id, "d" ); 
	});
	
	$("#btnGridSave3").click(function(){
		var gridRow = AUIGrid.getRowCount(grid_wrap3.id);
		var gridData = AUIGrid.getColumnValues(grid_wrap3.id, "RCPMNY_DE");
		
		for(i = 0; i<gridRow; i++){
			if(gridData[i] == ""){
				alert("차수 입금일을 입력해 주세요");
				return;
			}
		}
		
		if(confirm("저장하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		
		var rowCountItem = AUIGrid.getRowCount(grid_wrap3.id);
		var rowRemoveItem = AUIGrid.getRemovedItems(grid_wrap3.id);
		var rowItem = rowCountItem - rowRemoveItem;
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grid_wrap3.id);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grid_wrap3.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grid_wrap3.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CRUD = 'U';
			editedItems[i].LAST_UPDUSR = userId;			
			editedItems[i].CNTRCT_SN = selectCntrctSn;
			editedItems[i].TASK_SN = taskSn;
			editedItems[i].PYMNT_CNT = rowItem;
			arJson.push(editedItems[i]);
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CRUD = 'D';
			removeItems[i].LAST_UPDUSR = userId;						
			removeItems[i].CNTRCT_SN = selectCntrctSn;
			removeItems[i].TASK_SN = taskSn;
			removeItems[i].PYMNT_CNT = rowItem;
			arJson.push(removeItems[i]);
		}
		
		$.ajax({
			  url : './insertResearchFunds.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					 $("#btnGridUpdate3").show();
				 	 $("#btnGridAdd3").hide();
					 $("#btnGridDel3").hide();
					 $("#btnGridSave3").hide();
					 $("#btnX3").hide();
					 grid_wrap3.load();
					 AUIGrid.setProperty(grid_wrap3.id, "editable" , false );
				  } else {
					  AUIGrid.removeAjaxLoader(grid_wrap3.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	///////연구비 그리드 버튼 컨트롤 종료////////
	
	///////IRB심의 그리드 버튼 컨트롤////////	
	$("#btnGridAdd4").click(function(){
	
		var row = {
				 'USER_ID' : selectUserId
				,'TASK_SN' : taskSn
				,'SN' : ''
				,'DLBRT_KND' : ''
				,'PRESENTN_DE' : ''
				,'DLBRT_DE' : ''
				,'DLBRT_RESULT' : ''
				,'DLBRT_RESULT_DE' : ''
				,'DLBRTCT_RCPMNY_DE' : ''
				,'DLBRTCT_RCPMNY_AM' : ''
				,'CONFM_NTC_DOC' : ''
				,'USE_AT' : ''
				,'FRST_CREAT_DE' : ''
				,'FRST_CRTR' : userId			
				,'LAST_UPDT_DE' : ''
				,'LAST_UPDUSR' : userId
				,'CRUD' : 'C'
		};		
		AUIGrid.addRow(grid_wrap4.id, row, 'first'); // 최상단에 행 추가	
		
	});
	     
	$("#btnGridDel4").click(function(){
		AUIGrid.removeRow(grid_wrap4.id, "selectedIndex");
	});
	
	$("#btnGridUpdate4").click(function(){
		$("#btnGridUpdate4").hide();
		$("#btnGridAdd4").show();
		$("#btnGridDel4").show();
		$("#btnGridSave4").show();
		$("#btnX4").show();
		AUIGrid.setProperty(grid_wrap4.id, "editable" , true ); 
	});
	
	$("#btnX4").click(function(){
		$("#btnGridUpdate4").show();
		$("#btnGridAdd4").hide();
		$("#btnGridDel4").hide();
		$("#btnGridSave4").hide();
		$("#btnX4").hide();
		AUIGrid.setProperty(grid_wrap4.id, "editable" , false ); 
		AUIGrid.resetUpdatedItems(grid_wrap4.id, "d" ); 
	});
	
	$("#btnGridSave4").click(function(){
		var gridRowCnt = AUIGrid.getRowCount(grid_wrap4.id);
		var gridKndValue = AUIGrid.getColumnValues(grid_wrap4.id, "DLBRT_KND");
		var gridDeValue = AUIGrid.getColumnValues(grid_wrap4.id, "DLBRT_DE");
		
		for(i=0; i<gridRowCnt; i++){
			if(gridKndValue[i] == ""){
				alert("심의종류를 선택해 주세요.");
				return;
			}
			
			if(gridDeValue[i] == ""){
				alert("제출일을 입력해 주세요.");
				return;
			}
		}
		
		if(confirm("저장하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grid_wrap4.id);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grid_wrap4.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grid_wrap4.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CRUD = 'U';
			editedItems[i].LAST_UPDUSR = userId;
			arJson.push(editedItems[i]);
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CRUD = 'D';
			removeItems[i].LAST_UPDUSR = userId;
			arJson.push(removeItems[i]);
		}
		
		$.ajax({
			  url : './insertRsrchDlbrt.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  $("#btnGridUpdate4").show();
					  $("#btnGridAdd4").hide();
					  $("#btnGridDel4").hide();
					  $("#btnGridSave4").hide();
					  $("#btnX4").hide();
					  grid_wrap4.load();	
					  AUIGrid.setProperty(grid_wrap4.id, "editable" , false );
				  } else {
					  AUIGrid.removeAjaxLoader(grid_wrap4.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	///////IRB심의 버튼 컨트롤 종료////////
	
	///////동의서 그리드 버튼 컨트롤////////	
	$("#btnGridAdd5").click(function(){
		
		var row = {
				 'USER_ID' : selectUserId
				,'TASK_SN' : taskSn
				,'SN' : ''
				,'AT' : ''
				,'DLIV_AT' : ''
				,'VALID_DE' : ''
				,'VER' : ''
				,'RM' : ''
				,'USE_AT' : ''
				,'FRST_CREAT_DE' : ''
				,'FRST_CRTR' : userId
				,'LAST_UPDT_DE' : ''
				,'LAST_UPDUSR' : userId			
				,'CRUD' : 'C'
		};		
		AUIGrid.addRow(grid_wrap5.id, row, 'first'); // 최상단에 행 추가	
		
	});
	     
	$("#btnGridDel5").click(function(){
		AUIGrid.removeRow(grid_wrap5.id, "selectedIndex");
	});
	
	$("#btnGridUpdate5").click(function(){
		$("#btnGridUpdate5").hide();
		$("#btnGridAdd5").show();
		$("#btnGridDel5").show();
		$("#btnGridSave5").show();
		$("#btnX5").show();
		AUIGrid.setProperty(grid_wrap5.id, "editable" , true ); 
	});
	
	$("#btnX5").click(function(){
		$("#btnGridUpdate5").show();
		$("#btnGridAdd5").hide();
		$("#btnGridDel5").hide();
		$("#btnGridSave5").hide();
		$("#btnX5").hide();
		AUIGrid.setProperty(grid_wrap5.id, "editable" , false ); 
		AUIGrid.resetUpdatedItems(grid_wrap5.id, "d" ); 
	});
	
	$("#btnGridSave5").click(function(){
		var gridRowCnt = AUIGrid.getRowCount(grid_wrap5.id);
		var gridAtValue = AUIGrid.getColumnValues(grid_wrap5.id, "AT");		
		
		for(i=0; i<gridRowCnt; i++){
			if(gridAtValue[i] == ""){
				alert("유/무 를 선택해주세요");
				return;
			}
		}
		
		if(confirm("저장하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grid_wrap5.id);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grid_wrap5.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grid_wrap5.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CRUD = 'U';
			editedItems[i].LAST_UPDUSR = userId;
			arJson.push(editedItems[i]);
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CRUD = 'D';
			removeItems[i].LAST_UPDUSR = userId;
			arJson.push(removeItems[i]);
		}
		
		$.ajax({
			  url : './insertRsrchWrtcns.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  $("#btnGridUpdate5").show();
					  $("#btnGridAdd5").hide();
					  $("#btnGridDel5").hide();
					  $("#btnGridSave5").hide();
					  $("#btnX5").hide();
					  grid_wrap5.load();
					  AUIGrid.setProperty(grid_wrap5.id, "editable" , false );
				  } else {
					  AUIGrid.removeAjaxLoader(grid_wrap4.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	///////동의서 버튼 컨트롤 종료////////
	
	///////버전 그리드 버튼 컨트롤////////	
	$("#btnGridAdd6").click(function(){ //행추가		
		var row = {
				 'SN' : ''
				,'USER_ID' : selectUserId
				,'TASK_SN' : taskSn
				,'KND' : ''
				,'IEM' : ''
				,'VER' : ''
				,'DLBRT_KND' : ''
				,'CONFM_DE' : ''				
				,'USE_AT' : ''
				,'FRST_CREAT_DE' : ''
				,'FRST_CRTR' : userId
				,'LAST_UPDT_DE' : ''
				,'LAST_UPDUSR' : userId			
				,'CRUD' : 'C'
		};		
		AUIGrid.addRow(grid_wrap6.id, row, 'first'); // 최상단에 행 추가	
		AUIGrid.setSelectionByIndex(grid_wrap6.id, 0, 1);
	});
	
	$("#btnGridCopy6").click(function(){ //행복사
		var row = {
				 'SN' : ''
				,'USER_ID' : selectUserId
				,'TASK_SN' : taskSn
				,'KND' : selectKnd
				,'IEM' : selectIem
				,'VER' : ''
				,'DLBRT_KND' : ''
				,'CONFM_DE' : ''				
				,'USE_AT' : ''
				,'FRST_CREAT_DE' : ''
				,'FRST_CRTR' : userId
				,'LAST_UPDT_DE' : ''
				,'LAST_UPDUSR' : userId			
				,'CRUD' : 'C'
		};		
		AUIGrid.addRow(grid_wrap6.id, row, selectRow); // 최상단에 행 추가	
		AUIGrid.setSelectionByIndex(grid_wrap6.id, selectRow, 3);
	});
	
	$("#btnGridDel6").click(function(){
		AUIGrid.removeRow(grid_wrap6.id, "selectedIndex");
	});
	
	$("#btnGridUpdate6").click(function(){
		$("#btnGridUpdate6").hide();
		$("#btnGridCopy6").show();
		$("#btnGridAdd6").show();
		$("#btnGridDel6").show();
		$("#btnGridSave6").show();
		$("#btnX6").show();
		AUIGrid.setProperty(grid_wrap6.id, "editable" , true ); 
	});
	
	$("#btnX6").click(function(){
		$("#btnGridUpdate6").show();
		$("#btnGridCopy6").hide();
		$("#btnGridAdd6").hide();
		$("#btnGridDel6").hide();
		$("#btnGridSave6").hide();
		$("#btnX6").hide();
		AUIGrid.setProperty(grid_wrap6.id, "editable" , false ); 
		AUIGrid.resetUpdatedItems(grid_wrap6.id, "d" ); 
	});
	
	$("#btnGridSave6").click(function(){
		var rowCount = AUIGrid.getRowCount(grid_wrap6.id);
		var kndItems = AUIGrid.getColumnValues(grid_wrap6.id, "KND"); //종류
		var iemItems = AUIGrid.getColumnValues(grid_wrap6.id, "IEM"); //항목
		var verItems = AUIGrid.getColumnValues(grid_wrap6.id, "VER"); //버전
		var dltItems = AUIGrid.getColumnValues(grid_wrap6.id, "DLBRT_KND"); //심의종류
		
		for(i=0; i<rowCount; i++){
			if(kndItems[i] == "" || kndItems[i] == null){
				alert("종류를 입력해 주세요");
				return AUIGrid.setSelectionByIndex(grid_wrap6.id, i, 1);
			}
			
			if(iemItems[i] == "" || iemItems[i] == null){
				alert("항목을 입력해 주세요");
				return AUIGrid.setSelectionByIndex(grid_wrap6.id, i, 2);
			}
			
			if(verItems[i] == "" || verItems[i] == null){
				alert("버전을 입력해 주세요");
				return AUIGrid.setSelectionByIndex(grid_wrap6.id, i, 3);
			}
			
			if(dltItems[i] == "" || dltItems[i] == null){
				alert("싱의종류를 입력해 주세요");
				return AUIGrid.setSelectionByIndex(grid_wrap6.id, i, 4);
			}
		}
		
		if(confirm("저장하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grid_wrap6.id);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grid_wrap6.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grid_wrap6.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CRUD = 'U';
			editedItems[i].LAST_UPDUSR = userId;
			arJson.push(editedItems[i]);
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CRUD = 'D';
			removeItems[i].LAST_UPDUSR = userId;
			arJson.push(removeItems[i]);
		}
		
		$.ajax({
			  url : './insertRsrchVer.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  $("#btnGridUpdate6").show();
					  $("#btnGridCopy6").hide();
					  $("#btnGridAdd6").hide();
					  $("#btnGridDel6").hide();
					  $("#btnGridSave6").hide();
					  $("#btnX6").hide();
					  grid_wrap6.load();
					  AUIGrid.setProperty(grid_wrap6.id, "editable" , false );
				  } else {
					  AUIGrid.removeAjaxLoader(grid_wrap6.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	///////버전 버튼 컨트롤 종료////////
});


function fn_validator(value){
		var string = "";
		
		string += value;
		
		var stringLength = string.length;
		var stringByteLength = 0;
		
		stringByteLength = (function(s,b,i,c){
			for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
			return b;
		})(string);
		
		validatorCnt = stringByteLength;
	
		
}

function btnController(){
	//연구자 정보
	$("#btnGridUpdate0").show();
	$("#btnGridSave0").hide();
	$("#btnX0").hide();
	
	//조사연구기관
	$("#btnGridUpdate1").show();
	$("#btnGridSave1").hide();
	$("#btnX1").hide();
	
	//계약관리
	$("#btnGridUpdate2").show();
	$("#btnGridSave2").hide();
	$("#btnX2").hide();
	
	//연구비
	$("#btnGridUpdate3").show();
	$("#btnGridAdd3").hide();
	$("#btnGridDel3").hide();
	$("#btnGridSave3").hide();
	$("#btnX3").hide();
	
	//IRB 심의
	$("#btnGridUpdate4").show();
	$("#btnGridAdd4").hide();
	$("#btnGridDel4").hide();
	$("#btnGridSave4").hide();
	$("#btnX4").hide();
	
	//동의서
	$("#btnGridUpdate5").show();
	$("#btnGridAdd5").hide();
	$("#btnGridDel5").hide();
	$("#btnGridSave5").hide();
	$("#btnX5").hide();
	
	//버전
	$("#btnGridUpdate6").show();
	$("#btnGridCopy6").hide();
	$("#btnGridAdd6").hide();
	$("#btnGridDel6").hide();
	$("#btnGridSave6").hide();
	$("#btnX6").hide();
    
}

function accHeader(id){	
	if(selectCntrctSn != ""){
		switch(id){
		case "grid1" : //조사연구기관
			$("#grid1").siblings(".acdMenuCts01").slideToggle(0);
			$("#grid1").toggleClass("open");
			AUIGrid.destroy(grid_wrap1.id);
			grid_wrap1.createGrid();	
			break;
			
		case "grid2" : //계약관리
			$("#grid2").siblings(".acdMenuCts01").slideToggle(0);
			$("#grid2").toggleClass("open");
			AUIGrid.destroy(grid_wrap2.id);
			grid_wrap2.createGrid();			
			break;
		
		case "grid3" : //연구비
			$("#grid3").siblings(".acdMenuCts01").slideToggle(0);
			$("#grid3").toggleClass("open");
			AUIGrid.destroy(grid_wrap3.id);
			grid_wrap3.createGrid();			
			break;
		
		case "grid4" : //IRB 심의
			$("#grid4").siblings(".acdMenuCts01").slideToggle(0);
			$("#grid4").toggleClass("open");
			AUIGrid.destroy(grid_wrap4.id);
			grid_wrap4.createGrid();			
			break;
			
		case "grid5" : //동의서
			$("#grid5").siblings(".acdMenuCts01").slideToggle(0);
			$("#grid5").toggleClass("open");
			AUIGrid.destroy(grid_wrap5.id);
			grid_wrap5.createGrid();			
			break;
			
		case "grid6" : //버전
		    $("#grid6").siblings(".acdMenuCts01").slideToggle(0);
			$("#grid6").toggleClass("open");
			AUIGrid.destroy(grid_wrap6.id);
			grid_wrap6.createGrid();			
			break;
		
		default :
		}
	}else{
		alert("연구자를 선택해 주세요");
	}
	
	

} // function accHeader


$(window).resize(function(){
	if (typeof rsrchUserInfo.id !== "undefined") {
		AUIGrid.resize(rsrchUserInfo.id);
	}
	
	if (typeof grid_wrap1.id !== "undefined") {
		AUIGrid.resize(grid_wrap1.id);
	}

	if (typeof grid_wrap2.id !== "undefined") {
		AUIGrid.resize(grid_wrap2.id);
	}
	
	if (typeof grid_wrap3.id !== "undefined") {
		AUIGrid.resize(grid_wrap3.id);
	}

	if (typeof grid_wrap4.id !== "undefined") {
		AUIGrid.resize(grid_wrap4.id);
	}

	if (typeof grid_wrap5.id !== "undefined") {
		AUIGrid.resize(grid_wrap5.id);
	}

	if (typeof grid_wrap6.id !== "undefined") {
		AUIGrid.resize(grid_wrap6.id);
	}
	
});




</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMO0101&UPPER_MENU_ID=CTMO" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMO0101&UPPER_MENU_ID=CTMO" charEncoding="utf-8"/>
<div id="wrap">

	<!-- 메인 시작 -->
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
			
					   
 <!-- 컨텐츠박스 시작-->
     <section class="conBox100 conBox">
         <div class="conBoxInner">
          
         <!-- 컨텐츠 타이틀 끝-->
         	<article class="conTitBtnR">	                    
                    <input type="button" id="btnGridUpdate0" value="수정">
                    <input type="button" id="btnGridSave0"   value="저장">
                    <input type="button" id="btnX0"   value="X">
			</article>
			
            <article class="mgT40" style="clear:both;">                	
	            	<div id="rsrchUserInfo" class="gridHeiSz06 grid_wrap tb01_2"></div>
            </article>
            
            
            
     </section>

     <section class="conBox100 conBox">
         <div class="conBoxInner">


            <!-- 아코디언 메뉴  시작 -->            
           	
           	 	<!-- 아코디언 메뉴 리스트 시작 -->
               	<li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close" id="grid1" onclick='accHeader(this.id)'>조사연구기관</a>
                   	<div class="acdMenuCts acdMenuCts01 close">

		            <!-- 상단 테이블 오른쪽 메뉴 시작-->
			            <article class="conTitBtnR">	                    
	                        <input type="button" id="btnGridUpdate1" value="수정">
	                        <input type="button" id="btnGridSave1"   value="저장">
	                        <input type="button" id="btnX1"   value="X">
			            </article>
	                       <!-- 상단 테이블 오른쪽 메뉴 끝-->
	
						<article class="mgT40" style="clear:both;">
	                        <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                        <div id="grid_wrap1" class="gridHeiSz04 grid_wrap tb01_2"></div>
	                        <!-- 아코디언 메뉴 컨텐츠 끝 -->
	                    </article>
                    </div>
                  </li>
                  <!-- 아코디언 메뉴 리스트 끝 -->
                  
                  <!-- 아코디언 메뉴 리스트 시작 -->
                  <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close" id="grid2" onclick='accHeader(this.id)'>계약관리</a>
                   	<div class="acdMenuCts acdMenuCts01 close">

		            <!-- 상단 테이블 오른쪽 메뉴 시작-->
			            <article class="conTitBtnR">	                    
	                        <input type="button" id="btnGridUpdate2" value="수정">
	                        <input type="button" id="btnGridSave2"   value="저장">
	                        <input type="button" id="btnX2"   value="X">
			            </article>
	                       <!-- 상단 테이블 오른쪽 메뉴 끝-->
	
						<article class="mgT40" style="clear:both;">
	                        <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                        <div id="grid_wrap2" class="gridHeiSz04 grid_wrap tb01_2"></div>
	                        <!-- 아코디언 메뉴 컨텐츠 끝 -->
	                    </article>
                    </div>
                  </li>
                  <!-- 아코디언 메뉴 리스트 끝 -->
                  
                  <!-- 아코디언 메뉴 리스트 시작 -->
                  <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close" id="grid3" onclick='accHeader(this.id)'>연구비</a>
                   	<div class="acdMenuCts acdMenuCts01 close">

		            <!-- 상단 테이블 오른쪽 메뉴 시작-->
			            <article class="conTitBtnR">	     
			           		<input type="button" id="btnGridAdd3" value="행 추가">
	                        <input type="button" id="btnGridDel3"   value="행 삭제">               
	                        <input type="button" id="btnGridUpdate3" value="수정">
	                        <input type="button" id="btnGridSave3"   value="저장">
	                        <input type="button" id="btnX3"   value="X">
			            </article>
	                       <!-- 상단 테이블 오른쪽 메뉴 끝-->
	
						<article class="mgT40" style="clear:both;">
	                        <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                        <div id="grid_wrap3" class="gridHeiSz04 grid_wrap tb01_2"></div>
	                        <!-- 아코디언 메뉴 컨텐츠 끝 -->
	                    </article>
                    </div>
                  </li>
                  <!-- 아코디언 메뉴 리스트 끝 -->
           	      
           	      <!-- 아코디언 메뉴 리스트 시작 -->
                  <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close" id="grid4" onclick='accHeader(this.id)'>IRB 심의</a>
                   	<div class="acdMenuCts acdMenuCts01 close">

		            <!-- 상단 테이블 오른쪽 메뉴 시작-->
			            <article class="conTitBtnR">	     
			           		<input type="button" id="btnGridAdd4" value="행 추가">
	                        <input type="button" id="btnGridDel4"   value="행 삭제">               
	                        <input type="button" id="btnGridUpdate4" value="수정">
	                        <input type="button" id="btnGridSave4"   value="저장">
	                        <input type="button" id="btnX4"   value="X">
			            </article>
	                       <!-- 상단 테이블 오른쪽 메뉴 끝-->
	
						<article class="mgT40" style="clear:both;">
	                        <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                        <div id="grid_wrap4" class="gridHeiSz04 grid_wrap tb01_2"></div>
	                        <!-- 아코디언 메뉴 컨텐츠 끝 -->
	                    </article>
                    </div>
                  </li>
                  <!-- 아코디언 메뉴 리스트 끝 -->
                  
                  <!-- 아코디언 메뉴 리스트 시작 -->
                  <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close" id="grid5" onclick='accHeader(this.id)'>동의서</a>
                   	<div class="acdMenuCts acdMenuCts01 close">

		            <!-- 상단 테이블 오른쪽 메뉴 시작-->
			            <article class="conTitBtnR">	     
			           		<input type="button" id="btnGridAdd5" value="행 추가">
	                        <input type="button" id="btnGridDel5"   value="행 삭제">               
	                        <input type="button" id="btnGridUpdate5" value="수정">
	                        <input type="button" id="btnGridSave5"   value="저장">
	                        <input type="button" id="btnX5"   value="X">
			            </article>
	                       <!-- 상단 테이블 오른쪽 메뉴 끝-->
	
						<article class="mgT40" style="clear:both;">
	                        <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                        <div id="grid_wrap5" class="gridHeiSz04 grid_wrap tb01_2"></div>
	                        <!-- 아코디언 메뉴 컨텐츠 끝 -->
	                    </article>
                    </div>
                  </li>
                  <!-- 아코디언 메뉴 리스트 끝 -->
                  
                  <!-- 아코디언 메뉴 리스트 시작 -->
                  <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close" id="grid6" onclick='accHeader(this.id)'>버전관리</a>
                   	<div class="acdMenuCts acdMenuCts01 close">

		            <!-- 상단 테이블 오른쪽 메뉴 시작-->
			            <article class="conTitBtnR">	     
			                <input type="button" id="btnGridCopy6" value="행 복사">
			           		<input type="button" id="btnGridAdd6" value="행 추가">
	                        <input type="button" id="btnGridDel6"   value="행 삭제">               
	                        <input type="button" id="btnGridUpdate6" value="수정">
	                        <input type="button" id="btnGridSave6"   value="저장">
	                        <input type="button" id="btnX6"   value="X">
			            </article>
	                       <!-- 상단 테이블 오른쪽 메뉴 끝-->
	
						<article class="mgT40" style="clear:both;">
	                        <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                        <div id="grid_wrap6" class="gridHeiSz08 grid_wrap tb01_2"></div>
	                        <!-- 아코디언 메뉴 컨텐츠 끝 -->
	                    </article>
                    </div>
                  </li>
                  <!-- 아코디언 메뉴 리스트 끝 -->
        </div>
    </section>
</div>
</section>
</div>

</body>
</html>