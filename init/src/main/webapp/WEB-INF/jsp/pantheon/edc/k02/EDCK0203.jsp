<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />


<title></title>
<style>
</style>
<script type="text/javascript">
	$(document).ready(function() {
		alert("개발중");
		fn_moveTab('EDCK0202');

		if ($("#frm_main #TASK_SN").val() == "") {
			alert('<spring:message code="edc.taskSelect.msg" />');
			location.replace("./EDCK0201.do");
		} else {

			$("#tab ul li").click(function() {
				if ($("#frm_main #EDC_VER").val() == "") {
					$("#tab_menu1").addClass("port_back").siblings().removeClass("port_back");
				}
			});

		}
	});
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0203&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0203&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>EDC Designer</h3>
					<nav id="pathNav">
						<ul>
							<li>
								<img src="/images/pantheon/common/pathNavIco.png" alt="">Home
							</li>
							<li>과제관리</li>
							<li>EDC Designer</li>
						</ul>
					</nav>
				</article>


				<section class="conBox100 conBox">
					<div class="conBoxInner">

						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_menu1" class="tab_menu" onclick="fn_moveTab('EDCK0202');">CRF List</li>
								<li id="tab_menu2" class="port_back tab_menu">Template</li>
								<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0204');">Group</li>
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
								<li id="tab_menu5" class="tab_menu" onclick="fn_moveTab('EDCK0208');">Dictionary</li>
								<li id="tab_menu6" class="tab_menu" onclick="fn_moveTab('EDCK0209');">Layout</li>
								<li id="tab_menu7" class="tab_menu" onclick="fn_moveTab('EDCK0212');">Edit Check</li>
								<li id="tab_menu8" class="tab_menu" onclick="fn_moveTab('EDCK0214');">T-Domain</li>
							</ul>
						</div>

						<article class="conTitBox">
							<h5>
								<label id="tabTitle">${ TASK_NO } - ${ EDC_VER }</label>
							</h5>
						</article>

						<div class="conTitBtnR"></div>

						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
							<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
						</form>
					</div>
			</div>
		</section>
	</div>
</body>
</html>