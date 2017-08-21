<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>

<title>전자계약</title>

<style>
#mainCon{ padding:0;}
.conBoxInner{min-height:840px; }
.join_01{ width:1000px; margin:0 auto;}
.check_yes{ position: relative; top:4px; margin:0px 0 0 10px; background:url(/images/pantheon/common/check_01.png) no-repeat 0px 0px; display: inline-block; width:16px; height:16px;}
.check_no{ position: relative; top:4px; margin:0px 0 0 10px; background:url(/images/pantheon/common/check_01.png) no-repeat 0px -53px; display: inline-block; width:16px; height:16px;}
</style>

<script>
function CehckPassWord(ObjUserID, ObjUserPassWord, objUserPassWordRe) {

    if(objUserPassWordRe && ObjUserPassWord != objUserPassWordRe) {
		$('#spanPwCheck').text("입력하신 비밀번호와 비밀번호확인이 일치하지 않습니다");
        return false;
    }

    if(ObjUserPassWord.length<6) {
		$('#spanPwCheck').text("비밀번호는 문자, 숫자, 특수문자의 조합으로 6~16자리로 입력해주세요.");
        return false;
    }

    if(!ObjUserPassWord.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
		$('#spanPwCheck').text("비밀번호는 문자, 숫자, 특수문자의 조합으로 6~16자리로 입력해주세요.");
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

$(function(){
	$("#sign_3").hide();
	$("#sign_4").hide();
	$("#sign_5").hide();
	$("#sign_6").hide();
	
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
	
	$('#btnPasswordChange').click(function() {

		if(!$.trim($('#txtUserId').val())) {
			alert('아이디를 입력해 주십시오.');
			return;
		}
		
		if(!$.trim($('#psOldPassword').val())) {
			alert('기존 패스워드를 입력해 주십시오.');
			return;
			
		}
		
		if(!$.trim($('#psPassword01').val())) {
			alert('새 패스워드를 입력해 주십시오.');
			return;
			
		}
		
		if(!$.trim($('#psPassword02').val())) {
			alert('새 패스워드를 확인해 주십시오.');
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
		
 		$.ajax({
 		    url: "<c:url value='/com/anonymous/updateCmUserForChgPassword.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {
 		    	'USER_ID' : $('#txtUserId').val(),
 		    	'OLD_PASSWORD': $('#psOldPassword').val(),
 		    	'PASSWORD': $('#psPassword02').val()
 		    },
 		    success:function(data){
 		    	if(data.success) {
 		    		alert('비밀번호를 정상적으로 수정하였습니다. \n 다시 로그인해 주십시오.');
 		    		location.href="<c:url value='/com/i01/pantheonLoginUsr.do'/>";
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});

	});
});
</script>

</head>
<body>



<div id="wrap">
	<header id="topHeader">
		<a href="/com/i01/intro.do"><img id="logo" src="/images/pantheon/common/logo.png" alt=""></a>
	</header>


	<section id="mainCon">
		<div class="mainConInner">
            <section class="conBox100 conBox">
            
 
             
                <div class="conBoxInner">
                	<div class="join_01">
						<h4>비밀번호 변경</h4>
						


	                        <div style="margin-top: 10px;">
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>아이디</th>
											<td>
												<input type="text" id="txtUserId" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>기존 패스워드</th>
											<td>
												<input type="password" id="psOldPassword" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>새 패스워드</th>
											<td>
												<input type="password" id="psPassword01" style="width:70%;">
												<div class="check_yes" id="sign_3"></div>
												<div class="check_no" id="sign_4"></div>
												<span id="spanPwCheck"></span>
											</td>
										</tr>
										<tr>
											<th>새 패스워드 확인</th>
											<td>
												<input type="password" id="psPassword02" style="width:70%;">
												<div class="check_yes" id="sign_5"></div>
												<div class="check_no" id="sign_6"></div>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="agree_btn_01">
									<input type="button" id="btnPasswordChange" class="big_button_01"  value="비밀번호 변경">
								</div>
	                        </div>



						
						
                	</div>
                </div>


      

                
                
                
                
            </section>
		</div>
	</section>
</div>
</html>