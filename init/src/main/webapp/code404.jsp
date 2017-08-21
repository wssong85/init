<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<jsp:include page="/com/common.do" flush="false" />
<title></title>
<script type="text/javascript">
</script>
</head>

<body>
	<div class="error_01">
		<div class="error_02">
			<div class="error_img"><img src="/images/pantheon/common/img_error.png"></div>


			<ul class="error_txt">
			
				
				<li>HTTP 404 Error</li>
				<li>웹페이지를 찾을 수 없습니다.</li>
 				

<!-- 
				<li>HTTP 403 Error</li>
				<li>권한이 없습니다.</li>
 -->
				
				<!-- 
				<li>HTTP 500 Error</li>
				<li>서버 오류 입니다.</li>
				 -->
				
			</ul>
			

			<div class="error_btn"><input type="button" onclick="history.back()" value="이전 페이지"></div>


		</div>
	</div>
</body>




</html>