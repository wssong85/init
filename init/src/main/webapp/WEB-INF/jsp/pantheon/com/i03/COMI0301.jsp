<%@page pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<!DOCTYPE HTML>
<html lang="ko">
 <head>
  <title>Intro</title>
  <link rel="stylesheet" href="<c:url value='/css/pantheon/common/intro.css'/>"> 
  <link rel="stylesheet" href="<c:url value='/css/pantheon/common/bxslider.css'/>"> 
  <script src="<c:url value='/js/pantheon/common/jquery.bxslider.js'/>"></script>
  <script src="<c:url value='/js/pantheon/common/common.js'/>"></script>
  <script src="<c:url value='/js/pantheon/common/intro.js'/>"></script>
  <!--[if lt IE 9]>
  <script src="<c:url value='/js/pantheon/common/html5shiv.js'/>"></script>
  <script src="<c:url value='/js/pantheon/common/PIE.js'/>"></script>
  <script src="<c:url value='/js/pantheon/common/respond.min.js'/>"></script>
  <script src="<c:url value='https://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js'/>"></script>
  <script src="<c:url value='http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js'/>"></script>
  <script src="<c:url value='http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js'/>"></script>
  <![endif]-->


<script>
var globalInterval = setInterval(convertTime, 1000);

function convertTime() {
	var test = $('#headerTimeData').text();
	var test2 = test.split(':');
	var test3 = (test2[0] * 60) + test2[1] * 1;
	
	if(!test3) {
		location.href = "<c:url value='/com/i01/pantheonLogout.do'/>";
	}
	
	var test4 = '';
	var test5 = '';
	
	test3 = test3 - 1;
	
	if(test3%60 < 10) {
		test4 = '0' + test3%60; 
	} else {
		test4 = test3%60;
	}
	
	if(parseInt(test3/60) < 10) {
		test5 = '0' + parseInt(test3/60); 
	} else {
		test5 = parseInt(test3/60);
	}
	
	$('#headerTimeData').text(test5 + ':' + test4);   	
}

function resetTime() {
	var test = $('#headerTimeData').text();
	var test2 = test.split(':');
	var test3 = (test2[0] * 60) + test2[1] * 1;
	
	if(test3 < 1740) {
		$('#headerTimeData').text('30:00');	
	}
}

