<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="Author" content="RyuJiHyun">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>Document</title>
<link rel="stylesheet" type="text/css" href="/css/realtime/com/main_style.css">
<link rel="stylesheet" type="text/css" href="/css/realtime/com/reset.css">
<link rel="stylesheet" type="text/css" href="/css/realtime/com/font-awesome.css">
<link rel="stylesheet" type="text/css" href="/css/realtime/com/axicon.css">
<!-- <script src="js/jquery-2.1.1.js"></script> -->

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script src="/js/realtime/com/jquery-ui.min.js"></script>
<script src="/js/realtime/com/main_script.js"></script>

<!--[if lt IE 9]><script src="/js/html5shiv.js"></script><![endif]-->
<!--[if lt IE 9]><script src="/js/PIE.js"></script><![endif]-->

</head>

<body>
	<div id="wrap">

		<nav id="vertical_menu">
			<ul class="vertical_menu">
				<li class="vertical_menu_list"><a class="close" href="#">Home</a></li>
				<li class="vertical_menu_list has_sub"><a class="close"
					href="#">Products</a>
					<ul class="vertical_menu_sub close">
						<li class="vertical_menu_sub_list"><a href="#">Products1</a></li>
						<li class="vertical_menu_sub_list"><a href="#">Products2</a></li>
					</ul></li>
				<li class="vertical_menu_list has_sub"><a class="close"
					href="#">About</a>
					<ul class="vertical_menu_sub close">
						<li class="vertical_menu_sub_list"><a href="#">About1</a></li>
						<li class="vertical_menu_sub_list"><a href="#">About2</a></li>
					</ul></li>
				<li class="vertical_menu_list has_sub"><a class="close"
					href="#">Contact</a>
					<ul class="vertical_menu_sub close">
						<li class="vertical_menu_sub_list"><a href="#">Contact1</a></li>
						<li class="vertical_menu_sub_list"><a href="#">Contact2</a></li>
					</ul></li>
			</ul>
		</nav>

	</div>
	
	<div>
	${sessionScope.ROLE_MENUS}
<%-- 	${sessionScope.loginMap} --%>
	</div>
</body>
</html>