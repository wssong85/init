<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<style>

.aui-grid-template-renderer{}

.aui-grid-template-renderer-wrapper{ 
	 height:auto !important;
}

.search_yes{background:url(/images/pantheon/contents/search.png) no-repeat 0px 0px; display:inline-block; width:12px; height:12px; position: relative; top: 2px; /* left: 80%; */ 


.btn_style_01{ }
.btn_style_01 .aui-grid-renderer-base .aui-grid-button-renderer{ padding:4px 2.2em 7px 1.2em;}



.btn_style_01{ }
.btn_style_01 .aui-grid-renderer-base .aui-grid-button-renderer{ padding:4px 2.2em 7px 1.2em;}

</style>
<script type="text/javascript">
var taskSe = "${loginMap.TASK_TY_CODE}";  //선택하고 들어온 과제번호 구분 확인
var taskNo = "${loginMap.TASK_NO}"; //*선택하고 들어온 과제번호가 들어가야함
var taskSn = "${loginMap.TASK_SN}"; //*선택하고 들어온 과제번호가 들어가야함
var userId = "${loginMap.USER_ID}"; //로그인한 유저 ID
var planlist; //코드 가져오기
var gridItem; //check Click 변수담기
var p_instt_type = "";
var p_taskSn = "";
var keyInputSe = [{"CODE" : "A", "VALUE" : "CRA"}, {"CODE" : "M", "VALUE" : "CRM"}];
var dataInputSe ;
//AUIGrid 생성 후 반환 ID

$(document).ready(function() {
	todoGrid.createGrid();  
	AUIGrid.setProperty(todoGrid.id, "editingOnKeyDown", true);
	$("#btnAdd").hide();
    $("#btnDel").hide();
    $("#btnTodoSave").hide();
    $("#btnTodoX").hide();
    $("#btnTodoModify").show();
    AUIGrid.setProperty(todoGrid.id, "editable" , false); 
    //수정보고 버튼
	$('#btnModifyReport').click(function(){	
		alert("수정보고");	 	
	});
    	
	//계획보고 버튼
	$('#btnPlanReport').click(function(){		 	 	
		alert("계획보고");
	});
	
	//수정버튼 클릭
	$('#btnTodoModify').click(function(){	
       $("#btnAdd").show();
       $("#btnDel").show();
       $("#btnTodoSave").show();
       $("#btnTodoX").show();
       $("#btnTodoModify").hide();
		AUIGrid.setProperty(todoGrid.id, "editable" , true); 
	});
	
	//X버튼 클릭
	$("#btnTodoX").click(function(){
		$("#btnAdd").hide();
        $("#btnDel").hide();
        $("#btnTodoSave").hide();
        $("#btnTodoX").hide();
        $("#btnTodoModify").show();
        AUIGrid.setProperty(todoGrid.id, "editable" , false); 
        AUIGrid.resetUpdatedItems(todoGrid.id, "d" );
	});
	
	// 행추가
	$('#btnAdd').click(function() {		
		
		var row = {
				 'SN' : ''
				,'PLAN_SE' : ''
				,'PLAN_DETAIL': '' //*선택하고 들어온 과제번호가 들어가야함
				,'PLAN_BEGIN': ''
				,'PLAN_END': ''
				,'EXECUT_BEGIN': ''
				,'EXECUT_END': ''
				,'RM': ''
				,'INPUT_SE': 'A'	
				,'LAST_UPDUSR': userId	
				,'CRUD': 'C'
				,'TASK_SN' : taskSn
				,'INSTT_CODE' : ''
				,'INSTT_NAME' : ''
				,'CHARGER_ID' : userId
		};		
		AUIGrid.addRow(todoGrid.id, row, 'first'); // 최상단에 행 추가
		
	});
	
	// 행삭제
	$('#btnDel').click(function() {
		AUIGrid.removeRow(todoGrid.id, "selectedIndex");
	});
	
	//메뉴상단 저장
	$('#btnTodoSave').click(function() {
		var getGridItems = AUIGrid.getGridData(todoGrid.id);
		var rowIndex = AUIGrid.getRowCount(todoGrid.id);
		
		for(var i=0; i<rowIndex; i++ ){
			if(!getGridItems[i].PLAN_SE){alert("Category를 선택해 주세요.");  AUIGrid.setSelectionByIndex(todoGrid.id, i, 0); return;}
			if(!getGridItems[i].INSTT_CODE){alert("기관을 선택해주세요."); AUIGrid.setSelectionByIndex(todoGrid.id, i, 2); return;}			
			if(!getGridItems[i].PLAN_BEGIN){alert("계획일(시작)을 입력해주세요."); AUIGrid.setSelectionByIndex(todoGrid.id, i, 4); return;}
			if(!getGridItems[i].PLAN_END){alert("계획일(끝)을 입력해주세요."); AUIGrid.setSelectionByIndex(todoGrid.id, i, 5); return;}
			if(!getGridItems[i].EXECUT_BEGIN){alert("실행일(시작)을 입력해주세요."); AUIGrid.setSelectionByIndex(todoGrid.id, i, 6); return;}
			if(!getGridItems[i].EXECUT_END){alert("실행일(끝)을 입력해 주세요."); AUIGrid.setSelectionByIndex(todoGrid.id, i, 7); return;}			
			
		}
		
		if(confirm("저장하시겠습니까?") == true){
			//확인진행
		}else{
			return;
		}
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(todoGrid.id);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(todoGrid.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(todoGrid.id);
		
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
			  url : './updateGridByTodoList.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {		
					   AUIGrid.setProperty(todoGrid.id, "editable" , false ); 
					  
					   todoGrid.load();
					   
				  } else {
					  AUIGrid.removeAjaxLoader(todoGrid.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	 
	
}); 
function fn_setInstt(){
	var item; 
	
	item = {INSTT_CODE : returnValue.INSTT_CODE
		  , INSTT_NAME : returnValue.INSTT_NAME
		  , USER_ID : returnValue.USER_ID
		  , USER_NM : returnValue.USER_NM
			  
				}; 	
	
	AUIGrid.updateRow(todoGrid.id, item, "selectedIndex");
	
}

function fn_validator(value){
	var string = "";
	
	string += value;
	
	var stringLength = string.length;
	var stringByteLength = 0;
	
	stringByteLength = (function(s,b,i,c){
		for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		return b;
	})(string);
	//console.log(stringByteLength + " Bytes"); 
	
	validatorCnt = stringByteLength;
}

//보고서 페이지 이동
function reportPage(url, params){
	console.log(params);
	var f = document.createElement("form");
	
	var objs ;
	var value ;

	for(var key in params){
		value = params[key];
		//console.log("value:::::"+value);
		//console.log("key:::::"+key);
		objs = document.createElement("input");
		objs.setAttribute("type", "hidden");
		objs.setAttribute("id", key);
		objs.setAttribute("name", key);
		objs.setAttribute("value", value);
		f.appendChild(objs);
	}
	
	f.setAttribute("method", "post");
	f.setAttribute("action", url);
	document.body.appendChild(f);
	f.submit();
}



//보고서 페이지 이동전 구분
function fn_reportSe(items){
	//console.log(items);
	var url = "";
	var params;
	console.log("PLAN_SE : "+items.PLAN_SE+"      "+items.PERFORM);
	switch (items.PLAN_SE){
	case "A0" : //개시미팅(PMS/NIS)
		if(items.PERFORM == 'PERFORM01'){ //계획:PERFORM01 보고서인지 수행:PERFORM01  보고서인지 구분
			url = "/ctms/z02/CTMZ0201.do";
			params = items;		
			break;
		}else{
			url = "/ctms/z02/CTMZ0202.do";
			params = items;
			break;	
		}
	break;
	case "B0" : //모니터링(PMS/NIS)
		if(items.PERFORM == 'PERFORM01'){ //계획:PERFORM01 보고서인지 수행:PERFORM02  보고서인지 구분
			url = "/ctms/z04/CTMZ0401.do";
			params = items;
			break;
		}else{
			url = "/ctms/z04/CTMZ0402.do";
			params = items;
			break;	
		}
	
	case "C0" : //연구기관 방문 보고서 (PMS/NIS)
		if(items.PERFORM == 'PERFORM01'){ //계획:PERFORM01 보고서인지 수행:PERFORM01  보고서인지 구분
			url = "/ctms/z03/CTMZ0302.do";
			params = items;
			params.REPORT_SE = items.PLAN_SE + "1";
			params.REPORT_TYPE = "P";
			break;
		}else{
			url = "/ctms/z03/CTMZ0303.do";
			params = items;
			params.REPORT_SE = items.PLAN_SE + "2";
			params.REPORT_TYPE = "V";
			break;	
		}
	
	case "E0" : //연구자 적합성 보고서 (PMS/NIS)
		url = "/ctms/z05/CTMZ0501.do";
		params = items;
		params.REPORT_SE = items.PLAN_SE + "0";
		params.REPORT_TYPE = "P";
		break;
	case "D0" : //연구자 순응도 평가서 (PMS/NIS)
		url = "/ctms/z15/CTMZ1501.do";
		params = items;
		break;	
	case "E01" : //연구자 적합성 보고서 (PMS/NIS)
		url = "/ctms/z02/CTMZ0501.do";
		params = items;
		break;	
	case "G0" : //개시미팅 준비기록, 개시방문 보고서 (임상)
		if(items.PERFORM == 'PERFORM01'){ //계획:PERFORM01 보고서인지 수행:PERFORM01  보고서인지 구분
			url = "/ctms/z09/CTMZ0901.do";
			params = items;
			params.REPORT_SE = items.PLAN_SE + "1";
			params.REPORT_TYPE = "P";
			break;
		}else{
			url = "/ctms/z09/CTMZ0902.do";
			params = items;
			params.REPORT_SE = items.PLAN_SE + "2";
			params.REPORT_TYPE = "V";
			break;	
		}
	case "G0" : //개시미팅 준비기록, 개시방문 보고서 (임상)
		if(items.PERFORM == 'PERFORM01'){ //계획:PERFORM01 보고서인지 수행:PERFORM01  보고서인지 구분
			url = "/ctms/z09/CTMZ0901.do";
			params = items;
			params.REPORT_SE = items.PLAN_SE + "1";
			params.REPORT_TYPE = "P";
			break;
		}else{
			url = "/ctms/z09/CTMZ0902.do";
			params = items;
			params.REPORT_SE = items.PLAN_SE + "2";
			params.REPORT_TYPE = "V";
			break;	
		}	
	case "H0" : //시험 전 방문 보고서 (임상)
		if(items.PERFORM == 'PERFORM01' || items.PERFORM == 'PERFORM02'){ //계획:PERFORM01 보고서인지 수행:PERFORM02  보고서인지 구분
			url = "/ctms/z07/CTMZ0701.do";
			params = items;
			params.PLAN_SE = items.PLAN_SE + "0";
			params.REPORT_TYPE = "V";
			break;
		}
		break;
	
	case "L0" : //시험 종료 방문 보고서 (임상)
		if(items.PERFORM == 'PERFORM01' || items.PERFORM == 'PERFORM02'){
			url = "/ctms/z11/CTMZ1101.do";
			params = items;
			break;
		}
	case "I0" : //시험책임자 적합성 보고서 (임상)
		if(items.PERFORM == 'PERFORM01' || items.PERFORM == 'PERFORM02'){
			url = "/ctms/z08/CTMZ0801.do";
			params = items;
			break;
		}	
	
	case "J0" : //내용확인서 (임상)
		url = "/ctms/z12/CTMZ1201.do";
		params = items;
		params.REPORT_SE = items.PLAN_SE + "0";
		params.REPORT_TYPE = "P";
		break;
	case "K0" : //계획서 일탈 보고서 (임상)
		url = "/ctms/z14/CTMZ1401.do";
		params = items;
		params.REPORT_SE = items.PLAN_SE + "0";
		params.REPORT_TYPE = "P";
		break;
	case "L01" : //일탈로그 (임상)
		url = "/ctms/z02/CTMZ1401.do";
		params = items;
		break;
	default :
		return;
		break;
	}
	//보고서 페이지 이동
	if(items.EXECUT_BEGIN){
		reportPage(url, params);
		return false;
	}
	

}

var todoGrid = {
	 	id: '',
	 	div: {
	 		gridDiv: '#todoGrid'
	 	},
	 	proxy: {
	 		url: './selectGridByTodoList.do',
	 		param: {'USER_ID':userId, 'TASK_SN' : taskSn},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
		    // 페이징 사용
		   /*  
		    pageRowCount : 5,
		    showPageButtonCount : 5, */
		    usePaging : true,
		    showStateColumn: true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    rowCheckToRadio : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
		    enableFilter : true,			
			enableCellMerge : false,
		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleCells",
		    reverseRowNum : true,
		    //displayTreeOpen : true,
		   
	 	},	 	
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "PLAN_SE",
			headerText : "Category<span class='must_01'></span>",
			cellMerge : true,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = todoGrid;
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
	 		 },
	 		filter : {
				showIcon : true
			}
		},{
			dataField : "PLAN_DETAIL",
			headerText : "상세",
			editable : true,
			visible : true,
			editRenderer : {
	 			type: "InputEditRenderer", 	
	 			showEditorBtnOver : true,
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 100){ 
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
	 		},
			
		},{
			dataField : "INSTT_CODE",
			headerText : "기관코드",
			editable : false,
			visible : false
		},{
			dataField : "INSTT_NAME",
			headerText : "실시기관<span class='must_01'></span>",
			editable : false,
			cellMerge : true,
			filter : {
				showIcon : true
			},
			renderer: {
	 			type: 'TemplateRenderer'
	 		},
		
			labelFunction : function(rowIndex, columnIndex, value, headerText, item ) {
				
				if(item.INSTT_NAME == ""  || item.INSTT_NAME == null) {
					return "<span class='search_yes'></span>";
				}else{
					return item.INSTT_NAME;
				}
			}
		},{
			dataField : "USER_ID",
			headerText : "아이디",
			editable : false
		},{
			dataField : "USER_NM",
			headerText : "이름",
			editable : false
		},{
			dataField : "PLAN_BEGIN",
			headerText : "계획일(시작)<span class='must_01'></span>",
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			},
			editable : true			
		},{
			dataField : "PLAN_END",
			headerText : "계획일(끝)<span class='must_01'></span>",	
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			},
			editable : true			
		},{
			dataField : "EXECUT_BEGIN",
			headerText : "실행(시작)<span class='must_01'></span>",		
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			},	
			editable : true			
		},{
			dataField : "EXECUT_END",
			headerText : "실행(끝)<span class='must_01'></span>",	
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			},	
			editable : true			
		},{
			dataField : "RM",
			headerText : "비고",	
			editable : true,
			editRenderer : {
	 			type: "InputEditRenderer", 	
	 			showEditorBtnOver : true,
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 1000){
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
	 		},
		},{
			dataField : "INPUT_SE",
			headerText : "등록구분",
			filter : {
				showIcon : true
			},
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = todoGrid;
				var retStr = "";
				
				for(var i=0; dataInputSe.length > i; i++) {
					if(keyInputSe[i]["CODE"] == value) {
						retStr = keyInputSe[i]["VALUE"];
						break;
					}
				}
				return retStr;
		    },
		    editRenderer : {
	 			type : "DropDownListRenderer",
	 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
	 			list : keyInputSe,
	 			keyField : "CODE",
	 			valueField : "VALUE"
	 		 },
			editable : false			
		},{
			dataField : "PLANRE",
			headerText : "계획보고",
			width : 128,
			style:"btn_style_01",
			renderer : {
				type : "ButtonRenderer",
				labelText: "계획보고",
				onclick : function(rowIndex, columnIndex, value, item){
					var params = 
					       {'INSTT_CODE' : item.INSTT_CODE,
						    'NAME1' : item.INSTT_NAME,
						    'USER_NM' : item.USER_NM,
						    'USER_ID' : item.USER_ID,
						    'EXECUT_BEGIN' : item.EXECUT_BEGIN,
						    'PLAN_SE' : item.PLAN_SE,
						    'MILESTONE_SN' : item.SN,
						    'TASK_SN' : item.TASK_SN,
						    'PERFORM' : 'PERFORM01'
						    };
					
					fn_reportSe(params);
					
				}
			}		
		},{
			dataField : "PERFORM",
			headerText : "수행보고",
			width : 128,
			style:"btn_style_01",
			renderer : {
				type : "ButtonRenderer",
				labelText: "수행보고",
				onclick : function(rowIndex, columnIndex, value, item){
					var params = 
				       {'INSTT_CODE' : item.INSTT_CODE,
					    'NAME1' : item.INSTT_NAME,
					    'USER_NM' : item.USER_NM,
					    'USER_ID' : item.USER_ID,
					    'EXECUT_BEGIN' : item.EXECUT_BEGIN,
					    'PLAN_SE' : item.PLAN_SE,
					    'MILESTONE_SN' : item.SN,
					    'TASK_SN' : item.TASK_SN,
					    'PERFORM' : 'PERFORM02'
					    };
				
					fn_reportSe(params);
				}
			}			
		},{
			dataField : "TASK_SN",
			headerText : "과제순번",	
			editable : false,
			visible : false
		},{
			dataField : "CHARGER_ID",
			headerText : "담당자",	
			editable : false,
			visible : false
		},{
			dataField : "SN",
			headerText : "순번",	
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
	 		AUIGrid.bind(me.id, "cellEditBegin", function(event){
		 		// 추가된 행 아이템인지 조사하여 추가된 행인 경우만 에디팅 진입 허용
		 		if(event.dataField == "PLAN_SE" || event.dataField == "PLAN_BEGIN" || event.dataField == "PLAN_END"){
		 			if(event.item.INPUT_SE == "M"){
			 			return false;
			 		}
		 		}
		 		
		 		if(event.dataField == "PLAN_DETAIL"){
		 			if(event.item.PLAN_SE != "F0"){ //기타(F0)가 아니면 작성하지 못함
		 				return false;
		 			}
		 		}
		 		return true; // 다른 필드들은 편집 허용
	 		});
	 		
	 		
	 		
	 		AUIGrid.bind(me.id, "cellClick", function(event){
	 			if(event.columnIndex == 3){
	 				p_instt_name = "";	
	 				p_todolist = "Y";	 				
	 				p_taskSn = taskSn;
	 				var param = {};	 				
	 				if(event.item.INPUT_SE == "A"){ //INPUT_SE가 CRA이면
	 					mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
	 				}
	 				
	 			}
	 		});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 	
	 		    		dataInputSe = data.result;	 		    		
	 		    	 	if(taskSe == "01"){ //임상과제이면..
	 		    	 		//console.log(data.param2);
	 		    			me.columnLayout[0].editRenderer.list = data.param2;	 		    	 		
	 		    		}else{
	 		    			//console.log(data.param1);
	 		    			me.columnLayout[0].editRenderer.list = data.param1;	 		    			
	 		    		}
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
	 			    	AUIGrid.setProperty(todoGrid.id, "editable" , true ); 
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

$(window).resize(function(){
	if (todoGrid.id) {
		AUIGrid.resize(todoGrid.id);
	}	
});

</script>
</head>
<body>



<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTML0201&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTML0201&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>

	<!-- 컨텐츠박스 시작-->
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
                <div class="conBoxInner" style="min-height:900px;">

                    <div>
	                    <article class="conTitBtnR">
	                  	  <input type="button" id="btnAdd" class="add_01" title="행추가">
	                      <input type="button" id="btnDel" class="del_01" title="행삭제">  
	                      <input type="button" id="btnTodoSave" class="save_01" title="저장">
	                      <input type="button" id="btnTodoModify" class="edit_01" title="수정">
	                      <input type="button" id="btnTodoX" class="close_01" title="취소">
	                    </article>
                    </div>
					
                    <article class="mgT40">
                         <div id="todoGrid" class="gridHeiSz17 grid_wrap tb01_2"></div>
                    </article>

                </div>
            </section>


		</div>
	</section>
	<!-- 컨텐츠박스 끝-->
</div>




</body>
</html>










