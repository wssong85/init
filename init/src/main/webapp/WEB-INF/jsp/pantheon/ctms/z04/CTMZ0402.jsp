<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<script>
var g_maileSn = "${result.MILESTONE_SN}";   //마일스톤 순번
var g_InsttCode = "${result.INSTT_CODE}";   //기관코드				  
var g_InsttName = "${result.NAME1}";		//기관명
var g_rsrchNm = "${result.USER_NM}";		//책임연구자 NAME
var g_rsrchId = "${result.USER_ID}";		//책임연구자 ID
var g_taskNo = "${loginMap.TASK_NO}";		//과제번호
var g_taskSn = "${loginMap.TASK_SN}";		//과제순번
var g_userId = "${loginMap.USER_ID}";		//로그인한 USER_ID
var g_taskSe = "${loginMap.TASK_TY_CODE}";	//과제 타입
var crudCnt = "01";	//INSERT:01 인지 UPDATE:02 인지 구분
var reportSn; //리포트 MAIN 순번
var setleNo = "";  //결재번호
var approvalSn; //결재순번저장
var visitOdt; //방문회차
var visitOdtReportSn; //전 방문회차 리포트 순번
var visitOdtMileStone;
var validatorCnt;

var grid_wrap_01 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_01'
  },
  proxy: {
    url: './selectVisitInfoGrid1.do',
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
	url: './selectVisitInfoGrid2.do',
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
	    	    console.log(data.result);
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






var testData_03 =[
{
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}];



var grid_wrap_04 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_04'
  },
  proxy: {
	url: './selectApprovalInfo.do',
	param: {'REQUEST_NO' : approvalSn}, /*$("#appv").val()*/
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
  visitOdrSelect();
  mainSelect();
  grid_wrap_01.createGrid();
  grid_wrap_02.createGrid(); 
  grid_wrap_04.createGrid();
 
  
  //저장버튼 클릭
  $("#btnSave").click(function(){
	  if(confirm('<spring:message code="ctmz0201.msg.Save" />') == true){
		  //확인 진행
	  }else{		  
	  	  return;
	  }
	  
	  //이번에 검토한 CRF  validator
	  validator($("#txtCOL_A").val()); 
	  if(validatorCnt > 100){  //이번에 검토한 CRF 
		  alert("<spring:message code='ctmz0402.message.COL_A'/>");		 
		  $("#txtCOL_A").focus();
		  return;
	  } 
	  
	  //유해사례건수	 validator  
	  validator($("#txtCOL_C").val()); 
	  if(validatorCnt > 100){  
		  alert("<spring:message code='ctmz0402.message.COL_C'/>");		 
		  $("#txtCOL_C").focus();
		  return;
	  } 
	  
	  ////목표 조상대상자 수	 validator  
	  validator($("#txtItemA").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemA'/>");		 
		  $("#txtItemA").focus();
		  return;
	  }
	  
	   //////등록       	 validator  
	  validator($("#txtItemB").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemB'/>");		 
		  $("#txtItemB").focus();
		  return;
	  }
	  
	  //////완료       	 validator  
	  validator($("#txtItemC").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemC'/>");		 
		  $("#txtItemC").focus();
		  return;
	  }
	  
	  //////탈락       	 validator  
	  validator($("#txtItemD").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemD'/>");		 
		  $("#txtItemD").focus();
		  return;
	  }
	  
	  //////진행중       	 validator  
	  validator($("#txtItemE").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemE'/>");		 
		  $("#txtItemE").focus();
		  return;
	  }
	  
	  //////비고       	 validator  
	  validator($("#txtItemF").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemF'/>");		 
		  $("#txtItemF").focus();
		  return;
	  }
	  
	  //////1.코멘트	    validator  
	  validator($("#txtItemG").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemG'/>");		 
		  $("#txtItemG").focus();
		  return;
	  }
	  	
      //////2.코멘트	    validator  
	  validator($("#txtItemH").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemH'/>");		 
		  $("#txtItemH").focus();
		  return;
	  }
	  
       //////3.코멘트	    validator  
	  validator($("#txtItemI").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemI'/>");		 
		  $("#txtItemI").focus();
		  return;
	  }
	  
	  //////4.코멘트	    validator  
	  validator($("#txtItemJ").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemJ'/>");		 
		  $("#txtItemJ").focus();
		  return;
	  }
	  
	  //////5.코멘트	    validator  
	  validator($("#txtItemK").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ItemK'/>");		 
		  $("#txtItemK").focus();
		  return;
	  }
	  
	  //////total 비고	    validator  
	  validator($("#txtTotalRemark").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.TotalRemark'/>");		 
		  $("#txtTotalRemark").focus();
		  return;
	  }
	  
	  //////권고사항 REASON   	    validator  
	  validator($("#txtReason").val()); 
	  if(validatorCnt > 4000){  
		  alert("<spring:message code='ctmz0402.message.ReasonRemark'/>");		 
		  $("#txtReason").focus();
		  return;
	  }
	 
	  
	  if(!reportSn){
		  crudCnt = "01";
	  }else{
		  crudCnt = "02";
	  }
	  
	  var crud;
	  
	  if(crudCnt == "01"){ //01이면 INSERT 02는 UPDATE
		  crud = "C";		 
	  }else{
		  crud = "U";		 
	  }
	  console.log("CRUD:::::"+crud);
	  var arJson = [];
	  
	  ////////////////////////////////기존 방문회차 수정////////////////////////////
	  
	  if($("#txtNoOfVisit").val() != "1"){ //방문회차가 1이아니면 이전 조사대상자 정보 update
		  var item = $("#txtNoOfVisit").val();
	      var visitOdr = Number(item)-1;
		  var visitOdrData = {
				   'ODT_REPORT_SN' : visitOdtReportSn    			//이전회차 리포트 순번 
				  ,'ODT_MILESTONE_SN' : visitOdtMileStone
				  ,'VISIT_ODR' : visitOdr.toString()			    //이전회차 
				  ,'MILESTONE_SN' : g_maileSn                       //마일드스톤 순번   
				  ,'TASK_SN' : g_taskSn	                            //과제순번          
				  ,'REPORT_TYPE' : 'V'                              //리포트 타입       
				  ,'REPORT_SE' : 'B02'	                            //리포트 구분       
				  ,'JOB_SE' : g_taskSe		                        //과제타입          
				  ,'INSTT_CODE'	: g_InsttCode                       //기관코드
				  ,'ITEM_B' : $("#txtlastVisitEnrollment").val()	//등록 
				  ,'ITEM_C' : $("#txtLastCompletion").val()         //완료 
				  ,'ITEM_D' : $("#txtLastDropout").val()            //탈락
				  ,'ITEM_F' : $("#txtLastRemark").val()			    //비고
				  ,'LAST_UPDUSR' : g_userId                         //등록/수정자
				  ,'DATA_SE' : 'D'									//데이터 구분 A:MAIN,B:GRID,C:RADIO,D:이전 방문회차
				  ,'CRUD' : 'U'
		  };
		  arJson.push(visitOdrData);
		  console.log(arJson);
	  }
	  
	  /////////////////////////////////MAIN 저장////////////////////////////////////	  
	  var monitringData = {
			   'REPORT_SN' : reportSn		    							//리포트 순번       
			  ,'MILESTONE_SN' : g_maileSn                                   //마일드스톤 순번   
			  ,'TASK_SN' : g_taskSn	                                        //과제순번          
			  ,'REPORT_TYPE' : 'V'                                          //리포트 타입       
			  ,'REPORT_SE' : 'B02'	                                        //리포트 구분       
			  ,'JOB_SE' : g_taskSe		                                    //과제타입          
			  ,'INSTT_CODE'	: g_InsttCode                                   //기관코드          
			  ,'RSRCHMAN_ID' : g_rsrchId                                    //책임연구자	    
			  ,'VISIT_ODR' : $("#txtNoOfVisit").val()	             	    //방문차수          
			  ,'COL_A' : $("#txtCOL_A").val()                               //이번에 검토한 CRF 
			  ,'COL_C' : $("#txtCOL_C").val()                               //유해사례건수	    
			  ,'COL_D' : $('input[type=radio][name=raCOL_D]:checked').val()	//권고사항
			  ,'ITEM_A'	: $("#txtItemA").val()	                            //목표 조상대상자 수
			  ,'ITEM_B'	: $("#txtItemB").val()	                            //등록              
			  ,'ITEM_C'	: $("#txtItemC").val()	                            //완료              
			  ,'ITEM_D'	: $("#txtItemD").val()	                            //탈락              
			  ,'ITEM_E'	: $("#txtItemE").val()	                            //진행중            
			  ,'ITEM_F'	: $("#txtItemF").val()	                            //비고              
			  ,'ITEM_G'	: $("#txtItemG").val()	                            //1.코멘트	    
			  ,'ITEM_H'	: $("#txtItemH").val()	                            //2.코멘트          
			  ,'ITEM_I'	: $("#txtItemI").val()	                            //3.코멘트          
			  ,'ITEM_J'	: $("#txtItemJ").val()	                            //4.코멘트          
			  ,'ITEM_K'	: $("#txtItemK").val()	                            //5.코멘트   
			  ,'REMARK_A' : $("#txtTotalRemark").val()						//total 비고	
			  ,'REMARK_B' : $("#txtReason").val()		                    //권고사항 REASON   
			  ,'LAST_UPDUSR' : g_userId                                     //등록/수정자       
			  ,'CRUD' : crud												
			  ,'DATA_SE' : 'A'												//데이터 구분 A:MAIN,B:GRID,C:RADIO,D:이전 방문회차
			  ,'PURPS' : g_taskNo
			  ,'CHARGER_ID'	: g_userId
	  };
	  arJson.push(monitringData);
	  ////////////////////////////////////그리드//////////////////////////////////////
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
	  
	  ///////////////////////// CTMS_ST_REPORT_ITEM///////////////////////////////////////////
	  
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
					  'SUBJECT_CO' : $('#txtInputSubjectCo').val(),
					  'DTE' : $('#day_02').val(),
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
	  }
	  //console.log(arJson);
	  
	  $.ajax({		  
		  url : './insertMonitoringVisitReport.do',
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
	  
  });//저장버튼 클릭
  
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
					
		};		
		AUIGrid.addRow(grid_wrap_02.id, row, 'first'); // 최상단에 행 추가
  });

  //Grid2 row Delete
  $("#btnDel2").click(function(){
	  AUIGrid.removeRow(grid_wrap_02.id, "selectedIndex");
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
  
  //모니터링 계획서로 이동 CTMZ0401
  $("#btnPreparations").click(function(){
	  var params = { 'MILESTONE_SN' : g_maileSn,
		  		 	 'TASK_SN' : g_taskSn, 		        	 		    	  	
			 	 	 'NAME1' :   $("#txtClinicalTrialSite").val(),
					 'USER_NM' : $("#txtPrincipalInvestigator").val(),
			 	 	 'USER_ID' : g_rsrchId,			 	 	
  				 	 'INSTT_CODE' : g_InsttCode
  				 	 };
	  
	  
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
		f.setAttribute("action", "/ctms/z04/CTMZ0401.do");
		document.body.appendChild(f);
		f.submit();
	 // $(location).attr("href","/ctms/z02/CTMZ0202.do");
  });
  
  $("#btnPrint").click(function(){
	  var visitOdr;
	  if($("#txtNoOfVisit").val() == "1"){
		  visitOdr = $("#txtNoOfVisit").val();
	  }else{
		  visitOdr = Number(visitOdt)-1;  //방문회차가 1회가 아니면 -1
	  }
	  console.log("reprtSn:::"+reportSn);
	  var param = {
				MRD_NAME : "CTMZ0402_NSS-301-FORM 08-MCR-Ver.01.mrd",				
				TASK_SN : g_taskSn,				
				VISIT_ODR_P : visitOdr.toString(),
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
	grid_wrap_04.proxy.param = params;
	grid_wrap_04.load();
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
		    	  grid_wrap_04.proxy.param = params;
				  grid_wrap_04.load();
				  ///////////////////////////결재요청시 이메일 발송/////////////////////////
				  var items = AUIGrid.getGridData(grid_wrap_04.id);
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
	console.log(g_rsrchNm);
	$("#txtTitle").val(g_taskNo);		  		   //연구제목
	$("#txtClinicalTrialSite").val(g_InsttName);   //연구기관
	$("#txtPrincipalInvestigator").val(g_rsrchNm); //책임연구자
	//$("#txtNoOfVisit").val("01"); 			       //방문차수
	
	var params = {
			'MILESTONE_SN' : g_maileSn
			,'TASK_SN' : g_taskSn
			,'REPORT_SE' : 'B02'
			,'INSTT_CODE' : g_InsttCode
	};
	
	$.ajax({
		type		: "POST",
		url			: "./selectMonitoringMain.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	  success:function(data){
	  	if(data.success) {	  		
	  		if(data.result){
	  			$("#txtTitle").val(data.result.PURPS);
	  			$("#txtClinicalTrialSite").val(data.result.NAME1);
	  			$("#txtPrincipalInvestigator").val(data.result.USER_NM);
	  			$("#txtNoOfVisit").val(data.result.VISIT_ODR);
	  			$("#txtItemA").val(data.result.ITEM_A);
	  			$("#txtItemB").val(data.result.ITEM_B);
	  			$("#txtItemC").val(data.result.ITEM_C);
	  			$("#txtItemD").val(data.result.ITEM_D);
	  			$("#txtItemE").val(data.result.ITEM_E);
	  			$("#txtItemF").val(data.result.ITEM_F);
	  			$("#txtItemG").val(data.result.ITEM_G);
	  			$("#txtItemH").val(data.result.ITEM_H);
	  			$("#txtItemI").val(data.result.ITEM_I);
	  			$("#txtItemJ").val(data.result.ITEM_J);
	  			$("#txtItemK").val(data.result.ITEM_K);
	  			$("#txtCOL_A").val(data.result.COL_A);
	  			$("#txtCOL_C").val(data.result.COL_C);	  			
	  			$("#txtReason").val(data.result.REMARK_B); 
	  			$("#txtTotalRemark").val(data.result.REMARK_A);	  			
	  			$("input:radio[name=raCOL_D]:radio[value='"+data.result.COL_D+"']").attr("checked", true);	 
	  			reportSn = data.result.REPORT_SN;
	  			visitOdt = data.result.VISIT_ODR;	
	  			approvalSn = data.result.SETLE_NO;
 				selectItem(reportSn); 
 				
 				$("#btnPrint").attr("disabled", false);        
    			$("#btnApproval").attr("disabled", false);
    			if(data.result.SETLE_NO){ //결재요청번호가 있을때 결재정보 활성화
    				$("#btnApprovalInfo").attr("disabled", false);
    			}
	  		}else if(!data.result){ //신규면 출력, 결재요청, 결재 버튼 disabled
    			$("#btnPrint").attr("disabled", true);        
    			$("#btnApproval").attr("disabled", true);
    			$("#btnApprovalInfo").attr("disabled", true);
    			
    		}
	  		
  		    var visitData1 = {'MILESTONE_SN' : g_maileSn, 'TASK_SN' : g_taskSn, 'ITEM_SE' : '01', 'REPORT_SN' : reportSn};
			var visitData2 = {'MILESTONE_SN' : g_maileSn, 'TASK_SN' : g_taskSn, 'ITEM_SE' : '02', 'REPORT_SN' : reportSn};
			var visitData3 = {'REQUEST_NO' : approvalSn};
			
			
			
			grid_wrap_01.proxy.param = visitData1;
			grid_wrap_02.proxy.param = visitData2;
			grid_wrap_04.proxy.param = visitData3;
			grid_wrap_01.load();
			grid_wrap_02.load();
			grid_wrap_04.load();
				
	  		selectvisitOdrPrevious($("#txtNoOfVisit").val());
	  		
	  		if($("#txtNoOfVisit").val() == "1"){ //방문회차가 1이면 이전 조사대상자 정보 disabled
	  			$("#txtlastVisitEnrollment").attr("disabled" ,true);
		  		$("#txtLastCompletion").attr("disabled" ,true);
		  		$("#txtLastDropout").attr("disabled" ,true);
		  		$("#txtLastRemark").attr("disabled" ,true);
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

//////방문회차 조회/////
function visitOdrSelect(){
	
	var params = {			 
			 'REPORT_TYPE' : 'V'
			,'JOB_SE' : g_taskSe
			,'INSTT_CODE' : g_InsttCode
			,'TASK_SN' : g_taskSn
			,'DATA_TYPE' : 'A'      //DATA_TYPE이 A면 VISIT_ODR 조회 B면 전 방문차수 조사대상자수정보 데이터 조회     
	};
	
	$.ajax({
		type		: "POST",
		url			: "./selectVisitOdr.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	  success:function(data){
	  	if(data.success) {	  		
	  		console.log("VISIT_ODR::::"+data.result.VISIT_ODR);
	  		if(!data.result.VISIT_ODR){
	  			$("#txtNoOfVisit").val("1"); // 방문차수가 없으면 1	  			
	  		}else{
	  			var odr_data = Number(data.result.VISIT_ODR); //같은 기관의 새로운 모니터링 방문보고서면 기존의 방문차수에서 +1
	  			$("#txtNoOfVisit").val(odr_data+1);
	  			
	  		}
	  		
	  	} else {
	  		//alert(data.message);
	  	}
	  },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			//alert(errorThrown);
		}		
	});
}

//////전 방문회차 조사대상자 정보 데이터 조회/////
function selectvisitOdrPrevious(item){
	var params = {			 
			 'REPORT_TYPE' : 'V'
			,'JOB_SE' : g_taskSe
			,'INSTT_CODE' : g_InsttCode
			,'TASK_SN' : g_taskSn
			,'VISIT_ODR' : Number(item)-1
			,'DATA_TYPE' : 'B'      //DATA_TYPE이 A면 VISIT_ODR 조회 B면 전 방문차수 조사대상자수정보 데이터 조회     
	};
	
	$.ajax({
		type		: "POST",
		url			: "./selectvisitOdrPrevious.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	    success:function(data){	    	
	  	if(data.success) {	  	
	  		if(data.result){
	  			console.log("!!!!!!!!!!!!!!!!!!!!!!!!:::");
	  			$("#txtlastVisitEnrollment").val(data.result.ITEM_B);
		  		$("#txtLastCompletion").val(data.result.ITEM_C);
		  		$("#txtLastDropout").val(data.result.ITEM_D);
		  		$("#txtLastRemark").val(data.result.ITEM_F);		  		
		  		
		  		var itemB = Number($("#txtItemB").val());
		  		var itemC = Number($("#txtItemC").val());
		  		var itemD = Number($("#txtItemD").val());		  		
		  		var item1 = Number($("#txtlastVisitEnrollment").val());
		  		var item2 = Number($("#txtLastCompletion").val());
		  		var item3 = Number($("#txtLastDropout").val());		  		
		  		
		  		$("#txtTotalEnrollment").val(itemB+item1);
		  		$("#txtTotalCompletion").val(itemC+item2);
		  		$("#txtTotalDropout").val(itemD+item3);
		  		$("#txtTotalOngoing").val($("#txtItemE").val());
		  		
		  		visitOdtReportSn = data.result.REPORT_SN;
		  		visitOdtMileStone = data.result.MILESTONE_SN
	  		   
		  		
	  		}
	  			
	  		
	  	} else {
	  		//alert(data.message);
	  	}
	  },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			//alert(errorThrown);
		}		
	});
}
//////////////////CTMS_ST_REPORT_ITEM 조회////////////////////////////
function selectItem(param){
	console.log("param::::::::::"+param);
	$.ajax({
		type : "post",
		url	 : "./selectVisitInfoItem.do",
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
	if (grid_wrap_04.id) {
		AUIGrid.resize(grid_wrap_04.id);
	}	
});



</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0403&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0403&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
					<div id="tab" class="tab tab01">
						<ul>
							<li id="btnPreparations" class="tab_menu"><spring:message code="ctmz0202.title.btnPreparations" /></li>
							<li id="btnVisitReport" class="port_back tab_menu"><spring:message code="ctmz0202.title.btnVisitReport" /></li>
						</ul>
					</div>

					<table class="tb001">
						<colgroup>
							<col width="250px" />
							<col width="" />
							<col width="160px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>연구제목 Title</th>
								<td colspan="3">
									<input type="text" id="txtTitle" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>연구기관 Clinical Trial Site</th>
								<td colspan="3">
									<input type="text" id="txtClinicalTrialSite" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>책임연구자 Principal Investigator</th>
								<td>
									<input type="text" id="txtPrincipalInvestigator" style="width:100%;" disabled>
								</td>
								<th>방문차수 No. of Visit</th>
								<td>
									<input type="text" id="txtNoOfVisit" style="width:100px;" disabled> <spring:message code="ctmz0402.title.NdVisit" />
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
                        <h6>조사대상자 정보 Subject Information</h6>
                    </article>
					
					<div style="height:5px;"></div>
					
					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="16%" />
							<col width="16%" />
							<col width="16%" />
							<col width="16%" />
							<col width="16%" />
						</colgroup>
						<tbody>
							<tr>
								<td colspan="6">#목표 조사대상자수 Total Subjects Planned <input type="text" id="txtItemA" style="width:100px;" > <spring:message code="ctmz0402.title.Persons" /></td>
							</tr>
							<tr>
								<th></th>
								<th style="text-align:center; padding-left:5px;">등록 Enrollment</th>
								<th style="text-align:center; padding-left:5px;">완료 Completion</th>
								<th style="text-align:center; padding-left:5px;">탈락 Drop-out</th>
								<th style="text-align:center; padding-left:5px;">진행 중 On-going</th>
								<th style="text-align:center; padding-left:5px;">비고 Remark</th>
							</tr>
							<tr>
								<td style=" background:#f6f7ff;"><spring:message code="ctmz0402.title.LastVisit" /></td>
								<td><input type="text" id="txtlastVisitEnrollment" style="width:100%;" ></td>
								<td><input type="text" id="txtLastCompletion" style="width:100%;" ></td>
								<td><input type="text" id="txtLastDropout" style="width:100%;" ></td>
								<td style="padding:0; height:auto; font:0/0 arial;"><img src="/images/pantheon/common/x_img.png" alt="" style="width:100%; height:100%;"></td>
								<td><input type="text" id="txtLastRemark" style="width:100%;" ></td>
							</tr>
							<tr>
								<td style=" background:#f6f7ff;"><spring:message code="ctmz0402.title.TheVisit" /></td>
								<td><input type="text" id="txtItemB" style="width:100%;" ></td>
								<td><input type="text" id="txtItemC" style="width:100%;" ></td>
								<td><input type="text" id="txtItemD" style="width:100%;" ></td>
								<td><input type="text" id="txtItemE" style="width:100%;" ></td>
								<td><input type="text" id="txtItemF" style="width:100%;" ></td>
							</tr>
							<tr>
								<td style=" background:#f6f7ff;">Total</td>
								<td><input type="text" id="txtTotalEnrollment" style="width:100%;" disabled></td>
								<td><input type="text" id="txtTotalCompletion" style="width:100%;" disabled></td>
								<td><input type="text" id="txtTotalDropout" style="width:100%;" disabled></td>
								<td><input type="text" id="txtTotalOngoing" style="width:100%;" disabled></td>
								<td><input type="text" id="txtTotalRemark" style="width:100%;" ></td>
							</tr>
							<tr>
								<td colspan="2">#예상치 못한 유해사례 건수*: Unexpected AEs</td>
								<td colspan="4"><input type="text" id="txtCOL_C" style="width:100px;" > 건</td>
							</tr>
						</tbody>
					</table>


					<div style="height:2px;"></div>



					<div style="padding:0 0 0 0px;">
						<spring:message code="ctmz0402.title.NumberOfDiscovered" />
					</div>

					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>1. 근거문서 대조 및 증례기록서 검토 Source Document Verification and Case Report Form Review</h6>
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
								<td>동의서가 적절하게 작성되었습니까? Were all subjects consented correctly?</td>
								<td><input type="radio" id="a11" name="a1" value="Y"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1" value="N"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1" value="X"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td colspan="4">이번에 검토한 CRF Reviewed CRF on this visit : <input type="text" id="txtCOL_A" style="width:62%;" ></td>
							</tr>
							<tr name="trA">
								<td>3</td>
								<td colspan="4">
									<div style="display:inline-block; position:relative; top:-3px;"> 
										이번에 기록 완료된 CRF completed CRF on this visit :
									</div>
									<input type="radio" id="a21" name="a2" value="N"><label for="a21" class="raLab"><span><spring:message code="ctmz0402.title.None" /></span></label>
									<input type="radio" id="a22" name="a2" value="Y"><label for="a22" class="raLab"><span><spring:message code="ctmz0402.title.HasExist" /></span></label>
								</td>
							</tr>
							<tr name="trA">
								<td>4</td>
								<td>CRF는 근거문서에 따라 정확히, 빠짐없이, 제때에 작성되고 있습니까? Are CRFs completed accurate, exhaustive, timely in accordance with the source date/documentation?</td>
								<td><input type="radio" id="a31" name="a3" value="Y"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3" value="N"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3" value="X"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>5</td>
								<td>Paper CRF의 경우, CRF 수정시 적절한 수정방법을 사용하였습니까? Were CRF corrected rightly?</td>
								<td><input type="radio" id="a41" name="a4" value="Y"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4" value="N"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4" value="X"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>6</td>
								<td>이전 모니터링 시 지적한 문제가 해결되었습니까? Were outstanding data clarification forms/queries resolved?</td>
								<td><input type="radio" id="a51" name="a5" value="Y"><label for="a51" class="raLab"></label></td>
								<td><input type="radio" id="a52" name="a5" value="N"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5" value="X"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>7</td>
								<td>지난 방문 이후 연구계획서 위반사항(병력, 병용약물 등)이 있습니까? Have there been any protocol deviations since last visit?</td>
								<td><input type="radio" id="a61" name="a6" value="Y"><label for="a61" class="raLab"></label></td>
								<td><input type="radio" id="a62" name="a6" value="N"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6" value="X"><label for="a63" class="raLab"></label></td>
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
									<textarea id="txtItemG" rows="2" style="width: 100%;" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>2. 연구계획서 및 관련 규정의 준수 Compliance with Protocol & GCP and Applicable Regulatory Requirements</h6>
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
								<td>연구자가 연구계획서 및 관련 규정을 잘 준수하고 있습니까? Are site personnel aware of, and comply with, protocol, GCP and the applicable regulatory requirements?</td>
								<td><input type="radio" id="b11" name="b1" value="Y"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1" value="N"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1" value="X"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>2</td>
								<td>연구계획서 변경이 필요합니까? Is amendment of the protocol necessary? </td>
								<td><input type="radio" id="b21" name="b2" value="Y"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2" value="N"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2" value="X"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>3</td>
								<td>변경된 연구계획서의 내용은 IRB승인 후에 적용되고 있습니까? Were the changes implemented after approval of the regulatory authorities and/or the IRB/IBC?</td>
								<td><input type="radio" id="b31" name="b3" value="Y"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3" value="N"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3" value="X"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>4</td>
								<td>중간보고 및 지속심의 절차가 필요한지 확인하였습니까? Did you check whether the interim report and/or re-approval procedure is necessary or not?</td>
								<td><input type="radio" id="b41" name="b4" value="Y"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4" value="N"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4" value="X"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>5</td>
								<td>연구 계획서 위반사항이 있다면 위반 사항이 보고되었습니까? If any violation of protocol are reported violation?</td>
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
									<textarea id="txtItemH" rows="2" style="width: 100%;" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					


					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>3. 유해사례 Adverse Events</h6>
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
								<td>지난 방문 이후 발생한 유해사례 및/또는 중대한 유해사례가 있습니까? Have new AEs and/or SAEs since the last visit been reported?</td>
								<td><input type="radio" id="c11" name="c1" value="Y"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1" value="N"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1" value="X"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>2</td>
								<td>지난 방문 시 검토한 유해사례 및/또는 중대한 유해사례에 대한 새로운 정보가 있습니까? Has new information on previous AEs and/or SAEs been properly reviewed, reported, and documented?</td>
								<td><input type="radio" id="c21" name="c2" value="Y"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2" value="N"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2" value="X"><label for="c23" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>3</td>
								<td>지난 방문 이후 시험자가 알게 된 모든 중대한 유해사례는 관련규정, 계획서, SOP에 따라 모니터 및 IRB(경우에 따라 한국의약품안전관리원 까지)에 적절하게 보고되었습니까? Have all SAEs been reported to monitor &amp; IRB and/or regulatory authorities in compliance with the protocol and SOP?</td>
								<td><input type="radio" id="c31" name="c3" value="Y"><label for="c31" class="raLab"></label></td>
								<td><input type="radio" id="c32" name="c3" value="N"><label for="c32" class="raLab"></label></td>
								<td><input type="radio" id="c33" name="c3" value="X"><label for="c33" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>4</td>
								<td>유해사례로 인한 중단의 경우 유해사례 내용이 빠진 내용 없이 잘 기재 되어 있습니까? Discontinued due to adverse events for the better without the adverse information is disclosed are you missing information?</td>
								<td><input type="radio" id="c41" name="c4" value="Y"><label for="c41" class="raLab"></label></td>
								<td><input type="radio" id="c42" name="c4" value="N"><label for="c42" class="raLab"></label></td>
								<td><input type="radio" id="c43" name="c4" value="X"><label for="c43" class="raLab"></label></td>
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
									<textarea id="txtItemI" rows="2" style="width: 100%;" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>4. 연구자 기본문서 파일 Investigator Study File</h6>
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
								<td>
									기본문서를 적절히 보관하고 있습니까? Are investigator site files appropriately maintained?
									<ul>
										<li>- 연구계획서, 증례기록서, 동의서, IRB 심의통보서 , AE 관련 문서 , 계약서</li>
										<li>- protocol, CRFs, ICFs, Contract, IRB Notification, AE -related documents, contracts</li>
									</ul>
								</td>
								<td><input type="radio" id="d11" name="d1" value="Y"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1" value="N"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1" value="X"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>2</td>
								<td>기본문서파일은 최신의 내용을 반영하고 있습니까? Is the investigator site file updated?</td>
								<td><input type="radio" id="d21" name="d2" value="Y"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2" value="N"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2" value="X"><label for="d23" class="raLab"></label></td>
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
									<textarea id="txtItemJ" rows="2" style="width: 100%;" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>5. 모니터링 결과, 문제점, 조치/해결 내용 기술 Explain Monitoring Result, Issue, Management/Solution</h6>
                    </article>
					<div style="height:5px;"></div>



					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtItemK" rows="5" style="width: 100%;" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					
					<div style="height:20px;"></div>
					
					
                    <article class="conTitBox">
                        <h6>6. 권고사항 Recommendations</h6>
                    </article>
                    
					<div style="height:5px;"></div>
					
					<input type="radio" id="e11" name="raCOL_D" value="Y"><label for="e11" class="raLab"><span>모니터의 의견에 동의합니다. I agree with the recommendations of the monitor.</span></label>
					<br>                                        
					<input type="radio" id="e12" name="raCOL_D" value="N"><label for="e12" class="raLab"><span>모니터의 의견에 동의하지 않습니다. I do not agree with the recommendations of the monitor.</span></label>
					
					


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
									<textarea id="txtReason" rows="5" style="width: 100%;" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>7. <spring:message code="ctms.title.Approval"/></h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval" value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					
					
					<div style="height:10px;"></div>
					
					
					<div id="grid_wrap_04" class="gridHeiSz03 grid_wrap tb01_2"></div>



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