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
			$("#btnPopupSave").click(function(){
				if(!window.confirm("저장하시겠습니까?")){
					return;
				}
				if(!mkValidation()){
					return;
				}
				
				checkUser();
			});
			
			$("#btnClose").click(function(){
				layerClose();
			});
		}
		
		function checkUser(){
			var param = {
					USER_ID : $("#txtUserId").val(),
					PASSWORD : $("#txtPassword").val()
			};
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : "/iwrs/b01/selectUserInfo.do",
				success :function(data){
					if(data.result == "true"){
						${callbackFunction}($("#txtUserId").val());
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
		<div class="popup wd500">
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5>전자서명</h5>
					</article>
					<article class="mgT5">
						<table class="tb01">
							<tbody>
								<tr>
									<th>사용자아이디</th>
									<td><input type="text" id="txtUserId" valireqire="사용자아이디" /></td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input type="password" id="txtPassword" valireqire="비밀번호" /></td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnPopupSave" value="저장" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>	
</body>
</html>