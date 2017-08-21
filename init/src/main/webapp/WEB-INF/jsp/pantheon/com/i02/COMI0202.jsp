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

</style>

<script>
$(document).ready(function(){

// 	$('#txtDirectMail').css('display', 'none');
// 	$('#txtDirectMail2').css('display', 'none');
	
	if('${GUBUN}' == 'id') {
		$('#tab_menu1').trigger('click');
	} else {
		$('#tab_menu2').trigger('click');
	}

	$("#id_search").click(function (){
	    if (!$.trim($('#txtUserNm').val())) {
	        alert("이름을 입력하세요.");
	        return;
	    }
	    
	    if (!$.trim($('#txtPrevMail').val())) {
	        alert("이메일 주소를 입력하세요.");
	        return;
	    } 
		
		var vTmpMail = '';
		
		if($('#selectMail option:selected').val() == 'directInput') {
		    if (!$.trim($('#txtDirectMail').val())) {
		        alert("이메일 나머지 주소를 입력하세요.");
		        return;
		    } 
			
			vTmpMail = $('#txtPrevMail').val() + '@' + $('#txtDirectMail').val();
		} else {
			vTmpMail = $('#txtPrevMail').val() + '@' + $('#selectMail option:selected').val(); 
		}
		
	    $.ajax({
 		    url: "<c:url value='/com/anonymous/selectCmUserForFindId.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {
 		    	'USER_NM' : $('#txtUserNm').val(),
 		    	'EMAIL' : vTmpMail
 		    },
 		    success:function(data){
 		    	if(data.success) {
 		    		if(!data.USER_NM) {
 		    			alert('사용자가 없습니다.');
 		    		} else {
 		    			console.log(data);
 		    			$('#stUserId').text(data.USER_ID);
 		    			$('#spanUserNm').text(data.USER_NM);
 		    			$(".id_result_01").show();
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

	$("#pwd_search").click(function (){
		
	    if (!$.trim($('#txtUserId2').val())) {
	        alert("아이디를 입력하세요.");
	        return;
	    }
		
	    if (!$.trim($('#txtUserNm2').val())) {
	        alert("이름을 입력하세요.");
	        return;
	    }
	    
	    if (!$.trim($('#txtPrevMail2').val())) {
	        alert("이메일 주소를 입력하세요.");
	        return;
	    } 
		
		var vTmpMail = '';
		
		if($('#selectMail2 option:selected').val() == 'directInput') {
		    if (!$.trim($('#txtDirectMail2').val())) {
		        alert("이메일 나머지 주소를 입력하세요.");
		        return;
		    } 
			
			vTmpMail = $('#txtPrevMail2').val() + '@' + $('#txtDirectMail2').val();
		} else {
			vTmpMail = $('#txtPrevMail2').val() + '@' + $('#selectMail2 option:selected').val(); 
		}
		
		
	    $.ajax({
 		    url: "<c:url value='/com/anonymous/updateCmUserForSendTmpMail.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {
 		    	'USER_ID': $('#txtUserId2').val(),
 		    	'USER_NM' : $('#txtUserNm2').val(),
 		    	'EMAIL' : vTmpMail
 		    },
 		    success:function(data){
 		    	if(data.success) {
 		    		$(".pwd_result_01").show();
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
	});
	
	$("#selectMail").change(function() {
		if($('#selectMail option:selected').val() == 'directInput') {
			$('#txtDirectMail').css('display', '');
		} else {
			$('#txtDirectMail').css('display', 'none');
		}
	});
	
	$("#selectMail2").change(function() {
		if($('#selectMail2 option:selected').val() == 'directInput') {
			$('#txtDirectMail2').css('display', '');
		} else {
			$('#txtDirectMail2').css('display', 'none');
		}
	});

});
</script>

</head>
<body>



<div id="wrap">

	<header id="topHeader">
		<c:choose>
		<c:when test="${VIEW_GUBUN eq 'Y'}">
			<a href="<c:url value='/com/i01/intro.do'/>"><img id="logo" src="<c:url value='/images/pantheon/common/logo.png'/>" alt=""></a>
		</c:when>
		<c:otherwise>
			<a href="<c:url value='/Contract'/>"><img id="logo" src="<c:url value='/images/pantheon/common/logo.png'/>" alt=""></a>
		</c:otherwise>
		</c:choose>
	</header>


	<section id="mainCon">
		<div class="mainConInner">
            <section class="conBox100 conBox">
            
 
             
                <div class="conBoxInner">
                	<div class="join_01">
						<h4>아이디/비밀번호 찾기</h4>
						
	                    <div id="tab" class="tab tab01" style="margin-top: 20px;">
	                        <ul>
	                            <li id="tab_menu1" class="port_back tab_menu">아이디 찾기</li>
	                            <li id="tab_menu2" class="tab_menu">비밀번호 찾기</li>
	                        </ul>
	                    </div>




						<article class="tab_list">
	                        <div class="tab_sub1 tab_sub">
	                        
	                        
	                        
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>이름</th>
											<td>
												<input type="text" id="txtUserNm" name="USER_NM" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>
												<input type="text" id="txtPrevMail" style="width:20%;">
												@
												<select id="selectMail" style="width:20%;">
													<option value="directInput">===직접입력===</option>
													<option value="gmail.com">gmail.com</option>
													<option value="naver.com">naver.com</option>
													<option value="daum.com">daum.com</option>
													<option value="hotmail.com">hotmail.com</option>
													<option value="cj.net">cj.net</option>
												</select>
												<input type="text" id="txtDirectMail" style="width:30%;">
											</td>
										</tr>
									</tbody>
								</table>
								<div class="agree_btn_01">
									<input type="button" class="big_button_01" id="id_search" value="아이디 찾기">
								</div>
								
								
								<div class="id_result_01">
									<span id="spanUserNm"></span>님의 아이디는 <br><strong id="stUserId"></strong>입니다.
								</div>
								
								
	                        </div>
	                        <div class="tab_sub2 tab_sub">
	                        
	                        
	                        
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>아이디</th>
											<td>
												<input type="text" id="txtUserId2" name="USER_ID" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>이름</th>
											<td>
												<input type="text" id="txtUserNm2" name="USER_NM"style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>
												<input type="text" id="txtPrevMail2" style="width:20%;">
												@
												<select id="selectMail2" style="width:20%;">
													<option value="directInput">===직접입력===</option>
													<option value="gmail.com">gmail.com</option>
													<option value="naver.com">naver.com</option>
													<option value="daum.com">daum.com</option>
													<option value="hotmail.com">hotmail.com</option>
													<option value="cj.net">cj.net</option>
												</select>
												<input type="text" id="txtDirectMail2" style="width:30%;">
											</td>
										</tr>
									</tbody>
								</table>
								<div style="margin-top: 6px; font-size: 11px;">※ 전자계약연구자가입시 등록한 이메일로 비밀번호 변경 안내 메일이 발송됩니다</div>
								<div class="agree_btn_01">
									<input type="button" class="big_button_01" id="pwd_search" value="비밀번호 찾기">
								</div>
								
								
								<div class="pwd_result_01">
									<strong>메일</strong>이 발송되었습니다.
								</div>
	                        </div>
	                    </article>

						
						
                	</div>
                </div>


      

                
                
                
                
            </section>
		</div>
	</section>
</div>
</html>