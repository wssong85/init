<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/common/common.do" flush="false"/>

</head>

<title>메인 화면</title>
<body>

	<!-- wrapper -->
	<div id="wrapper">
    	<!-- 레프트 메뉴고정이 필요할 경우 -->
		<c:import url="/common/leftMenu.do" charEncoding="utf-8"/>
			
        <!-- Page Content -->
        <div id="page-content-wrapper">
        	<button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas">
        		<span class="hamb-top"></span>
            	<span class="hamb-middle"></span>
            	<span class="hamb-bottom"></span>
          	</button>
          	<div class="container">
          		<div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
<%--                         <p>${ROLE_MENUS}</p> --%>
                        <p>환영한다. ${loginMap.USER_ID}</p>
                        
                        <p>밥은 먹고 댕김?</p>
                    </div>
                </div>
			</div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->
    
</body>
</html>