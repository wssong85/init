<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<style>
.tb001_01 td{height:auto; padding:4px 20px;}
</style>


<script type="text/javascript">
var g_taskSn = "${loginMap.TASK_SN}";
var g_taskNo = "${loginMap.TASK_NO}";
var g_userId = "${loginMap.USER_ID}";
var g_taskSe = "${loginMap.TASK_TY_CODE}";
var g_maileSn = "${result.MILESTONE_SN}";
var g_insttNM = "${result.NAME1}";
var g_modifyCnt = "01"; //01이면 INSERT 02는 UPDATE
var g_rsrchId;
var g_instt_code = "${result.INSTT_CODE}";
var reportSn; 
var approvalSn; //결재순번저장
var validatorCnt;


var grid_wrap_01 = {
  id: '',
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
	    softRemovePolicy   : "exceptNew",
	    reverseRowNum : true,
  },
  columnLayout : [{
    dataField : "NAME",
    headerText : "<spring:message code="ctmz0201.gr.NAME" />",
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
				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
			}
		}
  },{
    dataField : "ROLE_NM",
    headerText : "<spring:message code="ctmz0201.gr.ROLE_NM" />",
    width : 200,
    editRenderer : {
		type: "InputEditRenderer", 			
		validator : function(oldValue, newValue, rowItem){
			var isValid = false; 	
			
			validator(newValue);
			
			if(validatorCnt <= 100){ 
				isValid = true;
			} 			
		    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
			return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
		}
	}
  },{
    dataField : "PSITN",
    headerText : "<spring:message code="ctmz0201.gr.PSITN" />",
    editRenderer : {
		type: "InputEditRenderer", 			
		validator : function(oldValue, newValue, rowItem){
			var isValid = false; 	
			
			validator(newValue);
			
			if(validatorCnt <= 500){ 
				isValid = true;
			} 			
		    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
			return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
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
  binding: function() { 
	  
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
	    softRemovePolicy   : "exceptNew",
	    reverseRowNum : true,
  },
  columnLayout : [{
    dataField : "NAME",
    headerText : "<spring:message code="ctmz0201.gr.NAME" />",
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
			return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
		}
	}
  },{
    dataField : "ROLE_NM",
    headerText : "<spring:message code="ctmz0201.gr.ROLE_NM" />",
    width : 200,
    editRenderer : {
		type: "InputEditRenderer", 			
		validator : function(oldValue, newValue, rowItem){
			var isValid = false; 	
			
			validator(newValue);
			
			if(validatorCnt <= 100){ 
				isValid = true;
			} 			
		    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
			return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
		}
	}
  },{
    dataField : "PSITN",
    headerText : "<spring:message code="ctmz0201.gr.PSITN" />",
    editRenderer : {
		type: "InputEditRenderer", 			
		validator : function(oldValue, newValue, rowItem){
			var isValid = false; 	
			
			validator(newValue);
			
			if(validatorCnt <= 500){ 
				isValid = true;
			} 			
		    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
			return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
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




//console.log("approvalSn:::"+approvalSn);
var grid_wrap_03 = {
  id: 'grid_wrap_03',

  div: {
    gridDiv: '#grid_wrap_03'
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
	  
  },
};





$(document).ready(function() {	
	/////////시 Hour
	var standardTimeHour;
	var hour = "";
	for(var i=1; i<=24; i++){		
		
		if(i<10){
			hour = "0"+(Math.floor(i));
		}else{
			hour = (Math.floor(i));
		}
		standardTimeHour += "<option value='"+hour+"'>"+hour+"</option>";
	}
	$("#stHH").append(standardTimeHour);
	///////////////////////////////
	
	/////////분 Minute
	var standardTimeMinute;
	var minute = "";
	for(var i=0; i<=59; i++){		
		
		if(i<10){
			minute = "0"+(Math.floor(i));
		}else{
			minute = (Math.floor(i));
		}
		standardTimeMinute += "<option value='"+minute+"'>"+minute+"</option>";
	}
	$("#stMM").append(standardTimeMinute);
	///////////////////////////////
  
  
  mkSetDatePickerYYMMDD("#day_01");  
  fn_setParam();
  fn_mainSelect();
  if(!g_maileSn){
	  //console.log("mailStoneSn Null!!!!!");	  
  }else{
	  //console.log("mailStoneSn Not Null!!!!!");	  
	  	  
  }
  grid_wrap_01.createGrid();
  grid_wrap_02.createGrid();
  grid_wrap_03.createGrid();
  //console.log("g_maileSn::::"+g_maileSn);
  
  
  $("#txtInputRsrchTitle").val(g_taskNo);
  
  //기관 검색버튼 클릭
  $("#btnSearchInstt").click(function(){
	    p_instt_name = "";	
		p_instt_type = "Y";
		p_taskSn = g_taskSn;
		var param = {};	
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
		
  });
  
  //Grid1 row Add 
  $("#btnAdd1").click(function(){
	  var row = {
				 'NM' : ''				
				,'ROLE_NM' : ''
				,'PSITN': '' 
				,'CRUD' : 'C'
				,'ITEM_SE' : '01' //외부참석자
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
					,'PSITN': '' 
					,'CRUD' : 'C' 
					,'ITEM_SE' : '02' //내부참석자
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
  
  //저장버튼 클릭
  $("#btnSave").click(function(){
	  if(!$("#day_01").val()){
		   alert("실시일을 입력해 주세요.");
		   return;
	   }
	  //console.log("g_modifyCnt:::"+g_modifyCnt);
	  if(confirm('<spring:message code="ctmz0201.msg.Save" />') == true){
			//확인 진행
		}else{
			return;
		}
	  
	  var arJson = [];
		
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
			addedRowItems1[i].REPORT_TYPE = 'P';			
			arJson.push(addedRowItems1[i]);			
		}
		
		for(var i = 0; i < editedItems1.length; i++) {
			editedItems1[i].CRUD = 'U';			
			editedItems1[i].DATA_SE = 'B';
			editedItems1[i].REPORT_TYPE = 'P';
			editedItems1[i].LAST_UPDUSR = g_userId;
			arJson.push(editedItems1[i]);
		}
		
		for(var i = 0; i < removeItems1.length; i++) {
			removeItems1[i].CRUD = 'D';
			removeItems1[i].DATA_SE = 'B';	
			removeItems1[i].REPORT_TYPE = 'P';
			removeItems1[i].LAST_UPDUSR = g_userId;			
			arJson.push(removeItems1[i]);
		}
		
		// 내부참석자 그리드
		for(var i = 0; i < addedRowItems2.length; i++) {
			addedRowItems2[i].CRUD = 'C';
			addedRowItems2[i].REPORT_SN = reportSn;
			addedRowItems2[i].TASK_SN = g_taskSn;		
			addedRowItems2[i].MILESTONE_SN = g_maileSn;
			addedRowItems2[i].REPORT_TYPE = 'P';			
			arJson.push(addedRowItems2[i]);			
		}
		
		for(var i = 0; i < editedItems2.length; i++) {
			editedItems2[i].CRUD = 'U';
			editedItems2[i].DATA_SE = 'B';
			editedItems2[i].REPORT_TYPE = 'P';
			editedItems2[i].LAST_UPDUSR = g_userId
			arJson.push(editedItems2[i]);
		}
		
		for(var i = 0; i < removeItems2.length; i++) {
			removeItems2[i].CRUD = 'D';
			removeItems2[i].ITEM_SE = 'B';
			removeItems2[i].REPORT_TYPE = 'P';
			removeItems2[i].LAST_UPDUSR = g_userId;
			arJson.push(removeItems2[i]);
		}
		
		var crud;
		var g_url;
		if(g_modifyCnt == "02"){//01이면 INSERT 02는 UPDATE
			crud = "U";
			g_url = "./updatePlanVisitReport.do";
		}else{
			crud = "C";
			g_url = "./insertPlanVisitReport.do";
		}
		//console.log("crud::::::::"+crud);
		var oprtnDay = $("#day_01").val();
		var split_ = oprtnDay.split("-");
		var oprtnTime = split_[0]+split_[1]+split_[2]+$("#stHH").val()+$("#stMM").val()+"00";
		//console.log(oprtnTime);
		//console.log(g_url);
		//console.log(reportSn);
		//console.log("g_rsrchId:::::::::"+g_rsrchId);
		var visitReportInfo =
		          {'TASK_SN' : g_taskSn,
				   'MILESTONE_SN' : g_maileSn,
				   'RSRCHMAN_ID' : g_rsrchId,
				   'INSTT_CODE' : g_instt_code,			   
				   'OPRTN_DE' : oprtnTime,		   
				   'PLACE' : $("#txtInputPlace").val(), 				   
				   'CHARGER_ID' : g_userId,				   
				   'REMARK_A' : $("#txtInputRemark").val(),
				   'JOB_SE' : g_taskSe,
				   'LAST_UPDUSR' : g_userId,
				   'REPORT_SE' : 'A01',
				   'DATA_SE' : 'A',
				   'REPORT_SN' : reportSn,
				   'CRUD' : crud,
				   'REPORT_TYPE' : 'P'
				  };


		arJson.push(visitReportInfo);
		//console.log(arJson);
		$.ajax({
			  url : g_url ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {				
				  
				  if(data.success) {
					  fn_mainSelect();
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
  
  //
  $("#btnVisitReport").click(function(){
	  var params = { 'MILESTONE_SN' : g_maileSn,
			         'TASK_SN' : g_taskSn, 
			         'OPRTN_DE': $("#day_01").val(),			    	  	
	  				 'NAME1' :   $("#txtInputSiteNm").val(),
	  				 'USER_NM' : $("#txtInputRsrchUser").val(),
	  				 'USER_ID' : g_rsrchId,
	  				 'TASK_NO' : $("#txtInputRsrchTitle").val(),
	  				 'INSTT_CODE' : g_instt_code};
	  
	  
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
		f.setAttribute("action", "/ctms/z02/CTMZ0202.do");
		document.body.appendChild(f);
		f.submit();
	 // $(location).attr("href","/ctms/z02/CTMZ0202.do");
  });
  
  //결재요청 버튼 클릭
  $("#btnApproval").click(function() {
		mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
			'REQUST_NM': '개시방문 준비기록',
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
				MRD_NAME : "CTMZ0201_NSS-301-FORM 03-IMLS-Ver.02.mrd",
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
  
  $("#btnTEST").click(function(){
	  
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
			'REPORT_TYPE' : 'P'
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
					  fn_Email(emailInfo);
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

function fn_Email(param){
	
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

function fn_mainSelect(){
	var params = {'MILESTONE_SN' : g_maileSn, 
				  'TASK_SN' : g_taskSn, 
				  'REPORT_TYPE' : 'P',
				  'INSTT_CODE' : g_instt_code};	
	
    $.ajax({
    	type		: "POST",
		url			: "./selectVisitInfoMain.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	    success:function(data){
	    	if(data.success) {	    	
	    		//console.log("selectMain");
	    		//console.log(data.result);
	    		console.log("g_maileSn::::::::"+g_maileSn);
	    		if(data.result){
	    			g_modifyCnt = "02"; //수정
	    			var oprtnTime = data.result.OPRTN_DE;
		    		
	    			$("#txtInputPlace").val(data.result.PLACE); //장소
		    	  	$("#day_01").val(oprtnTime.substring(0,10)); //날짜
		    	  	$("#stHH").val(oprtnTime.substring(11,13)); //시간 시
		    	  	$("#stMM").val(oprtnTime.substring(14,16)); //시간 분
		    	  	$("#txtInputRemark").val(data.result.REMARK_A);	//비고 Remark_A
		    	  	$("#txtInputSiteNm").val(data.result.NAME1); //기관명
		    	  	$("#txtInputRsrchUser").val(data.result.USER_NM); //책임연구자
		    	  	approvalSn = data.result.SETLE_NO; //결재번호
		    	  	$("#appv").val(data.result.SETLE_NO); //결재번호	    	  	
		    	  	reportSn = data.result.REPORT_SN; 
		    	  	g_rsrchId = data.result.RSRCHMAN_ID;
		    	  	g_instt_code = data.result.INSTT_CODE;
		    	  	console.log("g_instt_code2222::::"+g_instt_code);
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
	    	  	//console.log(params3);
	    		grid_wrap_01.proxy.param = params1;	    	  	    	  	
	    	  	grid_wrap_02.proxy.param = params2;	    		
	    	  	grid_wrap_03.proxy.param = params3;
	    	  	
	    	  	grid_wrap_01.load();
	    	  	grid_wrap_02.load();
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

function fn_setParam(){
	var g_result_code = "${result.INSTT_CODE}";
	var g_result_name = g_insttNM;
	var g_result_usernm = "${result.USER_NM}";
	var g_result_userId = "${result.USER_ID}";
	var g_startdate = "${result.EXECUT_BEGIN}";
	var g_sn = "${result.SN}";
	
	g_rsrchId = g_result_userId;
	//console.log("g_result_userId::::::::"+g_result_userId);
	
	$("#txtInputSiteCode").val(g_result_code);
	$("#txtInputSiteNm").val(g_result_name);
	$("#txtInputRsrchUser").val(g_result_usernm);
	$("#txtInputRsrchId").val(g_result_userId);
	$("#day_01").val(g_startdate);	
	$("#mileStoneSn").val(g_sn);	
	
}

function fn_setInstt(){
	var item; 	
	item = {INSTT_CODE : returnValue.KUNNR
		  , INSTT_NAME : returnValue.INSTT_NAME
		  , USER_ID : returnValue.USER_ID
		  , USER_NM : returnValue.USER_NM
			  
				}; 	
	$("#txtInputSiteCode").val(returnValue.KUNNR);
	$("#txtInputSiteNm").val(returnValue.INSTT_NAME);
	$("#txtInputRsrchUser").val(returnValue.USER_NM);
	
	//AUIGrid.updateRow(todoGrid.id, item, "selectedIndex");
	
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

window.onresize = function() {
	if (grid_wrap_01.id) {
		AUIGrid.resize(grid_wrap_01.id);
	}
	if (grid_wrap_02.id) {
		AUIGrid.resize(grid_wrap_02.id);
	}
	if (grid_wrap_03.id) {
		AUIGrid.resize(grid_wrap_03.id);
	}
};
</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0201&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0201&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
							<li id="btnPreparations" class="port_back tab_menu"><spring:message code="ctmz0201.title.btnPreparations" /></li>
							<li id="btnVisitReport" class="tab_menu"><spring:message code="ctmz0201.title.btnVisitReport" /></li>
						</ul>
					</div>
					

					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="ctmz0201.title.rsrchTitle"/></th>
								<td>
									<input type="hidden" id="appv">
									<input type="hidden" id="mileStoneSn">
									<input type="text" id="txtInputRsrchTitle" style="width:100%;" disabled>									
								</td>
							</tr>
							<tr>
								<th><spring:message code="ctmz0201.title.siteName"/></th>
								<td>
									<input type="hidden" id="txtInputSiteCode">
									<input type="text" id="txtInputSiteNm" style="width:100%;" disabled>
									
								</td>
							</tr>
							<tr>
								<th><spring:message code="ctmz0201.title.PrincipalInvestigator"/></th> 
								<td>
									<input type="hidden" id=txtInputRsrchId">
									<input type="text" id="txtInputRsrchUser" style="width:100%;" disabled>									
								</td>
							</tr>
							<tr>
								<th><spring:message code="ctmz0201.title.dateTime"/></th> 
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />										
									</div>										
										&nbsp;&nbsp;&nbsp;&nbsp;Time
										<select id="stHH">											
										</select>
										&nbsp;&nbsp;:&nbsp;&nbsp;
										<select id="stMM">											
										</select>
								</td>
							</tr>
							<tr>
								<th><spring:message code="ctmz0201.title.Place"/></th>
								<td>
									<input type="text" id="txtInputPlace" style="width:100%; maxlength="66">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6><spring:message code="ctmz0201.title.Attendants"/></h6> 
                    </article>
                    

                    <article class="conTitBtnR">
                        <input type="button" id="btnAdd1" value="<spring:message code="ctmz0201.btn.Add" />" >
                        <input type="button" id="btnDel1" value="<spring:message code="ctmz0201.btn.Del" />" >
                    </article>
					<div style="height:10px;"></div>
					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6><spring:message code="ctmz0201.title.In-houseAttendants"/></h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnAdd2" value="<spring:message code="ctmz0201.btn.Add" />" >
                        <input type="button" id="btnDel2" value="<spring:message code="ctmz0201.btn.Del" />" >
                    </article>
					<div style="height:10px;"></div>
					<div id="grid_wrap_02" class="gridHeiSz03 grid_wrap tb01_2"></div>
					
					
					<div style="height:20px;"></div>



					<table class="tb001 tb001_01">
						<colgroup>
							<col width="50%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th colspan="2"><spring:message code="ctmz0201.title.Role"/></th>
							</tr>
							<tr>
								<td><spring:message code="ctmz0201.title.A"/></td>
								<td><spring:message code="ctmz0201.title.B"/></td>
							</tr>
							<tr>
								<td><spring:message code="ctmz0201.title.C"/></td>
								<td><spring:message code="ctmz0201.title.D"/></td>
							</tr>
							<tr>
								<td><spring:message code="ctmz0201.title.E"/></td>
								<td><spring:message code="ctmz0201.title.F"/></td>
							</tr>
							<tr>
								<td><spring:message code="ctmz0201.title.G"/></td>
								<td><spring:message code="ctmz0201.title.H"/></td>
							</tr>
							<tr>
								<td><spring:message code="ctmz0201.title.I"/></td>
								<td><spring:message code="ctmz0201.title.J"/></td>
							</tr>
							<tr>
								<td><spring:message code="ctmz0201.title.K"/></td>
								<td></td>
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
								<th><spring:message code="ctmz0201.title.Remark"/></th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtInputRemark" rows="3" style="width: 100%;" maxlength="1333"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6><spring:message code="ctmz0201.title.Approval"/></h6>
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