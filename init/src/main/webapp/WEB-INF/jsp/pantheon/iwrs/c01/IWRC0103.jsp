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
			//$("#txtDilyDate").datepicker({minDate : 0});
			<c:forEach var="result" items="${insttlist}" varStatus="status">
				$("#sltSite").append("<option value='<c:out value="${result.INSTT_CODE}"/>'>" + '<c:out value="${result.NAME1}"/>' + "</option>");
			</c:forEach>
			mkSetDatePickerYYMMDD("#txtDilyDate");
			createIpType();
			
			buttonActive();
			
			if("${deliInfo.DLVY_REQUST_OCCRRNC_CODE}" == "01"){
				setDeliInfo();
				mkDisabled();
				$(".ui-datepicker-trigger").hide();
				$("#btnSave").val("승인");
				$("#sltSite").removeAttr("able");
			}else if("${deliInfo.DLVYMANAGE_CODE}" != ""){
				setDeliInfo();
				mkDisabled();
				$("#btnSave").hide();
				$(".ui-datepicker-trigger").hide();
				$("#sltSite").removeAttr("able");
			}else{
				$("#btnEdit").hide();
				$("#btnCancel").hide();
				$("#sltSite").val("${INSTT_CODE}").attr("selected", true);
				if("${INSTT_CODE}" != ""){
					$("#sltSite").attr("disabled", true);
				}
			}
		});

		
		function createIpType(){
			var tableIpType = "<table class='tb01'><thead><tr>";
			var tableIpCnt = "<table  class='tb01'><tbody><tr>";
			var txtControllers = "";
			<c:forEach var="ipType" items="${ipType}" varStatus="status">
				tableIpType += "<th style='width:'" + 100 / ${ipType.size()} + "%;'>";
				tableIpType += "${ipType.IP_TYPE}";
				tableIpType += "</td>";
				tableIpCnt += "<td style='width:'" + 100 / ${ipType.size()} + "%;'>";
				tableIpCnt += "<input type='text' id='txt${ipType.IP_TYPE}' style='width:100%;' able valireqire='${ipType.IP_TYPE}' valinum='${ipType.IP_TYPE}' />";  
				tableIpCnt += "<input type='hidden' id='h${ipType.IP_TYPE}' value='${ipType.SN}' />";
				tableIpCnt += "</td>";
				if(txtControllers == ""){
					txtControllers += "#txt${ipType.IP_TYPE}";
				}else{
					txtControllers += ", #txt${ipType.IP_TYPE}";
				}
			</c:forEach>
			tableIpType += "</tr></thead></table>";
			tableIpCnt += "</tr></tbody></table>";
			$("#divIpType").append(tableIpType);
			$("#divIpCnt").append(tableIpCnt);
			$(txtControllers).mkNumber();
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
				
				var toDate = new Date();				
				var dileDate = new Date(arrDileDate[0], arrDileDate[1] - 1, arrDileDate[2], 23, 59, 59);
				
				if(dileDate.getTime() - toDate.getTime() < 0){
					alert("배송희망일은 과거일을 등록할 수 없습니다.");
					return;
				}
								
				var cnt = 0;
				var ipType = "[ ";
				<c:forEach var="ipType" items="${ipType}" varStatus="status">
					if(cnt == 0){
						ipType += "{\"ipType\" : \"${ipType.IP_TYPE}\", \"ipCnt\" : \"" + $("#txt${ipType.IP_TYPE}").val() + "\", \"SN\" : \"" + $("#h${ipType.IP_TYPE}").val() + "\"}";
					}else{
						ipType += ",{\"ipType\" : \"${ipType.IP_TYPE}\", \"ipCnt\" : \"" + $("#txt${ipType.IP_TYPE}").val() + "\", \"SN\" : \"" + $("#h${ipType.IP_TYPE}").val() + "\"}";
					}
					cnt++;
				</c:forEach>
				ipType += "]";
				console.log(ipType);
				var param = [{
					instt_code : $("#sltSite option:selected").val(),
					task_code : "1",
					deli_request_date : $("#txtDilyDate").val().replace(/-/g, ""),
					iptype : $.parseJSON(ipType), 
					memo : $('#txtMemo').val(),
					user_id : $("#txtUserId").val(),
					pass : $("#txtPass").val(),
					dlvymanage_code : '${deliInfo.DLVYMANAGE_CODE}'
				}];
				
				var url = "";
				if("${deliInfo.DLVYMANAGE_CODE}" == ""){
					url = "/iwrs/c01/insertDeliveryCountRequestInfo.do";
				}else{
					url = "/iwrs/c01/updateDeliveryInfo.do";
				}
				
				$.ajax({
					type : "POST",
					async : false,
					data : {data : JSON.stringify(param) },
					url : url,
					success :function(data){
						if(data.result == "true"){
							alert("등록하였습니다.");
							if("${PAGE_ID}" == "IWRC0101"){
								gridDelivery.load();
							}else{
								updateRequestInfo("${INSTT_CODE}", "${DLVYREQUSTMANAGE_CODE}");
								gridRequest.load();
							}
							layerClose();
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
						dlvymanage_code : '${deliInfo.DLVYMANAGE_CODE}',
						type : "02",
						layer : "1"
					};
				mkLayerPopupOpen("/iwrs/c01/popupIwrc0105.do", param, 1);
			});
			
			$("#btnClose").click(function(){
				layerClose();
			});
		}
		
		function setDeliInfo(){
			$("#sltSite").val("${deliInfo.INSTT_CODE}").attr("selected", true);
			$("#txtDilyDate").val("${deliInfo.DLVY_HOPEDE}");
			$("#txtMemo").val("${deliInfo.DLVY_REQUST_COMMENT}");
			var ipCnt = "${deliInfo.DLVY_REQUST_QTT}".split("/");
			var ipType = "${deliInfo.IP_TYPE}".split("/");
			
			for(var i in ipType){
				$("#txt" + ipType[i]).val(ipCnt[i]);
			}
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd500">
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5>배송요청등록</h5>
					</article>
					<article class="mgT5">
						<table class="tb01">
							<colgroup>
								<col style="width:30%;" />
								<col style="width:70%;" />
							</colgroup>
							<tbody>
								<tr>
									<th>Site</th>
									<td><select id="sltSite" able valireqire="Site">
											<option value="">---선택하세요---</option>
									</select></td>
								</tr>
								<tr>
									<th>배송희망일</th>
		 							<td>
		 								<div class="dateBox"><input type="text" id="txtDilyDate" able valireqire="배송희망일" validate="배송희망일" /></div>
									</td>
								</tr>
								<tr>
									<th>항목</th>
									<td><div id="divIpType"></div></td>
								</tr>
								<tr>
									<th>수량</th>
									<td><div id="divIpCnt"></div></td>
								</tr>
								<tr>
									<th>배송요청메모</th>
									<td><textarea id="txtMemo" style="width:100%;" able></textarea></td>
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
						<div style="text-align:center">
							<input type="button" id="btnSave" value="저장" />
							<input type="button" id="btnEdit" value="수정" />
							<input type="button" id="btnCancel" value="요청취소" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>	
</body>
</html>