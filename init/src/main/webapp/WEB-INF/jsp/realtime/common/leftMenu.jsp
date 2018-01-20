<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
