<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	
<script type="text/javascript">
	$(function(){
		buttonActive();
	});
	
	function buttonActive(){
		$("#btnErrorSave").click(function(){
			if(!window.confirm("저장하시겠습니까?")){
				return;
			}
			
			if(!mkValidation()){
				return;
			}
			
			saveErrorInfo();
		});
		
		$("#btnClose").click(function(){
			layerClose();
		});
	}
	
	function saveErrorInfo(){
		var param = {
				USER_ID : $("#txtUserId").val(),
				PWD : $("#txtPassword").val(),
				RTUN_NO : "${RTUN_NO}",
				IP_CODE : "${IP_CODE}",
				DLVYMANAGE_CODE : "${DLVYMANAGE_CODE}",
				SN : "${SN}",
				INVNTRYMANAGE_CODE : "${INVNTRYMANAGE_CODE}",
				SUBJECT_CODE : "${SUBJECT_CODE}",
				VISIT_CODE : "${VISIT_CODE}",
				IP_ERROR_COMMENT : $("#txtReason").val(),
				IP_ERROR_CODE : $("input[name=iperror]:checked").val()
		};
		
		$.ajax({
			type : "POST",
			async : false,
			data : param,
			url : "/iwrs/e01/updateErrorInfo.do",
			success :function(data){
				if(data.result){
					alert(data.message);
					layerClose();
				}else{
					alert(data.message);
				}
			}
		});
	}
</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd560">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<h6>IP 오류등록</h6>
				<article class="mgT5">
					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>피험자</th>
								<td><label id="lblSubject">${ SUBJECT_CODE }</label></td>
							</tr>
							<tr>
								<th>방문</th>
								<td><label id="lblVisit">${ VISIT_LBL }</label></td>
							</tr>
							<tr>
								<th>IP코드</th>
								<td><label id="lblIpCode">${ IP_CODE }</label></td>
							</tr>
							<tr>
								<th>IP배정일</th>
								<td><label id="lblIpAsignDate">${ IPASIGN_DE }</label></td>
							</tr>
							<tr>
								<th>IP상태<span class='must_01'></span></th>
								<td>
									<input type="radio" id="rdoDamage" name="iperror" value="02" checked="checked" /><label for="rdoDamage">파손</label>
									<input type="radio" id="rdoOmission" name="iperror" value="01" /><label for="rdoOmission">분실</label>
								</td>
							</tr>
							<tr>
								<th>사유<span class='must_01'></span></th>
								<td style="padding:7px 6px 0px 7px;">
									<textarea id="txtReason" row="4" class="wd100Pct" valireqire="사유"></textarea>
								</td>
							</tr>
							<tr>
								<th>사용자아이디<span class='must_01'></span></th>
								<td><input type="text" id="txtUserId" valireqire="사용자아이디" /></td>
							</tr>
							<tr>
								<th>비밀번호<span class='must_01'></th>
								<td>
									<input type="password" id="txtPassword" class="longinInput loginPassword" valireqire="비밀번호" />
									<input type="password" id="txtPassword_fake" name="txtPassword_fake" placeholder="비밀번호" autocomplete="off" style="display: none;">
								</td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" id='hVisitCode' value="${VISIT_CODE }" />
					<input type="hidden" id="hTaskCode" value="${TASK_CODE }" />
					<input type='hidden' id="hRtunNo" value="${RTUN_NO }" />
					<input type="hidden" id="hDlvyManageCode" value="${DLVYMANAGE_CODE }" />
					<input type="hidden" id="hSn" value="${SN }" />
					<input type="hidden" id="hInvntryManageCode" value="${INVNTRYMANAGE_CODE }" />
				</article>
				<article class="mgT10">
					<div style="text-align:center">
						<input type="button" id="btnErrorSave" value="저장" />
						<input type="button" id="btnClose" value="닫기" />
					</div>
				</article>
			</div>
			</section>
		</div>
	</section>
</body>
</html>