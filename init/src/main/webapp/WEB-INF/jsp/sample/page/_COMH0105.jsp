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
		mkLayerPopupOpen("./_COMH0107.do", null);
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
							<li><span>정보입력</span></li>
							<li><span>계약안내</span></li>
							<li class="on"><span>계약요청</span></li>
							<li><span>계약요청완료</span></li>
						</ul>
						
						
						
						
						<div class="join_title_01">계약요청 내용</div>
						


						<table class="tb001">
							<colgroup>
								<col width="20%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td>yakua</td>
								</tr>
								<tr>
									<th>연구자 이름</th>
									<td>홍길동</td>
								</tr>
								<tr>
									<th>병의원 이름</th>
									<td>서울병원</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>010 - 0000 - 0000</td>
								</tr>
								<tr>
									<th>국가</th>
									<td>오스트레일리아</td>
								</tr>
								<tr>
									<th>이메일 주소</th>
									<td>yakua@nate.com</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>(21106) 인천광역시 계양구 새풀로 7번길 32(효성동, 크리스탈타운) 11 - 11</td>
								</tr>
								<tr>
									<th>목표례수</th>
									<td>
										<input type="text" style="width:10%;">
									</td>
								</tr>
							</tbody>
						</table>



						
					
						
						<div class="agree_btn_01">
							<input type="button" class="big_button_01" value="계약요청">
							<input type="button" class="big_button_01 popup_01" value="계약서 미리보기">
						</div>
						
						
						
						
                	</div>
                </div>


      

                
                
                
                
            </section>
		</div>
	</section>
</div>
</html>