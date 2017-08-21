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

var retNameVal = '';
var compareName = '${REQ_INFO.USER_NM}';

function fn_actionNext() {
	
	if(!retNameVal) {
		return;
	}
	
	if(retNameVal != compareName) {
		alert('본인인증한 연구자이름이 같지 않습니다.');
		return;
	}
	$.ajax({
	    url: "<c:url value='/com/anonymous/insertCtmsCoCntrctManageForJoin.do'/>",
	    type: 'post',
	    dataType: 'json',
	    data: {
	    	'GOAL_NO' : $('#txtGoalNo').val(),
	    	'USER_ID' : '${REQ_INFO.USER_ID}'
	    },
	    success:function(data){
	    	if(data.success) {
	    		document.frSubmit.action = "<c:url value='/com/anonymous/COMH0106.do'/>";
	    		document.frSubmit.submit();
	    	} else {
	    		alert(data.message);
	    	}
	    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}

$(function(){
	// 팝업레이어
	$('.popup_01').click(function(){
		
		if(!$.trim($('#txtGoalNo').val())) {
			alert('목표례수를 입력하십시오.');
			return;
		}	
		
		var viewer = "<c:url value='/js/pantheon/com/pdf2/web/viewer.html?file='/>";
		var schme = '${pageContext.request.scheme}';			
		var serverName = '${pageContext.request.serverName}';			
		var serverPort = '${pageContext.request.serverPort}';
		var contextPath = '${pageContext.request.contextPath}';
		var fileUrl = schme + "://" + serverName + ":" + serverPort +"/" + contextPath + '/com/anonymous/pdfActionView.do?FILE_NAME=';
		
 		$.ajax({
 		    url: "<c:url value='/com/anonymous/selectEdcCrTaskForWord.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {
 		    	'USER_ID' : '${REQ_INFO.USER_ID}',
 		    	'TASK_NO' : '${JOIN_TASK_NO}',
 		    	'GOAL_NO' : $('#txtGoalNo').val() 
 		    },
 		    success:function(data){
 		    	if(data.success) {
					window.open(viewer + fileUrl + data.result, "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});

	});
	
	$('#txtGoalNo').mkNumber();

	$('#btnContractReq').click(function(){
		if(!$.trim($('#txtGoalNo').val())) {
			alert('목표례수를 입력하십시오.');
			return;
		}	
		
		fnPopup();
		
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
	</form:form>
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
							<li><span>계약안내</span></li>
							<li class="on"><span>계약요청</span></li>
							<li><span>계약요청완료</span></li>
						</ul>
						
						
						
						
						<div class="join_title_01">계약요청 내용</div>
						


						<table class="tb001">
							<colgroup>
								<col width="20%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td>${REQ_INFO.USER_ID}</td>
								</tr>
								<tr>
									<th>연구자 이름</th>
									<td>${REQ_INFO.USER_NM}</td>
								</tr>
								<tr>
									<th>병의원 이름</th>
									<td>${REQ_INFO.HSPTL_NM}</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td>${REQ_INFO.TELNO}</td>
								</tr>
								<tr>
									<th>국가</th>
									<td>${REQ_INFO.STD_TIME_NM}</td>
								</tr>
								<tr>
									<th>이메일 주소</th>
									<td>${REQ_INFO.EMAIL}</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>${REQ_INFO.ADDR}</td>
								</tr>
								<tr>
									<th>목표례수</th>
									<td>
										<input type="text" id="txtGoalNo" name="GOAL_NO" style="width:10%; ime-mode:disabled;" max="10">
									</td>
								</tr>
							</tbody>
						</table>
						
					
						<c:import url="/com/anonymous/checkplus_main.do" charEncoding="utf-8"/>				
						<div class="agree_btn_01">
							<input type="button" id="btnContractReq" class="big_button_01" value="계약요청">
							<input type="button" class="big_button_01 popup_01" value="계약서 미리보기">
						</div>
						
						
						
						
                	</div>
                </div>

                
            </section>
		</div>
	</section>
</div>
</html>