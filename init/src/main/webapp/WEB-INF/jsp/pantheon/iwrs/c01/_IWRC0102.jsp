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
		$("#btnSave").click(function(){
			if(!window.confirm("저장하시겠습니까?")){
				return;
			}
			if(!mkValidation()){
				return;
			}
			
			saveDeliveryRequestInfo();
		});
		
		$("#btnClose").click(function(){
			layerClose();
		});
	}
	
	function saveDeliveryRequestInfo(){
		var param = {
				dlvy_requst_comment : $("#txtMemo").val(),
				user_id : $("#txtUserId").val(),
				pwd : $("#txtPassword").val()
		};
		
		$.ajax({
			type : "POST",
			async : false,
			data : param,
			url : "/iwrs/c01/insertDeliveryRequestInfo.do",
			success :function(data){
				if(data.result == "true"){
					alert("등록하였습니다.");
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
				<h6>인수확인</h6>
				<article class="mgT5">
					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Site</th>
								<td><label id="lblSite">헬스케어 기획팀</label></td>
							</tr>
							<tr>
								<th>메모</th>
								<td style="padding:7px 6px 0px 7px;">
									<textarea id="txtMemo" row="4" style="width:100%;"></textarea></td>
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
				</article>
				<article class="mgT10">
					<div style="text-align:center">
						<input type="button" id="btnSave" value="저장" />
						<input type="button" id="btnClose" value="닫기" />
					</div>
				</article>
			</div>
			</section>
		</div>
	</section>



</body>
</html>