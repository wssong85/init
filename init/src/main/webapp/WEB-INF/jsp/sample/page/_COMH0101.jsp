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
							<li class="on"><span>약관동의</span></li>
							<li><span>본인인증</span></li>
							<li><span>정보입력</span></li>
							<li><span>계약안내</span></li>
							<li><span>계약요청</span></li>
							<li><span>계약요청완료</span></li>
						</ul>
						
						<div class="join_title_01">과제번호 : <input type="text" id="" class="pdR15" style="width:200px;"></div>
						
						
						<div class="join_title_01" style="margin-top:0px;">약관동의</div>
						<div style="margin-top:0px;">1. 개인정보 수집, 제공 및 활용 동의</div>
						
						<div class="agreebox_01">
							<div class="agreebox_01div" style="height:300px;">
								<%@include file="./agree_01.jsp"%>
							</div>
						</div>
						
						<input type="checkbox" name="" id="c01" ><label for="c01" class="chcLab"><span>개인정보 수집, 제공 및 활용에 동의합니다.</span></label>
						
						
						<div style="margin-top:30px;">2. 개인정보 취급 위탁 동의</div>
						
						<div class="agreebox_01">
							<div class="agreebox_01div" style="height:300px;">
								<%@include file="./agree_02.jsp"%>
							</div>
						</div>
						
						<input type="checkbox" name="" id="c02"><label for="c02" class="chcLab"><span>개인정보 취급 위탁에 동의합니다.</span></label>

						

						
						<div class="agree_check_right">
							<input type="checkbox" name="" id="c03" ><label for="c03" class="chcLab"><span style="font-family:'NanumGothicBold';">전체 동의</span></label>
						</div>
						
						
						<div class="agree_btn_01">
							<input type="button" class="big_button_01" value="동의합니다.">
						</div>
                	</div>
                </div>


      

                
                
                
                
            </section>
		</div>
	</section>
</div>
</html>