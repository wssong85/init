<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		$(function(){
			buttonActive();
		});
		
		function buttonActive(){
			$("#btnCancelSave").click(function(){
				if(!window.confirm("취소하시겠습니까?")){
					return;
				}
				
				if(!mkValidation()){
					return;
				}
				
				saveDeliveryCancelInfo();
			});
			
			$("#btnClose1").click(function(){
				if("${map.layer}" == "1"){
					layerClose(1);
				}else{
					layerClose();
				}
			});
		}
		
		function saveDeliveryCancelInfo(){
			var param = {
					user_id : $("#txtUserId").val(),
					pwd : $("#txtPass").val(),
					dlvy_requst_comment : $("#txtCancelMemo").val(),
					dlvymanage_code		: "${map.dlvymanage_code}",
					type				: "${map.type}"
			};
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : "/iwrs/c01/updateDeliveryCancelInfo.do",
				success :function(data){
					if(data.result){
						alert("취소하였습니다.");
						if("${map.layer}" == "1"){
							layerClose(1);
						}
						layerClose();
						gridDelivery.load();
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
		<div class="popup popup1 wd500">
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5>배송취소</h5>
					</article>
					<article class="mgT5">
						<table class="tb01">
							<tbody>
								<tr>
									<th>취소사유<span class='must_01'></th>
									<td><textarea id="txtCancelMemo" rows="4" class="wd100Pct" valireqire="취소사유"></textarea></td>
								</tr>
								<tr>
									<th>사용자아이디<span class='must_01'></th>
									<td><input type="text" id="txtUserId" valireqire="사용자아이디" /></td>
								</tr>
								<tr>
									<th>비밀번호<span class='must_01'></th>
									<td><input type="password" id="txtPass" valireqire="비밀번호" /></td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnCancelSave" value="저장" />
							<input type="button" id="btnClose1" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>
</body>
</html>