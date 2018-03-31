<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
	 <meta charset="UTF-8">
	 <meta name="Author" content="">
	 <meta name="Keywords" content="">
	 <meta name="Description" content="">
	 <title>관리자 로그인</title>
	 
	<script type="text/javascript" src="/js/realtime/com/jquery-1.11.3.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="/css/realtime/bootstrap-3.3.2-dist/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="/css/realtime/bootstrap-3.3.2-dist/css/bootstrap-theme.min.css">
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="/css/realtime/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
	
	<style>
	  body {
    padding-top: 120px;
    padding-bottom: 40px;
    background-color: #eee;
  
  }
  .btn 
  {
   outline:0;
   border:none;
   border-top:none;
   border-bottom:none;
   border-left:none;
   border-right:none;
   box-shadow:inset 2px -3px rgba(0,0,0,0.15);
  }
  .btn:focus
  {
   outline:0;
   -webkit-outline:0;
   -moz-outline:0;
  }
  .fullscreen_bg {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-size: cover;
    background-position: 50% 50%;
    background-image: url('/images/realtime/login3.jpg');
    background-repeat:repeat;
  }
  .form-signin {
    max-width: 280px;
    padding: 15px;
    margin: 0 auto;
      margin-top:50px;
  }
  .form-signin .form-signin-heading, .form-signin {
    margin-bottom: 10px;
  }
  .form-signin .form-control {
    position: relative;
    font-size: 16px;
    height: auto;
    padding: 10px;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
  }
  .form-signin .form-control:focus {
    z-index: 2;
  }
  .form-signin input[type="text"] {
    margin-bottom: -1px;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    border-top-style: solid;
    border-right-style: solid;
    border-bottom-style: none;
    border-left-style: solid;
    border-color: #000;
  }
  .form-signin input[type="password"] {
    margin-bottom: 10px;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    border-top-style: none;
    border-right-style: solid;
    border-bottom-style: solid;
    border-left-style: solid;
    border-color: rgb(0,0,0);
    border-top:1px solid rgba(0,0,0,0.08);
  }
  .form-signin-heading {
    color: #fff;
    text-align: center;
    text-shadow: 0 2px 2px rgba(0,0,0,0.5);
  }
	</style>
	<script>
	$(function() {
		$('#loginBtn').click(function() {
			console.log('1');
			$('#loginFrm').submit();
		});
	});	
	</script>	 
</head>

<body>

	<div id="fullscreen_bg" class="fullscreen_bg"/>

	<div class="container">
	
		<form class="form-signin" id="loginFrm" name="loginFrm" action="<c:url value='/com/login/processLoginUsr.do'/>" method="post">
			<h1 class="form-signin-heading text-muted">시스템 관리</h1>
			
			<input id="loginId" name="loginId" type="text" class="form-control" placeholder="Id" required="" autofocus="">
			<input id="loginPassword" name="loginPassword" type="password" class="form-control" placeholder="Password" required="">
<!-- 			<button class="btn btn-lg btn-primary btn-block" type="submit"> -->
			<button class="btn btn-lg btn-warning btn-block" type="submit" id="loginBtn">
				로그인
			</button>
		</form>
	
	</div>
	
	
	<div class="container">
	<h1 class="form-signin-heading text-muted">- ABC SOFT</h1>
	</div>
</body>

</html>