<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/js/realtime/com/jquery-1.11.3.min.js"></script>
<!-- <script type="text/javascript" src="/js/realtime/com/jquery-ui.min.js"></script> -->
<!-- <script type="text/javascript" src="/js/realtime/com/jquery.form.min.js"></script> -->
<!-- <script type="text/javascript" src="/js/realtime/com/AUIGrid.js"></script> -->
<script>

$(function() {
	$('#loginBtn').click(function() {
		$('#loginFrm').submit();
	});
});

</script>
<title>Insert title here</title>
</head>
<body>
	<form id="loginFrm" name="loginFrm" action="<c:url value='/com/login/processLoginUsr.do'/>" method="post">
		<input type="text" id="loginId" name="loginId" >
		<input type="password" id="loginPassword" name="loginPassword"> 
		<input type="button" id="loginBtn"/>
	</form>
</body>
</html>