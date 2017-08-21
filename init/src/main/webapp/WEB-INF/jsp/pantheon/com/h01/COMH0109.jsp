<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Author" content="RyuJiHyun">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=IE9" charset="utf-8">
<title>Login</title>
<link rel="shortcut icon" href="<c:url value='/images/pantheon/common/favicon.ico'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/login.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/common.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/contents.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/theme.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/font-awesome.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/axicon.css'/>">
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/bxslider.css'/>">
<script src="<c:url value='/js/pantheon/common/jquery-2.1.1.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/jquery-ui.min.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/jquery.mobile-events.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/jquery.bxslider.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/common.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/theme.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/layout.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/login.js'/>"></script>

<!--[if lt IE 9]>
  <script src="<c:url value='/js/pantheon/common/html5shiv.js'/>"></script>
  <script src="<c:url value='/js/pantheon/common/PIE.js'/>"></script>
  <script src="<c:url value='/js/pantheon/common/respond.min.js'/>"></script>
  <script src="<c:url value='https://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js'/>"></script>
  <script src="<c:url value='http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js'/>"></script>
  <script src="<c:url value='http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js'/>"></script>
  <![endif]-->

<style>
#loginWrap {width:600px; }
.loginBox {width:600px;   }
.loginCon {width:482px; margin:0 auto; height:auto; display: block; border:1px solid #ffffff; float: none; }
.loginConDesc{ margin-top: 40px;}
#loginFrm{top: 180px;}
#loginFooter {width:600px;}
.loginAddBtn{  height: auto; overflow: hidden;}
.loginfind{ float: left;}
.memberjoin{ float: right;}

</style>


<script>
function actionLogin() {
    if (!$.trim($('#loginId').val())) {
        alert('<spring:message code="comh01.message.1"/>');
        return;
    } else if (!$.trim($('#loginPassword').val())) {
//         alert("비밀번호를 입력하세요");
        alert('<spring:message code="comh01.message.1"/>');
        return;
    } 
    
    $.ajax({
		    url: "<c:url value='/com/anonymous/selectCmUserForContractReq.do'/>",
		    type: 'post',
		    dataType: 'json',
		    data: {
		    	'USER_ID' : $('#loginId').val(),
		    	'PASSWORD' : $('#loginPassword').val()
		    },
		    success:function(data){
		    	if(data.success) {
		    		$('#loginFrm').submit();
		    	} else {
		    		alert(data.message);
		    	}
		    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});

}

$(function(){
	$('#btnUserJoin').click(function() {
		location.href="<c:url value='/com/anonymous/COMH0101.do'/>";
	});
	
	$('#loginPassword').keypress(function(e) {
		if(e.keyCode == 13) {
			actionLogin();
		}
	});
	
	$('#loginBtn').click(function() {
		actionLogin();
	});
});
</script>
</head>
<body>

	<div id="wrap">

		<div id="Slider">
			<ul class="visualSlider">
				<li><div class="visualImg visualImg01"></div></li>
				<li><div class="visualImg visualImg02"></div></li>
				<li><div class="visualImg visualImg03"></div></li>
			</ul>
		</div>

		<section id="loginWrap">

			<img class="loginLogo" src="/images/pantheon/common/logoB.png"	alt="">

			<article class="loginBox">
				<div class="loginCon">
					<dl class="loginConDesc">
						<dt>Member Login</dt>
						<dd><spring:message code="comh01.dd.1" /></dd>
					</dl>
<!-- 					<form id="loginFrm" action="" method="post"> -->
					<form id="loginFrm" action="<c:url value='/com/anonymous/COMH0104.do'/>" method="post">
						<fieldset class="loginFs">
							<div class="id_img"></div>
							<div class="pwd_img"></div>
							<input type="text" id="loginId" class="longinInput loginId" name="" placeholder=<spring:message code="comh01.ph.1" />>
							<input type="password" id="loginPassword_fake" name="loginPassword_fake" placeholder=<spring:message code="comh01.ph.2" /> autocomplete="off" style="display: none;">
							<input type="password" id="loginPassword" class="longinInput loginPassword" name="" placeholder=<spring:message code="comh01.ph.2" />> 
							<input type="button" id="loginBtn" title="로그인버튼" alt="로그인버튼" value="login">
							<div class="loginAddBtn">
<!-- 								<span class="loginfind"> -->
<%-- 									<a href="#"><spring:message code="comh01.a.1" /></a> --%>
<!-- 									 |  -->
<%-- 									<a href="#"><spring:message code="comh01.a.2" /></a> --%>
<!-- 								</span> -->
								<span class="loginfind"><a href="<c:url value='/com/anonymous/COMI0202.do?GUBUN=id&VIEW_GUBUN=N'/>"><spring:message code="login.a.1"/></a> | <a href="<c:url value='/com/anonymous/COMI0202.do?GUBUN=pw&VIEW_GUBUN=N'/>"><spring:message code="login.a.2"/></a></span>
								<span class="memberjoin">
									<input id="btnUserJoin" type="button" value=<spring:message code="comh01.btn.1" />>
								</span>
							</div>
						</fieldset>
					</form>
				</div>
			</article>


			<footer id="loginFooter">

				<div class="copyright">Copyright 2016 CJ HealthCare. All rights reserved.</div>

				<div class="loginFnb">
					<a href="#"><spring:message code="comh01.a.3" /></a> | <a href="#"><spring:message code="comh01.a.4" /></a>
				</div>
			</footer>
		</section>
	</div>
</body>
</html>