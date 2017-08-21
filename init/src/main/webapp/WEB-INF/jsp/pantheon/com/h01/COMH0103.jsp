<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false"/>

<title>전자계약</title>

<style>
#mainCon{ padding:0;}
.conBoxInner{min-height:840px; }
.join_01{ width:1000px; margin:0 auto;}
/* input:hover{ border:1px solid red;} */
/* input[type="text"]:focus{ border:1px solid red;} */
/* #ddd */
/* input[type="text"]:blur{ border:1px solid red;} */
/* input[type="text"]{ border:1px solid red;} */
/* input[type="password"]{ border:1px solid red;} */
/* select{ border:1px solid red;} */

.check_yes{ position: relative; top:4px; margin:0px 0 0 10px; background:url(/images/pantheon/common/check_01.png) no-repeat 0px 0px; display: inline-block; width:16px; height:16px;}
.check_no{ position: relative; top:4px; margin:0px 0 0 10px; background:url(/images/pantheon/common/check_01.png) no-repeat 0px -53px; display: inline-block; width:16px; height:16px;}
</style>

<script>
function CehckPassWord(ObjUserID, ObjUserPassWord, objUserPassWordRe) {

    if(objUserPassWordRe && ObjUserPassWord != objUserPassWordRe) {
		$('#spanPwCheck').text("입력하신 비밀번호와 비밀번호확인이 일치하지 않습니다");
        return false;
    }

    if(ObjUserPassWord && !ObjUserPassWord.substring(0,1).match(/([a-zA-Z])/)) {
    	$('#spanPwCheck').text("처음 시작하는 문자는 영문 대/소문자로 해주십시오.");
    	return false;
    }
    
    if(ObjUserPassWord.length<6 || ObjUserPassWord.length>16) {
    	$('#spanPwCheck').text("비밀번호는 문자(영문 대/소문자), 숫자, 특수문자 중 2종 이상 혼용해서 6~16자리로 입력해주세요.");
        return false;
    }

//     if(!ObjUserPassWord.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
	if(!ObjUserPassWord.match(/([a-zA-Z].*[0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~].*[0-9])|([a-zA-Z].*[0-9])|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~])/)) {
		$('#spanPwCheck').text("비밀번호는 문자(영문 대/소문자), 숫자, 특수문자 중 2종 이상 혼용해서 6~16자리로 입력해주세요.");
        return false;
    }
    
	for(var i = 0; i < ObjUserID.length; i++) {
		
		if(ObjUserID.substring(i, i+3).length > 2 && ObjUserPassWord.indexOf(ObjUserID.substring(i, i+3)) > -1)  {
			$('#spanPwCheck').text("ID와 동일한 3 자 이상의 패스워드를 사용할 수 없습니다.");
			return false;
		}
    }  
   
    var SamePass_0 = 0; //동일문자 카운트
    var SamePass_1 = 0; //연속성(+) 카운드
    var SamePass_2 = 0; //연속성(-) 카운드
    
    var chr_pass_0;
    var chr_pass_1;

    var chr_pass_2;

    
    for(var i=0; i < ObjUserPassWord.length; i++) {
        chr_pass_0 = ObjUserPassWord.charAt(i);
        chr_pass_1 = ObjUserPassWord.charAt(i+1);
       
        //동일문자 카운트
        if(chr_pass_0 == chr_pass_1) {
            SamePass_0 = SamePass_0 + 1
        }
        
       
        chr_pass_2 = ObjUserPassWord.charAt(i+2);
        //연속성(+) 카운드

        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1) {
            SamePass_1 = SamePass_1 + 1
        }
       
        //연속성(-) 카운드
        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1) {
            SamePass_2 = SamePass_2 + 1
        }
    }
    
    if(SamePass_0 > 1) {
		$('#spanPwCheck').text("동일문자를 3번 이상 사용할 수 없습니다.");
        return false;
    }
  
    if(SamePass_1 > 1 || SamePass_2 > 1 ) {
		$('#spanPwCheck').text("연속된 문자열(123 또는 321, abc, cba 등)을\n 3자 이상 사용 할 수 없습니다.");
        return false;
    }
    
    $('#spanPwCheck').text("");
 	return true;
} 


function loadCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.STD_TIME_SN + ">" + this.STD_TIME_NM + "</option> ";
	});

	target.append(dataArr);
	
	//기본 서울로 세팅
	$("#selectCmStdTime").val("304");
}

function fn_requestRequstAddr(v) {
	$('#txtRoadAddr').val(v.roadAddr);
	$('#txtZipNo').val(v.zipNo);
}

