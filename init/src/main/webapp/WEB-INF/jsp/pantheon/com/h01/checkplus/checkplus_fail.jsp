<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false"/>

<script>
$(function(){
	$('#btnClose').click(function(){
		window.close();
	});
});

</script>
<html>
<head>
    <title>NICE신용평가정보</title>
</head>
<body>
	<div class="error_01">
		<div class="error_02">
			<div class="error_img"><img src="/images/pantheon/common/img_error.png"></div>


			<ul class="error_txt">
				<li>${sMessage}</li>
			</ul>

			<div class="error_btn"><input type="button" id="btnClose" value="닫기"/></div>

		</div>
	</div>
</body>
</html>