// var id = "cjp_gamje06";
$(function(){
	var Slider=$(".visualSlider").bxSlider({
		mode: 'fade',            // 페이드로 슬라이드 된다.
		speed:1000,              // 이동 속도를 설정합니다.
		pause: 5000,       // 슬라이드를 얼마나 멈추고, 이동할지 설정
		moveSlides:1,         // 슬라이드 이동시 갯수 설정.
		auto:true,             // 자동으로 흐를지 설정합니다.
		autoHover:false,    // 마우스 오버시 정시킬지 설정합니다.
		controls:false,        // 이전 다음 버튼 노출 여부 설정합니다
		pager: false,     //현재 위치를 나타내는 볼릿버튼 유무여부
	});
	
	$('body').keydown(function(event){
		resetTime();		
	});
	
	$('body').mousemove(function(event){
		resetTime();
	});
	
	$("#aChgPassword").click(function(){
		if(!confirm('<spring:message code="header.message.4"/>')) {
			return;
		}
		
 		$.ajax({
 		    url: "<c:url value='/com/i02/updateCmUserForMainClick.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {},
 		    success:function(data){
 		    	if(data.success) {
 		    		var passwordUrl = "<c:url value='/com/anonymous/COMI0204.do?PASSWORD_CODE='/>";
					location.href = passwordUrl + data.result;
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
	});
});

var g_edc  = '${EDC}' ;
var g_ctms = '${CTMS}';
var g_sdb  = '${SDB}' ;
var g_com  = '${COM}' ;
var g_iwrs = '${IWRS}';
var g_dmc  = '${DMC}' ;

var eduType = "SYSTEM";
var callModule;
function fn_education(urlLink, module){
	switch(module){
	case "EDC" : //과제정보
		if(g_edc == "Y"){
			window.location.href = urlLink
		}
		else{
			callModule = module;
			var param={};
			mkLayerPopupOpen("/ctms/j03/popupDMCJ0304.do", param);
		}
		break;
	case "CTMS" : //기관정보
		if(g_ctms == "Y"){
			window.location.href = urlLink
		}
		else{
			callModule = module;
			var param={};
			mkLayerPopupOpen("/ctms/j03/popupDMCJ0304.do", param);
		}
		break;
	case "SDB" : //기관정보
		if(g_sdb == "Y"){
			window.location.href = urlLink
		}
		else{
			callModule = module;
			var param={};
			mkLayerPopupOpen("/ctms/j03/popupDMCJ0304.do", param);
		}
		break;
	case "COM" : //기관정보
		if(g_com == "Y"){
			window.location.href = urlLink
		}
		else{
			callModule = module;
			var param={};
			mkLayerPopupOpen("/ctms/j03/popupDMCJ0304.do", param);
		}
		break;
	case "IWRS" : //기관정보
		if(g_iwrs == "Y"){
			window.location.href = urlLink
		}
		else{
			callModule = module;
			var param={};
			mkLayerPopupOpen("/ctms/j03/popupDMCJ0304.do", param);
		}
		break;
	case "DMC" : //기관정보
		if(g_dmc == "Y"){
			window.location.href = urlLink
		}
		else{
			callModule = module;
			var param={};
			mkLayerPopupOpen("/ctms/j03/popupDMCJ0304.do", param);
		}
		break;
	
	default :

	} //switch
}
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



<section id="sstBtnBox">
	<div class="sstBtnBoxInner">

		<div class="intro_top">
			<header id="topHeader">
				<nav id="topMenu">
					<ul class="gnb">
<!-- 						<li><div class="gnbIco gnbIco02"></div><span>과제번호 : CJA011_00023</span></li> -->
						<li><div class="gnbIco gnbIco04"></div><span>${loginMap.USER_NM}</span></li>
						<li><div class="gnbIco gnbIco05"></div><span id="headerTimeData">30:00</span></li>
						<a href="/com/i01/pantheonLogout.do" >
							<li style="padding-left:0px; padding-right:0px; cursor: pointer; ">
								<div class="gnbIco gnbIco06"></div>
								<span><spring:message code="header.span.1"/></span>
							</li>
						</a>
						<a id="aChgPassword" href="#" >
						<li class="gnbmenu_008" style="padding-left:0px; padding-right:24px; margin-right:10px;cursor: pointer;">
							<div class="gnbIco gnbIco07"></div>
							<span><spring:message code="header.span.2"/></span>
						</li>
						</a>
					</ul>
				</nav>
			</header>
		</div>



	
		<ul class="sstBtn">
			<c:forEach items="${ result.list }" var="list">
				<c:choose>
					<c:when test="${list.MODULE_COUNT > 1 }">
						<li class="sstBtnLst sstBtnLst01"><span><a href="#">${list.MODULE_CODE}</a></span>
							<ul class="sstBtnSub">
							<c:forEach items="${ result.subList }" var="subList">
								<c:if test="${subList.MODULE_CODE eq list.MODULE_CODE}">
									<c:if test="${list.COMPLETE_YN eq 'Y'}">
										<li class="sstBtnSubLst"><a href="${subList.PROGRM_URL }">${subList.MENU_NM }</a></li>
									</c:if>
									<c:if test="${list.COMPLETE_YN eq null}">
										<li class="sstBtnSubLst"><a href="${subList.PROGRM_URL }">${subList.MENU_NM }</a></li>
									</c:if>
									<c:if test="${list.COMPLETE_YN eq 'N'}">
										<li class="sstBtnSubLst"><a href="#" onclick="fn_education('${subList.PROGRM_URL}','${list.MODULE_CODE}');">${subList.MENU_NM }</a></li>
									</c:if>
								</c:if>
							</c:forEach>
							</ul>	
						</li>
					</c:when>
					<c:otherwise>
							<c:forEach items="${ result.subList }" var="subList">
							<c:if test="${subList.MODULE_CODE eq list.MODULE_CODE}">
								<c:if test="${list.COMPLETE_YN eq 'Y'}">
									<a href="${subList.PROGRM_URL}"><li class="sstBtnLst sstBtnLst02"><span>${list.MODULE_CODE}</span></li></a>
								</c:if>
								<c:if test="${list.COMPLETE_YN eq null}">
									<a href="${subList.PROGRM_URL}"><li class="sstBtnLst sstBtnLst02"><span>${list.MODULE_CODE}</span></li></a>
								</c:if>
								<c:if test="${list.COMPLETE_YN eq 'N'}">
									<a href="#" onclick="fn_education('${subList.PROGRM_URL}','${list.MODULE_CODE}');"><li class="sstBtnLst sstBtnLst02"><span>${list.MODULE_CODE}</span></li></a>
								</c:if>
							</c:if>
							</c:forEach>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
</section>

</div>
</body>
</html>