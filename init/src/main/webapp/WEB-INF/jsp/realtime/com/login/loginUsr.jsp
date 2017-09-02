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
	 <title>Document</title>
	 <link rel="stylesheet" type="text/css" href="/css/realtime/com/common.css" > 
	 <script type="text/javascript" src="/js/realtime/com/jquery-1.11.3.min.js"></script>
	 <!--[if lt IE 9]><script src="/js/html5shiv.js"></script><![endif]-->
	 <!--[if lt IE 9]><script src="/js/PIE.js"></script><![endif]-->

	<script>
	$(function() {
		$('#loginBtn').click(function() {
			$('#loginFrm').submit();
		});
	});	
	</script>	 
</head>

<body>

	<div class="wrapper">
		<div class="form" id="log-in-form">
			<form id="loginFrm" name="loginFrm" action="<c:url value='/com/login/processLoginUsr.do'/>" method="post">
				<input type="text" id="loginId" name="loginId" class="input-std" id="id" placeholder="id">
				<input type="password" id="loginPassword" name="loginPassword" class="input-std"  placeholder="password">
				<button type="button" id="loginBtn" class="btn-submit" id="log-in">Log-In</button>
			</form>
		</div>
	</div>

</body>

</html>