$(function(){
	
	if('${USER_NAME}') {
		$('#txtUserNm').val('${USER_NAME}');
	} else {
		location.href = "<c:url value='/Contract'/>";
	}
	
	$("#sign_1").hide();
	$("#sign_2").hide();
	$("#sign_3").hide();
	$("#sign_4").hide();
	$("#sign_5").hide();
	$("#sign_6").hide();
	$("#sign_7").hide();
	$("#sign_8").hide();
	$("#sign_9").hide();
	$("#sign_10").hide();
	
	$('#btnPopAddr').click(function() {
		mkLayerPopupOpen('/com/anonymous/popupCOMZ0501.do', {
			'callbackFunction': 'fn_requestRequstAddr'
		});
	});
	
	// 팝업레이어
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./popup_01.do", null);
	});
	
	$('#txtUserId').keyup(function(e) {
		
		if($('#psPassword01').val()) {
			if(CehckPassWord($('#txtUserId').val(), $('#psPassword01').val())) {
				$("#sign_3").show();
	 			$("#sign_4").hide();
			} else {
				$("#sign_4").show();
	 			$("#sign_3").hide();
			}
		}
		
		if($('#psPassword02').val()) {
			if(CehckPassWord($('#txtUserId').val(), $('#psPassword02').val())) {
				$("#sign_5").show();
	 			$("#sign_6").hide();
			} else {
				$("#sign_6").show();
	 			$("#sign_5").hide();
			}
		}
		
		var vUserId = $('#txtUserId').val();
		
		if(!$.trim(vUserId)) {
 			$("#sign_2").hide();
 			$("#sign_1").hide();
			return;
		}
		
    	if(!fn_CheckUserId(vUserId)) {
 			$("#sign_2").show();
 			$("#sign_1").hide();
			return;
			
    	} else {
    	
    		if(($.trim(vUserId)) && ($.trim(vUserId).length > 4) && (vUserId.substring(0,4) != 'cjp_')) {
    	 		$.ajax({
    	 		    url: "<c:url value='/com/anonymous/selectCmUserCountForDupCheck.do'/>",
    	 		    type: 'post',
    	 		    dataType: 'json',
    	 		    doNotAjaxSetup: true,
    	 		    data: {
    	 		    	'USER_ID' : $('#txtUserId').val()
    	 		    },
    	 		    success:function(data){
    	 		    	if(data.success) {
    	 		    		if(data.count) {
    	 		    			$("#sign_2").show();
    	 		    			$("#sign_1").hide();
    	 		    		} else {
    	 		    			$("#sign_1").show();
    	 		    			$("#sign_2").hide();
    	 		    		}
    	 		    	} else {
    	 		    		alert(data.message);
    	 		    	}
    	 		    },
    				error : function(jqXHR, textStatus, errorThrown){
    					alert(textStatus);
    				}
    	 		});
    			
    		} else {
    			
				$("#sign_2").show();
				$("#sign_1").hide();
				
    		}
    		
    	}

	});
	
	$('#psPassword01').keyup(function(e) {
		if(!$('#psPassword01').val()) {
			$('#spanPwCheck').text("");
 			$("#sign_3").hide();
			$("#sign_4").hide();
			return;
		}
		
		if(CehckPassWord($('#txtUserId').val(), $('#psPassword01').val())) {
			$("#sign_3").show();
 			$("#sign_4").hide();
		} else {
			$("#sign_4").show();
 			$("#sign_3").hide();
		}

	});
	
	$('#psPassword02').keyup(function(e) {
		
		if(!$('#psPassword02').val()) {
			$("#sign_5").hide();
 			$("#sign_6").hide();
			return;
		}
		
		if($('#sign_3').css('display') == 'none') {
			$("#sign_5").hide();
 			$("#sign_6").hide();
			$("#psPassword01").focus();
			return;
		}
		
		if($('#psPassword01').val() == $('#psPassword02').val()) {
			$("#sign_5").show();
 			$("#sign_6").hide();
		} else {
			$("#sign_6").show();
 			$("#sign_5").hide();
		}
		
	});
	
	
	$('#txtEmail').keyup(function(e) {
		 var email = $('#txtEmail').val();  
		 var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
		 if(!$.trim(email)) {
			$("#sign_7").hide();
			$("#sign_8").hide();
			$('#spanEmailCheck').text("");
			return;			 
		 }
		 if(regex.test(email)) {  
			$("#sign_7").show();
			$("#sign_8").hide();
			$('#spanEmailCheck').text("");
			/* 이메일 중복체크 
 	 		$.ajax({
	 		    url: "<c:url value='/com/anonymous/selectCmUserCountForEmail.do'/>",
	 		    type: 'post',
	 		    dataType: 'json',
	 		    data: {
	 		    	'EMAIL' : $('#txtEmail').val()
	 		    },
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		if(data.count) {
		 		   			$("#sign_8").show();
		 					$("#sign_7").hide();
		 					$('#spanEmailCheck').text("이메일 주소가 중복되었습니다.");
	 		    		} else {
	 		   				$("#sign_7").show();
	 						$("#sign_8").hide();
	 						$('#spanEmailCheck').text("");
	 		    		}
	 		    	} else {
	 		    		alert(data.message);
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
			*/
		 } else {
			$("#sign_8").show();
			$("#sign_7").hide();
			$('#spanEmailCheck').text("");
		 }  
	});
	
	$('#txtTel01').keyup(function(e) {
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
		var telNo = $('#txtTel01').val() + $('#txtTel02').val() + $('#txtTel03').val(); 	
		
		if(!$.trim(telNo)) {
			$("#sign_9").hide();
			$("#sign_10").hide();
			return;
		}
		
		if(regExp.test(telNo)) {
			$("#sign_9").show();
			$("#sign_10").hide();
		} else {
			$("#sign_10").show();
			$("#sign_9").hide();
		}
	});
	
	$('#txtTel02').keyup(function(e) {
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
		var telNo = $('#txtTel01').val() + $('#txtTel02').val() + $('#txtTel03').val(); 	
		
		if(!$.trim(telNo)) {
			$("#sign_9").hide();
			$("#sign_10").hide();
			return;
		}
		
		if(regExp.test(telNo)) {
			$("#sign_9").show();
			$("#sign_10").hide();
		} else {
			$("#sign_10").show();
			$("#sign_9").hide();
		}
	});

	$('#txtTel03').keyup(function(e) {
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
		var telNo = $('#txtTel01').val() + $('#txtTel02').val() + $('#txtTel03').val(); 	
		
		if(!$.trim(telNo)) {
			$("#sign_9").hide();
			$("#sign_10").hide();
			return;
		}

		if(regExp.test(telNo)) {
			$("#sign_9").show();
			$("#sign_10").hide();
		} else {
			$("#sign_10").show();
			$("#sign_9").hide();
		}
	});
	
	$('#btnUserJoin').click(function() {

		if(!$.trim($('#txtHsptlNm').val())) {
			alert('병의원을 입력해 주십시오.');
			return;
		}
		
		if($('#sign_1').css('display') == 'none') {
			alert('아이디를 확인해 주십시오.');
			return;
		}
		
		if(!$.trim($('#txtUserNm').val())) {
			alert('이름을 입력해 주십시오.');
			return;
		}
		
		if($('#sign_3').css('display') == 'none') {
			alert('비밀번호를 확인해 주십시오.');
			return;
		}
		
		if($('#sign_5').css('display') == 'none') {
			alert('비밀번호확인을 확인해 주십시오.');
			return;
		}
		
		if(!$('#selectCmStdTime').val()) {
			alert('국가를 선택해 주십시오.');
			return;
		}
		
		if($('#sign_7').css('display') == 'none') {
			alert('이메일주소를 확인해 주십시오.');
			return;
		}
		
		if($('#sign_9').css('display') == 'none') {
			alert('전화번호를 확인해 주십시오.');
			return;
		}

 		$.ajax({
 		    url: "<c:url value='/com/anonymous/insertCmRsrchuserForJoin.do'/>",
 		    type: "post",
 		    dataType: "json",
 		    data: {
 		    	'HSPTL_NM': $('#txtHsptlNm').val(),
 		    	'IRB_AT': $(":radio[name='IRB_AT']:checked").val(), 
 		    	'USER_ID': $('#txtUserId').val(),
 		    	'USER_NM': $('#txtUserNm').val(),
 		    	'PASSWORD': $('#psPassword02').val(),
 		    	'STD_TIME_SN': $('#selectCmStdTime').val(),
 		    	'EMAIL': $('#txtEmail').val(),
 		    	'ZIP': $('#txtZipNo').val(),
 		    	'ADDRONE': $('#txtRoadAddr').val(),
 		    	'TELNO': $('#txtTel01').val() + $('#txtTel02').val() + $('#txtTel03').val()
 		    },
 		    success:function(data){
 		    	if(data.success) {
 		    		alert('회원가입에 성공하였습니다.');
 		    		document.frSubmit.action = "<c:url value='/com/anonymous/COMH0104.do'/>";
		    		document.frSubmit.submit();
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
		
	});
	
	
	$.ajax({
		url : "<c:url value='/com/anonymous/selectCmStdTimeForJoin.do'/>",
		success : function(data) {
			loadCombo($("#selectCmStdTime"), data.result);
// 	        $("#selectCmStdTime").val("304");
		}
	});

});
</script>

</head>
<body>



<div id="wrap">
	<header id="topHeader">
		<a href="<c:url value='/Contract'/>"><img id="logo" src="<c:url value='/images/pantheon/common/logo.png'/>" alt=""></a>
	</header>
	
	<form:form commandName="frSubmit" name="frSubmit"  method="post">
	<section id="mainCon">
		<div class="mainConInner">
            <section class="conBox100 conBox">
             
                <div class="conBoxInner">
                	<div class="join_01">
						<h4>전자계약연구자가입</h4>
						<ul class="step_01">
							<li><span>약관동의</span></li>
							<li><span>본인인증</span></li>
							<li class="on"><span>정보입력</span></li>
							<li><span>계약안내</span></li>
							<li><span>계약요청</span></li>
							<li><span>계약요청완료</span></li>
						</ul>
						
						<div class="join_title_01">정보입력</div>

						<table class="tb001">
							<colgroup>
								<col width="20%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>병의원 이름</th>
									<td>
										<input type="text" id="txtHsptlNm" name="HSPTL_NM" style="width:70%;">
									</td>
								</tr>
								<tr>
									<th>병원내 IRB(임상시험심사위원회)<br>여부</th>
									<td>
										<input type="radio" id="raIrbAt01" name="IRB_AT" value="Y"><label for="raIrbAt01" class="raLab"><span>예 (임상시험심사위원회가 있습니다.)</span></label>
										&nbsp;&nbsp;
										<input type="radio" id="raIrbAt02" name="IRB_AT" checked value="N"><label for="raIrbAt02" class="raLab"><span>아니오 (전자계약)</span></label>
										
									</td>
								</tr>
								<tr>
									<th>아이디</th>
									<td>
										<input type="text" id="txtUserId" name="USER_ID" style="width:30%;ime-mode:disabled;">
										<div class="check_yes" id="sign_1"></div>
										<div class="check_no" id="sign_2"></div>
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<input type="text" id="txtUserNm" name="USER_NM" style="width:30%;" readonly="true">
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td>
										<input type="password" id="psPassword01" style="width:30%;">
										<div class="check_yes" id="sign_3"></div>
										<div class="check_no" id="sign_4"></div>
										<span id="spanPwCheck"></span>
									</td>
								</tr>
								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input type="password" id="psPassword02" name="PASSWORD" style="width:30%;">
										<div class="check_yes" id="sign_5"></div>
										<div class="check_no" id="sign_6"></div>
									</td>
								</tr>
								<tr>
									<th>국가</th>
									<td>
										<select id="selectCmStdTime" style="width:30%;">
											<option>===국가선택===</option>
											<option value="">한국</option>
											<option value="">미국</option>
											<option value="">오스트레일리아</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>이메일 주소</th>
									<td>
										<input type="text" id="txtEmail" name="EMAIL" style="width:30%;">
										<div class="check_yes" id="sign_7"></div>
										<div class="check_no" id="sign_8"></div>
										<span id="spanEmailCheck"></span>
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td style="padding-top:6px; padding-bottom:6px;">
										<input type="text" id="txtZipNo" name="ZIP" style="width:10%;" readonly="true">
										<input type="button" id="btnPopAddr" value="우편번호" style="margin-bottom:5px;">
										<br>
<!-- 										<input type="text" style="width:70%; margin-bottom:5px;"> -->
										<input type="text" id="txtRoadAddr" name="ADDRONE" style="width:70%;" readonly="true">
									</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>
										<input type="text" id="txtTel01" style="width:8%;"> - 
										<input type="text" id="txtTel02" style="width:8%;"> - 
										<input type="text" id="txtTel03" style="width:8%;">
										<div class="check_yes" id="sign_9"></div>
										<div class="check_no" id="sign_10"></div>
									</td>
								</tr>
							</tbody>
						</table>
						
						<div class="agree_btn_01">
							<input type="button" id="btnUserJoin" class="big_button_01" value="회원가입">
							<input type="button" class="big_button_01 popup_01" value="개인정보취급방침">
						</div>
						
                	</div>
                </div>

            </section>
		</div>
	</section>
	</form:form>
</div>
</html>