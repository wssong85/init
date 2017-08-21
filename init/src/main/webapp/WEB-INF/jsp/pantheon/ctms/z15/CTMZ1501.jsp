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

$(document).ready(function() {
  mkSetDatePickerYYMMDD("#day_01");
  mainSelect();
//저장버튼 클릭
  $("#btnSave").click(function(){
	  
	   //////////기타 특이사항 validator
	  validator($("#txtOther").val()); 
	  if(validatorCnt > 4000){ 
		  alert("<spring:message code='ctmz1501.message.OtherComment'/>");		 
		  $("#txtOther").focus();
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
	  var oprtnDe = $("#day_01").val();
      var oprtnDay = oprtnDe.split("-");
      var day01 = oprtnDay[0]+oprtnDay[1]+oprtnDay[2]+"000000";
	  
	  var visitData = {
			   'REPORT_SN' : reportSn		    							//리포트 순번       
			  ,'MILESTONE_SN' : g_maileSn                                   //마일드스톤 순번   
			  ,'TASK_SN' : g_taskSn	                                        //과제순번          
			  ,'REPORT_TYPE' : 'V'                                          //리포트 타입       
			  ,'REPORT_SE' : 'D00'	                                        //리포트 구분       
			  ,'JOB_SE' : g_taskSe		                                    //과제타입          
			  ,'INSTT_CODE'	: g_InsttCode                                   //기관코드          
			  ,'RSRCHMAN_ID' : g_rsrchId                                    //책임연구자 
			  ,'OPRTN_DE' : day01   							            //조사 실시일
			  ,'ITEM_A' : $("#txtCriticalItem").val() 						//필수항목점수
			  ,'ITEM_B' : $("#txtOptionalItem").val()						//선택항목점수
			  ,'ITEM_C' : $("#txtTotalScore").val()                         //총점
			  ,'ITEM_D' : $("#txtCraOrCrm").val()           				//평가자
			  ,'ITEM_E' : $("#txtOther").val()                              //기타특이사항
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
	  var params = [  $("tbody[id]").find('tr[name=trA]').length];
	 
	  var params2 = [ $("tbody[id]").find('tr[name=trB]').length];
	  
	  var addItems = {};		
	  var num = 97; //아스키코드 소문자 a 시작	 
	  var a_value;
	  
	  var addItems2 = {};
	  var num2 = 98; //아스키코드 소문자 b 시작	 
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
	  
	  var itemValue; //체크했으면 Y 아니면 N	 
	  
	  for(var j=0; j<params2.length; j++){		 	  
		  a_value2 = String.fromCharCode(num2);	//아스키코드를 문자형으로..	
		  //console.log("a_value::::"+a_value);
		  num2++;
		  
		  for(var i=1; i<=params2[j]; i++){		
			  if($('input:checkbox[name="'+a_value2+i+'"]').is(':checked') == true){
				  itemValue = "Y";
			  }else{
				  itemValue = "N";
			  }
			  addItems2[i] = {
					  'REPORT_SN' : reportSn,
					  'MILESTONE_SN' : g_maileSn,
					  'TASK_SN' : g_taskSn,						  
					  'REPORT_TYPE' : 'V',
					  'ITEM_SE' : a_value2+i,						 
					  'ITEM_VALUE' : itemValue,						   
					  'CHARGER_ID' : g_userId,
					  'RM' : '',					  
					  'CRUD' : crud,
					  'DATA_SE' : 'C',
					  'LAST_UPDUSR' : g_userId
			  }
//				  if(!$(':input:radio[name="'+a_value+i+'"]:checked').val()){
//					  alert("선택되지 않은 항목이 있습니다.");
//					  return;
//				  }
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
  
  //RD 출력버튼
  $("#btnPrint").click(function(){
	    var param = {
				MRD_NAME : "CTMZ1501-FORM.mrd",
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

function mainSelect(){
	
	$("#txtTitle").val(g_taskNo);		  		   //연구제목
	$("#txtClinicalTrialSite").val(g_InsttName);   //연구기관	
	$("#txtPotential").val(g_rsrchNm);			   //책임연구자	
	$("#txtCriticalItem").val("0");		//필수항목점수
	$("#txtOptionalItem").val("0");		//선택항목점수
	$("#txtTotalScore").val("0"); 		//총점	 	
	$("#txtCraOrCrm").val(g_userNm);//평가자
	//체크박스 비활성
	for(var i=1; i<=20; i++){
		$("#bc"+i).attr("disabled", true);
	}
	
	var params = {
			 'MILESTONE_SN' : g_maileSn
			,'TASK_SN' : g_taskSn
			,'REPORT_SE' : 'D00'
			,'INSTT_CODE' : g_InsttCode
	};
	
	$.ajax({
		type		: "POST",
		url			: "./selectTrialVisitReport.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
	  success:function(data){
	  	if(data.success) {	  		
	  		if(data.result){
	  			console.log(data.result);
	  			$("#txtTitle").val(data.result.PURPS);	         //연구제목
	  			$("#txtClinicalTrialSite").val(data.result.NAME1);   //연구기관	
	  			$("#txtPotential").val(data.result.USER_NM);	     //책임연구자	
	  			$("#txtVisit").val(g_userNm);				   		 //방문자
	  			$("#day_01").val(data.result.OPRTN_DE);				 //조사 실시일	  			 
				$("#txtCriticalItem").val(data.result.ITEM_A);      //필수항목점수  
			    $("#txtOptionalItem").val(data.result.ITEM_B);	    //선택항목점수  
				$("#txtTotalScore").val(data.result.ITEM_C);        //총점          
				$("#txtCraOrCrm").val(data.result.ITEM_D);          //평가자        
				$("#txtOther").val(data.result.ITEM_E);             //기타특이사항  
				
	  			reportSn = data.result.REPORT_SN;	  			     //리포트 순번 	  		
	  			selectItem(reportSn); //ITEM 조회
	  			$("#btnPrint").attr("disabled", false);
	  			//체크박스 비활성
	  			for(var i=1; i<=20; i++){
	  				if(data.result.ITEM_C >= 30){
	  					$("#bc"+i).attr("disabled", false);
	  				}	  				
	  			}
	  		}else if(!data.result){ //신규면 출력, 결재요청, 결재 버튼 disabled
    			$("#btnPrint").attr("disabled", true);  
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
    			if(itemData[i].ITEM_SE < String.fromCharCode(98)){
    				$('input:radio[name="'+itemData[i].ITEM_SE+'"]:input[value="'+itemData[i].ITEM_VALUE+'"]').attr('checked',true);
    			}else if(itemData[i].ITEM_SE >= String.fromCharCode(98)){
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

/////////필수항목점수 라디오박스///////
function radioCheckSelect(){
	
	var num = 0;
	var value = [];
	var params = [  $("tbody[id]").find('tr[name=trA]').length];
	
	for(var i=1; i<=params[0]; i++){
		value[i] = $('input:radio[name="'+"a"+i+'"]:checked').val();
		
		if(value[i] == "Y"){
			num += 5;
		}
	}
	
	$("#txtCriticalItem").val(num); //필수항목점수	
	
	for(var i=1; i<=20; i++){	//체크박스 비활성
		if(num < 30){
			$("#bc"+i).attr("disabled", true);
			$("#bc"+i).attr("checked", false);
			$("#txtOptionalItem").val(0); //선택항목점수
		}else if(num >= 30){
			$("#bc"+i).attr("disabled", false);			
		}			
	}	
	
	$("#txtTotalScore").val(Number($("#txtCriticalItem").val())+Number($("#txtOptionalItem").val())); //총점
}

////////선택항목점수////////
function checkBoxSelect(){
	var criticalItem = $("#txtCriticalItem").val(); //필수항목점수
	var optionalItem = $("#txtOptionalItem").val(); //선택항목점수
	var num = 0;
	var value = [];
	var params = [  $("tbody[id]").find('tr[name=trB]').length];
	
	for(var i=1; i<=params[0]; i++){
		value[i] = $('input:checkbox[name="'+"b"+i+'"]:checked').val();
		
		if(value[i] == "Y"){
			num += 2.5;
		}
	}	
	$("#txtOptionalItem").val(num); //선택항목점수
	$("#txtTotalScore").val(Number($("#txtCriticalItem").val())+Number($("#txtOptionalItem").val())); //총점
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

</script>


</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1502&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1502&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
						<h5><spring:message code="ctmz1501.title.RsrchCompliance"/></h5>
					</article>

					<div style="height:10px;"></div>


					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>과제명 Title</th>
								<td>
									<input type="text" id="txtTitle" style="width:100%;" disabled>
								</td>
								<th>실시일 Date of contact</th>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" disabled/>
									</div>
								</td>
							</tr>
							<tr>
								<th>연구기관 Site Name</th>
								<td>
									<input type="text" id="txtClinicalTrialSite" style="width:100%;" disabled>
								</td>
								<th>연구자명 PI</th>
								<td>
									<input type="text" id="txtPotential" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>필수항목 점수 Critical Item Score</th>
								<td>
									<input type="text" id="txtCriticalItem" style="width:100%;" disabled>
								</td>
								<th>선택항목 점수 Optional Item Score</th>
								<td>
									<input type="text" id="txtOptionalItem" style="width:100%;" disabled>
								</td>
							</tr>
							<tr>
								<th>총점 Total Score</th>
								<td>
									<input type="text" id="txtTotalScore" style="width:100%;" disabled>
								</td>
								<th>평가자 CRA or CRM</th>
								<td>
									<input type="text" id="txtCraOrCrm" style="width:100%;" disabled>
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>

					<table class="tb001">
						<colgroup>
							<col width="130px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbA">
							<tr>
								<th colspan="2">A. <spring:message code="ctmz1501.title.Mandatory"/></th>
								<th>Yes</th>
								<th>No</th>
							</tr>
							<tr name="trA">
								<th><spring:message code="ctmz1501.title.BeforeString"/></th>
								<td><spring:message code="ctmz1501.title.BeforeString_Cn"/></td>
								<td><input type="radio" id="a12" name="a1" value="Y" onclick="radioCheckSelect()"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1" value="N" onclick="radioCheckSelect()"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<th rowspan="4"><spring:message code="ctmz1501.title.StudyOf"/></th>
								<td><spring:message code="ctmz1501.title.StudyOf_Cn_1"/></td>
								<td><input type="radio" id="a22" name="a2" value="Y" onclick="radioCheckSelect()"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2" value="N" onclick="radioCheckSelect()"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td><spring:message code="ctmz1501.title.StudyOf_Cn_2"/></td>
								<td><input type="radio" id="a32" name="a3" value="Y" onclick="radioCheckSelect()"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3" value="N" onclick="radioCheckSelect()"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td><spring:message code="ctmz1501.title.StudyOf_Cn_3"/></td>
								<td><input type="radio" id="a42" name="a4" value="Y" onclick="radioCheckSelect()"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4" value="N" onclick="radioCheckSelect()"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td><spring:message code="ctmz1501.title.StudyOf_Cn_4"/></td>
								<td><input type="radio" id="a52" name="a5" value="Y" onclick="radioCheckSelect()"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5" value="N" onclick="radioCheckSelect()"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<th rowspan="3"><spring:message code="ctmz1501.title.AfterCompletion"/></th>
								<td><spring:message code="ctmz1501.title.AfterCompletion_Cn_1"/></td>
								<td><input type="radio" id="a62" name="a6" value="Y" onclick="radioCheckSelect()"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6" value="N" onclick="radioCheckSelect()"><label for="a63" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td><spring:message code="ctmz1501.title.AfterCompletion_Cn_2"/></td>
								<td><input type="radio" id="a72" name="a7" value="Y" onclick="radioCheckSelect()"><label for="a72" class="raLab"></label></td>
								<td><input type="radio" id="a73" name="a7" value="N" onclick="radioCheckSelect()"><label for="a73" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td><spring:message code="ctmz1501.title.AfterCompletion_Cn_3"/></td>
								<td><input type="radio" id="a82" name="a8" value="Y" onclick="radioCheckSelect()"><label for="a82" class="raLab"></label></td>
								<td><input type="radio" id="a83" name="a8" value="N" onclick="radioCheckSelect()"><label for="a83" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<th rowspan="2"><spring:message code="ctmz1501.title.Claim"/></th>
								<td><spring:message code="ctmz1501.title.Claim_Cn_1"/></td>
								<td><input type="radio" id="a92" name="a9" value="Y" onclick="radioCheckSelect()"><label for="a92" class="raLab"></label></td>
								<td><input type="radio" id="a93" name="a9" value="N" onclick="radioCheckSelect()"><label for="a93" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td><spring:message code="ctmz1501.title.Claim_Cn_2"/></td>
								<td><input type="radio" id="a102" name="a10" value="Y" onclick="radioCheckSelect()"><label for="a102" class="raLab"></label></td>
								<td><input type="radio" id="a103" name="a10" value="N" onclick="radioCheckSelect()"><label for="a103" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="4">
									<div style="margin-bottom:5px;"><spring:message code="ctmz1501.title.Mandatory_2"/></div>
									<spring:message code="ctmz1501.title.Mandatory_3"/>
								</th>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					
					


					<table class="tb001">
						<colgroup>
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="ctmz1501.title.OtherComment"/></th>
							</tr>
							<tr>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtOther" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>

					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="40px" />
						</colgroup>
						<tbody id="trB">
							<tr>
								<th>B. <spring:message code="ctmz1501.title.Mandatory"/></th>
								<th>Yes</th>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_1"/></td>
								<td><input type="checkbox" name="b1" id="bc1" value="Y" onclick="checkBoxSelect()"><label for="bc1" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_2"/></td>
								<td><input type="checkbox" name="b2" id="bc2" value="Y" onclick="checkBoxSelect()"><label for="bc2" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_3"/></td>
								<td><input type="checkbox" name="b3" id="bc3" value="Y" onclick="checkBoxSelect()"><label for="bc3" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_4"/></td>
								<td><input type="checkbox" name="b4" id="bc4" value="Y" onclick="checkBoxSelect()"><label for="bc4" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_5"/></td>
								<td><input type="checkbox" name="b5" id="bc5" value="Y" onclick="checkBoxSelect()"><label for="bc5" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_6"/></td>
								<td><input type="checkbox" name="b6" id="bc6" value="Y" onclick="checkBoxSelect()"><label for="bc6" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_7"/></td>
								<td><input type="checkbox" name="b7" id="bc7" value="Y" onclick="checkBoxSelect()"><label for="bc7" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_8"/></td>
								<td><input type="checkbox" name="b8" id="bc8" value="Y" onclick="checkBoxSelect()"><label for="bc8" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_9"/></td>
								<td><input type="checkbox" name="b9" id="bc9" value="Y" onclick="checkBoxSelect()"><label for="bc9" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_10"/></td>
								<td><input type="checkbox" name="b10" id="bc10" value="Y" onclick="checkBoxSelect()"><label for="bc10" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_11"/></td>
								<td><input type="checkbox" name="b11" id="bc11" value="Y" onclick="checkBoxSelect()"><label for="bc11" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_12"/></td>
								<td><input type="checkbox" name="b12" id="bc12" value="Y" onclick="checkBoxSelect()"><label for="bc12" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_13"/></td>
								<td><input type="checkbox" name="b13" id="bc13" value="Y" onclick="checkBoxSelect()"><label for="bc13" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_14"/></td>
								<td><input type="checkbox" name="b14" id="bc14" value="Y" onclick="checkBoxSelect()"><label for="bc14" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_15"/></td>
								<td><input type="checkbox" name="b15" id="bc15" value="Y" onclick="checkBoxSelect()"><label for="bc15" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_16"/></td>
								<td><input type="checkbox" name="b16" id="bc16" value="Y" onclick="checkBoxSelect()"><label for="bc16" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_17"/></td>
								<td><input type="checkbox" name="b17" id="bc17" value="Y" onclick="checkBoxSelect()"><label for="bc17" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_18"/></td>
								<td><input type="checkbox" name="b18" id="bc18" value="Y" onclick="checkBoxSelect()"><label for="bc18" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_19"/></td>
								<td><input type="checkbox" name="b19" id="bc19" value="Y" onclick="checkBoxSelect()"><label for="bc19" class="chcLab"></label></td>
							</tr>
							<tr name="trB">
								<td><spring:message code="ctmz1501.title.Mandatory_B_20"/></td>
								<td><input type="checkbox" name="b20" id="bc20" value="Y" onclick="checkBoxSelect()"><label for="bc20" class="chcLab"></label></td>
							</tr>
							<tr>
								<th colspan="2">
									<div style="margin-bottom:5px;"><spring:message code="ctmz1501.title.Mandatory_B_21"/></div>
									<spring:message code="ctmz1501.title.Mandatory_B_22"/>
								</th>
							</tr>
						</tbody>
					</table>



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