<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
.check_yes{ position: relative; top:4px; margin:0px 0 0 10px; background:url(/images/pantheon/common/check_01.png) no-repeat 0px 0px; display: inline-block; width:16px; height:16px;}
.check_no{ position: relative; top:4px; margin:0px 0 0 10px; background:url(/images/pantheon/common/check_01.png) no-repeat 0px -53px; display: inline-block; width:16px; height:16px;}
</style>

<script>

function loadCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.ROLE_ID + ">" + this.ROLE_NM + "</option> ";
	});

	target.append(dataArr);
}

$(function(){
	$("#sign_1").hide();
	$("#sign_2").hide();
	
	$('#txtUserId2').keyup(function(e) {
		
		var vUserId = $('#txtUserId2').val();
		
		if(!$.trim(vUserId)) {
 			$("#sign_2").hide();
 			$("#sign_1").hide();
			return;
		}
		
    	if(!fn_CheckUserId(vUserId)) {
 			$("#sign_2").show();
 			$("#sign_1").hide();
			return;
			
    	} else {

    		if(($.trim(vUserId)) && ($.trim(vUserId).length > 4) && (vUserId.substring(0,4) != 'cjp_')) {
    			
    	 		$.ajax({
    	 		    url: "<c:url value='/com/anonymous/selectCmUserCountForDupCheck.do'/>",
    	 		    type: 'post',
    	 		    dataType: 'json',
    	 		    data: {
    	 		    	'USER_ID' : $('#txtUserId2').val()
    	 		    },
    	 		    doNotAjaxSetup: true,
    	 		    success:function(data){
    	 		    	if(data.success) {
    	 		    		if(data.count) {
    	 		    			$("#sign_2").show();
    	 		    			$("#sign_1").hide();
    	 		    		} else {
    	 		    			$("#sign_1").show();
    	 		    			$("#sign_2").hide();
    	 		    		}
    	 		    	} else {
    	 		    		alert(data.message);
    	 		    	}
    	 		    },
    				error : function(jqXHR, textStatus, errorThrown){
    					alert(textStatus);
    				}
    	 		});
    			
    		} else {
    			
				$("#sign_2").show();
				$("#sign_1").hide();
				
    		}
    		
    	}
	});
	
	$("#btnCreate").click(function() {
		if(!$('#selectRoles option:selected').val()) {
			alert('<spring:message code="comf0102.message.1"/>');
			return;
		}
		
		if($('#sign_1').css('display') == 'none') {
			alert('<spring:message code="comf0102.message.2"/>');
			return;
		}
		
		if(!$.trim($('#txtUserNm2').val())) {
			alert('<spring:message code="comf0102.message.3"/>');
			return;
		}
		
		var email = $('#txtEmail2').val();  
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
		 
		if(!$.trim(email)) {
			alert('<spring:message code="comf0102.message.4"/>');
			return;
		}
		 
		if(!regex.test(email)) {
			alert('<spring:message code="comf0102.message.5"/>');
			return;
		}
		
		var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
		var telNo = $('#txtTel01').val() + $('#txtTel02').val() + $('#txtTel03').val(); 	
		
		if(!$.trim(telNo)) {
			alert('<spring:message code="comf0102.message.6"/>');
			return;
		}
		
		if(!regExp.test(telNo)) {
			alert('<spring:message code="comf0102.message.7"/>');
			return;
		}
		
		var params = {
			'ROLE_ID' : $('#selectRoles option:selected').val(),
			'USER_ID' : $('#txtUserId2').val(),
			'USER_NM' : $.trim($('#txtUserNm2').val()),
			'EMAIL' : email,
			'TELNO' : telNo
		};
		
		//패스워드 발급
		if($('#chkPassword').is(':checked')) {
			params['SEND'] = 'Y';	
		}
		//패스워드 미발급
		else {
			params['SEND'] = 'N';
		}
				
		$.ajax({
			url : "<c:url value='/com/f01/insertCmUserForCreate.do'/>",
			type: 'post',
			dataType: 'json',
			data : params,
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					alert('<spring:message code="comf0102.message.8"/>');
					$("#btnClose").trigger('click');				  
				} else {
					alert(data.message);
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});

		
	});
	
	$("#btnClose").click(function() {
		layerClose();
	});
	
	$.ajax({
		url : "<c:url value='/com/b01/selectCmRoleForComboBox.do'/>",
		success : function(data) {
			loadCombo($("#selectRoles"), data.result);
            $("#selectRoles").val("");
		}
	});
});
</script>

<section class="popupWrap">
	<div class="popup wd600">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5><spring:message code="comf0102.title.1"/></h5>
			<article class="mgT5" style="h8eight:200px;">
				<table class="tb001">
					<colgroup>
						<col width="16%" />
						<col width="35%" />
						<col width="16%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="comf0102.th.1"/></th>
							<td>
								<input type="checkbox" name="CREATE_PASSWORD" id="chkPassword" checked=true><label for="chkPassword" class="chcLab"><span><spring:message code="comf0102.th.7"/></span></label>
							</td>
							<th><spring:message code="comf0102.th.2"/></th>
							<td>
								<select id="selectRoles" style="width:100%;">
									<option>===selected===</option>
<!-- 									<option value="">마스터</option> -->
<!-- 									<option value="">손님</option> -->
								</select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="comf0102.th.5"/></th>
							<td>
								<input type="text" id="txtUserId2" name="USER_ID" style="width:165px;ime-mode:disabled;">
								<div class="check_yes" id="sign_1"></div>
								<div class="check_no" id="sign_2"></div>
							</td>
							<th><spring:message code="comf0102.th.3"/></th>
							<td>
								<input type="text" id="txtUserNm2" name="USER_NM" style="width:100%;" />
							</td>
						</tr>
						<tr>
							<th><spring:message code="comf0102.th.4"/></th>
							<td>
								<input type="text" id="txtEmail2" name="EMAIL" style="width:100%;" />
							</td>
							<th><spring:message code="comf0102.th.6"/></th>
							<td>
								<input type="text" id="txtTel01" style="width:25%;"> - 
								<input type="text" id="txtTel02" style="width:30%;"> - 
								<input type="text" id="txtTel03" style="width:30%;">
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="btnCreate" value=<spring:message code="comf0102.btn.1"/>>
					<input type="button" id="btnClose" value=<spring:message code="comf0102.btn.2"/>>
				</div>
			</article>
		</div>
		</section>
	</div>
</section>
