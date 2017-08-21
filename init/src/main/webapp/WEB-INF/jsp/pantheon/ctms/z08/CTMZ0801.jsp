<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<style>
.row_height_01 th{ height:auto; padding:2px 5px 2px 12px;}
</style>


<script>
var g_taskNo = "${loginMap.TASK_NO}";		//과제번호
var g_taskSn = "${loginMap.TASK_SN}";		//과제순번
var g_userId = "${loginMap.USER_ID}";		//로그인한 USER_ID
var g_userNm = "${loginMap.USER_NM}";		//로그인한 USER_ID
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
var dayFormat = /^(19[7-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/; //2016-06-29



var testData_01 =[
{
  "역할 Role":"CRM Prepared by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"TM Reviewed by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}];



var grid_wrap_01 = {
		  id: '',

		  div: {
		    gridDiv: '#grid_wrap_01'
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
	  mkSetDatePickerYYMMDD("#day_01");
	  mainSelect();
	  grid_wrap_01.createGrid();
	 
	  
	  //저장버튼 클릭
	  $("#btnSave").click(function(){
		  //////실시일 널값체크
		  if(!$("#day_01").val()){
			   alert("<spring:message code='ctmz0801.message.Dateofcontract_null'/>");
			   $("#day_01").focus();
			   return;
		   }
		  //////실시일 형식 체크
		  if(!dayFormat.test($("#day_01").val())){
			  alert("<spring:message code='ctmz0801.message.Dateofcontract'/>")
			  $("#day_01").focus();
			  return;
		  }
		  //////////연구자의 역량 Comment  validator
		  validator($("#txtCommentG").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.txtCommentG'/>");		 
			  $("#txtCommentG").focus();
			  return;
		  } 
		  
          //////////공동연구자 및 인력의 적합성 Comment validator
		  validator($("#txtCommentH").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.txtCommentH'/>");		 
			  $("#txtCommentH").focus();
			  return;
		  } 
		  
		  //////////연구대상자 모집 유용성 Comment validator
		  validator($("#txtCommentI").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.txtCommentI'/>");		 
			  $("#txtCommentI").focus();
			  return;
		  } 
		  
		  //////////연구자의 할애 가능한 시간 Comment validator
		  validator($("#txtCommentJ").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.txtCommentJ'/>");		 
			  $("#txtCommentJ").focus();
			  return;
		  } 
		  
		  //////////연구자의 관심도와 충실성 Comment validator
		  validator($("#txtCommentK").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.txtCommentK'/>");		 
			  $("#txtCommentK").focus();
			  return;
		  }
		  
		  //////////문서보존 능력 Commnet validator
		  validator($("#txtCommentL").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.txtCommentL'/>");		 
			  $("#txtCommentL").focus();
			  return;
		  }
		  
		  //////////기타 validator
		  validator($("#txtOther").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.txtOther'/>");		 
			  $("#txtOther").focus();
			  return;
		  }
		  
		  //////////의견  validator
		  validator($("#REMARK_A").val()); 
		  if(validatorCnt > 4000){ 
			  alert("<spring:message code='ctmz0801.message.REMARK_A'/>");		 
			  $("#REMARK_A").focus();
			  return;
		  }
		  
		  if(!$(':input:radio[name=raColA]:checked').val()){
			  alert("<spring:message code='ctmz0801.message.raColA'/>");
			  return;
		  }
		  
		  if(!$(':input:radio[name=a1]:checked').val()){
			  alert("<spring:message code='ctmz0801.message.a1'/>");
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
		  
		  //console.log("CRUD::::::"+crud);
		  var arJson = [];
		  
		  /////////////////////////////////MAIN 저장////////////////////////////////////
		  var oprtnDe = $("#day_01").val();
	      var oprtnDay = oprtnDe.split("-");
	      var day01 = oprtnDay[0]+oprtnDay[1]+oprtnDay[2]+"000000";
		  
		  var visitData = {
				   'REPORT_SN' : reportSn		    							//리포트 순번       
				  ,'MILESTONE_SN' : g_maileSn                                   //마일드스톤 순번   
				  ,'TASK_SN' : g_taskSn	                                        //과제순번          
				  ,'REPORT_TYPE' : 'V'                                          //리포트 타입       
				  ,'REPORT_SE' : 'I00'	                                        //리포트 구분       
				  ,'JOB_SE' : g_taskSe		                                    //과제타입          
				  ,'INSTT_CODE'	: g_InsttCode                                   //기관코드          
				  ,'RSRCHMAN_ID' : g_rsrchId                                    //책임연구자    
				  ,'OPRTN_DE' : day01   							            //조사 실시일
				  ,'ITEM_A' : $('input[type=radio][name=a1]:checked').val() 	//평가방법
				  ,'ITEM_B' : $("#txtCommentG").val()							//연구자의 역량 Comment
				  ,'ITEM_C' : $("#txtCommentH").val()                           //공동연구자 및 인력의 적합성 Comment
				  ,'ITEM_D' : $("#txtCommentI").val()                           //연구대상자 모집 유용성 Comment
				  ,'ITEM_E' : $("#txtCommentJ").val()                           //연구자의 할애 가능한 시간 Comment
				  ,'ITEM_F' : $("#txtCommentK").val()                           //연구자의 관심도와 충실성 Comment
				  ,'ITEM_G' : $("#txtCommentL").val()                           //문서보존 능력 Commnet
				  ,'ITEM_H' : $("#txtOther").val() 								//기타 Other
				  ,'REMARK_A' : $("#txtRemarkA").val()   						//의견
				  ,'COL_A' : $('input[type=radio][name=raColA]:checked').val() 		//추천 
				  ,'COL_B' : $("#txtg").val()
				  ,'COL_C' : $("#txth").val()
				  ,'COL_D' : $("#txti").val()
				  ,'COL_E' : $("#txtj").val()
				  ,'COL_F' : $("#txtk").val()
				  ,'COL_H' : $("#txtl").val()				  
				  ,'LAST_UPDUSR' : g_userId                                     //등록/수정자       
				  ,'CRUD' : crud												
				  ,'DATA_SE' : 'A'												//데이터 구분 A:MAIN,B:GRID,C:RADIO,D:이전 방문회차
				  ,'PURPS' : g_taskNo
				  ,'CHARGER_ID'	: g_userId
				  
		  };
		  arJson.push(visitData);
		  
		  
		  /////////////////////////////////ITEM 저장////////////////////////////////////
		  var totalRows = $("tbody[id]").length;
		  //console.log("totalRows:::::"+totalRows);
		  var params = [  $("tbody[id]").find('tr[name=trB]').length, 
						  $("tbody[id]").find('tr[name=trC]').length, 
						  $("tbody[id]").find('tr[name=trD]').length, 
						  $("tbody[id]").find('tr[name=trE]').length, 
						  $("tbody[id]").find('tr[name=trF]').length,						  					 
						  ];
		 
		  var params2 = [ $("tbody[id]").find('tr[name=trG]').length,
						  $("tbody[id]").find('tr[name=trH]').length,
						  $("tbody[id]").find('tr[name=trI]').length,
						  $("tbody[id]").find('tr[name=trJ]').length,
						  $("tbody[id]").find('tr[name=trK]').length,
						  $("tbody[id]").find('tr[name=trL]').length,
						  $("tbody[id]").find('tr[name=trM]').length,						 
						  ];
		  
		  var addItems = {};		
		  var num = 98; //아스키코드 소문자 b 시작	 
		  var a_value;
		  
		  var addItems2 = {};
		  var num2 = 103; //아스키코드 소문자 g 시작	 
		  var a_value2;
		  
		  for(var j=0; j<params.length; j++){		 	  
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
		  
		  for(var j=0; j<params2.length; j++){		 	  
			  a_value2 = String.fromCharCode(num2);	//아스키코드를 문자형으로..	
			  //console.log("a_value::::"+a_value);
			  num2++;
			  
			  for(var i=1; i<=params2[j]; i++){				 
				  addItems2[i] = {
						  'REPORT_SN' : reportSn,
						  'MILESTONE_SN' : g_maileSn,
						  'TASK_SN' : g_taskSn,						  
						  'REPORT_TYPE' : 'V',
						  'ITEM_SE' : a_value2+i,						 
						  'ITEM_VALUE' : $('input:checkbox[name="'+a_value2+i+'"]:checked').val(),						   
						  'CHARGER_ID' : g_userId,
						  'RM' : '',					  
						  'CRUD' : crud,
						  'DATA_SE' : 'C',
						  'LAST_UPDUSR' : g_userId
				  }
// 				  if(!$(':input:radio[name="'+a_value+i+'"]:checked').val()){
// 					  alert("선택되지 않은 항목이 있습니다.");
// 					  return;
// 				  }
				  //console.log("checkedValue::::"+a_value+i+"::::::"+$('input:radio[name="'+a_value+i+'"]:checked').val());
				  arJson.push(addItems2[i]);	
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
			'REQUST_NM': '시험책임자 적합성 점검표',
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
					MRD_NAME : "CTMZ0801_CSS-400-FORM 02-PIQC-ver03.mrd",
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
	grid_wrap_01.proxy.param = params;
	grid_wrap_01.load();
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
		    	  grid_wrap_01.proxy.param = params;
				  grid_wrap_01.load();
				  ///////////////////////////결재요청시 이메일 발송/////////////////////////
				  var items = AUIGrid.getGridData(grid_wrap_01.id);
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


function mainSelect(){
	
	$("#txtTitle").val(g_taskNo);		  		   //연구제목
	$("#txtClinicalTrialSite").val(g_InsttName);   //연구기관	
	$("#txtPotential").val(g_rsrchNm);			   //책임연구자	
	$("#txtVisit").val(g_userNm);				   //방문자
		
	$("#btnPrint").attr("disabled", true);        
	$("#btnApproval").attr("disabled", true);
	$("#btnApprovalInfo").attr("disabled", true);
	
	var params = {
			 'MILESTONE_SN' : g_maileSn
			,'TASK_SN' : g_taskSn
			,'REPORT_SE' : 'I00'
			,'INSTT_CODE' : g_InsttCode
	};
	
	console.log(params);
	
	$.ajax({
		type		: "POST",
		url			: "./selectTrialVisitReport.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	  success:function(data){
	  	if(data.success) {	  		
	  		if(data.result){
	  			console.log("Not New");
	  			$("#txtTitle").val(data.result.PURPS);	         //연구제목
	  			$("#txtClinicalTrialSite").val(data.result.NAME1);   //연구기관	
	  			$("#txtPotential").val(data.result.USER_NM);	     //책임연구자	
	  			$("#txtVisit").val(g_userNm);				   		 //방문자
	  			$("#day_01").val(data.result.OPRTN_DE);				 //조사 실시일	  			 
				$('input:radio[name=a1]:input[value="'+data.result.ITEM_A+'"]').attr("checked", true);  //평가방법
			    $("#txtCommentG").val(data.result.ITEM_B);			 //연구자의 역량 Comment
				$("#txtCommentH").val(data.result.ITEM_C);            //공동연구자 및 인력의 적합성 Comment
				$("#txtCommentI").val(data.result.ITEM_D);            //연구대상자 모집 유용성 Comment
				$("#txtCommentJ").val(data.result.ITEM_E);            //연구자의 할애 가능한 시간 Comment
				$("#txtCommentK").val(data.result.ITEM_F);            //연구자의 관심도와 충실성 Comment
				$("#txtCommentL").val(data.result.ITEM_G);            //문서보존 능력 Commnet
				$("#txtOther").val(data.result.ITEM_H); 				 //기타 Other
				$("#txtg").val(data.result.COL_B);
				$("#txth").val(data.result.COL_C);
				$("#txti").val(data.result.COL_D);
				$("#txtj").val(data.result.COL_E);
				$("#txtk").val(data.result.COL_F);
				$("#txtl").val(data.result.COL_H);
				$("#txtRemarkA").val(data.result.REMARK_A);   		 //의견
				$('input:radio[name=raColA]:input[value="'+data.result.COL_A+'"]').attr("checked", true);  ///추천
	  			reportSn = data.result.REPORT_SN;	  			     //리포트 순번 
	  			approvalSn = data.result.SETLE_NO; //결재순번
	  			selectItem(reportSn); //ITEM 조회
					  			
	  			$("#btnPrint").attr("disabled", false);        
   			    $("#btnApproval").attr("disabled", false);
   			    if(data.result.SETLE_NO){ //결재요청번호가 있을때 결재정보 활성화
   			  	    $("#btnApprovalInfo").attr("disabled", false);
   			    }
    			
 				var visitData1 = {'REQUEST_NO' : approvalSn};				
				
 				grid_wrap_01.proxy.param = visitData1;
 				grid_wrap_01.load();

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
    			if(itemData[i].ITEM_SE < String.fromCharCode(103)){
    				$('input:radio[name="'+itemData[i].ITEM_SE+'"]:input[value="'+itemData[i].ITEM_VALUE+'"]').attr('checked',true);
    			}else if(itemData[i].ITEM_SE >= String.fromCharCode(103)){
    				$('input:checkbox[name="'+itemData[i].ITEM_SE+'"]:input[value="'+itemData[i].ITEM_VALUE+'"]').attr('checked',true);	
    				
    			}
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

//////체크박스 중복체크 방지/////
function checkSelect(id,name){
	
	var obj = document.getElementsByName(name);
	
	for(var i=0; i<obj.length; i++){
		if(obj[i] != id){
			obj[i].checked = false;
		}
	}
	
	var value = name.substring(0,1);
	
	checkValue(value);
}


///////체크박스 점수 체크///////
function checkValue(value){
	var params  = [];
	var num = 0; //체크 Y 하나에 1
	var checkNum = 0;
	for(var i=1; i<=3; i++){
		 params[i] = $('input:checkbox[name="'+value+i+'"]:checked').val();		
		// console.log("params::"+params[i]);
		 if(params[i] == "Y"){
			 num++;
		 }
		 if( $('input:checked[name="'+value+i+'"]').is(':checked') == true){
			 checkNum++;
		 }
	}
	var txtId = "#txt"+value;
	if(checkNum == 0){
		$(txtId).val("N/A"); //체크가 없으면 N/A
	}else{
		$(txtId).val(num);
	}
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
});


</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0802&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0802&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
						<h5><spring:message code="ctmz0801.title.CTMZ0801Title" /></h5>
					</article>

					<div style="height:10px;"></div>


					<div style="padding:0 0 0 0px;">
						본 서식은 임상시험의 임상시험책임자를 선정하기 위한 조사내용을 문서화하기 위한 것이다.
						<br>
						임상시험책임자 및 주요 연구진에 대해 아래 점검표의 항목에 따라 면밀히 조사하여 기록한다.
						The purpose of this form is to document a Qualification Visit in advance of selecting a potential principal investigator for a clinical study.  The clinical research manager will go over all the topics on the following checklist with the principal investigator and other key study personnel.
					</div>



					<div style="height:20px;"></div>


					<table class="tb001 tb001_01">
						<colgroup>
							<col width="250px" />
							<col width="" />
							<col width="160px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>시험제목 Title</th>
								<td colspan="3">
									<input type="text" id="txtTitle" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="txtClinicalTrialSite" style="width:100%;" disabled>
								</td>
								<th>조사실시일 Date of contract</th>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>시험책임자 후보 Potential PI</th>
								<td>
									<input type="text" id="txtPotential" style="width:100%;" disabled>
								</td>
								<th>방문자 Visit</th>
								<td>
									<input type="text" id="txtVisit" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>평가방법 Method of Evaluation</th>
								<td colspan="3">
									<div><input type="radio" id="a11" name="a1" value="01"><label for="a11" class="raLab"><span>전화방문 Telephone Contact</span></label></div>
									<div><input type="radio" id="a12" name="a1" value="02"><label for="a12" class="raLab"><span>기관방문 Site Visit</span></label></div>
									<div><input type="radio" id="a13" name="a1" value="03"><label for="a13" class="raLab"><span>메일 Mail Contact</span></label></div>
									
								</td>
							</tr>
						</tbody>
					</table>
					<div style="height:20px;"></div>

					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbB">
							<tr>
								<th>A. 기관에 제공된 정보 확인 Confirm information provided to the site</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trB">
								<td>1. 시험자가 비밀유지계약서에 서명함. Confidentiality Agreement has been signed by the investigato</td>
								<td><input type="radio" id="b11" name="b1" value="Y"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1" value="N"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1" value="X"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>2. 시험자가 시험계획(안)을 검토함. Protocol(draft) has been reviewed by the investigator</td>
								<td><input type="radio" id="b21" name="b2" value="Y"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2" value="N"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2" value="X"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>3. 시험자가 본 임상시험의 목적을 이해함. Relevant scientific background is understood by investigator</td>
								<td><input type="radio" id="b31" name="b3" value="Y"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3" value="N"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3" value="X"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>4. 임상시험 시작, 피험자 모집속도 및 완료시점에 대한 임상시험 일정을 인지하고 있음. Study timeline, including initiation, subject accrual rate and completion</td>
								<td><input type="radio" id="b41" name="b4" value="Y"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4" value="N"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4" value="X"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr>
					 	</tbody>
					 	<tbody id="tbC">
								<th colspan="4">B. 시험자 Investigator</th>
							</tr>
							<tr name="trC">
								<td>1. 본 임상시험용의약품 또는 유사 제품에 대한 임상시험 참여 경험이 있음. The investigator has any previous studies with this investigational product or a similar product?</td>
								<td><input type="radio" id="c11" name="c1" value="Y"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1" value="N"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1" value="X"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>2. 시험자는 임상시험에 할애할 충분한 시간이 있고 경험이 있음. The investigator has sufficient time, training and experience to conduct the study</td>
								<td><input type="radio" id="c21" name="c2" value="Y"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2" value="N"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2" value="X"><label for="c23" class="raLab"></label></td>
							</tr>
							<tr>
						</tbody>
						<tbody id="tbD">
								<th colspan="4">C. 임상시험 운영진 Study Team</th>
							</tr>
							<tr name="trD">
								<td>1. 시험자는 훈련되어 있는 연구진 및 기타 자원을 적절히 확보하고 있음. The investigator has adequate, trained staff and other resources</td>
								<td><input type="radio" id="d11" name="d1" value="Y"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1" value="N"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1" value="X"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>2. 주요 연구진의 연락처가 확보되어 있음. A key study contact has been identified.</td>
								<td><input type="radio" id="d21" name="d2" value="Y"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2" value="N"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2" value="X"><label for="d23" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>3. 주요 연구진과 연구간호사는 인증된 자격이 있음. Key staff includes (a) certified clinical coordinator(s)</td>
								<td><input type="radio" id="d31" name="d3" value="Y"><label for="d31" class="raLab"></label></td>
								<td><input type="radio" id="d32" name="d3" value="N"><label for="d32" class="raLab"></label></td>
								<td><input type="radio" id="d33" name="d3" value="X"><label for="d33" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbE">
							<tr>
								<th colspan="4">D. 설비 Facilities</th>
							</tr>
							<tr name="trE">
								<td>1. 시험을 위한 적절한 설비(공간, 장비)가 있음. Facilities appear adequate for the study (space, equipment)</td>
								<td><input type="radio" id="e11" name="e1" value="Y"><label for="e11" class="raLab"></label></td>
								<td><input type="radio" id="e12" name="e1" value="N"><label for="e12" class="raLab"></label></td>
								<td><input type="radio" id="e13" name="e1" value="X"><label for="e13" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>2. 임상시험관련문서를 보관한 적절한 장소를 확보하고 있음. Storage for subject and study files is adequate and secure</td>
								<td><input type="radio" id="e21" name="e2" value="Y"><label for="e21" class="raLab"></label></td>
								<td><input type="radio" id="e22" name="e2" value="N"><label for="e22" class="raLab"></label></td>
								<td><input type="radio" id="e23" name="e2" value="X"><label for="e23" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>3. 모니터링을 할 장소가 있음. There is any adequate space for the monitoring</td>
								<td><input type="radio" id="e31" name="e3" value="Y"><label for="e31" class="raLab"></label></td>
								<td><input type="radio" id="e32" name="e3" value="N"><label for="e32" class="raLab"></label></td>
								<td><input type="radio" id="e33" name="e3" value="X"><label for="e33" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>4. 시료의 안전한 보관이 가능함. Secure storage of specimens is available</td>
								<td><input type="radio" id="e41" name="e4" value="Y"><label for="e41" class="raLab"></label></td>
								<td><input type="radio" id="e42" name="e4" value="N"><label for="e42" class="raLab"></label></td>
								<td><input type="radio" id="e43" name="e4" value="X"><label for="e43" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbF">
							<tr>
								<th colspan="4">E. 피험자 Subjects</th>
							</tr>
							<tr name="trF">
								<td>1. 선정제외기준에 적합한 피험자 등록이 가능함. Sufficient eligible subjects (patients, samples) are available</td>
								<td><input type="radio" id="f11" name="f1" value="Y"><label for="f11" class="raLab"></label></td>
								<td><input type="radio" id="f12" name="f1" value="N"><label for="f12" class="raLab"></label></td>
								<td><input type="radio" id="f13" name="f1" value="X"><label for="f13" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="4">F. 연구비 Budget</th>
							</tr>
							<tr name="trF">
								<td>1. 임상시험 예산에 대해 논의 및 합의함. Study budget discussed and finalized</td>
								<td><input type="radio" id="f21" name="f2" value="Y"><label for="f21" class="raLab"></label></td>
								<td><input type="radio" id="f22" name="f2" value="N"><label for="f22" class="raLab"></label></td>
								<td><input type="radio" id="f23" name="f2" value="X"><label for="f23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="15%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>의견 Comment</th>
								<td style="padding:10px 20px;">
									<textarea id="txtRemarkA" rows="3" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>
					
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="220px" />
						</colgroup>
						<tbody id="tbG">
							<tr>
								<th colspan="5">평가 Evaluation</th>								
							</tr>
							<tr>
								<td colspan="2">평가요인 Evaluation Factor</td>
								<td colspan="2" style="text-align: center; border-right:none;">범례 : </td>
								<td style="border-left:none;">
									Excellent :  3 점
									<br>
									Normal : 2 점
									<br>
									Poor : 0 ~ 1점
		  						</td>
							</tr>
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 역량  Investigator capabilities</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2">비고 Comment</th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txtg" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trG">
								<td>1</td>
								<td>연구 참여 경험이 많고, GCP 이수 등 연구자로서의 소양을 갖춤</td>
								<td><input type="checkbox" name="g1" id="cg1" value="Y" onclick="checkSelect(this, this.name)"><label for="cg1" class="chcLab"></label></td>
								<td><input type="checkbox" name="g1" id="cg2" value="N" onclick="checkSelect(this, this.name)"><label for="cg2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtCommentG" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trG">
								<td>2</td>
								<td>안전성 정보 수집의 당위성과 필요성을 이해하고 관심갖으며, AE와 SAE의 개념을 이해함</td>
								<td><input type="checkbox" name="g2" id="cg3" value="Y" onclick="checkSelect(this, this.name)"><label for="cg3" class="chcLab"></label></td>
								<td><input type="checkbox" name="g2" id="cg4" value="N" onclick="checkSelect(this, this.name)"><label for="cg4" class="chcLab"></label></td>
							</tr>
							<tr name="trG">
								<td>3</td>
								<td>컴퓨터 사용에 능숙하여 eCRF 작성이 가능함</td>
								<td><input type="checkbox" name="g3" id="cg5" value="Y" onclick="checkSelect(this, this.name)"><label for="cg5" class="chcLab"></label></td>
								<td><input type="checkbox" name="g3" id="cg6" value="N" onclick="checkSelect(this, this.name)"><label for="cg6" class="chcLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tdH">						
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">공동연구자 및 인력의 적합성 Suitability of subinvestigator and other human resources</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>								
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txth" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trH">
								<td>1</td>
								<td>공동연구자 및 연구담당자의 연구 참여 경험이 많고, GCP 이수 등 연구자로서의 소양을 갖춤</td>
								<td><input type="checkbox" name="h1" id="ch1" value="Y" onclick="checkSelect(this, this.name)"><label for="ch1" class="chcLab"></label></td>
								<td><input type="checkbox" name="h1" id="ch2" value="N" onclick="checkSelect(this, this.name)"><label for="ch2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtCommentH" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trH">
								<td>2</td>
								<td>안전성 정보 수집의 당위성과 필요성을 이해하고 관심갖으며, AE와 SAE의 개념을 이해함</td>
								<td><input type="checkbox" name="h2" id="ch3" value="Y" onclick="checkSelect(this, this.name)"><label for="ch3" class="chcLab"></label></td>
								<td><input type="checkbox" name="h2" id="ch4" value="N" onclick="checkSelect(this, this.name)"><label for="ch4" class="chcLab"></label></td>
							</tr>
							<tr name="trH">
								<td>3</td>
								<td>컴퓨터 사용에 능숙하여 eCRF 작성이 가능함</td>
								<td><input type="checkbox" name="h3" id="ch5" value="Y" onclick="checkSelect(this, this.name)"><label for="ch5" class="chcLab"></label></td>
								<td><input type="checkbox" name="h3" id="ch6" value="N" onclick="checkSelect(this, this.name)"><label for="ch6" class="chcLab"></label></td>
							</tr>
						</tbody>
							
						<tbody id="tdI">	
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구대상자 모집 유용성 Subject accrual availability</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txti" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trI">
								<td>1</td>
								<td>충분한 조사대상자 확보가 가능함</td>
								<td><input type="checkbox" name="i1" id="ci1" value="Y" onclick="checkSelect(this, this.name)"><label for="ci1" class="chcLab"></label></td>
								<td><input type="checkbox" name="i1" id="ci2" value="N" onclick="checkSelect(this, this.name)"><label for="ci2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtCommentI" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trI">
								<td>2</td>
								<td>해당 연구에 적합한 진료과에서 연구를 진행함</td>
								<td><input type="checkbox" name="i2" id="ci3" value="Y" onclick="checkSelect(this, this.name)"><label for="ci3" class="chcLab"></label></td>
								<td><input type="checkbox" name="i2" id="ci4" value="N" onclick="checkSelect(this, this.name)"><label for="ci4" class="chcLab"></label></td>
							</tr>
							<tr name="trI">
								<td>3</td>
								<td>유사성분의 연구를 중복해서 진행한 경험이 없음</td>
								<td><input type="checkbox" name="i3" id="ci5" value="Y" onclick="checkSelect(this, this.name)"><label for="ci5" class="chcLab"></label></td>
								<td><input type="checkbox" name="i3" id="ci6" value="N" onclick="checkSelect(this, this.name)"><label for="ci6" class="chcLab"></label></td>
							</tr>
						</tbody>
							
						<tbody id="tbJ">	
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 할애 가능한 시간 Investigator’s available time</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txtj" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trJ">
								<td>1</td>
								<td>하루에 30분 이상 연구에 시간 할애가 가능함</td>
								<td><input type="checkbox" name="j1" id="cj1" value="Y" onclick="checkSelect(this, this.name)"><label for="cj1" class="chcLab"></label></td>
								<td><input type="checkbox" name="j1" id="cj2" value="N" onclick="checkSelect(this, this.name)"><label for="cj2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtCommentJ" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trJ">
								<td>2</td>
								<td>다른 연구를 5개 이상 진행하고 있지 않음</td>
								<td><input type="checkbox" name="j2" id="cj3" value="Y" onclick="checkSelect(this, this.name)"><label for="cj3" class="chcLab"></label></td>
								<td><input type="checkbox" name="j2" id="cj4" value="N" onclick="checkSelect(this, this.name)"><label for="cj4" class="chcLab"></label></td>
							</tr>
							<tr name="trJ">
								<td>3</td>
								<td>전체 연구기간 동안 중단 없이 참여 가능함</td>
								<td><input type="checkbox" name="j3" id="cj5" value="Y" onclick="checkSelect(this, this.name)"><label for="cj5" class="chcLab"></label></td>
								<td><input type="checkbox" name="j3" id="cj6" value="N" onclick="checkSelect(this, this.name)"><label for="cj6" class="chcLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbK">
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 관심도와 충실성 Investigator’s interest and commitment</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txtk" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trK">
								<td>1</td>
								<td>연구 참여에 적극적인 의사를 표함</td>
								<td><input type="checkbox" name="k1" id="ck1" value="Y" onclick="checkSelect(this, this.name)"><label for="ck1" class="chcLab"></label></td>
								<td><input type="checkbox" name="k1" id="ck2" value="N" onclick="checkSelect(this, this.name)"><label for="ck2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtCommentK" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trK">
								<td>2</td>
								<td>연구디자인, 선정/제외기준 등 관련사항 및 연구진행 프로세스에 대해 정확히 인지함</td>
								<td><input type="checkbox" name="k2" id="ck3" value="Y" onclick="checkSelect(this, this.name)"><label for="ck3" class="chcLab"></label></td>
								<td><input type="checkbox" name="k2" id="ck4" value="N" onclick="checkSelect(this, this.name)"><label for="ck4" class="chcLab"></label></td>
							</tr>
							<tr name="trK">
								<td>3</td>
								<td>CRF를 작성 및 쿼리해결의 퀄리티가 높으며, 쿼리 발행사항을 신속히 해결함</td>
								<td><input type="checkbox" name="k3" id="ck5" value="Y" onclick="checkSelect(this, this.name)"><label for="ck5" class="chcLab"></label></td>
								<td><input type="checkbox" name="k3" id="ck6" value="N" onclick="checkSelect(this, this.name)"><label for="ck6" class="chcLab"></label></td>
							</tr>
						</tbody>	
							
						<tbody id="tbL">	
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">문서보존 능력 Recordkeeping capability</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txtl" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trL">
								<td>1</td>
								<td>연구 관련 문서를 보관할 수 있는 적합한 공간을 확보함</td>
								<td><input type="checkbox" name="l1" id="cl1" value="Y" onclick="checkSelect(this, this.name)"><label for="cl1" class="chcLab"></label></td>
								<td><input type="checkbox" name="l1" id="cl2" value="N" onclick="checkSelect(this, this.name)"><label for="cl2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtCommentL" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trL">
								<td>2</td>
								<td>연구 종료 후 3년간 근거문서를 보관해야 함을 인지함</td>
								<td><input type="checkbox" name="l2" id="cl3" value="Y" onclick="checkSelect(this, this.name)"><label for="cl3" class="chcLab"></label></td>
								<td><input type="checkbox" name="l2" id="cl4" value="N" onclick="checkSelect(this, this.name)"><label for="cl4" class="chcLab"></label></td>
							</tr>
							<tr name="trL">
								<td>3</td>
								<td>계약서, ISF 등의 관련문서를 적절히 보관함</td>
								<td><input type="checkbox" name="l3" id="cl5" value="Y" onclick="checkSelect(this, this.name)"><label for="cl5" class="chcLab"></label></td>
								<td><input type="checkbox" name="l3" id="cl6" value="N" onclick="checkSelect(this, this.name)"><label for="cl6" class="chcLab"></label></td>
							</tr>
						</tbody>
					</table>
					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
							<col width="180px" />
						</colgroup>
						<tbody id="tbM">
							<tr class="row_height_01">
								<th rowspan="2" colspan="2">기타 Other</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">NA</th>	
								<th rowspan="2"></th>							
							</tr>
							<tr class="row_height_01">
								<th colspan="3" style="text-align:center; font-weight:bold; padding-left:5px;"> </th>
							</tr>							
							<tr name="trM">
								<td>1</td>
								<td style="padding-right:12px;"><input type="text" id="txtOther" style="width:100%;"></td>
								<td><input type="checkbox" name="m1" id="cm1" value="3" onclick="checkSelect(this, this.name)"><label for="cm1" class="chcLab"></label></td>
								<td><input type="checkbox" name="m1" id="cm2" value="2" onclick="checkSelect(this, this.name)"><label for="cm2" class="chcLab"></label></td>
								<td><input type="checkbox" name="m1" id="cm3" value="1" onclick="checkSelect(this, this.name)"><label for="cm3" class="chcLab"></label></td>
								<td></td>
							</tr>
						</tbody>
							
							
							<tr>
								<th colspan="6">추천 Recommendation</th>
							</tr>
							<tr>
								<td colspan="2">
									본 시험자는 시험을 진행하기 위한 CJ의 기준에 부합함 This investigator meets <CJ>'s criteria to conduct the study

								</td>
								<td colspan="4">
									<input type="radio" id="o11" name="raColA" value="Y"><label for="o11" class="raLab"><span>예 Yes</span></label>
									<input type="radio" id="o12" name="raColA" value="N"><label for="o12" class="raLab"><span>아니오 No</span></label>
								</td>
							</tr>
						
					</table>



					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6><spring:message code="ctms.title.Approval"/></h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval" value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					
					
					<div style="height:10px;"></div>
					
					
					<div id="grid_wrap_01" class="gridHeiSz04 grid_wrap tb01_2"></div>



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