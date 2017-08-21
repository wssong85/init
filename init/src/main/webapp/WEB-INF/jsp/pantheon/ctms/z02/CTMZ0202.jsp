<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>
<script>
var g_taskSn = "${loginMap.TASK_SN}";
var g_taskNo = "${loginMap.TASK_NO}";
var g_userId = "${loginMap.USER_ID}";
var g_taskSe = "${loginMap.TASK_TY_CODE}";
var g_maileSn = "${result.MILESTONE_SN}";
var g_oprtn = "${result.OPRTN_DE}";
var g_name1 = "${result.NAME1}";
var g_user_nm = "${result.USER_NM}";
var g_rsrch_id = "${result.USER_ID}";
var g_insttCode = "${result.INSTT_CODE}";
var g_modifyCnt = "01" //01이면 INSERT 02면 UPDATE
var reportSn;
var approvalSn;

var dayFormat = /^(19[7-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/; //2016-06-29
//console.log("g_insttCode:::::"+g_insttCode);
var grid_wrap_01 = {
  id: 'grid_wrap_01',

  div: {
    gridDiv: '#grid_wrap_01'
  },
  proxy: {
    url: './selectVisitInfoGrid.do',
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
    selectionMode : "multipleCells",
    softRemoveRowMode  : true,
    softRemovePolicy   : "exceptNew"
  },
  columnLayout : [{
	    dataField : "NAME",
	    headerText : '<spring:message code="ctmz0202.gr.NAME"/>',
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
	    headerText : '<spring:message code="ctmz0202.gr.ROLE_NM"/>',
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
		 dataField : "VISIT_SN",
		 headerText : "VISIT_SN",	
		 visible : false
	  },{
	    dataField : "ITEM_SE",
	    headerText : "ITEM_SE",
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
  id: 'grid_wrap_02',

  div: {
    gridDiv: '#grid_wrap_02'
  },
  proxy: {
    url: './selectVisitInfoGrid.do',
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
    selectionMode : "multipleCells",
    softRemoveRowMode  : true,
    softRemovePolicy   : "exceptNew"
  },
  columnLayout : [{
	    dataField : "NAME",
	    headerText : '<spring:message code="ctmz0202.gr.Company_NAME"/>',
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
	    headerText : '<spring:message code="ctmz0202.gr.Company_ROLE_NM"/>',
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
		 dataField : "VISIT_SN",
		 headerText : "VISIT_SN",
		 visible : false
	  },{
	    dataField : "ITEM_SE",
	    headerText : "ITEM_SE",
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



var grid_wrap_03 = {
  id: 'grid_wrap_03',

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
      editable : false,
      enableFilter : true,
      headerHeight: 40,
      rowHeight: 37,
      selectionMode : "multipleCells"
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
  grid_wrap_01.createGrid();
  grid_wrap_02.createGrid();
  grid_wrap_03.createGrid();
  mkSetDatePickerYYMMDD("#day_01");
  mkSetDatePickerYYMMDD("#day_02");
  f_mainSelect();
  
  $("#btnPreparations").click(function(){
	  var params = { 'MILESTONE_SN' : g_maileSn,
			  		 'INSTT_CODE' : g_insttCode,
			  		 'TASK_SN' : g_taskSn, 
			         'OPRTN_DE': $("#day_01").val(),			    	  	
	  				 'NAME1' :   $("#txtInputSiteName").val(),
	  				 'USER_NM' : $("#txtInputInvestigator").val(),
	  				 'USER_ID' : g_rsrch_id, 
	  				 'TASK_NO' : g_taskNo
		         };

	var f = document.createElement("form");
	
	var objs ;
	var value ;
	
	for(var key in params){
		value = params[key];		
		objs = document.createElement("input");
		objs.setAttribute("type", "hidden");
		objs.setAttribute("id", key);
		objs.setAttribute("name", key);
		objs.setAttribute("value", value);
		f.appendChild(objs);
	}
	
	f.setAttribute("method", "post");
	f.setAttribute("action", "/ctms/z02/CTMZ0201.do");
	document.body.appendChild(f);
	f.submit();
	 // $(location).attr("href","/ctms/z02/CTMZ0201.do");
  });
  
  //Grid1 row Add 
  $("#btnAdd1").click(function(){
	  var row = {
				 'NM' : ''
				,'VISIT_SN' : ''
				,'ROLE_NM' : ''				
				,'CRUD' : 'C'
				,'ITEM_SE' : '01' //외부참석자
				,'LAST_UPDUSR' : g_userId
				,'DATA_SE' : 'B'
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
			  		,'VISIT_SN' : ''
					,'ROLE_NM' : ''					
					,'CRUD' : 'C' 
					,'ITEM_SE' : '02' //내부참석자
					,'LAST_UPDUSR' : g_userId
					,'DATA_SE' : 'B'
		};		
		AUIGrid.addRow(grid_wrap_02.id, row, 'first'); // 최상단에 행 추가
  });

  //Grid2 row Delete
  $("#btnDel2").click(function(){
	  AUIGrid.removeRow(grid_wrap_02.id, "selectedIndex");
  });
  
  $("#btnTest").click(function(){
	  var items = AUIGrid.getGridData(grid_wrap_03.id);
	  var exItems = [{"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
	                 {"EMAIL" : "gupanzer@daum.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
	                 {"EMAIL" : "sendiablo2@naver.com" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/}];
	  //console.log(items[0].EMAIL);
	  //console.log(items[0].SANCTNER_NM);	
	  var emailInfo = {};
	  for(var i=0; i<items.length; i++){
		  //emailInfo = {"EMAIL" : items[i].EMAIL /*sendEmail*/, "USER_NM" : items[i].SANCTNER_NM/*userName*/}; 실제 메일발송
		  emailInfo = {"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/, "MILESTONE_SN" : g_maileSn};
		  f_Email(emailInfo);
	  }

  });
  
  //저장버튼 클릭
  $("#btnSave").click(function(){	
	   //////실시일 널값체크
	   if(!$("#day_01").val()){
		   alert("<spring:message code='ctmz0202.message.day01'/>");
		   $("#day_01").focus();
		   return;
	   }
	   //////실시일 형식체크
	   if(!dayFormat.test($("#day_01").val())){
			  alert("<spring:message code='ctmz0201.message.day01_va'/>")
			  $("#day_01").focus();
			  return;
		  }
	   //////비고 remark - txtInputRemark
	   validator($("#txtInputRemark").val());
	   if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0201.message.Remark'/>");		 
			  $("#txtInputRemark").focus();
			  return;
		  } 
	   
	   if(confirm('<spring:message code="ctmz0201.msg.Save" />') == true){
			//확인 진행
	   }else{
			return;
	   }
	   
	   var arJson = [];
	  
	   var crud;	  
	  
	   if(g_modifyCnt == "02"){//01이면 INSERT 02는 UPDATE
		  crud = "U";		 
	   }else{
		  crud = "C";	 	 
	   }
	  
	   ///////////////////////////CTMS_ST_REPORT_MAIN////////////////////////////
	   var visitReportItem = {
			  
	   };
	   var oprtnDe = $("#day_01").val();
	   var oprtnDay = oprtnDe.split("-");
	   var day01 = oprtnDay[0]+oprtnDay[1]+oprtnDay[2]+"000000";
	   //console.log("day01::::::::"+day01);
	   var visitReportInfo = {'TASK_SN' : g_taskSn,
						      'MILESTONE_SN' : g_maileSn,
						      'RSRCHMAN_ID' : g_rsrch_id,
						      'INSTT_CODE' : $("#txtInputSiteCode").val(),			   
						      'OPRTN_DE' : day01,
						      'CHARGER_ID' : g_userId,				   
						      'REMARK_A' : $("#txtInputRemark").val(),
						      'JOB_SE' : g_taskSe,
						      'LAST_UPDUSR' : g_userId,
						      'REPORT_SE' : 'A02',
						      'DATA_SE' : 'A',
						      'REPORT_SN' : reportSn,
						      'CRUD' : crud,
						      'REPORT_TYPE' : 'V'
						      
						      };
	   
	    arJson.push(visitReportInfo);
		///////////////////////////CTMS_ST_REPORT_VISIT////////////////////////////
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
			addedRowItems1[i].TASK_SN = g_taskSn;		
			addedRowItems1[i].MILESTONE_SN = g_maileSn;
			addedRowItems1[i].REPORT_SN = reportSn;
			addedRowItems1[i].REPORT_TYPE = 'V';	
			addedRowItems1[i].DATA_SE = 'B';
			arJson.push(addedRowItems1[i]);			
		}
		
		for(var i = 0; i < editedItems1.length; i++) {
			editedItems1[i].CRUD = 'U';			
			editedItems1[i].DATA_SE = 'B';
			editedItems1[i].REPORT_TYPE = 'V';
			editedItems1[i].REPORT_SN = reportSn;
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
			addedRowItems2[i].TASK_SN = g_taskSn;		
			addedRowItems2[i].MILESTONE_SN = g_maileSn;
			addedRowItems2[i].REPORT_TYPE = 'V';
			addedRowItems2[i].DATA_SE = 'B';
			addedRowItems2[i].REPORT_SN = reportSn;
			arJson.push(addedRowItems2[i]);			
		}
		
		for(var i = 0; i < editedItems2.length; i++) {
			editedItems2[i].CRUD = 'U';
			editedItems2[i].DATA_SE = 'B';
			editedItems2[i].REPORT_TYPE = 'V';
			editedItems2[i].REPORT_SN = reportSn;
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
		
		
		/////////////////////////CTMS_ST_REPORT_ITEM//////////////////////////
		
	    var day02Data = $('#day_02').val();
	    var day02Split = day02Data.split('-');
	    var day02Value = day02Split[0]+day02Split[1]+day02Split[2]+"000000";
	  
		var totalRows = $("tbody[id]").length;
		  //console.log("totalRows:::::"+totalRows);
		  var params = [  $("tbody[id]").find('tr[name=trA]').length,
						  $("tbody[id]").find('tr[name=trB]').length, 
						  $("tbody[id]").find('tr[name=trC]').length, 
						  $("tbody[id]").find('tr[name=trD]').length, 
						  $("tbody[id]").find('tr[name=trE]').length, 
						  $("tbody[id]").find('tr[name=trF]').length, 
						  $("tbody[id]").find('tr[name=trG]').length, 
						  $("tbody[id]").find('tr[name=trH]').length, 
						  $("tbody[id]").find('tr[name=trI]').length, 
						  $("tbody[id]").find('tr[name=trJ]').length];
		 
		  var addItems = {};
		  var num = 97; //아스키코드 소문자 a
		  var item;
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
						  'DTE' : day02Value,
						  'CRUD' : crud,
						  'DATA_SE' : 'C',
						  'LAST_UPDUSR' : g_userId
				  }
				  if(!$(':input:radio[name="'+a_value+i+'"]:checked').val()){
					  alert("<spring:message code='ctms.message.radioCheck'/>");
					  return; 
				  }
				  //console.log("checkedValue::::"+a_value+i+"::::::"+$('input:radio[name="'+a_value+i+'"]:checked').val());
				  arJson.push(addItems[i]);	
			  }
		  }
		  
		//console.log(arJson);
		$.ajax({
			  url : './insertVisitReport.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {				
				  
				  if(data.success) {
					  f_mainSelect();
					  g_modifyCnt = '02';
					  
				  } else {					  
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
				  //alert(jqXHR);
			  }
		});
  });
  
//결재요청 버튼 클릭
  $("#btnApproval").click(function() {
		mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
			'REQUST_NM': "<spring:message code='ctmz0202.title.report'/>",//ctmz0202.title.report
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
				MRD_NAME : "CTMZ0202_NSS-301-FORM 04-SIVR-Ver.02.mrd",
				MILESTONE_SN : g_maileSn,
				TASK_SN : g_taskSn,
				
				
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
	//console.log('RequstNo : ' + v);
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
				                 {"EMAIL" : "kimbokmin@daum.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
				                 {"EMAIL" : "kimbokmin@naver.com" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/}];
				 
				  var emailInfo = {};
				  for(var i=0; i<items.length; i++){
					  //emailInfo = {"EMAIL" : items[i].EMAIL /*sendEmail*/, "USER_NM" : items[i].SANCTNER_NM/*userName*/}; 실제 메일발송
// 					  emailInfo = {"EMAIL" : exItems[i].EMAIL /*sendEmail*/, "USER_NM" : exItems[i].SANCTNER_NM/*userName*/};
// 					  f_Email(emailInfo);
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

function f_mainSelect(){
	$("#txtInputTitle").val(g_taskNo);
	$("#txtInputSiteName").val(g_name1);
	$("#txtInputInvestigator").val(g_user_nm);	
	$("#txtInputSiteCode").val(g_insttCode);
		
	var params = {'MILESTONE_SN' : g_maileSn, 
			  	  'TASK_SN' : g_taskSn, 
			  	  'REPORT_TYPE' : 'V',
			  	  'INSTT_CODE' : g_insttCode};	
	
	$.ajax({
		type		: "POST",
		url			: "./selectVisitInfoMain.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	  success:function(data){
	  	if(data.success) {
	  		if(data.result){
	  			var oprtnDe = data.result.OPRTN_DE;
	  			var day01 = oprtnDe.substring(0,10);
	  			g_modifyCnt = "02";
	  			$("#txtInputTitle").val(data.result.TASK_NO);
		  		$("#txtInputSiteName").val(data.result.NAME1);
		  		$("#txtInputInvestigator").val(data.result.USER_NM);
		  		$("#day_01").val(day01);
		  		$("#txtInputRemark").val(data.result.REMARK_A);
		  		$("#txtInputRsrchUserId").val(data.result.RSRCHMAN_ID);
		  		g_rsrch_id = data.result.RSRCHMAN_ID;
		  		reportSn = data.result.REPORT_SN;
		  		approvalSn = data.result.SETLE_NO;
		  		//console.log("reportSn::::"+reportSn);
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
	  		
	  		var params1 = {
    	  			'MILESTONE_SN' : g_maileSn, 'TASK_SN' : g_taskSn, 'ITEM_SE' : '01', 'REPORT_SN' : reportSn
    			};    		
    	  	var params2 = {
    	  			'MILESTONE_SN' : g_maileSn, 'TASK_SN' : g_taskSn, 'ITEM_SE' : '02', 'REPORT_SN' : reportSn
    			};
    	  	var params3 = {
    	  			'REQUEST_NO' : approvalSn
    	  			
    			};
    	  	grid_wrap_01.proxy.param = params1;
    	  	grid_wrap_01.load();
    	  	grid_wrap_02.proxy.param = params2;
    	  	grid_wrap_02.load();
    	  	grid_wrap_03.proxy.param = params3;
    	  	grid_wrap_03.load();
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

//////////////////CTMS_ST_REPORT_ITEM 조회////////////////////////////
function selectItem(param){
	console.log("param::::::::::"+param);
	$.ajax({
		type		: "post",
		url			: "./selectVisitInfoItem.do",
		data : {'REPORT_SN' : param},
		dataType : "json",
	  success:function(data){
	  	if(data.success) {
	  		//console.log(data.result);
	  		$("#txtInputSubjectCo").val(data.result[0].SUBJECT_CO);	  		
	  		$("#day_02").val(data.result[0].DTE);
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
	console.log(stringByteLength + " Bytes"); 
	
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
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0202&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0202&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
							<li id="btnPreparations" class="tab_menu"><spring:message code="ctmz0201.title.btnPreparations" /></li>
							<li id="btnVisitReport" class="port_back tab_menu"><spring:message code="ctmz0201.title.btnVisitReport" /></li>
						</ul>
					</div>

					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>연구제목 Title</th>
								<td>
									<input type="text" id="txtInputTitle" style="width:100%;" disabled>									
								</td>
							</tr>
							<tr>
								<th>연구기관 Site Name</th>
								<td>
									<input type="hidden" id="txtInputSiteCode">
									<input type="text" id="txtInputSiteName" style="width:100%;" disabled>									
								</td>
							</tr>
							<tr>
								<th>책임연구자 Principal Investigator</th>
								<td>
									<input type="hidden" id="txtInputRsrchUserId">
									<input type="text" id="txtInputInvestigator" style="width:100%;" disabled>									
								</td>
							</tr>
						</tbody>
					</table>
					
					
					<div style="height:20px;"></div>

                    <article class="conTitBox">
                        <h6>
							실시일 Date : 
							<div class="dateBox">
								<input type="text" id="day_01" style="width: 120px;" />
							</div>
						</h6>
                    </article>

					<div style="height:10px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h6>참가자 Attendees</h6>
                    </article>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAdd1" class="add_01" title="행추가">
						<input type="button" id="btnDel1" class="del_01" title="행삭제">
					</div>
					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>	


					<div style="height:20px;"></div>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAdd2" class="add_01" title="행추가">
						<input type="button" id="btnDel2" class="del_01" title="행삭제">
					</div>
					<div id="grid_wrap_02" class="gridHeiSz03 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 연구계획서 Protocol</h6>
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
								<td>연구의 목적/디자인 Trial purpose/design</td>
								<td><input type="radio" id="a11" name="a1" value = "Y"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1" value = "N"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1" value = "X"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>2</td>
								<td>선정/제외기준 Inclusion and exclusion criteria</td>
								<td><input type="radio" id="a21" name="a2" value = "Y"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2" value = "N"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2" value = "X"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>3</td>
								<td>탈락/연구종료기준 Drop-out and study completion criteria</td>
								<td><input type="radio" id="a31" name="a3" value = "Y"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3" value = "N"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3" value = "X"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>4</td>
								<td>연구의 절차, 요구사항 및 계획엄수 Study procedure, requirements and adherence</td>
								<td><input type="radio" id="a41" name="a4" value = "Y"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4" value = "N"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4" value = "X"><label for="a43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>2. 연구대상자 모집 Recruitment of Trial Subjects</h6>
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
								<td>본 기관의 모집 목표 연구 대상자 수 Planned Subjects No. : <input type="text" id="txtInputSubjectCo" style="width:100px;"> 명</td>
								<td><input type="radio" id="b11" name="b1" value="Y"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1" value="N"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1" value="X"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>2</td>
								
								<td>연구시작일 Start Date of Study : <div class="dateBox"><input type="text" id="day_02" style="width: 120px;" /></div>
								<td><input type="radio" id="b21" name="b2" value = "Y"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2" value = "N"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2" value = "X"><label for="b23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 연구자 Investigator</h6>
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
								<td>연구자의 변경사항 Change of investigator</td>
								<td><input type="radio" id="c11" name="c1" value = "Y"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1" value = "N"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1" value = "X"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>2</td>
								<td>역할 할당 및 문서화  Delegation and documentation of duties</td>
								<td><input type="radio" id="c21" name="c2" value = "Y"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2" value = "N"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2" value = "X"><label for="c23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>4. 연구대상자 동의 절차 Informed Consent Process</h6>
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
								<td>연구자의 변경사항 Change of investigator</td>
								<td><input type="radio" id="d11" name="d1" value = "Y"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1" value = "N"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1" value = "X"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>2</td>
								<td>서명된 동의서 혹은 개인정보활용동의서 보관  Documentation and retention of all signed informed consent</td>
								<td><input type="radio" id="d21" name="d2" value = "Y"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2" value = "N"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2" value = "X"><label for="d23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>5. 증례기록서 및 데이터의 수집 Case Report Form and Data Collection</h6>
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
						<tbody id="tbE">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trE">
								<td>1</td>
								<td>증례기록서 작성을 위한 세부지침 CRF completion guidelines</td>
								<td><input type="radio" id="e11" name="e1" value = "Y"><label for="e11" class="raLab"></label></td>
								<td><input type="radio" id="e12" name="e1" value = "N"><label for="e12" class="raLab"></label></td>
								<td><input type="radio" id="e13" name="e1" value = "X"><label for="e13" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>2</td>
								<td>수정에 관한 절차 Procedures for corrections</td>
								<td><input type="radio" id="e21" name="e2" value = "Y"><label for="e21" class="raLab"></label></td>
								<td><input type="radio" id="e22" name="e2" value = "N"><label for="e22" class="raLab"></label></td>
								<td><input type="radio" id="e23" name="e2" value = "X"><label for="e23" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>3</td>
								<td>증례기록서/데이터의 서명에 관한 사항 CRF/Data signature requirements</td>
								<td><input type="radio" id="e31" name="e3" value = "Y"><label for="e31" class="raLab"></label></td>
								<td><input type="radio" id="e32" name="e3" value = "N"><label for="e32" class="raLab"></label></td>
								<td><input type="radio" id="e33" name="e3" value = "X"><label for="e33" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>4</td>
								<td>증례기록서/데이터의 작성기한 CRF/Data completion timelines</td>
								<td><input type="radio" id="e41" name="e4" value = "Y"><label for="e41" class="raLab"></label></td>
								<td><input type="radio" id="e42" name="e4" value = "N"><label for="e42" class="raLab"></label></td>
								<td><input type="radio" id="e43" name="e4" value = "X"><label for="e43" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>5</td>
								<td>데이터 쿼리 해결 절차 Process of query resolution</td>
								<td><input type="radio" id="e51" name="e5" value = "Y"><label for="e51" class="raLab"></label></td>
								<td><input type="radio" id="e52" name="e5" value = "N"><label for="e52" class="raLab"></label></td>
								<td><input type="radio" id="e53" name="e5" value = "X"><label for="e53" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>6</td>
								<td>전자자료 및 기록에 대한 규정의 준수 Regulatory requirements for electronic data and records</td>
								<td><input type="radio" id="e61" name="e6" value = "Y"><label for="e61" class="raLab"></label></td>
								<td><input type="radio" id="e62" name="e6" value = "N"><label for="e62" class="raLab"></label></td>
								<td><input type="radio" id="e63" name="e6" value = "X"><label for="e63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>6. 안전성 정보 Safety Information</h6>
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
						<tbody id="tbF">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trF">
								<td>1</td>
								<td>유해사례 및 중대한 유해사례의 정의 Definition of AE and SAE</td>
								<td><input type="radio" id="f11" name="f1" value = "Y"><label for="f11" class="raLab"></label></td>
								<td><input type="radio" id="f12" name="f1" value = "N"><label for="f12" class="raLab"></label></td>
								<td><input type="radio" id="f13" name="f1" value = "X"><label for="f13" class="raLab"></label></td>
							</tr>                                          
							<tr name="trF">
								<td>2</td>
								<td>유해사례 및 중대한 유해사례의 보고에 관한 사항 AE and SAE reporting requirements</td>
								<td><input type="radio" id="f21" name="f2" value = "Y"><label for="f21" class="raLab"></label></td>
								<td><input type="radio" id="f22" name="f2" value = "N"><label for="f22" class="raLab"></label></td>
								<td><input type="radio" id="f23" name="f2" value = "X"><label for="f23" class="raLab"></label></td>
							</tr>
							<tr name="trF">
								<td>3</td>
								<td>중대한 유해사례 발생 시 연락처 Contact information of sponsor</td>
								<td><input type="radio" id="f31" name="f3" value = "Y"><label for="f31" class="raLab"></label></td>
								<td><input type="radio" id="f32" name="f3" value = "N"><label for="f32" class="raLab"></label></td>
								<td><input type="radio" id="f33" name="f3" value = "X"><label for="f33" class="raLab"></label></td>
							</tr>
							<tr name="trF">
								<td>4</td>
								<td>유해사례 및 중대한 유해사례의 추적관찰에 관한 사항 AE and SAE follow-up</td>
								<td><input type="radio" id="f41" name="f4" value = "Y"><label for="f41" class="raLab"></label></td>
								<td><input type="radio" id="f42" name="f4" value = "N"><label for="f42" class="raLab"></label></td>
								<td><input type="radio" id="f43" name="f4" value = "X"><label for="f43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>7. 의학적 처치 및 검사/실험적 검사 등 Medical/Laboratory/Technical Procedures/Tests</h6>
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
						<tbody id="tbG">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trG">
								<td>1</td>
								<td>추가로 실시한 실험실적 검사 및 기타 의학적 검사의 검토에 대한 연구자의 책임 Investigator’s responsibilities for review and follow-up of laboratory reports and other medical data</td>
								<td><input type="radio" id="g11" name="g1" value = "Y"><label for="g11" class="raLab"></label></td>
								<td><input type="radio" id="g12" name="g1" value = "N"><label for="g12" class="raLab"></label></td>
								<td><input type="radio" id="g13" name="g1" value = "X"><label for="g13" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>8. 추가적인 연구자의 의무 Additional Investigator Obligations</h6>
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
						<tbody id="tbH">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trH">
								<td>1</td>
								<td>임상시험심사의원회와의 의사소통 Communication with IRB</td>
								<td><input type="radio" id="h11" name="h1" value = "Y"><label for="h11" class="raLab"></label></td>
								<td><input type="radio" id="h12" name="h1" value = "N"><label for="h12" class="raLab"></label></td>
								<td><input type="radio" id="h13" name="h1" value = "X"><label for="h13" class="raLab"></label></td>
							</tr>
							<tr name="trH">
								<td>2</td>
								<td>점검 및 규제기관의 실태조사 Sponsor audits and regulatory authority inspections</td>
								<td><input type="radio" id="h21" name="h2" value = "Y"><label for="h21" class="raLab"></label></td>
								<td><input type="radio" id="h22" name="h2" value = "N"><label for="h22" class="raLab"></label></td>
								<td><input type="radio" id="h23" name="h2" value = "X"><label for="h23" class="raLab"></label></td>
							</tr>
							<tr name="trH">
								<td>3</td>
								<td>연구결과 출판에 관한 정책 Publication policy</td>
								<td><input type="radio" id="h31" name="h3" value = "Y"><label for="h31" class="raLab"></label></td>
								<td><input type="radio" id="h32" name="h3" value = "N"><label for="h32" class="raLab"></label></td>
								<td><input type="radio" id="h33" name="h3" value = "X"><label for="h33" class="raLab"></label></td>
							</tr>
							<tr name="trH">
								<td>4</td>
								<td>연구비 결산에 관한 절차 Finalcial disclosure procedures</td>
								<td><input type="radio" id="h41" name="h4" value = "Y"><label for="h41" class="raLab"></label></td>
								<td><input type="radio" id="h42" name="h4" value = "N"><label for="h42" class="raLab"></label></td>
								<td><input type="radio" id="h43" name="h4" value = "X"><label for="h43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>9. 필수문서 Required Documents</h6>
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
						<tbody id="tbI">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trI">
								<td>1</td>
								<td>연구 관련 문서(근거문서 포함)의 보관 및 유지 Retention and archiving of trial documents (including source data and source documents</td>
								<td><input type="radio" id="i11" name="i1" value = "Y"><label for="i11" class="raLab"></label></td>
								<td><input type="radio" id="i12" name="i1" value = "N"><label for="i12" class="raLab"></label></td>
								<td><input type="radio" id="i13" name="i1" value = "X"><label for="i13" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>10. 연구관련 물품의 인수 인계 현황 Receipt of Study Materials</h6>
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
						<tbody id="tbJ">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trJ">
								<td>1</td>
								<td>연구 계획서 Protocol</td>
								<td><input type="radio" id="j11" name="j1" value = "Y"><label for="j11" class="raLab"></label></td>
								<td><input type="radio" id="j12" name="j1" value = "N"><label for="j12" class="raLab"></label></td>
								<td><input type="radio" id="j13" name="j1" value = "X"><label for="j13" class="raLab"></label></td>
							</tr>
							<tr name="trJ">
								<td>2</td>
								<td>증례기록서 Case report forms</td>
								<td><input type="radio" id="j21" name="j2" value = "Y"><label for="j21" class="raLab"></label></td>
								<td><input type="radio" id="j22" name="j2" value = "N"><label for="j22" class="raLab"></label></td>
								<td><input type="radio" id="j23" name="j2" value = "X"><label for="j23" class="raLab"></label></td>
							</tr>
							<tr name="trJ">
								<td>3</td>
								<td>동의서 혹은 개인정보활용동의서 Informed consent forms</td>
								<td><input type="radio" id="j31" name="j3" value = "Y"><label for="j31" class="raLab"></label></td>
								<td><input type="radio" id="j32" name="j3" value = "N"><label for="j32" class="raLab"></label></td>
								<td><input type="radio" id="j33" name="j3" value = "X"><label for="j33" class="raLab"></label></td>
							</tr>
							<tr name="trJ">
								<td>4</td>
								<td>기타 물품 Other supplements</td>
								<td><input type="radio" id="j41" name="j4" value = "Y"><label for="j41" class="raLab"></label></td>
								<td><input type="radio" id="j42" name="j4" value = "N"><label for="j42" class="raLab"></label></td>
								<td><input type="radio" id="j43" name="j4" value = "X"><label for="j43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>






					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>비고 Remark</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtInputRemark" rows="3" style="width: 100%;" maxlength="1333"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>11. <spring:message code="ctms.title.Approval"/></h6>
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