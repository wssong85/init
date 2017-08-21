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

var testData_01 =[
{
  "이름 Name":"홍길동",
  "제목 Title":"제목입니다."
}, {
  "이름 Name":"홍길동",
  "제목 Title":"제목입니다."
}, {
  "이름 Name":"홍길동",
  "제목 Title":"제목입니다."
}];

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
	  
	  //////////의견 Comment validator
	  validator($("#txtComment_A").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz0701.message.OtherComment'/>");		 
		  $("#txtComment_A").focus();
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
			  ,'REPORT_SE' : 'H00'	                                        //리포트 구분       
			  ,'JOB_SE' : g_taskSe		                                    //과제타입          
			  ,'INSTT_CODE'	: g_InsttCode                                   //기관코드          
			  ,'RSRCHMAN_ID' : g_rsrchId                                    //책임연구자    
			  ,'REMARK_A' : $("#txtComment_A").val()		                //의견 Comment
			  ,'ITEM_A'	: $("#txtTotalSubjectsSite").val()	                //본 기관의 모집예상 피험자 수 
			  ,'ITEM_B'	: $("#txtRecruitmentWm").val()	                    //주 단위 또는 월 단위로 기대되는 피험자 수     
			  ,'ITEM_C'	:$('input[type=radio][name=f1]:checked').val()	    //후속조치
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
					  $("tbody[id]").find('tr[name=trE]').length, 
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
				MRD_NAME : "CTMZ0701_CSS-400-FORM 05-PTVR-ver02.mrd",
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
					
				  }
				  emailInfo = {"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/};
				  f_Email(emailInfo);
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
		    		//alert("ok");	    	
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
			,'REPORT_SE' : 'H00'
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
	  			 			  
				  $("#txtComment_A").val(data.result.REMARK_A) //의견 Comment
				  $("#txtTotalSubjectsSite").val(data.result.ITEM_A) //본 기관의 모집예상 피험자 수 
				  $("#txtRecruitmentWm").val(data.result.ITEM_B) //주 단위 또는 월 단위로 기대되는 피험자 수
				  $("input:radio[name=f1]:radio[value='"+data.result.ITEM_C+"']").attr("checked", true); //후속조치
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
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0702&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0702&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
						<h5>시험전 방문보고서</h5>
					</article>

					<div style="height:10px;"></div>


					<table class="tb001 tb001_01">
						<colgroup>
							<col width="250px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>시험제목 Title</th>
								<td>
									<input type="text" id="txtTitle" style="width:100%;"  disabled>
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



					<div style="height:10px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h7>방문시 접촉한 연구진 Study Personnel Present During Visit</h7>
                    </article>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAdd1" class="add_01" title="행추가">
						<input type="button" id="btnDel1" class="del_01" title="행삭제">
					</div>
					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>	


					<div style="height:20px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h7>방문자 및 방문일 Visit &amp; Visit Date</h7>
                    </article>


					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAdd2" class="add_01" title="행추가">
						<input type="button" id="btnDel2" class="del_01" title="행삭제">
					</div>
					<div id="grid_wrap_02" class="gridHeiSz03 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>



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
								<th colspan="2">A. 시험계획서 관련 사항 Protocol and Pertaining Issues</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trA">
								<td>1</td>
								<td>
									시험책임자에게 임상시험(목적, 계획서, 절차 등)에 대한 설명을 하고 논의하였습니까? Were the trial objectives, protocol, and required procedures (if applicable) explained to and discussed with the principal investigator?
									<br>
									시험계획서 버전 Specify the protocol version:
								</td>
								<td><input type="radio" id="a11" name="a1" value="Y"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1" value="N"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1" value="X"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>2</td>
								<td>시험자에게 임상시험용의약품에 대한 정보가 제공되었습니까?<br>Were the descriptions of investigational products explained?</td>
								<td><input type="radio" id="a21" name="a2" value="Y"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2" value="N"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2" value="X"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>3</td>
								<td>피험자 동의 과정에 대해 검토하였습니까?<br>Was the informed consent procedure reviewed?</td>
								<td><input type="radio" id="a31" name="a3" value="Y"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3" value="N"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3" value="X"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>4</td>
								<td>
									시험책임자는 시험기간 내에 적절한 수의 피험자를 모집할 수 있습니까? 
									Does the principal investigator have access to adequate number of subjects within the timeline?
									<br>
									본 기관의 모집예상 피험자 수 Total number of eligible subjects at the site <input type="text" id="txtTotalSubjectsSite" style="width:100px;"> 명
									
									<div style=" margin:6px 0;">주 단위 또는 월 단위로 기대되는 피험자 수 Recruitment expected per weekly/monthly <input type="text" id="txtRecruitmentWm" style="width:100px;"> 명</div>
								</td>
								<td><input type="radio" id="a41" name="a4" value="Y"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4" value="N"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4" value="X"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>5</td>
								<td>피험자 등록에 영향을 줄 수 있는 타 임상시험이 있습니까? 있다면 기술하시오.<br>Any studies or trials that may impact accrual. If yes, please describe :</td>
								<td><input type="radio" id="a51" name="a5" value="Y"><label for="a51" class="raLab"></label></td>
								<td><input type="radio" id="a52" name="a5" value="N"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5" value="X"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>6</td>
								<td>예산에 대해 시험책임자와 논의하고 동의하였습니까?<br>Was the trial budget discussed and agreed by the PI?</td>
								<td><input type="radio" id="a61" name="a6" value="Y"><label for="a61" class="raLab"></label></td>
								<td><input type="radio" id="a62" name="a6" value="N"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6" value="X"><label for="a63" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>7</td>
								<td>시험자의 책임(중대한 이상반응 보고, 임상시험심사위원회의 승인, 임상시험관리기준 요구사항, 모니터링 조정/점검/ 실태조사에 대한 협조)에 대해 논의하였습니까?<br>Were responsibilities of investigators reviewed including reporting SAEs, obtaining the approval from the IRB/IEC for the protocol, other GCP requirements and coordinating monitoring, audits, and inspections?</td>
								<td><input type="radio" id="a71" name="a7" value="Y"><label for="a71" class="raLab"></label></td>
								<td><input type="radio" id="a72" name="a7" value="N"><label for="a72" class="raLab"></label></td>
								<td><input type="radio" id="a73" name="a7" value="X"><label for="a73" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>8</td>
								<td>(중앙검사실을 사용하는 경우) 생체시료의 운반과정에 대해 논의하였습니까?<br>Was the body fluids/tissue sample shipping procedure discussed (in case of use of the central laboratory)?</td>
								<td><input type="radio" id="a81" name="a8" value="Y"><label for="a81" class="raLab"></label></td>
								<td><input type="radio" id="a82" name="a8" value="N"><label for="a82" class="raLab"></label></td>
								<td><input type="radio" id="a83" name="a8" value="X"><label for="a83" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbB">
							<tr>
								<th colspan="2">B. 시험자의 적합성 Investigator Qualification</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trB">
								<td>1</td>
								<td>
									시험자와 연구진은 임상시험을 진행하기에 적절한 자격(임상시험 참여 경험, GCP 관련 교육 이수 등)을 갖추고 있습니까?
									<br>
									Are investigators and other staffs are qualified to conduct this trial (GCP training and previous clinical trial experience)?
									<br>
									이력서에 임상시험 경험과 GCP교육이력에 대한 정보가 있어야 함.
									<br>
									Ensure that the information on GCP training and previous clinical trial experiences is indicated in CVs.
								</td>
								<td><input type="radio" id="b11" name="b1" value="Y"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1" value="N"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1" value="X"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>2</td>
								<td>
									시험책임자는 임상시험을 시행하기 위한 충분한 시간이 있습니까?
									<br>
									Do the principal investigator has adequate time to conduct this trial?
								</td>
								<td><input type="radio" id="b21" name="b2" value="Y"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2" value="N"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2" value="X"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="2">C. 시설과 실험실 Facilities and Laboratory</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
						</tbody>
						<tbody id="tbC">
							<tr name="trC">
								<td>1</td>
								<td>
									임상시험을 실시하고자 하는 기관의 시설, 장비, 실험실이 적절하게 갖추어져 있습니까? Are site facilities, equipment, and laboratory adequate for this trial?
									임상시험 개시 시까지는 실험실에 대한 인증서가 확보되어야 함.
									<br>
									Laboratory certification/accreditation should be obtained by site initiation
								</td>
								<td><input type="radio" id="c11" name="c1" value="Y"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1" value="N"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1" value="X"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>2</td>
								<td>
									임상시험기간 또는 요구되는 기간 동안 증례기록서와 다른 중요문서를 보관할 안전한 장소가 있습니까? Does the investigator have the adequate, secured space for CRFs and any other essential documents during the trial and for the period requested by the regulatory requirements?
									<br>
									보관 장소 Specify the retention space:
								</td>
								<td><input type="radio" id="c21" name="c2" value="Y"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2" value="N"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2" value="X"><label for="c23" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>3</td>
								<td>
									요구되는 기간 동안 임상시험용의약품 또는 생체시료들을 보관할 안전한 장소가 있습니까? Does the site have adequate, secure storage facilities for investigational products or body fluids/tissue samples for the required period?
									<br>
									보관장소나 시설, 온도점검(필요하다면) 과정에 대한 설명 Specify storage areas/facilities and/or the type of temperature monitoring process (if required) : 
								</td>
								<td><input type="radio" id="c31" name="c3" value="Y"><label for="c31" class="raLab"></label></td>
								<td><input type="radio" id="c32" name="c3" value="N"><label for="c32" class="raLab"></label></td>
								<td><input type="radio" id="c33" name="c3" value="X"><label for="c33" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>4</td>
								<td>
									모니터링을 할 장소가 있습니까? Is there any adequate space for the monitoring?
									<br>
									모니터링 장소 Specify monitoring space:
								</td>
								<td><input type="radio" id="c41" name="c4" value="Y"><label for="c41" class="raLab"></label></td>
								<td><input type="radio" id="c42" name="c4" value="N"><label for="c42" class="raLab"></label></td>
								<td><input type="radio" id="c43" name="c4" value="X"><label for="c43" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>5</td>
								<td>
									모니터링 하는 장소에서 모니터링, 점검, 실태조사자들이 근거자료나 문서에 바로 접근이 가능합니까?
									<br>
									Dies the site agree to direct access to source data/document by the monitors, auditors, and inspectors?
								</td>
								<td><input type="radio" id="c51" name="c5" value="Y"><label for="c51" class="raLab"></label></td>
								<td><input type="radio" id="c52" name="c5" value="N"><label for="c52" class="raLab"></label></td>
								<td><input type="radio" id="c53" name="c5" value="X"><label for="c53" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>6</td>
								<td>
									(임상시험용의약품이나 생체시료들을 냉장 또는 냉동보관 할 경우) 정전 시 비상설비가 있습니까?
									<br>
									Is there any emergency equipment for electricity outage (only in case that investigational products or body fluids/tissue samples were required to be refrigerated or frozen)?
								</td>
								<td><input type="radio" id="c61" name="c6" value="Y"><label for="c61" class="raLab"></label></td>
								<td><input type="radio" id="c62" name="c6" value="N"><label for="c62" class="raLab"></label></td>
								<td><input type="radio" id="c63" name="c6" value="X"><label for="c63" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbD">
							<tr>
								<th colspan="2">D. 임상시험심사위원회 절차  IRB/IEC Procedures</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trD">
								<td>1</td>
								<td>
									임상시험심사위원회의 승인과 통지 절차를 확인하였습니까? Were notification and approval procedures of the IRB/IEC verified?
									<br>
									심사회의 횟수 Specify the regular and expedited meeting frequencies :                                                        
									<br>
									각 기관의 특별한 요구조건 Specify any site specific requirements :
								</td>
								<td><input type="radio" id="d11" name="d1" value="Y"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1" value="N"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1" value="X"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>2</td>
								<td>
									타기관 발생 중대한 이상반응을 포함한 모든 중대한 이상반응은 보고되어야 합니까? Do all SAEs including SAEs occurred in other sites should be reported to the IRB/IEC?
									<br>
									보고범위와 보고기간 Specify the extent of reporting and timeline :
								</td>
								<td><input type="radio" id="d21" name="d2" value="Y"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2" value="N"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2" value="X"><label for="d23" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbE">
							<tr>
								<th colspan="2">E. 임상시험용의약품과 그 외 공급물품 Investigator Product and Other Supplies</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trE">
								<td>1</td>
								<td>
									임상시험용의약품의 입출고, 폐기 과정을 확인하였습니까? Were receipt, return, and destruction procedures of investigational products reviewed?
									<br>
									입출고, 폐기 횟수/간격과 방법 Specify supply/return/destruction frequencies/intervals and method :
								</td>
								<td><input type="radio" id="e11" name="e1" value="Y"><label for="e11" class="raLab"></label></td>
								<td><input type="radio" id="e12" name="e1" value="N"><label for="e12" class="raLab"></label></td>
								<td><input type="radio" id="e13" name="e1" value="X"><label for="e13" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>2</td>
								<td>
									임상시험용의약품의 수불과정을 논의하였습니까? Were the investigational product accountability and dispensing procedures discussed?
									<br>
									과정을 서술하시오. Describe the procedures:
								</td>
								<td><input type="radio" id="e21" name="e2" value="Y"><label for="e21" class="raLab"></label></td>
								<td><input type="radio" id="e22" name="e2" value="N"><label for="e22" class="raLab"></label></td>
								<td><input type="radio" id="e23" name="e2" value="X"><label for="e23" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>3</td>
								<td>
									이 임상시험을 수행하기 위해 본 기관에 제공해야할 물품이 있습니까? Are there any site specific supplied provided to conduct this trial?
									<br>
									목록 Specify:
								</td>
								<td><input type="radio" id="e31" name="e3" value="Y"><label for="e31" class="raLab"></label></td>
								<td><input type="radio" id="e32" name="e3" value="N"><label for="e32" class="raLab"></label></td>
								<td><input type="radio" id="e33" name="e3" value="X"><label for="e33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					

					<div style="height:30px;"></div>


                    <article class="conTitBox">
                        <h7>후속조치가 필요합니까? Were any Issue that require follow-up?</h7>
                    </article>
					
					
					
					<div style="height:5px;"></div>
					
					<input type="radio" id="f11" name="f1" value="Y"><label for="f11" class="raLab"><span>Yes</span></label>
					<br>
					<input type="radio" id="f12" name="f1" value="N"><label for="f12" class="raLab"><span>No 만약 있다면, 의견 란에 작성하시오. If yes, complete the comment.</span></label>


					<div style="height:10px;"></div>


					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>의견 Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtComment_A" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>
					
					





                    <article class="conTitBox">
                        <h7><spring:message code="ctms.title.Approval" /></h7>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval" value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					
					
					<div style="height:10px;"></div>
					
					
					<div id="grid_wrap_03" class="gridHeiSz03 grid_wrap tb01_2"></div>



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