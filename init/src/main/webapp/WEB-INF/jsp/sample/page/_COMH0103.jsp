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
$(function(){
	// 팝업레이어
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./popup_01.do", null);
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
										<input type="text" style="width:70%;">
									</td>
								</tr>
								<tr>
									<th>병원내 IRB(임상시험심사위원회)<br>여부</th>
									<td>
										<input type="radio" id="ra01" name="aaa"><label for="ra01" class="raLab"><span>예 (임상시험심사위원회가 있습니다.)</span></label>
										&nbsp;&nbsp;
										<input type="radio" id="ra02" name="aaa" checked><label for="ra02" class="raLab"><span>아니오 (전자계약)</span></label>
									</td>
								</tr>
								<tr>
									<th>아이디</th>
									<td>
										<input type="text" style="width:20%;">
										<input type="button" value="중복체크">
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<input type="text" style="width:30%;">
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td>
										<input type="password" style="width:30%;">
									</td>
								</tr>
								<tr>
									<th>비밀번호 확인</th>
									<td>
										<input type="password" style="width:30%;">
									</td>
								</tr>
								<tr>
									<th>국가</th>
									<td>
										<select id="" style="width:30%;">
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
										<input type="text" style="width:30%;">
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td style="padding-top:6px; padding-bottom:6px;">
										<input type="text" style="width:10%;">
										<input type="button" value="우편번호" style="margin-bottom:5px;">
										<br>
										<input type="password" style="width:70%; margin-bottom:5px;">
										<input type="password" style="width:70%; ">
									</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>
										<input type="text" style="width:8%;"> - 
										<input type="text" style="width:8%;"> - 
										<input type="text" style="width:8%;">
									</td>
								</tr>
							</tbody>
						</table>



						
						

						
						
						<div class="agree_btn_01">
							<input type="button" class="big_button_01" value="회원가입">
							<input type="button" class="big_button_01 popup_01" value="개인정보취급방침">
						</div>
						
						
						
						
                	</div>
                </div>


      

                
                
                
                
            </section>
		</div>
	</section>
</div>
</html>