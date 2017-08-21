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
var reportSn = ""; //리포트 MAIN 순번
var setleNo = "";  //결재번호
var approvalSn; //결재순번저장
var validatorCnt; //벨리데이션 체크 




var grid_wrap_01 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_01'
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
  grid_wrap_01.createGrid();
  mainSelect();
  
  //저장버튼 클릭
  $("#btnSave").click(function(){
	  
	//console.log("g_modifyCnt:::"+g_modifyCnt);
	  if(confirm('<spring:message code="ctmz0201.msg.Save" />') == true){
			//확인 진행
	  }else{
	  	return;
	  }
	  
	  //////////모니터링 시기 첫번째 정기 모니터링 validator
	  validator($("#txtTimeFirstMonitoring").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz0401.message.TimeFirstMonitoring'/>");		 
		  $("#txtTimeFirstMonitoring").focus();
		  return;
	  }
	  //////////모니터링 시기 이후 정기 모니터링 validator
	  validator($("#txtTimeAfterMonitoring").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz0401.message.TimeAfterMonitoring'/>");		 
		  $("#txtTimeAfterMonitoring").focus();
		  return;
	  }
	  //////////모니터링 방법 첫번째 정기 모니터링 validator
	  validator($("#txtWayFirstMonitoring").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz0401.message.FirstMonitoring'/>");		 
		  $("#txtWayFirstMonitoring").focus();
		  return;
	  }
	  //////////모니터링 방법 이후 정기 모니터링 validator
	  validator($("#txtWayAfterMonitoring").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz0401.message.AfterMonitoring'/>");		 
		  $("#txtWayFirstMonitoring").focus();
		  return;
	  }
	  //////////종료방문  validator
	  validator($("#txtEndVisit").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz0201.message.Place'/>");		 
		  $("#txtEndVisit").focus();
		  return;
	  }
	
	  
	  var crud = "";
	  if(crudCnt == "01"){ //01이면 INSERT
		  crud = "C";
	  }else{
		  crud = "U";
	  }
	  
	  var arJson = [];
	  var monitringData;
	  
	  monitringData = {
			  'REPORT_SN' : reportSn,
			  'MILESTONE_SN' : g_maileSn,
			  'TASK_SN' : g_taskSn,
			  'REPORT_SE' : 'B01',
			  'JOB_SE' : g_taskSe, //과제 타입 구분
			  'INSTT_CODE' : g_InsttCode,
			  'RSRCHMAN_ID' : g_rsrchId,
			  'PURPS' : g_taskNo,
			  'ITEM_B' : $('#txtTimeFirstMonitoring').val(), //모니터링 시기 첫번째 정기 모니터링     
			  'ITEM_C' : $('#txtTimeAfterMonitoring').val(), //모니터링 시기 이후 정기 모니터링      
			  'ITEM_D' : $('#txtWayFirstMonitoring').val(),  //모니터링 방법 첫번째 정기 모니터링     
			  'ITEM_E' : $('#txtWayAfterMonitoring').val(),  //모니터링 방법 이후 정기 모니터링      
			  'ITEM_F' : $('#txtEndVisit').val(),            //종료방문                    
			  'SETLE_NO' : '',			  
			  'LAST_UPDUSR' : g_userId,
			  'CHARGER_ID' : g_userId,
			  'REPORT_TYPE' : 'P',
			  'CRUD' : crud,
			  'SETLE_NO' : setleNo
	  };
	  arJson.push(monitringData);
	  
	  $.ajax({
		 url : './insertMonitoringPlanReport.do',
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
		'REQUST_NM': '<spring:message code="ctmz0401.title.report" />',
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
				MRD_NAME : "CTMZ0401_NSS-301-FORM 07-MPN-Ver.01.mrd",
				REPORT_SN : reportSn,
				INSTT_CODE : g_InsttCode
				
				
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
  
  //모니터링 보고서 화면으로 이동 CTMZ0402
  $("#btnVisitReport").click(function(){
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
		f.setAttribute("action", "/ctms/z04/CTMZ0402.do");
		document.body.appendChild(f);
		f.submit();
	 // $(location).attr("href","/ctms/z02/CTMZ0202.do");
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

	$("#txtTitle").val(g_taskNo);
	$("#txtClinicalTrialSite").val(g_InsttName);
	$("#txtPrincipalInvestigator").val(g_rsrchNm);
	$("#txtTaskNo").val(g_taskNo);
	
	var params = {
			 'MILESTONE_SN' : g_maileSn
			,'TASK_SN' : g_taskSn
			,'REPORT_SE' : 'B01'
			,'INSTT_CODE' : g_InsttCode
	};
	console.log(params);
	$.ajax({
    	type		: "POST",
		url			: "./selectMonitoringMain.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	    success:function(data){
	    	if(data.success) {	    		
	    		if(data.result){
	    			console.log(data.result);
	    		    $("#txtTimeFirstMonitoring").val(data.result.ITEM_B); //모니터링 시기 첫번째 정기 모니터링
	  			    $("#txtTimeAfterMonitoring").val(data.result.ITEM_C); //모니터링 시기 이후 정기 모니터링
	  			    $("#txtWayFirstMonitoring").val(data.result.ITEM_D);  //모니터링 방법 첫번째 정기 모니터링
	  			    $("#txtWayAfterMonitoring").val(data.result.ITEM_E);  //모니터링 방법 이후 정기 모니터링
	  			    $("#txtEndVisit").val(data.result.ITEM_F); 	          //종료방문
	  			    $("#txtTitle").val(data.result.PURPS); //연구제목
	  			    $("#txtClinicalTrialSite").val(data.result.NAME1); //연구기관
	  			    $("#txtPrincipalInvestigator").val(data.result.USER_NM); //책임연구자
	  			    $("#txtTaskNo").val(data.result.PURPS); //목적
	  			    crudCnt = "02"; //01:INSERT 02:UPDATE
	  			    reportSn = data.result.REPORT_SN;
	  			    approvalSn = data.result.SETLE_NO; //결재번호
	  			    
	  			  var params = {
	  		  			'REQUEST_NO' : approvalSn
	  				};
	  				grid_wrap_01.proxy.param = params;
	  				grid_wrap_01.load();
	  				
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
							<li id="btnPreparations" class="port_back tab_menu"><spring:message code="ctmz0202.title.btnPreparations" /></li>
							<li id="btnVisitReport" class="tab_menu"><spring:message code="ctmz0202.title.btnVisitReport" /></li>
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
									<input type="text" id="txtTitle" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>연구기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="txtClinicalTrialSite" style="width:100%;" disabled>
									
								</td>
							</tr>
							<tr>
								<th>책임연구자 Principal Investigator</th>
								<td>
									<input type="text" id="txtPrincipalInvestigator" style="width:100%;" disabled>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 목적 Attendants</h6>
                    </article>
                    

					<div style="height:2px;"></div>



					<div style="padding:0 0 0 18px;">
						<spring:message code="ctmz0401.title.Attendants_1"/> <input type="text" id="txtTaskNo" style="width:200px;" disabled> <spring:message code="ctmz0401.title.Attendants_2"/>
					</div>




					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>2. 정기 모니터링 Routine Monitoring Visit</h6>
                    </article>


					<div style="height:2px;"></div>


					<div style="padding:0 0 0 18px;">
						<spring:message code="ctmz0401.title.RoutineMonitoringVisit"/>
					</div>





					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6 style="color:#FF0000;"><spring:message code="ctmz0401.title.Example"/></h6>
                    </article>


					<div style="height:2px;"></div>


					<h7 style="color:#FF0000;"><spring:message code="ctmz0401.title.TimeMonitoring"/></h7>
					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="ctmz0401.title.TimeFirstMonitoring"/></th>
								<td style="color:#FF0000;">
									<spring:message code="ctmz0401.title.TimeFirstMonitoring_2"/>
								</td>
							</tr>
							<tr>
								<th></th>
								<td style="color:#FF0000;">
									<input type="text" id="txtTimeFirstMonitoring" style="width:100%;" >
								</td>
							</tr>
							<tr>
								<th><spring:message code="ctmz0401.title.AfterMonitoring"/></th>
								<td style="color:#FF0000;">
									<spring:message code="ctmz0401.title.AfterMonitoring_2"/>
								</td>
							</tr>
							<tr>
								<th></th>
								<td style="color:#FF0000;">
									<input type="text" id="txtTimeAfterMonitoring" style="width:100%;" >
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:10px;"></div>
					

					<h7 style="color:#FF0000;"><spring:message code="ctmz0401.title.HowtoMonitor"/></h7>
					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="ctmz0401.title.TimeFirstMonitoring"/></th>
								<td style="color:#FF0000;">
									<spring:message code="ctmz0401.title.Census"/>
								</td>
							</tr>
							<tr>
								<th></th>
								<td style="color:#FF0000;">
									<input type="text" id="txtWayFirstMonitoring" style="width:100%;">
								</td>
							</tr>
							<tr>
								<th><spring:message code="ctmz0401.title.AfterMonitoring"/></th>
								<td style="color:#FF0000;">
									<spring:message code="ctmz0401.title.PreviousChecklist"/>
								</td>
							</tr>
							<tr>
								<th></th>
								<td style="color:#FF0000;">
									<input type="text" id="txtWayAfterMonitoring" style="width:100%;">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:2px;"></div>


					<div style="padding:0 0 0 0px;">
						<spring:message code="ctmz0401.title.Only"/> <span style="color:#FF0000;">
						<spring:message code="ctmz0401.title.MonitoringRecoveryTime"/></span>
						<spring:message code="ctmz0401.title.Prior"/> <span style="color:#FF0000;">
						<spring:message code="ctmz0401.title.InstitutionalChange"/></span>
					</div>



					<div style="height:20px;"></div>
					

					<h7><spring:message code="ctmz0401.title.NextVisit_1"/></h7>

					<div style="padding:0 0 0 18px;">
						<ul>
							<li><spring:message code="ctmz0401.title.NextVisit_2"/></li>
							<li><spring:message code="ctmz0401.title.NextVisit_3"/></li>
							<li>- <span style="color:#FF0000;"><spring:message code="ctmz0401.title.NextVisit_4"/></span></li>
							<li>- <span style="color:#FF0000;"><spring:message code="ctmz0401.title.NextVisit_5"/></span></li>
						</ul>
					</div>




					<div style="height:20px;"></div>
					

					<h7><spring:message code="ctmz0401.title.NextDiv_1"/></h7>

					<div style="padding:0 0 0 18px;">
						<ul>
							<li><spring:message code="ctmz0401.title.NextDiv_2"/></li>
							<li>- <span style="color:#FF0000;"><spring:message code="ctmz0401.title.NextDiv_3"/></span></li>
							<li>- <span style="color:#FF0000;"><spring:message code="ctmz0401.title.NextDiv_4"/></span></li>
							<li>- <span style="color:#FF0000;"><spring:message code="ctmz0401.title.NextDiv_5"/></span></li>
							<li>- <spring:message code="ctmz0401.title.NextDiv_6"/></li>
							<li>- <spring:message code="ctmz0401.title.NextDiv_7"/> <span style="color:#FF0000;"><spring:message code="ctmz0401.title.NextDiv_8"/></span></li>
							<li>- <span style="color:#FF0000;"><spring:message code="ctmz0401.title.NextDiv_9"/></span></li>
						</ul>
					</div>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 종료 모니터링 Close-out Visit</h6>
                    </article>


					<div style="height:2px;"></div>


					<div style="padding:0 0 0 0px;">
						<spring:message code="ctmz0401.title.LastSurvey"/>
					</div>
					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="ctmz0401.title.VisitExit"/></th>
								<td style="color:#FF0000;">
									<spring:message code="ctmz0401.title.endOfStudy"/>
								</td>
							</tr>
							<tr>
								<th></th>
								<td style="color:#FF0000;">
									<input type="text" id="txtEndVisit" style="width:100%;">
								</td>
							</tr>
							
						</tbody>
					</table>



					<div style="height:20px;"></div>

                    <article class="conTitBox">
                        <h6>4. <spring:message code="ctms.title.Approval"/></h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval" value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					<div style="height:10px;"></div>
					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>



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