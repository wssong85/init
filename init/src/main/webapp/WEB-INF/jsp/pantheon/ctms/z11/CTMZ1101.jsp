<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<script>
var g_taskNo = "${loginMap.TASK_NO}";		//과제번호
var g_taskSn = "${loginMap.TASK_SN}";		//과제순번
var g_userId = "${loginMap.USER_ID}";		//로그인한 USER_ID
var g_taskSe = "${loginMap.TASK_TY_CODE}";	//과제 타입

var g_maileSn = "${result.MILESTONE_SN}";   //마일스톤 순번
var g_InsttCode = "${result.INSTT_CODE}";   //기관코드				  
var g_InsttName = "${result.NAME1}";		//기관명
var g_rsrchNm = "${result.USER_NM}";		//책임연구자 NAME
var g_rsrchId = "${result.USER_ID}";		//책임연구자 ID

var reportSn; //리포트 MAIN 순번
var setleNo = "";  //결재번호
var approvalSn; //결재순번저장
var crudCnt = "01"; //01이면 INSERT 02면 UPDATE
var validatorCnt;

var grid_wrap_01 = {
		  id: '',

		  div: {
		    gridDiv: '#grid_wrap_01'
		  },
		  proxy: {
		    url: './selectVisitReport1.do',
		    param: {},
		    type: 'post',
		    dataType: 'json',
		    autoLoad: true,
		  },
		  gridPros: {
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
		    enableFilter : true,
		    headerHeight: 40,
		    rowHeight: 37,
		    softRemoveRowMode  : true,
		    reverseRowNum : true,
		    selectionMode : "multipleCells",
		    softRemovePolicy   : "exceptNew"
		  },
		  columnLayout : [{
		    dataField : "NM",
		    headerText : "이름 Name",
		    width : 100,
		    editRenderer : {
				type: "InputEditRenderer", 			
				validator : function(oldValue, newValue, rowItem){
					var isValid = false; 	
					
					validator(newValue);
					
					if(validatorCnt <= 100){ 
						isValid = true;
					} 			
				    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
					return{"validate" : isValid, "message" : "<spring:message code='ctms.message.validate'/>"};
				}
			}
		  },{
		    dataField : "ROLE_NM",
		    headerText : "Title",
		    editRenderer : {
				type: "InputEditRenderer", 			
				validator : function(oldValue, newValue, rowItem){
					var isValid = false; 	
					
					validator(newValue);
					
					if(validatorCnt <= 100){ 
						isValid = true;
					} 			
				    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
					return{"validate" : isValid, "message" : "<spring:message code='ctms.message.validate'/>"};
				}
			}
		  },{
		    dataField : "ITEM_SE",
		    headerText : "ITEM_SE",
		    visible : false
			  
		  },{
		    dataField : "VISIT_SN",
		    headerText : "VISIT_SN",
		    visible : false
		  }],

		  createGrid: function() {
		    var me = this;
		    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		    me.binding();
		    if(me.proxy.autoLoad) {
		      me.load();
		    }
		  },
		  binding: function() { },
		  load: function(v1, v2) {
		    var me = this;
		    
		    $.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: me.proxy.param,
			    success:function(data){
			    	if(data.success) {	 	    		
			    	    
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




		var grid_wrap_02 = {
		  id: '',

		  div: {
		    gridDiv: '#grid_wrap_02'
		  },
		  proxy: {
			url: './selectVisitReport2.do',
		    param: {},
		    type: 'post',
		    dataType: 'json',
		    autoLoad: true,
		  },
		  gridPros: {
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
		    enableFilter : true,
		    headerHeight: 40,
		    rowHeight: 37,
		    softRemoveRowMode  : true,
		    reverseRowNum : true,
		    softRemovePolicy   : "exceptNew"
		  },
		  columnLayout : [{
		    dataField : "NM",
		    headerText : "모니터 Monitor",
		    editRenderer : {
				type: "InputEditRenderer", 			
				validator : function(oldValue, newValue, rowItem){
					var isValid = false; 	
					
					validator(newValue);
					
					if(validatorCnt <= 100){ 
						isValid = true;
					} 			
				    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
					return{"validate" : isValid, "message" : "<spring:message code='ctms.message.validate'/>"};
				}
			}
		  },{
		    dataField : "FROM_VISIT_DE",
		    headerText : "방문시작일 Visit The Beginning",
		    width : 200,
		    dataType : "date",	
		    formatString : "yyyy-mm-dd",
		    editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			}
		  },{
		    dataField : "TO_VISIT_DE",
		    headerText : "방문종료일 Visit End",
		    width : 200,
		    dataType : "date",	
		    formatString : "yyyy-mm-dd",
		    editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			}
		  },{
		    dataField : "ITEM_SE",
		    headerText : "ITEM_SE",
		    visible : false
			  
		  },{
		    dataField : "VISIT_SN",
		    headerText : "VISIT_SN",
		    visible : false
		  }],

		  createGrid: function() {
		    var me = this;
		    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		    me.binding();
		    if(me.proxy.autoLoad) {
		      me.load();
		    }
		  },
		  binding: function() { },
		  load: function(v1, v2) {
		    var me = this;
		    
		    $.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: me.proxy.param,
			    success:function(data){
			    	if(data.success) {	 	    		
			    	    
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




var grid_wrap_03 = {
		  id: '',

		  div: {
		    gridDiv: '#grid_wrap_03'
		  },
		  proxy: {
			url: './selectApprovalInfo.do',
		    param: {},
		    type: 'post',
		    dataType: 'json',
		    autoLoad: true,
		  },
		  gridPros: {
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
		    enableFilter : true,
		    headerHeight: 40,
		    rowHeight: 37
		  },
		  columnLayout : [{
				dataField : "SANCTN_CODE_NM",
				headerText : '<spring:message code="comz0903.gr.SANCTN_CODE_NM"/>'
			},{
				dataField : "DEPT_NM",
				headerText : '<spring:message code="comz0903.gr.DEPT_NM"/>'
			},{
				dataField : "SANCTNER_NM",
				headerText : '<spring:message code="comz0903.gr.SANCTNER_NM"/>'
			},{
				dataField : "SANCTNER_ID",
				headerText : '<spring:message code="comz0903.gr.SANCTNER_ID"/>',
				visible : false
			},{
				dataField : "STTUS_CODE_NM",
				headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>'
			},{
				dataField : "SANCTN_CODE",
				headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>',
				visible : false
			},{
				dataField : "STTUS_CODE",
				headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>',
				visible : false 		
			},{
				dataField : "SANCTN_DT",
				headerText : '<spring:message code="comz0903.gr.SANCTN_DT"/>',
				formatString : "yyyy-mm-dd HH:MM:ss",
				dataType:"date",
				width: 200
			},{
				dataField : "SANCTN_COMMENT",
				headerText : '<spring:message code="comz0903.gr.SANCTN_COMMENT"/>'
			},{
				dataField : "EMAIL",
				headerText : 'EMAIL',
				visible : true
			}],

		  createGrid: function() {
		    var me = this;
		    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		    me.binding();
		    if(me.proxy.autoLoad) {
		      me.load();
		    }
		  },
		  binding: function() { },
		  load: function(v1, v2) {
		    var me = this;
		    $.ajax({
			    url: me.proxy.url,
			    type: me.proxy.type,
			    dataType: me.proxy.dataType,
			    data: me.proxy.param,
			    success:function(data){
			    	if(data.success) {
			    		//console.log(data.result);				    	
				    	AUIGrid.setGridData(me.id, data.result);
				    	AUIGrid.setSelectionByIndex(me.id, 0);				    	
			    	}
			    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		  }
		};




$(document).ready(function() {
  mainSelect();
  grid_wrap_01.createGrid();
  grid_wrap_02.createGrid();
  grid_wrap_03.createGrid();
  
//Grid1 row Add 
  $("#btnAdd1").click(function(){
	  var row = {
				 'NM' : ''				
				,'ROLE_NM' : ''				
				,'CRUD' : 'C'
				,'ITEM_SE' : '01' //방문시 접촉한 연구진
				,'LAST_UPDUSR' : g_userId
				,'DATA_SE' : 'B'
				,'VISIT_SN' : ''
				
		};		
		AUIGrid.addRow(grid_wrap_01.id, row, 'first'); // 최상단에 행 추가
  });

  //Grid1 row Delete
  $("#btnDel1").click(function(){
	  AUIGrid.removeRow(grid_wrap_01.id, "selectedIndex");
  });
  
  //Grid2 row Add 
  $("#btnAdd2").click(function(){
	  var row = {
			 	     'NM' : ''			 	    
					,'ROLE_NM' : ''					
					,'CRUD' : 'C' 
					,'ITEM_SE' : '02' //방문자 및 방문일
					,'LAST_UPDUSR' : g_userId
					,'DATA_SE' : 'B'
					,'VISIT_SN' : ''
					,'FROM_VISIT_DE' : ''
					,'TO_VISIT_DE' : ''
					
		};		
		AUIGrid.addRow(grid_wrap_02.id, row, 'first'); // 최상단에 행 추가
  });

  //Grid2 row Delete
  $("#btnDel2").click(function(){
	  AUIGrid.removeRow(grid_wrap_02.id, "selectedIndex");
  });
  
//저장버튼 클릭
  $("#btnSave").click(function(){	 	  
	  //////////목표피험자수 validator
	  validator($("#txtPlanned").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_1'/>");		 
		  $("#txtPlanned").focus();
		  return;
	  } 
	  //////////완료 피험자수  validator
	  validator($("#txtCompleted").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_2'/>");		 
		  $("#txtCompleted").focus();
		  return;
	  } 
	  //////////스크리닝 피험자수 validator
	  validator($("#txtScreened").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_3'/>");		 
		  $("#txtScreened").focus();
		  return;
	  } 	                   
	  //////////탈락 피험자수 validator
	  validator($("#txtDropped").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_4'/>");		 
		  $("#txtDropped").focus();
		  return;
	  } 
	  //////////증례기록수 코멘트 validator
	  validator($("#txtComment_A").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_5'/>");		 
		  $("#txtComment_A").focus();
		  return;
	  } 
	  //////////기본문서 코멘트 validator
	  validator($("#txtComment_B").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_6'/>");		 
		  $("#txtComment_B").focus();
		  return;
	  } 
	  //////////임상시험용의약품 코멘트 validator
	  validator($("#txtComment_C").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_7'/>");		 
		  $("#txtComment_C").focus();
		  return;
	  } 
	  //////////기타 validator
	  validator($("#txtComment_D").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_8'/>");		 
		  $("#txtComment_D").focus();
		  return;
	  } 
	  //////////Reason validator
	  validator($("#txtReason").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1101.message.Validator_9'/>");		 
		  $("#txtReason").focus();
		  return;
	  } 
	  
	  if(!$(':input:radio[name=e1]:checked').val()){
		  alert("<spring:message code='ctmz1101.message.e1'/>");
		  return;
	  }
	  
	  if(confirm('<spring:message code="ctmz0201.msg.Save" />') == true){
		  //확인 진행
	  }else{		  
	  	  return;
	  }
	  
	  if(!reportSn){
		  crudCnt = "01";
	  }else{
		  crudCnt = "02";
	  }
	  
	  var crud = "";
	  if(crudCnt == "01"){
		  crud = "C";
	  }else{
		  crud = "U";
	  }
	  console.log("CRUD::::::"+crud);
	  var arJson = [];
	 
	  /////////////////////////////////MAIN 저장////////////////////////////////////
	  var visitData = {
			   'REPORT_SN' : reportSn		    							//리포트 순번       
			  ,'MILESTONE_SN' : g_maileSn                                   //마일드스톤 순번   
			  ,'TASK_SN' : g_taskSn	                                        //과제순번          
			  ,'REPORT_TYPE' : 'V'                                          //리포트 타입       
			  ,'REPORT_SE' : 'L00'	                                        //리포트 구분       
			  ,'JOB_SE' : g_taskSe		                                    //과제타입          
			  ,'INSTT_CODE'	: g_InsttCode                                   //기관코드          
			  ,'RSRCHMAN_ID' : g_rsrchId                                    //책임연구자
			  ,'ITEM_A' : $("#txtPlanned").val()                             //목표피험자수 
			  ,'ITEM_B' : $("#txtCompleted").val()                           //완료 피험자수      
			  ,'ITEM_C' : $("#txtScreened").val()                            //스크리닝 피험자수
			  ,'ITEM_D' : $("#txtDropped").val()                             //탈락 피험자수
			  ,'ITEM_E' : $("#txtComment_A").val()                           //증례기록수 코멘트
			  ,'ITEM_F' : $("#txtComment_B").val()                           //기본문서 코멘트
			  ,'ITEM_G' : $("#txtComment_C").val()                           //임상시험용의약품 코멘트
			  ,'ITEM_H' : $("#txtComment_D").val()                           //기타 코멘트
			  ,'ITEM_I' : $('input[type=radio][name=e1]:checked').val()  //권고사항			
			  ,'ITEM_J' : $("#txtReason").val()		                   //Reason
			  ,'LAST_UPDUSR' : g_userId                                     //등록/수정자       
			  ,'CRUD' : crud												
			  ,'DATA_SE' : 'A'												//데이터 구분 A:MAIN,B:GRID,C:RADIO,D:이전 방문회차
			  ,'PURPS' : g_taskNo
			  ,'CHARGER_ID'	: g_userId
			  
	  };
	  arJson.push(visitData);
	/////////////////////////////////VISIT 저장////////////////////////////////////
	  // 추가된 행 아이템들(배열)
	  var addedRowItems1 = AUIGrid.getAddedRowItems(grid_wrap_01.id);	
	  var addedRowItems2 = AUIGrid.getAddedRowItems(grid_wrap_02.id);
	  // 수정된 행 아이템들(배열)
	  var editedItems1 = AUIGrid.getEditedRowItems(grid_wrap_01.id);
	  var editedItems2 = AUIGrid.getEditedRowItems(grid_wrap_02.id);
	  // 삭제된 행 아이템들(배열)
	  var removeItems1 = AUIGrid.getRemovedItems(grid_wrap_01.id);
	  var removeItems2 = AUIGrid.getRemovedItems(grid_wrap_02.id);
	  
	  // 외부참석자 그리드 
	  for(var i = 0; i < addedRowItems1.length; i++) {
	  	addedRowItems1[i].CRUD = 'C';
	  	addedRowItems1[i].REPORT_SN = reportSn;
	  	addedRowItems1[i].TASK_SN = g_taskSn;			
	  	addedRowItems1[i].MILESTONE_SN = g_maileSn;
	  	addedRowItems1[i].REPORT_TYPE = 'V';	
	  	addedRowItems1[i].DATA_SE = 'B';
	  	arJson.push(addedRowItems1[i]);			
	  }
	  
	  for(var i = 0; i < editedItems1.length; i++) {
	  	editedItems1[i].CRUD = 'U';			
	  	editedItems1[i].DATA_SE = 'B';
	  	editedItems1[i].REPORT_TYPE = 'V';
	  	editedItems1[i].LAST_UPDUSR = g_userId;
	  	arJson.push(editedItems1[i]);
	  }
	  
	  for(var i = 0; i < removeItems1.length; i++) {
	  	removeItems1[i].CRUD = 'D';
	  	removeItems1[i].DATA_SE = 'B';	
	  	removeItems1[i].REPORT_TYPE = 'V';
	  	removeItems1[i].LAST_UPDUSR = g_userId;			
	  	arJson.push(removeItems1[i]);
	  }
	  
	  // 내부참석자 그리드
	  for(var i = 0; i < addedRowItems2.length; i++) {
	  	addedRowItems2[i].CRUD = 'C';
	  	addedRowItems2[i].REPORT_SN = reportSn;
	  	addedRowItems2[i].TASK_SN = g_taskSn;		
	  	addedRowItems2[i].MILESTONE_SN = g_maileSn;
	  	addedRowItems2[i].REPORT_TYPE = 'V';		
	  	addedRowItems2[i].DATA_SE = 'B';
	  	arJson.push(addedRowItems2[i]);			
	  }
	  
	  for(var i = 0; i < editedItems2.length; i++) {
	  	editedItems2[i].CRUD = 'U';
	  	editedItems2[i].DATA_SE = 'B';
	  	editedItems2[i].REPORT_TYPE = 'V';
	  	editedItems2[i].LAST_UPDUSR = g_userId
	  	arJson.push(editedItems2[i]);
	  }
	  
	  for(var i = 0; i < removeItems2.length; i++) {
	  	removeItems2[i].CRUD = 'D';
	  	removeItems2[i].ITEM_SE = 'B';
	  	removeItems2[i].REPORT_TYPE = 'V';
	  	removeItems2[i].LAST_UPDUSR = g_userId;
	  	arJson.push(removeItems2[i]);
	  }
	  
	  /////////////////////////////////ITEM 저장////////////////////////////////////
	  var totalRows = $("tbody[id]").length;
	  //console.log("totalRows:::::"+totalRows);
	  var params = [  $("tbody[id]").find('tr[name=trA]').length,
					  $("tbody[id]").find('tr[name=trB]').length, 
					  $("tbody[id]").find('tr[name=trC]').length, 
					  $("tbody[id]").find('tr[name=trD]').length,
					  ];
	 
	  var addItems = {};
	  var num = 97; //아스키코드 소문자 a 시작	 
	  var a_value;
	  for(var j=0; j<totalRows; j++){		 	  
		  a_value = String.fromCharCode(num);	//아스키코드를 문자형으로..	
		  //console.log("a_value::::"+a_value);
		  num++;
		  
		  for(var i=1; i<=params[j]; i++){
			  addItems[i] = {
					  'REPORT_SN' : reportSn,
					  'MILESTONE_SN' : g_maileSn,
					  'TASK_SN' : g_taskSn,						  
					  'REPORT_TYPE' : 'V',
					  'ITEM_SE' : a_value+i,
					  'ITEM_VALUE' : $('input:radio[name="'+a_value+i+'"]:checked').val(),						   
					  'CHARGER_ID' : g_userId,
					  'RM' : '',					  
					  'CRUD' : crud,
					  'DATA_SE' : 'C',
					  'LAST_UPDUSR' : g_userId
			  }
			  if(!$(':input:radio[name="'+a_value+i+'"]:checked').val()){
				  alert("선택되지 않은 항목이 있습니다.");
				  return;
			  }
			  //console.log("checkedValue::::"+a_value+i+"::::::"+$('input:radio[name="'+a_value+i+'"]:checked').val());
			  arJson.push(addItems[i]);	
		  }
	  }//for
	  
	  $.ajax({		  
		  url : './insertPreTrialVisitReport.do',
		  type : 'post',
		  contentType : 'application/json; charset=UTF-8',
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR){
			  if(data.success){
			 	  crudCnt = "02"; //01:INSERT 02:UPDATE
			 	  mainSelect();
			  }else{
				  alert(data.message);
			  }
		  },
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	   });
  });
  
//결재요청 버튼 클릭
  $("#btnApproval").click(function() {
	  mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
		'REQUST_NM': '모니터링 보고서',
		'callbackFunction': 'f_requestRequstNo_1'
	  }, 1);
  });
  
  //결재정보버튼 클릭
  $('#btnApprovalInfo').click(function() {	  
	  mkLayerPopupOpen('/com/z09/popupCOMZ0903.do', {
	  	'REQUST_NO': approvalSn,
		'callbackFunction': 'f_requestRequstNo_2',
		'CALLBACK_TRUE' : true
	  });
  });
  
//RD 출력버튼
  $("#btnPrint").click(function(){
	  var param = {
				MRD_NAME : "CTMZ1101CPM-504-FORM 02-COVR-ver02.mrd",
				REPORT_SN : reportSn
				
		};

		var f = document.createElement("form");
		
		$.each(param, function(key, value){
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", key);
			obj.setAttribute("value", value);
			f.appendChild(obj);	
		});
		
		window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
		
		f.setAttribute("method", "post");
		f.setAttribute("action", "/com/system/CommonRD.do");
		f.setAttribute("target", "popForm");
		document.body.appendChild(f);
		f.submit();
	

  });

});

//결재정보 버튼 callback
function f_requestRequstNo_2(v) {
	//console.log("approvalSn:::::"+approvalSn);
	var params = {
  			'REQUEST_NO' : approvalSn
		};
	grid_wrap_03.proxy.param = params;
	grid_wrap_03.load();
}

//결재요청 버튼 callback
function f_requestRequstNo_1(v) {
	console.log('RequstNo : ' + v);
	approvalSn = v;
	
	var arJson = [];
	var approval = {
			'REPORT_SN' : reportSn,			
			'CHARGER_ID' : g_userId,
			'LAST_UPDUSR' : g_userId,
			'SETLE_NO' : v,
			'MILESTONE_SN' : g_maileSn,
			'TASK_SN' : g_taskSn, 
			'REPORT_TYPE' : 'V'
	};
	
	//console.log(approval);
	arJson.push(approval);
	
	$.ajax({
		  url : './updateApproval.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {				
			  
			  if(data.success) {
				  //approvalSn = data.result.
				    var params = {
	    	  			'REQUEST_NO' : v
	    			};
		    	  //console.log(params1);
		    	  grid_wrap_03.proxy.param = params;
				  grid_wrap_03.load();
				  ///////////////////////////결재요청시 이메일 발송/////////////////////////
				  var items = AUIGrid.getGridData(grid_wrap_03.id);
				  var exItems = [{"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
				                 {"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
				                 {"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/}];
				  //console.log(items[0].EMAIL);
				  //console.log(items[0].SANCTNER_NM);	
				  var emailInfo = {};
				  for(var i=0; i<items.length; i++){
					  //emailInfo = {"EMAIL" : items[i].EMAIL /*sendEmail*/, "USER_NM" : items[i].SANCTNER_NM/*userName*/}; 실제 메일발송
					  emailInfo = {"EMAIL" : exItems[i].EMAIL /*sendEmail*/, "USER_NM" : exItems[i].SANCTNER_NM/*userName*/};
					  //f_Email(emailInfo);
				  }
				  $("#btnApprovalInfo").attr("disabled", false);
				  
			  } else {					  
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
			  //alert(jqXHR);
		  }
	});
	
}

function f_Email(param){
	
	//console.log(sendEmail);

	var arJson = [];	
	arJson.push(param);

	$.ajax({
		    url: './insertApprovalEmail.do',
		    type: 'post', 		
		    contentType: "application/json; charset=UTF-8",
		    dataType: 'json',
		    data: JSON.stringify(arJson), 		  
		    success:function(data){
		    	
		    	if(data.success) {
		    		alert("ok");	    	
		    	} else { 		    		
		    		alert(data.message);
		    	}
		    },
		    error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			alert(errorThrown);
			alert(jqXHR.responseText);				
		}
	});
	
}

//화면이 열릴때 MAIN 조회 및 초기값 세팅
function mainSelect(){
	$("#txtTitle").val(g_taskNo);		  		   //연구제목
	$("#txtClinicalTrialSite").val(g_InsttName);   //연구기관
	$("#txtPrincipalInvestigator").val(g_rsrchNm); //책임연구자	
	
	var params = {
			 'MILESTONE_SN' : g_maileSn
			,'TASK_SN' : g_taskSn
			,'REPORT_SE' : 'L00'
			,'INSTT_CODE' : g_InsttCode			
	};
	
	$.ajax({
		type		: "POST",
		url			: "./selectPreTrialVisitReport.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	  success:function(data){
	  	if(data.success) {	  		
	  		if(data.result){
	  			  
				  $("#txtPlanned").val(data.result.ITEM_A)                             //목표피험자수 
				  $("#txtCompleted").val(data.result.ITEM_B)                           //완료 피험자수      
				  $("#txtScreened").val(data.result.ITEM_C)                            //스크리닝 피험자수
				  $("#txtDropped").val(data.result.ITEM_D)                             //탈락 피험자수
				  $("#txtComment_A").val(data.result.ITEM_E)                           //증례기록수 코멘트
				  $("#txtComment_B").val(data.result.ITEM_F)                           //기본문서 코멘트
				  $("#txtComment_C").val(data.result.ITEM_G)                           //임상시험용의약품 코멘트
				  $("#txtComment_D").val(data.result.ITEM_H)                           //기타 코멘트				 
				  $("input:radio[name=e1]:radio[value='"+data.result.ITEM_I+"']").attr("checked", true); //권고사항
				  $("#txtReason").val(data.result.ITEM_J)		                   //Reason				  
				  $("#txtTitle").val(data.result.PURPS);		  		   //연구제목
				  $("#txtClinicalTrialSite").val(data.result.NAME1);   //연구기관
				  $("#txtPrincipalInvestigator").val(data.result.USER_NM); //책임연구자					  
	  			  reportSn = data.result.REPORT_SN;	  			  
	  			  approvalSn = data.result.SETLE_NO; //결재순번
	  			  selectItem(reportSn); //ITEM 조회
	  			  
	  			  $("#btnPrint").attr("disabled", false);        
    			  $("#btnApproval").attr("disabled", false);
    			  if(data.result.SETLE_NO){ //결재요청번호가 있을때 결재정보 활성화
    			  	  $("#btnApprovalInfo").attr("disabled", false);
    			  }
	  			  var visitData1 = {'MILESTONE_SN' : g_maileSn, 'TASK_SN' : g_taskSn, 'ITEM_SE' : '01', 'REPORT_SN' : reportSn};
 				  var visitData2 = {'MILESTONE_SN' : g_maileSn, 'TASK_SN' : g_taskSn, 'ITEM_SE' : '02', 'REPORT_SN' : reportSn};
 				  var visitData3 = {'REQUEST_NO' : approvalSn};
  				
  				
 				
 				  grid_wrap_01.proxy.param = visitData1;
 				  grid_wrap_02.proxy.param = visitData2;
 				  grid_wrap_03.proxy.param = visitData3;
 				  grid_wrap_01.load();
 				  grid_wrap_02.load();
 				  grid_wrap_03.load();
	  		}else if(!data.result){ //신규면 출력, 결재요청, 결재 버튼 disabled
    			$("#btnPrint").attr("disabled", true);        
    			$("#btnApproval").attr("disabled", true);
    			$("#btnApprovalInfo").attr("disabled", true);    			
    		}
	  	} else {
	  		//alert(data.message);
	  	}
	  },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			//alert(jqXHR);
		}		
	});	
	
}

//////////////////CTMS_ST_REPORT_ITEM 조회////////////////////////////
function selectItem(param){
	console.log("param::::::::::"+param);
	$.ajax({
		type : "post",
		url	 : "./selectItemReport.do",
		data : {'REPORT_SN' : param},
		dataType : "json",
	  success:function(data){
	  	if(data.success) {
    		var itemData = data.result;
    	
    		for(var i=0; i<data.result.length; i++){
    			$('input:radio[name="'+itemData[i].ITEM_SE+'"]:input[value="'+itemData[i].ITEM_VALUE+'"]').attr('checked',true);	
    		}	    		
	  	} else {
	  		alert(data.message);
	  	}
	  },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			//alert(jqXHR);
		}		
	});	

}

function validator(value){
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

$(window).resize(function(){
	if (grid_wrap_01.id) {
		AUIGrid.resize(grid_wrap_01.id);
	}
	if (grid_wrap_02.id) {
		AUIGrid.resize(grid_wrap_02.id);
	}	
	if (grid_wrap_03.id) {
		AUIGrid.resize(grid_wrap_03.id);
	}	
});




</script>


</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1102&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1102&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
					<article>
						<h5><spring:message code="ctmz1101.title.CTMZ1101" /></h5>
					</article>

					<div style="height:10px;"></div>

					<table class="tb001">
						<colgroup>
							<col width="250px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>임상시험제목 Title</th>
								<td>
									<input type="text" id="txtTitle" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="txtClinicalTrialSite" style="width:100%;" disabled>									
								</td>
							</tr>
							<tr>
								<th>시험책임자 Principal Investigator</th>
								<td>
									<input type="text" id="txtPrincipalInvestigator" style="width:100%;" disabled>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h6>방문시 접촉한 연구진 Study Personnel Present During Visit</h6>
                    </article>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAdd1" class="add_01" title="행추가">
						<input type="button" id="btnDel1" class="del_01" title="행삭제">
					</div>
					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>	


					<div style="height:20px;"></div>



                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h6>방문자 및 방문일 Visit &amp; Visit Date</h6>
                    </article>


					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAdd2" class="add_01" title="행추가">
						<input type="button" id="btnDel2" class="del_01" title="행삭제">
					</div>
					<div id="grid_wrap_02" class="gridHeiSz03 grid_wrap tb01_2"></div>
                    




					<div style="height:20px;"></div>



                    <article class="conTitBox">
                        <h6>피험자 정보 Subject Information</h6>
                    </article>
					
					<div style="height:5px;"></div>
					
					<table class="tb001">
						<colgroup>
							<col width="50%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<td><span style="margin-right:44px;"># 목표피험자수 Total Subjects Planned</span> <input type="text" id="txtPlanned" style="width:100px;" value=""> 명</td>
								<td><span style="margin-right:10px;"># 완료 피험자수 Total Subjects Completed</span> <input type="text" id="txtCompleted" style="width:100px;" value=""> 명</td>
							</tr>
							<tr>
								<td><span style="margin-right:10px;"># 스크리닝 피험자수 Total Subjects Screened</span> <input type="text" id="txtScreened" style="width:100px;" value=""> 명</td>
								<td><span style="margin-right:21px;"># 탈락 피험자수 Total Subjects Dropped</span> <input type="text" id="txtDropped" style="width:100px;" value=""> 명</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>1. 증례기록서 Case Report Form</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbA">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trA">
								<td>1</td>
								<td>증례기록서 원본을 모두 수거하였습니까? Have all original CRFs been collected?</td>
								<td><input type="radio" id="a11" name="a1" value="Y"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1" value="N"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1" value="X"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>2</td>
								<td>증례기록서의 의문사항이 모두 해결되었습니까? Have all data clarification forms/queries been resolved to CRFs?</td>
								<td><input type="radio" id="a21" name="a2" value="Y"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2" value="N"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2" value="X"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>3</td>
								<td>증례기록서 원본 이외에 임상시험용물품은 모두 수거하였습니까? Have all clinical trial materials (except original CRFs) been collected?</td>
								<td><input type="radio" id="a31" name="a3" value="Y"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3" value="N"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3" value="X"><label for="a33" class="raLab"></label></td>
							</tr>

						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtComment_A" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>2.기본문서 Essential Document</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbB">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trB">
								<td>1</td>
								<td>시험책임자는 KGCP에 따른 시험자 기본문서를 제대로 구비하고 있습니까? Is the site study file appropriately maintained according to KGCP?</td>
								<td><input type="radio" id="b11" name="b1" value="Y"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1" value="N"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1" value="X"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>2</td>
								<td>시험책임자는 문서보관(CRF, 근거문서, 시험자기본문서) 임무와 보관기간을 알고 있습니까? Has the PI been reminded of his/her records (CRF, source document and essential document) retention obligations?</td>
								<td><input type="radio" id="b21" name="b2" value="Y"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2" value="N"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2" value="X"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>3</td>
								<td>관리약사는 KGCP에 따른 기본문서를 제대로 구비하고 있습니까? Is the pharmacy file appropriately maintained according to KGCP?</td>
								<td><input type="radio" id="b31" name="b3" value="Y"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3" value="N"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3" value="X"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>4</td>
								<td>IRB는 KGCP에 따른 기본문서를 제대로 구비하고 있습니까? Is IRB’s document appropriately maintained according to KGCP?</td>
								<td><input type="radio" id="b41" name="b4" value="Y"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4" value="N"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4" value="X"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>5</td>
								<td>기관으로부터 시험의뢰자가 받아야 할 기본문서를 모두 받았습니까? Have all the essential documents of site been forwarded to sponsor?</td>
								<td><input type="radio" id="b51" name="b5" value="Y"><label for="b51" class="raLab"></label></td>
								<td><input type="radio" id="b52" name="b5" value="N"><label for="b52" class="raLab"></label></td>
								<td><input type="radio" id="b53" name="b5" value="X"><label for="b53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtComment_B" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					


					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>3.임상시험용의약품 Investigational Product Accountability</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbC">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trC">
								<td>1</td>
								<td>임상시험용의약품을 모두 반납 받았습니까? Have investigational products been returned to sponsor?</td>
								<td><input type="radio" id="c11" name="c1" value="Y"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1" value="N"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1" value="X"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>2</td>
								<td>임상시험용의약품의 수불기록 사본을 받았습니까? Have copies of accountability of all investigational product been submitted to sponsor?</td>
								<td><input type="radio" id="c21" name="c2" value="Y"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2" value="N"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2" value="X"><label for="c23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtComment_C" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>4. 기타 Others</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbD">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trD">
								<td>1</td>
								<td>IRB에 시험종료보고 계획에 대하여 PI와 협의하였습니까? Has the PI been reminded to notify the IRB of site close-out?</td>
								<td><input type="radio" id="d11" name="d1" value="Y"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1" value="N"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1" value="X"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>2</td>
								<td>연구비 정산 및 지급에 관하여 PI와 협의하였습니까? Has the financial issue (ex. final payment) been discussed with the PI?</td>
								<td><input type="radio" id="d21" name="d2" value="Y"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2" value="N"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2" value="X"><label for="d23" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>3</td>
								<td>외부에 발표할 계획에 대하여 PI와 협의하였습니까? Has the publication plan been discussed with the PI?</td>
								<td><input type="radio" id="d31" name="d3" value="Y"><label for="d31" class="raLab"></label></td>
								<td><input type="radio" id="d32" name="d3" value="N"><label for="d32" class="raLab"></label></td>
								<td><input type="radio" id="d33" name="d3" value="X"><label for="d33" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>4</td>
								<td>미해결 문제가 있습니까? Is there any unsolved problems</td>
								<td><input type="radio" id="d41" name="d4" value="Y"><label for="d41" class="raLab"></label></td>
								<td><input type="radio" id="d42" name="d4" value="N"><label for="d42" class="raLab"></label></td>
								<td><input type="radio" id="d43" name="d4" value="X"><label for="d43" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>5</td>
								<td>이후 진행과정(Audit, 실태조사 등)에 관해 논의하였습니까? Has the PI been reminded of Audit and/or KFDA inspection?</td>
								<td><input type="radio" id="d51" name="d5" value="Y"><label for="d51" class="raLab"></label></td>
								<td><input type="radio" id="d52" name="d5" value="N"><label for="d52" class="raLab"></label></td>
								<td><input type="radio" id="d53" name="d5" value="X"><label for="d53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtComment_D" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

                    <article class="conTitBox">
                        <h6>5. 권고사항 Recommendations</h6>
                    </article>
					
					
					
					<div style="height:5px;"></div>
					
					<input type="radio" id="e1" name="e1" value="Y"><label for="e1" class="raLab"><span>모니터의 의견에 동의합니다. I agree with the recommendations of the monitor.</span></label>
					<br>
					<input type="radio" id="e2" name="e1" value="N"><label for="e1" class="raLab"><span>모니터의 의견에 동의하지 않습니다. I do not agree with the recommendations of the monitor.</span></label>


					<div style="height:10px;"></div>


					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Reason</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtReason" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>6. <spring:message code="ctms.title.Approval"/></h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval" value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					
					
					<div style="height:10px;"></div>
					
					
					<div id="grid_wrap_03" class="gridHeiSz04 grid_wrap tb01_2"></div>



					<div style="height:20px;"></div>



                    <div style="text-align:center;">
                        <input type="button" id="btnSave" value="<spring:message code="ctmz0201.btn.Save" />">
                        <input type="button" id="btnPrint" value="<spring:message code="ctmz0201.btn.Print" />">
                    </div>


							
				</div>
            </section>

		</div>
	</section>

</div>
</body>
</html>