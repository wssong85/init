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


<script></script>
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
						<dd>아이디와 비밀번호를 입력 후, 로그인 버튼을 클릭 해주세요.</dd>
					</dl>
					<form id="loginFrm" action="" method="post">
						<fieldset class="loginFs">
							<div class="id_img"></div>
							<div class="pwd_img"></div>
							<input type="text" id="" class="longinInput loginId" name="" placeholder="아이디">
							<input type="password" id="" class="longinInput loginPassword" name="" placeholder="비밀번호"> 
							<input type="submit" id="loginBtn" title="로그인버튼" alt="로그인버튼" value="login">
							<div class="loginAddBtn">
								<span class="loginfind">
									<a href="#">아이디 찾기</a>
									 | 
									<a href="#">비밀번호찾기</a>
								</span>
								<span class="memberjoin">
									<input type="button" value="회원가입">
								</span>
							</div>
						</fieldset>
					</form>
				</div>
			</article>






			<footer id="loginFooter">

				<div class="copyright">Copyright 2016 CJ HealthCare. All rights reserved.</div>

				<div class="loginFnb">
					<a href="#">법적고시</a> | <a href="#">이메일무단수집거부</a>
				</div>
			</footer>
		</section>
	</div>
</body>
</html>