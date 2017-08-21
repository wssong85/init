<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
<script type="text/javascript">

var overlapCnt = "0"; //중복여부
var requestCnt = "0"; //0:저장인지 1:요청인지 구분
var validatorCnt;
var confmSe;
var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
$(document).ready(function(){
	
	//Role선택 selectbox 
	var roleBoxText;
	//console.log(roleCode);
	roleBoxText += "<option value=''></option>";
	for(var i=0; roleCode.length > i; i++){		
		if(roleCode[i].CMMN_CODE == "ROLE_PI" || roleCode[i].CMMN_CODE == "ROLE_CRC" || roleCode[i].CMMN_CODE == "ROLE_Sub-I"){
			roleBoxText += "<option value='"+roleCode[i].CMMN_CODE+"'>"+roleCode[i].CMMN_CODE_NM+"</option>";
		}		
 	}
	$("#selectRole").append(roleBoxText);
	
	//표준시간 선택 selectbox 
	var standardTimeText;
	standardTimeText += "<option value=''></option>";
 	for(var i=0; standardTime.length > i; i++){
 		standardTimeText += "<option value='"+standardTime[i].STD_TIME_SN+"'>"+standardTime[i].STD_TIME_NM+"</option>";
 	}
 	$("#standardTime").append(standardTimeText);
	
	
	//목록버튼
	$("#btnList").click(function(){
		layerClose();
		insertCnt = "0";
	});
	
	//기관조회 버튼
	$("#btnSearchInstt").click(function(){
		var param = {};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
	});
	
	//과제조회
	$("#btnSearchTask").click(function(){
		var param = {};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
	});
	
	//저장버튼 클릭
	$("#btnSave").click(function(){
		if(overlapCnt == "1"){ //중복체크 여부
			confmSe = "01";
			requestCnt = "0";
			fn_insertRsrchUser();
		}else{
			alert("아이디 중복체크를 해주세요");
		}
		
	});
	
	//요청버튼
	$("#btnRequest").click(function(){
		if(overlapCnt == "1"){ //중복체크 여부
			confmSe = "02";
			requestCnt = "2"
			fn_insertRsrchUser();			
		}else{
			alert("중복체크를 해주세요");
		}
		
		
	});
	
	//ID 중복체크
	$("#btnOverlapId").click(function(){
		if(!$("#txtInputTaskSn").val()){
			alert("과제번호를 입력해 주세요.");
			return;
		}
		if(!$("#txtInputRsrchId").val()){
			alert("ID를 입력해 주세요.");
			return;
		}	
		
		 overlapCnt = "1";
		$.ajax({
 		    url: './selectCmUser.do',
 		    type: 'post',
 		    dataType: 'json',
 		    data: {'USER_ID' : $("#txtInputRsrchId").val(),'TASK_SN' : $("#txtInputTaskSn").val()},
 		    success:function(data){
 		    	if(data.success) {	
 		    		var items = data.result;
 		    		if(items != ""){
 		    			for(i=0; i<items.length; i++){
 	 		    			if(items[i].USER_ID+items[i].TASK_SN == $("#txtInputRsrchId").val()+$("#txtInputTaskSn").val()){
 								alert("중복된 ID가 있습니다.");
 								overlapCnt = "0";
 								return;
 							}
 	 		    		}
 		    			if(confirm("기존ID가 있습니다. 데이터를 불러오시겠습니까? 새로 입력 저장시 기존데이터 덮어씀") == true){
 		    				$("#txtInputRsrchNm").val(items[0].USER_NM); 		    				
 		    				$("#txtInputEmail").val(items[0].EMAIL);
 		    				$("#selectRole").val(items[0].ROLE_ID);
 		    				$("#txtInputTelNo").val(items[0].TELNO);
 		    				$("#txtInputRsrchEngNm").val(items[0].USER_ENGNM);
 		    				$("#standardTime").val(items[0].STD_TIME_SN);
 		    				$("#txtInputInsttCode").val(items[0].INSTT_CD);
 		    			    $("#txtInputInsttNm").val(items[0].INSTT_NM);
 		    			    $("#txtInputInsttAdr").val(items[0].ADDRESS); 	
 		    			    $("#btnSearchInstt").hide();
 		    				$("#btnSearchTask").hide();
 		    				$("#btnOverlapId").hide(); 		    				
 		    			
 		    				$("#txtInputRsrchId").attr("disabled",true);
 		    				$("#txtInputRsrchNm").attr("disabled",true);
 		    				$("#selectRole").attr("disabled",true);
 		    				$("#txtInputEmail").attr("disabled",true);
 		    				$("#txtInputRsrchEngNm").attr("disabled",true);
 		    				$("#txtInputTelNo").attr("disabled",true);
 		    				$("#standardTime").attr("disabled",true);
 		    				
 		    			}else{
 		    				$("#txtInputInsttCode").val(items[0].INSTT_CD);
 		    			    $("#txtInputInsttNm").val(items[0].INSTT_NM);
 		    			    $("#txtInputInsttAdr").val(items[0].ADDRESS); 
 		    			    $("#btnSearchInstt").hide();
 		    			}
 		    			
 		    		}else{
 		    			alert("사용가능한 ID입니다.");
 		    		}
 		    		
 		    		
 		    	} else { 		    		
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
	});
	
	//삭제버튼
	$("#btnDelete").click(function(){
		if(confirm("삭제하시겠습니까?") == true){
			insertCnt = "2";
			fn_insertRsrchUser();
		}
		
	});
	
	$('input').on("blur keyup",function(){
		//$("#txtInputRsrchId").val($("#txtInputRsrchId").val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g,''));
		//$("#txtInputEmail").val($("#txtInputEmail").val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g,''));
		
	});


	
	
}); 

function fn_insertRsrchUser(){
	
	if(!$("#txtInputRsrchId").val()){
		alert("ID를 입력해 주세요");	
		$("#txtInputRsrchId").focus();
		return;
	}
	if(!$("#txtInputTaskNo").val()){
		alert("과제번호를 입력해 주세요");
		return;
	}
	if(!$("#txtInputInsttCode").val()){
		alert("기관코드를 입력해 주세요");
		return;
	}
	if(!$("#txtInputEmail").val()){
		alert("Email을 입력해 주세요");
		$("#txtInputEmail").focus();
		return;
	}
	if(!regEmail.test($("#txtInputEmail").val())){
		alert("이메일 주소가 유효하지 않습니다.");
		$("#txtInputEmail").focus();
		return false;
	}
	if(!$("#txtInputRsrchNm").val()){
		alert("연구자명을 입력해 주세요");
		$("#txtInputRsrchNm").focus();
		return;
	}
	if(!$("#selectRole").val()){
		alert("Role을 선택해 주세요");
		return;
	}
	if(!$("#standardTime").val()){
		alert("표준시간대를 선택해 주세요");	
		return;
	}
	if(insertCnt == "0"){ //신규저장일때
		if(requestCnt == "0"){ //저장버튼을 클릭했을때
			if(confirm("저장 하시겠습니까?") == true){
				//확인진행
			}else{
				return;
			}
		}else{ //요청버튼을 클릭했을때
			if(confirm("요청/저장 하시겠습니까?") == true){
				//확인진행
			}else{
				return;
			}
		}
		
	}else if(insertCnt == "1"){ //수정일때
		if(requestCnt == "0"){ //저장버튼을 클릭했을때
			if(confirm("저장 하시겠습니까? 해당 ID의 정보가 입력한 데이터로 변경됩니다.") == true){
				//확인진행
			}else{
				return;
			}
		}else{ //요청버튼을 클릭 했을때
			if(confirm("요청/저장 하시겠습니까? 해당 ID의 정보가 입력한 데이터로 변경됩니다.") == true){
				//확인진행
			}else{
				return;
			}
		}
		
	}
	
	
	var insertCrud;
	
	if(insertCnt == "0"){
		insertCrud = "C"
	}else if(insertCnt == "1"){
		insertCrud = "U"
	}else if(insertCnt == "2"){
		insertCrud = "D"
	}
	console.log($("#txtInputRsrchId").val());
	console.log( $("#txtInputInsttCode").val());
					   
	var arJson = [];
	var rsrchUserInfo = {'USER_ID' : $("#txtInputRsrchId").val()
					   , 'INSTT_CODE' : $("#txtInputInsttCode").val()
					   , 'HSPTL_NM' : $("#txtInputInsttNm").val()
					   , 'ZIP' : $("#txtInputPstlz").val()
					   , 'ADDRONE' :  $("#txtInputOrt01").val() + " " +$("#txtInputStras").val()
					   , 'ADDRTWO' : $("#txtInputRegio").val()
					   , 'PASSWORD' : '1234'
					   , 'USER_NM' : $("#txtInputRsrchNm").val()
					   , 'USER_ENGNM' : $("#txtInputRsrchEngNm").val()
					   , 'EMAIL' : $("#txtInputEmail").val()
					   , 'TELNO' : $("#txtInputTelNo").val()
					   , 'LAST_UPDUSR' : userId,'TASK_NO' : $("#txtInputTaskNo").val()
					   , 'TASK_SN' : $("#txtInputTaskSn").val()
					   , 'ROLE_ID' : $("#selectRole").val()
					   , 'STD_TIME_SN' : $("#standardTime").val()
					   , 'CRUD' : insertCrud, 'CONFM_SE' : confmSe}
	
	arJson.push(rsrchUserInfo);  
	console.log("confmSe:::::"+confmSe);
	console.log("insertCrud:::::"+insertCrud);
	console.log("ROLE_ID:::::"+$("#selectRole").val());
	$.ajax({
		  url : './insertRsrchUserInfo.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {	
			  if(data.success) {					  
				  layerClose();	
				  fn_GridLoad();
				  insertCnt = "0";
				  overlapCnt = "0";
			  } else {					  
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
}

//기관조회 팝업
function fn_setInstt(){
    $("#txtInputInsttCode").val(returnValue.KUNNR);
    $("#txtInputInsttNm").val(returnValue.INSTT_NAME);
    $("#txtInputInsttAdr").val(returnValue.ADDRESS);    
    $("#txtInputOrt01").val(returnValue.ORT01); //주소 도시
    $("#txtInputStras").val(returnValue.STRAS); //주소 상세
    $("#txtInputPstlz").val(returnValue.PSTLZ); //우편번호
    $("#txtInputRegio").val(returnValue.REGIO); //지역
}

function fn_setTaskNo(){
	console.log(returnTaskValue.TASK_NO);
	$("#txtInputTaskSn").val(returnTaskValue.TASK_SN);
	$("#txtInputTaskNo").val(returnTaskValue.TASK_NO);
}

function fn_popupNew(){
	$("#btnDelete").hide();
}

function fn_popupDetail(){
	if(paramItems.CONFM_SE == "01"){ //신규,반려 일때
		$("#btnSearchInstt").show();
		$("#btnSearchTask").show();
		$("#txtInputRsrchId").attr("disabled",false);
	}else if(paramItems.CONFM_SE == "02" || paramItems.CONFM_SE == "03"){ //요청일때
		$("#btnSearchInstt").hide();
		$("#btnSearchTask").hide();
		$("#btnRequest").hide();
		$("#btnSave").hide();
		$("#btnDelete").hide();
		$("#btnOverlapId").hide();		
		$("#btnSearchTask").hide();
		
		$("#txtInputRsrchId").attr("disabled",true);
		$("#txtInputRsrchNm").attr("disabled",true);
		$("#selectRole").attr("disabled",true);
		$("#txtInputEmail").attr("disabled",true);
		$("#txtInputRsrchEngNm").attr("disabled",true);
		$("#txtInputTelNo").attr("disabled",true);
		$("#standardTime").attr("disabled",true);
		
	}
	
	$("#txtInputInsttCode").val(paramItems.INSTT_CD);
    $("#txtInputInsttNm").val(paramItems.INSTT_NM);
    $("#txtInputInsttAdr").val(paramItems.ORT01 + ' ' + paramItems.STRAS);
    $("#txtInputOrt01").val(paramItems.ORT01); //주소 도시
    $("#txtInputStras").val(paramItems.STRAS); //주소 상세
    $("#txtInputPstlz").val(paramItems.PSTLZ); //우편번호
    $("#txtInputRegio").val(paramItems.REGIO); //지역
    $("#txtInputTaskSn").val(paramItems.TASK_SN);
	$("#txtInputTaskNo").val(paramItems.TASK_NO);
	$("#txtInputRsrchNm").val(paramItems.USER_NM);
	$("#txtInputRsrchId").val(paramItems.USER_ID);
	$("#txtInputEmail").val(paramItems.EMAIL);
	$("#selectRole").val(paramItems.ROLE_ID);
	$("#txtInputTelNo").val(paramItems.TELNO);
	$("#txtInputRsrchEngNm").val(paramItems.USER_ENGNM);
	$("#standardTime").val(paramItems.STD_TIME_SN);
	overlapCnt = "1";
}




</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd1000" >	
			<section class="conBox100 popup_conBox" style='margin:0px;'>
				<div class="popup_conBoxInner">		
					<div class="conTitBtnR">	
				    	
						<input type="button" id="btnRequest" value="요청">					
						<input type="button" id="btnDelete" value="삭제">		
		                <input type="button" id="btnSave" value="저장">
		                <input type="button" id="btnList" value="목록">	  					                          
		            </div>					             
		            <table class="tb02">
		           		<tbody>
							<tr>					
								</select>
								<th><span class="must_01"></span>과제번호</th>
                                <td>                 	
                                	<input type="hidden" id="txtInputTaskSn" disabled>
                                    <input type="text" id="txtInputTaskNo" disabled> <input type="button" id="btnSearchTask" value="조회" >                                          
                                </td>  
								</td>
								<th><span class="must_01"></span>ID</th>
                                <td>        
                                	<input type="text" id="txtInputRsrchId" maxlength="32" style="ime-mode:disabled;"> <input type="button" id="btnOverlapId" value="중복체크" >	                                                               	
                                </td>	               
							</tr>	
							<tr>
								<th><span class="must_01"></span>기관코드</th>
                                <td>                                	
                                    <input type="text" id="txtInputInsttCode" disabled> <input type="button" id="btnSearchInstt" value="조회" >
                                    <input type="hidden" id="txtInputOrt01" >
                                    <input type="hidden" id="txtInputStras" >
                                    <input type="hidden" id="txtInputPstlz" >
                                    <input type="hidden" id="txtInputRegio" >
                                </td>
								<th><span class="must_01"></span>기관명</th>
								<td>
								<input type="text" id="txtInputInsttNm" disabled>											
								</td>               
							</tr>
							<tr>
								<th><span class="must_01"></span>주소</th>
								<td>
								<input type="text" id="txtInputInsttAdr" disabled>
								</td>	
								
								<th><span class="must_01"></span>E-mail</th>
								<td>
								<input type="text" id="txtInputEmail" maxlength="100" style="ime-mode:disabled;">
								</td>	
							</tr>
							<tr>												
								<th><span class="must_01"></span>연구자명</th>
                                <td>
                                    <input type="text" id="txtInputRsrchNm" maxlength="66"> 
                                </td>  	
                                <th><span class="must_01"></span>Role</th>
                                <td>
                                    <select id="selectRole" name="selectRole">
									</select> 
                                </td>							 										
							</tr>	
							<tr>
							    <th>영문명</th>
                                <td>
                                    <input type="text" id="txtInputRsrchEngNm" style="ime-mode:disabled;">
                                </td>
                                <th></span>전화번호</th>
                                <td>
                                	<input type="text" id="txtInputTelNo" >
                                </td>                                         
							</tr>	
							<tr>                                 
                                <th><span class="must_01"></span>표준시간대</th>
                                <td>
                                	<select id="standardTime" name="standardTime">
									</select>   
                                </td>          
							</tr>	
						</tbody>
						
						
						
					</table>								
                 					
				</div>
			</section>
	    </div>
	</section>

</body>
</html>