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
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<script type="text/javascript">
		$(function(){
			mkSetDatePickerYYMMDD("#txtDilyDate");
			setDeliInfo();
			createIpType();
			if("${deliInfo.DLVY_BGNDE}" == ""){
				$("#btnEdit").hide();
				$("#btnCancel").hide();
			}else{
				mkDisabled();
				$("#btnSave").hide();
				$(".ui-datepicker-trigger").hide();
			}
			buttonActive();
		});
		
		function setDeliInfo(){
			$("#lblSite").text("${deliInfo.INSTT_NAME}");
			$("#lblDeliDate").text("${deliInfo.DLVY_HOPEDE}");
			$("#hDlvyManageCode").val("${deliInfo.DLVYMANAGE_CODE}");
			if("${deliInfo.DLVY_BGNDE}" != ""){
				$("#txtDilyDate").val("${deliInfo.DLVY_BGNDE}");	
			}
			$("#txtMemo").val("${deliInfo.DLVY_CNFIRM_COMMENT}");
		}
		
		function createIpType(){
			var tableIpCode = "<table width='200px'>";
			<c:forEach var="ip" items="${list}" varStatus="status">
				tableIpCode += "<tr><th>${ip.IP_TYPE}</th>";
				tableIpCode += "<td><label>${ip.IP_CNT}</label></td>";
				tableIpCode += "<td><a href='javascript:showIpCode(\"${ip.IP_TYPE}\")'><span>IP보기</span></a></td></tr>";
			</c:forEach>
			tableIpCode += "</table>";
			$("#divIpInfo").append(tableIpCode);
		}
		
		function buttonActive(){
			$("#btnSave").click(function(){
				if(!window.confirm("저장하시겠습니까?")){
					return;
				}
				
				if(!mkValidation()){
					return;
				}
				
				var arrDileDate = $("#txtDilyDate").val().split("-");
				var requestDateArray = "${deliInfo.DLVY_RQESTDE}".split("-");
				
				var toDate = new Date();				
				var dileDate = new Date(arrDileDate[0], arrDileDate[1] - 1, arrDileDate[2], 0, 0, 0);
				var requestDate = new Date(requestDateArray[0], requestDateArray[1] - 1, requestDateArray[2], 0, 0, 0);
				
				if(dileDate.getTime() - toDate.getTime() > 0){
					alert("배송일은 미래일을 등록할 수 없습니다.");
					return;
				}
				
				if(dileDate.getTime() - requestDate.getTime() < 0){
					alert("배송완료일은 배송 요청일 보다 과거일을 등록할 수 없습니다.");
					return;
				}
				
				var param = {
					dlvymanage_code : $("#hDlvyManageCode").val(),
					deli_begin_date : $("#txtDilyDate").val().replace(/-/g, ""),
					dlvy_cnfirm_comment : $("#txtMemo").val(), 
					user_id : $("#txtUserId").val(),
					pass : $("#txtPass").val()
				};
				
				$.ajax({
					type : "POST",
					async : false,
					data : param,
					url : "/iwrs/c01/updateDeliveryConfirmInfo.do",
					success :function(data){
						if(data.result == "true"){
							alert("등록하였습니다.");
							layerClose();
							gridDelivery.load();
						}else{
							alert(data.message);
						}
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			});
			
			$("#btnEdit").click(function(){
				mkEnabled();
				$("#btnSave").show();
				$("#btnEdit").hide();
				$(".ui-datepicker-trigger").show();
			});
			
			$("#btnCancel").click(function(){
				if(!window.confirm("취소하시겠습니까?")){
					return;
				}
				
				var param = {
						dlvymanage_code : $("#hDlvyManageCode").val(),
						type : "04",
						layer : "1"
					};
				mkLayerPopupOpen("/iwrs/c01/popupIwrc0105.do", param, 1);
			});
			
			$("#btnClose").click(function(){
				layerClose();
			});
		}
		
		function showIpCode(ipType){
			var param = {
					DLVYMANAGE_CODE : "${deliInfo.DLVYMANAGE_CODE}",
					IP_TYPE : ipType
			};
			mkLayerPopupOpen("/iwrs/c01/popupIwrc0113.do", param, 1);
			AUIGrid.resize(gridIpList.id);
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd500">
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5>배송확인</h5>
					</article>
					<article class="mgT5">
						<table class="tb01">
							<colgroup>
								<col style="width:30%"/>
								<col style="width:70%"/>
							</colgroup>
							<tbody>
								<tr>
									<th>Site</th>
									<td><label id="lblSite"></label></td>
								</tr>
								<tr>
									<th>배송희망일</th>
									<td><lable id="lblDeliDate"></lable></td>
								</tr>
								<tr>
									<th>배송일</th>
									<td><div class="dateBox"><input type="text" id="txtDilyDate" able valireqire="배송일" validate="배송일" /></div></td>
								</tr>
								<tr>
									<th>배송메모</th>
									<td><textarea id="txtMemo" class="wd100Pct" row="4" able></textarea></td>
								</tr>
								<tr>
									<th>IP코드</th>
									<td><div id="divIpInfo"></div></td>
								</tr>
								<tr>
									<th>사용자아이디</th>
									<td><input type="text" id="txtUserId" valireqire="사용자아이디" /></td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input type="password" id="txtPass" valireqire="비밀번호" /></td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<input type="hidden" id="hDlvyManageCode" />
						<div style="text-align:center;">
							<input type="button" id="btnSave" value="저장" />
							<input type="button" id="btnEdit" value="수정" />
							<input type="button" id="btnCancel" value="배송취소" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>
</body>
</html>