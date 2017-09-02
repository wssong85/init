<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/common/common.do" flush="false"/>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/realtime/com/intro.css" >

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<title>메인 화면</title>

<script type="text/javascript">
	$(document).ready(function () {
	  var trigger = $('.hamburger'),
	      overlay = $('.overlay'),
	     isClosed = false;

	    trigger.click(function () {
	      hamburger_cross();      
	    });

	    function hamburger_cross() {

	      if (isClosed == true) {          
	        overlay.hide();
	        trigger.removeClass('is-open');
	        trigger.addClass('is-closed');
	        isClosed = false;
	      } else {   
	        overlay.show();
	        trigger.removeClass('is-closed');
	        trigger.addClass('is-open');
	        isClosed = true;
	      }
	  }
	  
	  $('[data-toggle="offcanvas"]').click(function () {
	        $('#wrapper').toggleClass('toggled');
	  });  
	});
</script>

</head>

<body>

	<!-- wrapper -->
	<div id="wrapper">
		<div class="overlay"></div>
    
        <!-- Sidebar -->
        <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
        	<ul class="nav sidebar-nav">
        		<li class="sidebar-brand">
                    <a href="#">Awesome realtime</a>
                </li>
                
                <c:set var="isFirst" value="true" />
                
                <c:forEach var="menu" items="${sessionScope.ROLE_MENUS}" varStatus="status">
                	<c:choose>
					    <c:when test="${menu.LV eq '1'}">
					    	<c:if test="${not isFirst}">
					    			</ul>
					    		</li>
					    	</c:if>
					    	
					    	<li class="dropdown">
		                    	<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-fw fa-plus"></i> ${menu.MENU_NM}</a>
		                    	<ul class="dropdown-menu" role="menu">
		                    		<li class="dropdown-header" style="display:none">일단쓰지않음</li>
	                    	<c:set var="isFirst" value="false" />
					    </c:when>
					    <c:otherwise>
		                	<!-- <li class="dropdown-header">Dropdown heading</li> -->
		                    <li><a href="${menu.PROGRAM_URL}">${menu.MENU_NM}</a></li>
					    </c:otherwise>
					</c:choose>
                </c:forEach>
                	</ul>
				</li>
            </ul>
        </nav>
        <!-- /#sidebar-wrapper -->

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
                        <p>${sessionScope.ROLE_MENUS}</p>
                    </div>
                </div>
			</div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->
    
</body>
</html>