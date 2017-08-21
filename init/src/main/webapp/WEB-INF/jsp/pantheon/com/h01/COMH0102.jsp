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
</style>

<script>
var retNameVal = '';

function fn_actionNext() {
	
	if(!retNameVal) {
		return;
	}
	$('#hdUserName').val(retNameVal);

	//테스트
// 	$('#hdUserName').val("송원석");
	
	document.frSubmit.action = "<c:url value='/com/anonymous/COMH0103.do'/>";
	document.frSubmit.submit();
}

$(function() {
	$('#btnSelfAuthentication').click(function() {
		
		fnPopup();
		
		//테스트
// 		fn_actionNext()
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
		<input type="hidden" id="hdUserName" name="USER_NAME" />
	</form:form>
	<section id="mainCon">
		<div class="mainConInner">
            <section class="conBox100 conBox">
             
                <div class="conBoxInner">
                	<div class="join_01">
						<h4>전자계약연구자가입</h4>
						<ul class="step_01">
							<li><span>약관동의</span></li>
							<li class="on"><span>본인인증</span></li>
							<li><span>정보입력</span></li>
							<li><span>계약안내</span></li>
							<li><span>계약요청</span></li>
							<li><span>계약요청완료</span></li>
						</ul>
						
						<div class="join_title_01">본인인증</div>
						
	
						<div class="agreebox_01">
							<div class="agreebox_01div" style="height:300px;">
								<%@include file="./agree_03.jsp"%>
							</div>
						</div>
						
						<div class="agree_btn_01">
							<input type="button" id="btnSelfAuthentication" class="big_button_01" value="본인인증">
						</div>
						<c:import url="/com/anonymous/checkplus_main.do" charEncoding="utf-8"/>
                	</div>
                </div>
                
            </section>
		</div>
	</section>
</div>
</html>