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

<script>
	function actionLogin() {
	    if (!$.trim($('#loginId').val())) {
	        alert('<spring:message code="login.message.2"/>');
	        return;
	    } 
	    
	    if (!$.trim($('#loginPassword').val())) {
	        alert('<spring:message code="login.message.3"/>');
	        return;
	    } 
	    
	    $.ajax({
 		    url: "<c:url value='/com/i01/pantheonUsrOverlapCheck.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {
 		    	'USER_ID' : $('#loginId').val(),
 		    	'PASSWORD': $('#loginPassword').val()
 		    },
 		    success:function(data){
 		    	if(data.success) {
 		    		
 		    		if(data.redirect) {
 		    			alert('<spring:message code="login.message.4"/>');
 		    			location.href="<c:url value='/com/anonymous/COMI0203.do'/>"
 		    			return;
 		    		}
 		    		
 		    		if(!data.OVERLAP) {
 		    			$('#loginFrm').submit();
 		    			return;
 		    		} else {
 		    			if(confirm('<spring:message code="login.message.5"/>')) {
 		    				$('#loginFrm').submit();
 		    			}
 		    		}
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
	}
	
	function fn_openNoticeDetail(v) {
		window.open("<c:url value='/com/anonymous/COMZ0402.do?NOTICE_SN='/>"+v, 'target','width=1175px, height=500, scrollbars=yes, menubar=no, status=no, toolbar=no');
	}
	
	function setCookie (name, value, expires) {
	    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
	}

	function getCookie(Name) {
	    var search = Name + "=";
	    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
	        offset = document.cookie.indexOf(search);
	        if (offset != -1) { // 쿠키가 존재하면
	            offset += search.length;
	            // set index of beginning of value
	            end = document.cookie.indexOf(";", offset);
	            // 쿠키 값의 마지막 위치 인덱스 번호 설정
	            if (end == -1)
	                end = document.cookie.length;
	            return unescape(document.cookie.substring(offset, end));
	        }
	    }
	    return "";
	}

	function saveid(form) {
	    var expdate = new Date();
	    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
	    if (form.chkBox01.checked)
	        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
	    else
	        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
	    setCookie("saveid", form.loginId.value, expdate);
	}
	
	function getid(form) {
	    form.chkBox01.checked = ((form.loginId.value = getCookie("saveid")) != "");
	}

	function fnInit() {
	    getid(document.loginFrm);
	    document.loginFrm.loginId.focus();
	}
	
	var loginFlag = false;
	
	$(function() {
		var Slider = $(".visualSlider").bxSlider({
			mode : 'fade', // 페이드로 슬라이드 된다.
			speed : 1000, // 이동 속도를 설정합니다.
			pause : 5000, // 슬라이드를 얼마나 멈추고, 이동할지 설정
			moveSlides : 1, // 슬라이드 이동시 갯수 설정.
			auto : true, // 자동으로 흐를지 설정합니다.
			autoHover : false, // 마우스 오버시 정시킬지 설정합니다.
			controls : false, // 이전 다음 버튼 노출 여부 설정합니다
			pager : false, //현재 위치를 나타내는 볼릿버튼 유무여부
		});
		
		$('#btnMore').click(function() {
			window.open("<c:url value='/com/anonymous/COMZ0401.do'/>", 'target','width=1250px, height=560, scrollbars=yes, menubar=no, status=no, toolbar=no');
		});
		
		$('#loginPassword').keypress(function(e) {
			if(e.keyCode == 13) {
				actionLogin();
			}
		});
		
		$('#loginBtn').click(function() {
			actionLogin();
		});
		
		fnInit();
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

			<img class="loginLogo" src="<c:url value='/images/pantheon/common/logoB.png'/>" alt="">

			<c:if test="${pageContext.response.locale eq 'kr'  || pageContext.response.locale eq 'ko_KR'}">
				<div class="loginLagSel">Korean<img class="mgL3" src="<c:url value='/images/pantheon/common/LoginLagSelArrow.png'/>" alt="">
			</c:if>
			<c:if test="${pageContext.response.locale eq 'jp'}">
				<div class="loginLagSel">日本語<img class="mgL3" src="<c:url value='/images/pantheon/common/LoginLagSelArrow.png'/>" alt="">
			</c:if>
			<c:if test="${pageContext.response.locale eq 'en'}">
				<div class="loginLagSel">ENGLISH<img class="mgL3" src="<c:url value='/images/pantheon/common/LoginLagSelArrow.png'/>" alt="">
			</c:if>
			
			<c:if test="${pageContext.response.locale eq 'ch_1'}">
				<div class="loginLagSel">簡体中文<img class="mgL3" src="<c:url value='/images/pantheon/common/LoginLagSelArrow.png'/>" alt="">
			</c:if>
			
			<c:if test="${pageContext.response.locale eq 'ch_2'}">
				<div class="loginLagSel">繁体中文<img class="mgL3" src="<c:url value='/images/pantheon/common/LoginLagSelArrow.png'/>" alt="">
			</c:if>
			
				<ul class="loginLagSelSub">
					<div class="arrow01"></div>
					<li class="loginLagSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=kr&URL='/>${LOCALE_RETURN}" >Korean</a></li>
					<li class="loginLagSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=en&URL='/>${LOCALE_RETURN}">ENGLISH</a></li>
					<li class="loginLagSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=jp&URL='/>${LOCALE_RETURN}">日本語</a></li>
					<li class="loginLagSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=ch_1&URL='/>${LOCALE_RETURN}">簡体中文</a></li>
					<li class="loginLagSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=ch_2&URL='/>${LOCALE_RETURN}">繁体中文</a></li>
				</ul>
			</div>

			<article class="loginBox">

				<div class="loginCon">

					<dl class="loginConDesc">
						<dt>Member Login</dt>
						<dd><spring:message code="login.message.1"/></dd>
					</dl>

					<form id="loginFrm" name="loginFrm" action="<c:url value='/com/i01/pantheonLoginUsr.do'/>" method="post">
						<%-- <form name="loginForm" action ="<c:url value='/uat/uia/actionLogin.do'/>" method="post"> --%>
						<fieldset class="loginFs">
							<div class="id_img"></div>
							<div class="pwd_img"></div>
							<input type="text" id="loginId" class="longinInput loginId" name="loginId" >
							<input type="password" id="loginPassword_fake" name="loginPassword_fake" placeholder=<spring:message code="login.input.1"/> autocomplete="off" style="display: none;">
							<input type="password" id="loginPassword" class="longinInput loginPassword" name="loginPassword" placeholder=<spring:message code="login.input.1"/>> 
							<input type="button" id="loginBtn" title=<spring:message code="login.input.2"/> alt=<spring:message code="login.input.2"/> value="login">
							<div class="loginAddBtn">
								<input type="checkbox" name="chkBox01" id="chkBox01" class="loginChkBoxLab" onClick="javascript:saveid(document.loginFrm);"><label for="chkBox01" class="loginChkBoxLab">
								<span><spring:message code="login.span.1"/></span></label> 
								<span class="loginfind"><a href="<c:url value='/com/anonymous/COMI0202.do?GUBUN=id&VIEW_GUBUN=Y'/>"><spring:message code="login.a.1"/></a> | <a href="<c:url value='/com/anonymous/COMI0202.do?GUBUN=pw&VIEW_GUBUN=Y'/>"><spring:message code="login.a.2"/></a></span>
							</div>
						</fieldset>
					</form>

				</div>

				<div class="loginNtcCon">
					<dl class="loginNtcDesc">
						<dt>Notice</dt>
					</dl>

					<button id="btnMore" class="moreBtn02">
						<span>more<div class="moreArrow"></div></span>
					</button>
					<hr class="loginNtcHr">
					<ul class="loginNtcUl">
					<c:forEach items="${ LIST_CM_NOTICE }" var="list_cm_notice">
						<li class="loginNtcLst" onclick="fn_openNoticeDetail(${list_cm_notice.NOTICE_SN})">
							<span class="loginTitle">${list_cm_notice.NOTICE_SJ}</span>
							<span class="loginNtcLstDate">${list_cm_notice.LAST_UPDDE}</span>
						</li>
					</c:forEach>			
					</ul>
				</div>
			</article>

			<footer id="loginFooter">

				<div class="copyright">Copyright 2016 CJ HealthCare. All rights reserved.</div>

				<div class="loginFnb">
					<a href="#"><spring:message code="login.footer.1"/></a> | <a href="#"><spring:message code="login.footer.2"/></a>
				</div>
			</footer>
		</section>
	</div>
</body>
</html>