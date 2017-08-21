<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false"/>

<title>전자계약</title>

<style>
#mainCon{ padding:0;}
.conBoxInner{min-height:840px; }
.join_01{ width:1000px; margin:0 auto;}

</style>

<script>
var vJoinTaskNo = '${JOIN_TASK_NO}';

function fn_actionNext() {
	document.frSubmit.action = "<c:url value='/com/anonymous/COMH0105.do'/>";
	document.frSubmit.submit();
}

$(function() {
	if(vJoinTaskNo) {
		$('#txtTaskNo').attr('readOnly', true);
	}
		
	$('#btnAgree').click(function() {
			
		if(!$.trim($('#txtTaskNo').val())) {
			alert('과제번호를 기입해 주십시오.');
			return;
		}
		
 		$.ajax({
 		    url: "<c:url value='/com/anonymous/selectEdcCrTaskCountForDupCheckByTaskNo.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {
 		    	'TASK_NO' : $('#txtTaskNo').val()
 		    },
 		    success:function(data){
 		    	if(data.success) {
 		    		
 		    		if(!data.count) {
 		    			alert('유효하지 않은 과제번호 입니다.');
 		    			return;
 		    		}
 		    		
 		    		fn_actionNext();
 		    		
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
</script>

</head>
<body>



<div id="wrap">
	<header id="topHeader">
		<a href="<c:url value='/Contract'/>"><img id="logo" src="<c:url value='/images/pantheon/common/logo.png'/>" alt=""></a>
	</header>

	<form:form commandName="frSubmit" name="frSubmit"  method="post">
	<section id="mainCon">
		<div class="mainConInner">
            <section class="conBox100 conBox">
             
                <div class="conBoxInner">
                	<div class="join_01">
						<h4>전자계약연구자가입</h4>
						<ul class="step_01">
							<li><span>약관동의</span></li>
							<li><span>본인인증</span></li>
							<li><span>정보입력</span></li>
							<li class="on"><span>계약안내</span></li>
							<li><span>계약요청</span></li>
							<li><span>계약요청완료</span></li>
						</ul>
							
						<div class="join_title_01">과제번호 : <input type="text" id="txtTaskNo" name="TASK_NO"class="pdR15" style="width:200px;" value="${JOIN_TASK_NO}"></div>
<!-- 						<div class="join_title_01">과제번호 : <input type="text" id="txtTaskNo" class="pdR15" style="width:200px;" value="CJ_A00_101"></div> -->
						
						<div style="text-align:center;">
							<img src="/images/pantheon/common/img_best1.jpg" alt="">
						</div>
						
						<div class="agree_btn_01">
							<input type="button" id="btnAgree" class="big_button_01" value="수락">
						</div>
						
						
                	</div>
                </div>
                
            </section>
		</div>
	</section>
	</form:form>
</div>
</html>