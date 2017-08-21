<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false"/>

<title>테스트</title>
<script>
$(function(){
	
	$('#transactionTest').click(function(){
		$.ajax({
		    url: "<c:url value='/com/anonymous/transactionTest.do'/>",
		    type: 'post',
		    dataType: 'json',
		    success:function(data){
		    	if(data.success) {
		    		alert(data.result);
		    	} else {
		    		alert(data.message);
		    	}
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});
	
	$('#mailTest').click(function(){
		$.ajax({
		    url: "<c:url value='/com/anonymous/mailTest.do'/>",
		    type: 'post',
		    dataType: 'json',
		    data: {
		    	'MAIL' : $('#txtMail').val()
		    },
		    success:function(data){
		    	if(data.success) {
		    		alert(data.result);
		    	} else {
		    		alert(data.message);
		    	}
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
		
	});
	
	$('#smsTest').click(function(){
		$.ajax({
		    url: "<c:url value='/com/anonymous/smsTest.do'/>",
		    type: 'post',
		    dataType: 'json',
		    data: {
		    	'SMS' : $('#txtSms').val()
		    },
		    success:function(data){
		    	if(data.success) {
		    		alert(data.result);
		    	} else {
		    		alert(data.message);
		    	}
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
		
	});
	
	$('#drmTest').click(function(){
		$.ajax({
		    url: "<c:url value='/com/anonymous/drmTest.do'/>",
		    type: 'post',
		    dataType: 'json',
		    success:function(data){
		    	if(data.success) {
		    		alert(data.result);
		    	} else {
		    		alert(data.message);
		    	}
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
		
	});
	
	$('#openOfficeTest').click(function(){
		$.ajax({
		    url: "<c:url value='/com/anonymous/openOfficeTest.do'/>",
		    type: 'post',
		    dataType: 'json',
		    success:function(data){
		    	if(data.success) {
		    		alert(data.result);
		    	} else {
		    		alert(data.message);
		    	}
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});
	
	$('#damoTest').click(function(){
		$.ajax({
		    url: "<c:url value='/com/anonymous/damoTest.do'/>",
		    type: 'post',
		    dataType: 'json',
		    success:function(data){
		    	if(data.success) {
		    		alert(data.result);
		    		alert(data.result2);
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
<body>
<h>테이블이름은 "TEST" 이니, TEST 테이블의 전 데이타를 확인하고 데이터가 들어가 있으면 실패, 안들어가 있으면 성공이다. </h>
<br>
<input type="button" id="transactionTest" value="transaction test">
<br>

<h>받을 메일주소 적으시오. 없을시 default는 wssong한테 메일 감</h>
<br>
mail주소:<input type="text" id="txtMail" value=""/>
<br>
<input type="button" id="mailTest" value="mail test">
<br>

<h>받을 sms번호를 적으시오. 없을시 default는 wssong한테 문자 감 * 성공이 나왔는데 문자가 안온다면, 같은 내용을 다시 보냈는지 확인한다. 다른 휴대폰 번호로 보내본다. 아니면 sms html 의 값을 변경해서 보내본다.</h>
<br>
sms번호:<input type="text" id="txtSms" value=""/>
<br>
<input type="button" id="smsTest" value="sms test">
<br>

<h>경로:C:/pantheon/fasoo/fsdinit , drm테스트파일:C:/test/drm/drm_sample.xlsx, drm푼파일:C:/test/drm/drm_sample2.xlsx</h>
<br>
<input type="button" id="drmTest" value="drm test">
<br>

<h>8100 port 에 붙는지 확인한다.</h>
<br>
<input type="button" id="openOfficeTest" value="openoffice test">
<br>

<h>정상적으로 암/복호화 하는지 alert창 확인</h>
<br>
<input type="button" id="damoTest" value="damo test">
</body>
</html>