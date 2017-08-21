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
				<li>알 수 없는 오류가 발생했습니다.</li>
			</ul>

			<div class="error_btn"><input type="button" onclick="history.back()" value="이전 페이지"></div>

		</div>
	</div>
</body>

</html>