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
			init();
			event();
		});
		
		function init(){
			$("#apply_1").prop("checked", true);
			mkSetDatePickerYYMMDD("#txtApplyDate");
			$("#txtApplyDate").prop("disabled", true).val("");
			$(".ui-datepicker-trigger").hide();
			$("#txtVersion").val("${IWRS_VER }");
		}
		
		function event(){
			$("input[name=apply]").change(function() {
				var radioValue = $(this).val();
				if (radioValue == "01") {
					$("#txtApplyDate").prop("disabled", true).val("");
					$(".ui-datepicker-trigger").hide();
				} else {
					mkSetDatePickerYYMMDD("#txtApplyDate");
					$("#txtApplyDate").prop("disabled", false);
					$(".ui-datepicker-trigger").show();
				}
			});
			
			$("#btnSave").click(function(){
				if(!window.confirm("저장하시겠습니까?")){
					return;
				}
				if(!mkValidation()){
					return;
				}
				
				var param = {
					TASK_SN : "${TASK_SN}",
					IWRS_VER : "${IWRS_VER}",
					PROGRS_CODE : '02',
					CHANGE_RESN : $("#txtChangeResn").val(),
					APPLC_CODE : $("input[name=apply]:checked").val(),
					APPLC_DE : $("#txtApplyDate").val().replace(/-/g, ""),
					USE_AT : "Y"
				};
				
				$.ajax({
					type : "POST",
					async : false,
					data : param,
					url : "/iwrs/g01/insertIwrsDesignerInfo.do",
					success :function(data){
						if(data.result){
							alert(data.message);
							var param = {
								TASK_SN : "${TASK_SN}",
								IWRS_VER : "${IWRS_VER}"
							};
							${callbackFunction}(param);
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
			
			$("#btnClose").click(function(){
				layerClose();
			});
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd500">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<h5>변경</h5>
					<article class="mgT5">
						<table class="tb001">
							<colgroup>
								<col style="width:30%;" />
								<col style="" />
							</colgroup>
							<tbody>
								<tr>
									<th>적용방법</th>
		 							<td>
		 								<c:forEach items="${ IWRS015 }" var="list" varStatus="status">
											<input type="radio" id="apply_${ status.count }" name="apply" value="${ list.CMMN_CODE }" />
											<label for="apply_${ status.count }" class="raLab"> <span>${ list.CMMN_CODE_NM }</span>
											</label>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th>적용일</th>
									<td>
										<div class="dateBox"><input type="text" id="txtApplyDate" style="width: 120px;" /></div>
									</td>
								</tr>
								<tr>
									<th>버전</th>
		 							<td>
		 								<input type="text" id="txtVersion" disabled="disabled" />
									</td>
								</tr>
								<tr>
									<th>변경사유</th>
									<td style="padding-top:7px; padding-bottom: 0px;">
										<textarea id="txtChangeResn" rows="3" style="width:100%;"></textarea>
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